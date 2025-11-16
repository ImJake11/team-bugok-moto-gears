import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:team_bugok_business/utils/helpers/print_clean_json.dart';
import 'package:team_bugok_business/utils/model/expense_item_model_supabase.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

class ExpensesRepository {
  final supabase = Supabase.instance.client;

  Future<List<ExpenseItemModel>> retriveExpensesItem(int expenseId) async =>
      _retriveExpensesItem(expenseId);

  Future<double> computExpensesTotal(ProductModel product) async =>
      _computeExpensesTotal(product);

  Future<int> insertExpenses(ExpensesModel expenes) async =>
      _insertExpenses(expenes);

  Future<void> insertExpenseItem(ExpenseItemModelSupabase item) async =>
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

  Future<int> _insertExpenses(ExpensesModel expenses) async {
    try {
      final newEntry = await supabase
          .from('expense')
          .insert(expenses.toMap())
          .select();

      print("✅ New Expenses inserted, id: ${newEntry.first['id']}");
      return newEntry.first['id'];
    } catch (e, st) {
      print("_insertExpenses error: $e");
      print("Stack trace: $st");
      rethrow;
    }
  }

  Future<void> _insertExpenseItem(ExpenseItemModelSupabase item) async {
    try {
      await supabase.from('expense_item').insert(item.toMap());
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
        // check each sizes if existing or not
        for (final size in variant.sizes) {
          // if id  is null means size is not yet existing
          if (size.id == null) {
            totalExpenses += (costPrice * size.stock);
          } else {
            final res = await supabase
                .from('size')
                .select('stock')
                .eq(
                  'id',
                  size.id!,
                );

            // calculate the stock difference based on current stock stored in db
            if (res.isNotEmpty) {
              final stock = res.first['stock'];
              final stockDifference = size.stock - stock;

              /**
               *[size.stock] is came from frontend which is the modified data by
               user,
              so deduct the current [stock] that is came from db to [size.stock]
              so we can determine the stock difference that will be added to 
              total expenses, this means user add stock
               */
              if (stockDifference > 0) {
                totalExpenses += stockDifference * costPrice;
              }
            }
            // or if result is empty just perform the normal operation
            else {
              totalExpenses += (costPrice * size.stock);
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

      // get sizes available on each variants
      for (final variant in productData.variants) {
        // get sizes stock difference from previous
        for (final size in variant.sizes) {
          // if size id is null means it is new
          final isExisting = size.id != null;

          if (isExisting) {
            // get current stock count
            final result = await supabase
                .from('size')
                .select('stock')
                .eq(
                  'id',
                  size.id!,
                );

            if (result.isEmpty) {
              totalExpenses += (costPrice * size.stock);
              continue;
            }

            final currentSize = result.first['stock'];

            final stock = currentSize;
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
        "[ExpensesRepository] _computeExpensesTotalOnProductUpdate error: $e",
      );
      print("Stack trace: $st");
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
      final firstDay = DateTime(now.year, now.month, 1);
      final lastDay = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
      final firstDayOfYear = DateTime(now.year, 1, 1);
      final lastDayOfYear = DateTime(now.year, 12, 31);

      var query = supabase.from('expense').select();

      if (isMonthlyOnly ?? false) {
        query = query
            .gt('created_at', firstDay.microsecondsSinceEpoch)
            .lte("created_at", lastDay.millisecondsSinceEpoch);
      }

      if (isAnnualy ?? false) {
        query = query
            .gt('created_at', firstDayOfYear.microsecondsSinceEpoch)
            .lte("created_at", lastDayOfYear.millisecondsSinceEpoch);
      }

      final results = await query;

      return results
          .map(
            (result) => ExpensesModel(
              category: result['category'],
              id: result['id'],
              note: result['note'],
              createdAt: result['created_at'],
              total: result['total'],
            ),
          )
          .toList();
    } catch (e, st) {
      print("🔥 [ExpensesRepository] _retrieveAllExpenses error: $e");
      print("📜 Stack trace: $st");
      rethrow;
    }
  }

  Future<List<ExpenseItemModel>> _retriveExpensesItem(int expenseId) async {
    try {
      final query = await supabase
          .from('expense_item')
          .select('''
            *,
            variant(
             color,
             product(
                brand_id,
                model_value
              )
            ),
            size(size_value)
            ''')
          .eq(
            'expense_id',
            expenseId,
          );

      if (query.isEmpty) return [];

      List<ExpenseItemModel> items = query.map(
        (e) {
          prettyPrintJson(e);
          return ExpenseItemModel.fromJson(e);
        },
      ).toList();

      return items;
    } catch (e, st) {
      print("Failed to get expenses items ${e}");
      print(st);
      rethrow;
    }
  }
}
