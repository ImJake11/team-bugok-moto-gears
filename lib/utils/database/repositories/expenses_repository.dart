import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

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

  Future<List<ExpensesModel>> retriveAllExpenses() async =>
      _retrieveAllExpenses();

  // =========================== Private Functions ============================ //

  Future<int> _insertExpenses(ExpensesCompanion expenes) async {
    try {
      int id = await db.into(db.expenses).insert(expenes);
      print("Expense ID ${id}");

      return id;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<void> _insertExpenseItem(ExpensesItemsCompanion item) async {
    try {
      final id = await db.into(db.expensesItems).insert(item);
      print("Expense ITem id ${id}");
    } catch (e) {
      print(e);
    }
  }

  Future<double> _computeExpensesTotal(ProductModel product) async {
    double totalExpenses = 0.00;

    final costPrice = product.costPrice;

    for (final variant in product.variants) {
      List<VariantSizeModel> sizes = variant.sizes;

      for (final size in sizes) {
        if (size.id == null) {
          totalExpenses += (costPrice * size.stock);
        } else {
          final currentData =
              await (db.select(db.sizes)..where(
                    (tbl) => tbl.id.equals(size.id!),
                  ))
                  .getSingle();

          final currentStock = currentData.stock;
          final stockDifference = size.stock - currentStock;

          if (stockDifference > 0) {
            totalExpenses += stockDifference * costPrice;
          }
        }
      }
    }

    return totalExpenses;
  }

  // this function is to get the total expenses of the current product that is being updated
  // we need to check each sizes if it has changes or not so that's why we seperated this function
  // on the other compute total expenses which is less complex than this current function
  Future<double> _computeExpensesTotalOnProductUpdate(
    ProductModel productData,
  ) async {
    double totalExpenses = 0.00;

    final costPrice = productData.costPrice;

    for (final variant in productData.variants) {
      final sizes = variant.sizes;

      for (final size in sizes) {
        // each sizes has an id that is possibly null
        // this mean this product is new and we can insert it easily
        // but if the id is not null this means  it is modified
        // so we will get the difference of the current stock from db and subtract
        // it to new stock passed on the parameter
        bool isExisting = size.id != null;

        if (isExisting) {
          final currentData =
              await (db.select(db.sizes)..where(
                    (tbl) => tbl.id.equals(size.id!),
                  ))
                  .getSingleOrNull();

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
  }

  Future<List<ExpensesModel>> _retrieveAllExpenses() async {
    final results = await (db.select(db.expenses)).get();

    return [
      for (final result in results)
        ExpensesModel(
          id: result.id,
          note: result.note,
          createdAt: result.createdAt,
          total: result.total,
        ),
    ];
  }
}
