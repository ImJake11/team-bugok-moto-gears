import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:team_bugok_business/utils/model/cart_model.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';

class SalesRepository {
  late final SupabaseClient supabase;

  SalesRepository() : supabase = Supabase.instance.client;

  Future<void> insertSale(List<CartModel> cart) async => _insertSale(cart);

  Future<List<SalesModel>> retrieveSales({
    bool? isFilterInCurrentWeek,
    bool? isFilterInCurrentMonth,
    DateTime? referenceDate,
  }) async => _retrieveSales(
    isFilterInCurrentMonth: isFilterInCurrentMonth,
    isFilterInCurrentWeek: isFilterInCurrentWeek,
    referenceDate: referenceDate,
  );

  // ========================== PRIVATE FUNCTIONS ========================== //

  Future<void> _insertSale(List<CartModel> cart) async {
    try {
      // Compute cart total
      final double cartTotal = cart.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity),
      );

      // Insert the sale

      final newSaleEntry = SalesModel(
        createdAt: DateTime.now().millisecond,
        total: cartTotal,
        items: [],
      ).toMap();

      newSaleEntry.remove('items');

      final res = await supabase.from('sale').insert(newSaleEntry).select('id');

      if (res.isEmpty) return;
      print('✅ Sale entry inserted');

      final saleId = res.first['id'];

      // Insert sale items and update stock
      await supabase.from('sale_item').insert([
        for (var item in cart)
          CartModel(
            saleId: saleId,
            price: item.price,
            quantity: item.quantity,
            brand: item.brand,
            model: item.model,
            size: item.size,
            color: item.color,
            sizeId: item.sizeId,
          ).toMap(),
      ]);

      for (var c in cart) {
        await supabase.rpc(
          'stock_decrement',
          params: {
            'pid': c.sizeId,
            'qty': c.quantity,
          },
        );
      }

      print("✅ Sale items inserted");
    } catch (e, st) {
      print("🔥 [SalesRepository._insertSale] Failed to insert sale");
      print("Error: $e");
      print("Stack Trace:\n$st");
      rethrow;
    }
  }

  Future<List<SalesModel>> _retrieveSales({
    final bool? isFilterInCurrentWeek = true,
    final bool? isFilterInCurrentMonth = true,
    final DateTime? referenceDate,
  }) async {
    try {
      final DateTime today = referenceDate ?? DateTime.now();

      final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
      final endOfWeek = startOfWeek.add(Duration(days: 6));
      final startOfMonth = DateTime(today.year, today.month, 1);
      final endOfMonth = DateTime(
        today.year,
        today.month + 1,
        0,
        23,
        59,
        59,
        999,
      );

      var query = supabase.from('sale').select('''
      *,
      sale_item (*)
      ''');

      if (isFilterInCurrentWeek ?? false) {
        query = query
            .gt('created_at', startOfWeek.microsecondsSinceEpoch)
            .lt('created_at', endOfWeek.microsecondsSinceEpoch);
      }

      if (isFilterInCurrentMonth ?? false) {
        query = query
            .gt('created_at', startOfMonth.millisecondsSinceEpoch)
            .lt('created_at', endOfMonth.millisecondsSinceEpoch);
      }

      final results = await query;

      List<SalesModel> sales = [
        for (var result in results) SalesModel.fromJson(result),
      ];

      return sales;
    } catch (e, st) {
      print("🔥 [SalesRepository._retrieveSales] Failed to retrieve sales");
      print("Error: $e");
      print("Stack Trace:\n$st");
      rethrow;
    }
  }
}
