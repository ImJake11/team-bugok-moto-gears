import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/database/repositories/size_repository.dart';
import 'package:team_bugok_business/utils/model/cart_model.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';

class SalesRepository {
  final db = appDatabase;

  Future<void> insertSale(List<CartModel> cart) async => _insertSale(cart);

  Future<List<SalesModel>> retrieveSales() async => _retrieveSales();

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
        await sizeRepository.updateStock(id, item.quantity);
      }
    } catch (e) {
      throw Error();
    }
  }

  Future<List<SalesModel>> _retrieveSales() async {
    final result = await db.select(db.sales).get();

    List<SalesModel> sales = [];

    for (final s in result) {
      // sale items of each
      final salesItemResult = await (db.select(
        db.saleItems,
      )..where((tbl) => tbl.saleId.equals(s.id))).get();

      sales.add(
        SalesModel(
          id: s.id,
          createdAt: s.createdAt,
          total: s.total,
          items: salesItemResult
              .map<CartModel>(
                (e) => CartModel(
                  id: e.id,
                  price: e.price,
                  model: e.model,
                  size: e.size,
                  color: e.color,
                  brand: e.brand,
                ),
              )
              .toList(),
        ),
      );
    }

    return sales;
  }
}
