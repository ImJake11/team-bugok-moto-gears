import 'package:drift/drift.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/database/repositories/expenses_repository.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

class SizeRepository {
  final ExpensesRepository expensesRepository = ExpensesRepository();

  final db = appDatabase;

  Future<void> upsertSize(
    List<VariantSizeModel> sizes,
    int variantId,
    productId,
    expenseId,
    costPrice,
  ) async => _upsertSize(
    sizes,
    variantId,
    productId,
    expenseId,
    costPrice,
  );

  Future<VariantSizeModel> querySize(int id) async => _querySize(id);

  Future<void> updateStock(int id, int quantity) async =>
      _updateStock(id, quantity);

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
    final sizeId = await db
        .into(db.sizes)
        .insert(
          SizesCompanion.insert(
            productId: productId,
            variantId: variantId,
            stock: size.stock,
            sizeValues: size.sizeValue,
          ),
        );

    await expensesRepository.insertExpenseItem(
      ExpensesItemsCompanion.insert(
        expenseId: expenseId,
        variantId: variantId,
        sizeId: sizeId,
        price: costPrice,
        quantity: size.stock,
      ),
    );
  }

  Future<void> _updateSize(
    VariantSizeModel size,
    int variantId,
    int productId,
    int expenseId,
    double costPrice,
  ) async {
    await (db.update(db.sizes)..where(
          (tbl) => tbl.id.equals(size.id!),
        ))
        .write(
          SizesCompanion(
            isActive: Value(size.isActive),
            sizeValues: Value(size.sizeValue),
            stock: Value(size.stock),
          ),
        );

    // compare size current stock to new size stock
    final currentData =
        await (db.select(db.sizes)..where(
              (tbl) => tbl.id.equals(size.id!),
            ))
            .getSingleOrNull();

    if (currentData != null) {
      final currentStock = currentData.stock;
      final stockDifference = size.stock - currentStock;

      if (stockDifference > 0) {
        await expensesRepository.insertExpenseItem(
          ExpensesItemsCompanion.insert(
            expenseId: expenseId,
            variantId: variantId,
            sizeId: size.id!,
            price: costPrice,
            quantity: stockDifference,
          ),
        );
      }
    }
  }

  Future<void> _upsertSize(
    List<VariantSizeModel> sizes,
    int variantId,
    int productId,
    int expenseId,
    double costPrice,
  ) async {
    for (final s in sizes) {
      final existing =
          await (db.select(db.sizes)..where(
                (tbl) => tbl.id.equals(s.id ?? 0),
              ))
              .getSingleOrNull();

      if (existing == null) {
        await _insertSize(
          variantId,
          productId,
          expenseId,
          costPrice,
          s,
        );
      } else {
        await _updateSize(
          s,
          variantId,
          productId,
          expenseId,
          costPrice,
        );
      }
    }
  }

  Future<VariantSizeModel> _querySize(int id) async {
    final result =
        await (db.select(db.sizes)..where(
              (tbl) => tbl.id.equals(id),
            ))
            .getSingle();

    return VariantSizeModel(
      id: result.id,
      variantId: result.variantId,
      isActive: result.isActive,
      sizeValue: result.sizeValues,
      stock: result.stock,
    );
  }

  Future<void> _updateStock(int id, int quantity) async {
    await (db.update(db.sizes)..where((tbl) => tbl.id.equals(id))).write(
      SizesCompanion.custom(stock: db.sizes.stock - Constant(quantity)),
    );
  }

  Future<List<VariantSizeModel>> _retrieveAllSizes() async {
    final result = await db.select(db.sizes).get();

    return [
      for (final size in result)
        VariantSizeModel(
          sizeValue: '',
          productId: size.productId,
          stock: size.stock,
        ),
    ];
  }
}
