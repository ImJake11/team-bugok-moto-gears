import 'package:drift/drift.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

class ExpensesRepository {
  final db = appDatabase;

  Future<List<EpxenseItemModel>> retriveExpensesItem(int expenseId) async =>
      _retriveExpensesItem(expenseId);

  Future<double> computExpensesTotal(ProductModel product) async =>
      _computeExpensesTotal(product);

  Future<int> insertExpenses(ExpensesCompanion expenes) async =>
      _insertExpenses(expenes);

  Future<void> insertExpenseItem(ExpensesItemsCompanion item) async =>
      _insertExpenseItem(item);

  Future<double> computeExpensesTotalOnProductUpdate(
    ProductModel productData,
  ) async => _computeExpensesTotalOnProductUpdate(productData);

  Future<List<ExpensesModel>> retriveAllExpenses({
    DateTime? referenceDate,
    bool? isMonthOnly,
    bool? isAnnualy,
    int? year,
  }) async => _retrieveAllExpenses(
    referenceDate: referenceDate,
    isMonthlyOnly: isMonthOnly,
    isAnnualy: isAnnualy,
    year: year,
  );

  // =========================== Private Functions ============================ //

  Future<int> _insertExpenses(ExpensesCompanion expenes) async {
    try {
      final id = await db.into(db.expenses).insert(expenes);
      return id;
    } catch (e, st) {
      print("🔥 [ExpensesRepository] _insertExpenses error: $e");
      print("📜 Stack trace: $st");
      rethrow;
    }
  }

  Future<void> _insertExpenseItem(ExpensesItemsCompanion item) async {
    try {
      final id = await db.into(db.expensesItems).insert(item);
      print(id);
      print(item.expenseId);
    } catch (e, st) {
      print("🔥 [ExpensesRepository] _insertExpenseItem error: $e");
      print("📜 Stack trace: $st");
      rethrow;
    }
  }

  Future<double> _computeExpensesTotal(ProductModel product) async {
    try {
      double totalExpenses = 0.00;
      final costPrice = product.costPrice;

      for (final variant in product.variants) {
        for (final size in variant.sizes) {
          if (size.id == null) {
            totalExpenses += (costPrice * size.stock);
          } else {
            final currentData = await (db.select(
              db.sizes,
            )..where((tbl) => tbl.id.equals(size.id!))).getSingleOrNull();

            if (currentData != null) {
              final currentStock = currentData.stock;
              final stockDifference = size.stock - currentStock;
              if (stockDifference > 0) {
                totalExpenses += stockDifference * costPrice;
              }
            }
          }
        }
      }

      return totalExpenses;
    } catch (e, st) {
      print("🔥 [ExpensesRepository] _computeExpensesTotal error: $e");
      print("📜 Stack trace: $st");
      rethrow;
    }
  }

  Future<double> _computeExpensesTotalOnProductUpdate(
    ProductModel productData,
  ) async {
    try {
      double totalExpenses = 0.00;
      final costPrice = productData.costPrice;

      for (final variant in productData.variants) {
        for (final size in variant.sizes) {
          final isExisting = size.id != null;

          if (isExisting) {
            final currentData = await (db.select(
              db.sizes,
            )..where((tbl) => tbl.id.equals(size.id!))).getSingleOrNull();

            final stock = currentData?.stock ?? 0;
            final stockDifference = size.stock - stock;

            if (stockDifference > 0) {
              totalExpenses += (costPrice * stockDifference);
            }
          } else {
            totalExpenses += (costPrice * size.stock);
          }
        }
      }

      return totalExpenses;
    } catch (e, st) {
      print(
        "🔥 [ExpensesRepository] _computeExpensesTotalOnProductUpdate error: $e",
      );
      print("📜 Stack trace: $st");
      rethrow;
    }
  }

  Future<List<ExpensesModel>> _retrieveAllExpenses({
    DateTime? referenceDate,
    bool? isMonthlyOnly,
    bool? isAnnualy,
    int? year,
  }) async {
    try {
      final now = referenceDate ?? DateTime.now();
      final currentYear = year ?? now.year;
      final firstDay = DateTime(now.year, now.month, 1);
      final lastDay = DateTime(now.year, now.month + 1, 0);

      final query = db.select(db.expenses)
        ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);

      if (isMonthlyOnly ?? false) {
        query.where(
          (tbl) =>
              tbl.createdAt.isBiggerThanValue(firstDay) &
              tbl.createdAt.isSmallerThanValue(lastDay),
        );
      }

      if (isAnnualy ?? false) {
        query.where((tbl) => tbl.createdAt.year.equals(currentYear));
      }

      final results = await query.get();

      return results
          .map(
            (result) => ExpensesModel(
              category: result.category,
              id: result.id,
              note: result.note,
              createdAt: result.createdAt,
              total: result.total,
            ),
          )
          .toList();
    } catch (e, st) {
      print("🔥 [ExpensesRepository] _retrieveAllExpenses error: $e");
      print("📜 Stack trace: $st");
      rethrow;
    }
  }

  Future<List<EpxenseItemModel>> _retriveExpensesItem(int expenseId) async {
    try {
      final query = db.select(db.expensesItems)
        ..where(
          (tbl) => tbl.expenseId.equals(expenseId),
        );

      final rows = await query.get();

      if (rows.isEmpty) return [];

      List<EpxenseItemModel> items = [];

      for (var row in rows) {
        // the variant model and brand
        final variantQuery = db.select(db.variants)
          ..where(
            (tbl) => tbl.id.equals(row.variantId),
          );

        final variant = await variantQuery.getSingleOrNull();

        // skip current iteration if variant is null
        if (variant == null) continue;

        final productQuery = db.select(db.products)
          ..where((tbl) => tbl.id.equals(variant.productId));

        final product = await productQuery.getSingleOrNull();

        // skip
        if (product == null) continue;

        //get the size value

        final sizeQuery = db.select(db.sizes)
          ..where(
            (tbl) => tbl.id.equals(row.sizeId),
          );

        final size = await sizeQuery.getSingleOrNull();

        if (size == null) continue;

        items.add(
          EpxenseItemModel(
            brand: product.brand,
            model: product.model,
            color: variant.color,
            size: size.sizeValues,
            price: row.price,
            quantity: row.quantity,
          ),
        );
      }

      return items;
    } catch (e, st) {
      print("Failed to get expenses items ${e}");
      print(st);
      rethrow;
    }
  }
}
