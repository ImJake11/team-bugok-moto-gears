import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:team_bugok_business/utils/database/repositories/expenses_repository.dart';
import 'package:team_bugok_business/utils/model/expense_item_model_supabase.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

class SizeRepository {
  final ExpensesRepository expensesRepository;
  final SupabaseClient supabase;

  SizeRepository()
    : expensesRepository = ExpensesRepository(),
      supabase = Supabase.instance.client;

  Future<void> upsertSize(
    List<VariantSizeModel> sizes,
    int variantId,
    int productId,
    int expenseId,
    double costPrice,
  ) async => _upsertSize(sizes, variantId, productId, expenseId, costPrice);

  Future<VariantSizeModel?> getCurrentSizeStock(int id) async =>
      _getCurrentSizeStock(id);

  Future<List<VariantSizeModel>> retrieveAllSizes() async =>
      _retrieveAllSizes();

  // ==================================  Private Functions =========================================== //

  Future<void> _insertSize(
    int variantId,
    int productId,
    int expenseId,
    double costPrice,
    VariantSizeModel size,
  ) async {
    try {
      final newSizeEntry = VariantSizeModel(
        sizeValue: size.sizeValue,
        stock: size.stock,
        isActive: 1,
        productId: productId,
        variantId: variantId,
      );
      final result = await supabase
          .from('size')
          .insert(newSizeEntry.toMap())
          .select();

      if (result.isEmpty) return;

      final sizeId = result.first['id'];

      await expensesRepository.insertExpenseItem(
        ExpenseItemModelSupabase(
          expenseId: expenseId,
          price: costPrice,
          quantity: size.stock,
          variantId: variantId,
          sizeId: sizeId,
        ),
      );
      print('✅ New size inserted');
    } catch (e, st) {
      print(
        "[SizeRepository] _insertSize Failed to insert size for variantId=$variantId",
      );
      print("Error: $e");
      print("Stack Trace:\n$st");
      rethrow;
    }
  }

  Future<void> _updateSize(
    VariantSizeModel size,
    int variantId,
    int productId,
    int expenseId,
    double costPrice,
  ) async {
    try {
      // if expense id is 0 means now expenses added
      // so we will just update the size
      if (expenseId <= 0 && size.id != null) {
        await supabase.from('size').update(size.toMap()).eq('id', size.id!);
        return;
      }

      // Fetch current data to calculate stock difference
      final result = await supabase
          .from('size')
          .select('stock')
          .eq(
            'id',
            size.id!,
          );

      if (result.isNotEmpty) {
        final currentSize = result.first;
        final currentStock = currentSize['stock'];

        //get the stock difference based on current and updated stock
        int stockDifference = (size.stock - currentStock) as int;

        if (stockDifference > 0) {
          final newExpense = ExpenseItemModelSupabase(
            expenseId: expenseId,
            price: costPrice,
            quantity: stockDifference,
            variantId: variantId,
            sizeId: size.id!,
          ).toMap();

          // add to expenses when current stock is modified
          await supabase.from('expense_item').insert(newExpense);
        }
      }

      // update size
      await supabase
          .from('size')
          .update(size.toMap())
          .eq(
            'id',
            size.id!,
          );

      print('✅ Size Updated Successfully');
    } catch (e, st) {
      print(
        "🔥 [SizeRepository._updateSize] Failed to update size id=${size.id}",
      );
      print("Error: $e");
      print("Stack Trace:\n$st");
      rethrow;
    }
  }

  Future<void> _upsertSize(
    List<VariantSizeModel> sizes,
    int variantId,
    int productId,
    int expenseId,
    double costPrice,
  ) async {
    try {
      for (final s in sizes) {
        // check if size is existing
        final isExisting = s.id != null;

        if (isExisting) {
          await _updateSize(s, variantId, productId, expenseId, costPrice);
        } else {
          await _insertSize(variantId, productId, expenseId, costPrice, s);
        }
      }

      print("✅ Sizes Updated");
    } catch (e, st) {
      print(
        "🔥 [SizeRepository] _upsertSize Failed to upsert sizes for variantId=$variantId",
      );
      print("Error: $e");
      print("Stack Trace:\n$st");
      rethrow;
    }
  }

  Future<VariantSizeModel?> _getCurrentSizeStock(int id) async {
    try {
      final res = await supabase.from('size').select('stock').eq('id', id);

      if (res.isEmpty) return null;

      return VariantSizeModel.fromJson(res.first);
    } catch (e, st) {
      print("[SizeRepository] getCurrentSizeStock Failed to query size id=$id");
      print("Error: $e");
      print("Stack Trace:\n$st");
      rethrow;
    }
  }

  Future<List<VariantSizeModel>> _retrieveAllSizes() async {
    try {
      final result = await supabase.from('size').select();

      return [for (final size in result) VariantSizeModel.fromJson(size)];
    } catch (e, st) {
      print("🔥 [SizeRepository._retrieveAllSizes] Failed to retrieve sizes");
      print("Error: $e");
      print("Stack Trace:\n$st");
      rethrow;
    }
  }
}
