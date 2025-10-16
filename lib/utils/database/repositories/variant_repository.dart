import 'package:drift/drift.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/database/repositories/size_repository.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

class VariantRepository {
  final db = appDatabase;

  Future<void> updateVariant(VariantModel variant, int id) async =>
      _updateVariant(variant, id);

  Future<void> upservariant(
    List<VariantModel> variants,
    int productId,
    int expenseId,
    double costPrice,
  ) async => _upsertVariant(
    productId,
    variants,
    expenseId,
    costPrice,
  );

  // =======================  Private Functions ============================ //
  Future<void> _updateVariant(
    VariantModel variant,
    int id,
  ) async {
    await (db.update(db.variants)..where(
          (tbl) => tbl.id.equals(id),
        ))
        .write(
          VariantsCompanion(
            color: Value(variant.color),
            id: Value(variant.id!),
            isActive: Value(variant.isActive),
            productId: Value(variant.productId!),
          ),
        );
  }

  Future<int> _insertVariant(
    VariantModel variant,
    int productId,
  ) async {
    final id = await db
        .into(db.variants)
        .insert(
          VariantsCompanion.insert(
            productId: productId,
            color: variant.color,
          ),
        );

    return id;
  }

  Future<void> _upsertVariant(
    int productId,
    List<VariantModel> variants,
    int expenseId,
    double costPrice,
  ) async {
    for (final v in variants) {
      final existing =
          await (db.select(db.variants)..where(
                (tbl) => tbl.id.equals(v.id ?? 0),
              ))
              .getSingleOrNull();

      if (existing == null) {
        final id = await _insertVariant(v, productId);
        await SizeRepository().upsertSize(
          v.sizes,
          id,
          productId,
          expenseId,
          costPrice,
        );
      } else {
        await _updateVariant(v, v.id!);
        await SizeRepository().upsertSize(
          v.sizes,
          existing.id,
          productId,
          expenseId,
          costPrice,
        );
      }
    }
  }
}
