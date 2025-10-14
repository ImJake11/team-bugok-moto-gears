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
  }) async => _retrieveSales();

  // PRIVATE FUNCTIONS //

  Future<void> _insertSale(
    List<CartModel> cart,
  ) async {
    final SizeRepository sizeRepository = SizeRepository();

    try {
      double cartTotal = cart.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity),
      );

      final id = await db
          .into(db.sales)
          .insert(
            SalesCompanion.insert(
              total: cartTotal,
            ),
          );

      for (final item in cart) {
        // save the item to sale items table
        await db
            .into(db.saleItems)
            .insert(
              SaleItemsCompanion.insert(
                saleId: id,
                price: item.price,
                quantity: item.quantity,
                brand: item.brand,
                model: item.model,
                size: item.size,
                color: item.color,
                productId: item.id,
              ),
            );

        // update the stock of the item
        await sizeRepository.updateStock(item.id, item.quantity);
      }
    } catch (e) {
      throw Error();
    }
  }

  Future<List<SalesModel>> _retrieveSales({
    final bool? isFilterInCurrentWeek,
  }) async {
    final DateTime today = DateTime.now();

    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));

    final query =
        db.select(db.sales).join([
          leftOuterJoin(
            db.saleItems,
            db.saleItems.saleId.equalsExp(db.sales.id),
          ),
        ])..orderBy(
          [OrderingTerm.desc(db.sales.createdAt)],
        );

    if (isFilterInCurrentWeek ?? false) {
      query.where(
        db.sales.createdAt.isBiggerThanValue(startOfWeek) &
            db.sales.createdAt.isSmallerThanValue(endOfWeek),
      );
    }

    final result = await query.get();

    // Use a map to group sale items under each sale
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
  }
}
