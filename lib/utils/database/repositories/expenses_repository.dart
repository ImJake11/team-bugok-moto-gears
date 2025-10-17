import 'package:drift/drift.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

class ExpensesRepository {
  final db = appDatabase;

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
  }) async => _retrieveAllExpenses(
    referenceDate: referenceDate,
    isMonthlyOnly: isMonthOnly,
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
      await db.into(db.expensesItems).insert(item);
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
  }) async {
    try {
      final now = referenceDate ?? DateTime.now();
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

      final results = await query.get();

      return results
          .map(
            (result) => ExpensesModel(
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
}
