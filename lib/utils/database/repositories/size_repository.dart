import 'package:drift/drift.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

class SizeRepository {
  final db = appDatabase;

  Future<void> upsertSize(
    List<VariantSizeModel> sizes,
    int variantId,
    productId,
  ) async => _upsertSize(
    sizes,
    variantId,
    productId,
  );

  Future<VariantSizeModel> querySize(int id) async => _querySize(id);

  Future<void> updateStock(int id, int quantity) async =>
      _updateStock(id, quantity);

  /// PRIVATE FUNCTIONS ///
  Future<void> _insertSize(
    int variantId,
    int productId,
    VariantSizeModel size,
  ) async {
    await db
        .into(db.sizes)
        .insert(
          SizesCompanion.insert(
            productId: productId,
            variantId: variantId,
            stock: size.stock,
            sizeValues: size.sizeValue,
          ),
        );
  }

  Future<void> _updateSize(
    VariantSizeModel size,
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
  }

  Future<void> _upsertSize(
    List<VariantSizeModel> sizes,
    int variantId,
    int productId,
  ) async {
    for (final s in sizes) {
      final existing =
          await (db.select(db.sizes)..where(
                (tbl) => tbl.id.equals(s.id ?? 0),
              ))
              .getSingleOrNull();

      if (existing == null) {
        await _insertSize(variantId, productId, s);
      } else {
        await _updateSize(s);
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
}
