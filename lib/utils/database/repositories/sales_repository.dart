import 'package:drift/drift.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/database/repositories/size_repository.dart';
import 'package:team_bugok_business/utils/model/cart_model.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';

class SalesRepository {
  final db = appDatabase;

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
    final SizeRepository sizeRepository = SizeRepository();

    try {
      // Compute cart total
      final double cartTotal = cart.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity),
      );

      // Insert the sale
      final int saleId = await db
          .into(db.sales)
          .insert(
            SalesCompanion.insert(total: cartTotal),
          );

      // Insert sale items and update stock
      for (final item in cart) {
        try {
          await db
              .into(db.saleItems)
              .insert(
                SaleItemsCompanion.insert(
                  saleId: saleId,
                  price: item.price,
                  quantity: item.quantity,
                  brand: item.brand,
                  model: item.model,
                  size: item.size,
                  color: item.color,
                  productId: item.id,
                ),
              );

          await sizeRepository.updateStock(item.id, item.quantity);
        } catch (itemError, itemSt) {
          print(
            "🔥 [SalesRepository._insertSale] Failed inserting sale item for productId=${item.id}",
          );
          print("Error: $itemError");
          print("Stack Trace:\n$itemSt");
          rethrow;
        }
      }
    } catch (e, st) {
      print("🔥 [SalesRepository._insertSale] Failed to insert sale");
      print("Error: $e");
      print("Stack Trace:\n$st");
      rethrow;
    }
  }

  Future<List<SalesModel>> _retrieveSales({
    final bool? isFilterInCurrentWeek,
    final bool? isFilterInCurrentMonth,
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

      final query = db.select(db.sales).join([
        leftOuterJoin(db.saleItems, db.saleItems.saleId.equalsExp(db.sales.id)),
      ])..orderBy([OrderingTerm.desc(db.sales.createdAt)]);

      if (isFilterInCurrentWeek ?? false) {
        query.where(
          db.sales.createdAt.isBiggerThanValue(startOfWeek) &
              db.sales.createdAt.isSmallerThanValue(endOfWeek),
        );
      }

      if (isFilterInCurrentMonth ?? false) {
        query.where(
          db.sales.createdAt.isBiggerThanValue(startOfMonth) &
              db.sales.createdAt.isSmallerThanValue(endOfMonth),
        );
      }

      final result = await query.get();

      // Group sale items by sale ID
      final Map<int, SalesModel> groupedSales = {};

      for (final row in result) {
        final sale = row.readTable(db.sales);
        final item = row.readTableOrNull(db.saleItems);
        
        groupedSales.putIfAbsent(
          sale.id,
          () => SalesModel(
            id: sale.id,
            createdAt: sale.createdAt,
            total: sale.total,
            items: [],
          ),
        );

        if (item != null) {
          groupedSales[sale.id]!.items.add(
            CartModel(
              saleId: item.saleId,
              quantity: item.quantity,
              id: item.id,
              price: item.price,
              model: item.model,
              size: item.size,
              color: item.color,
              brand: item.brand,
            ),
          );
        }
      }

      return groupedSales.values.toList();
    } catch (e, st) {
      print("🔥 [SalesRepository._retrieveSales] Failed to retrieve sales");
      print("Error: $e");
      print("Stack Trace:\n$st");
      rethrow;
    }
  }
}
