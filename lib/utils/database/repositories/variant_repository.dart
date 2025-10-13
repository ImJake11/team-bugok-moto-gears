import 'package:drift/drift.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/database/repositories/size_repository.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

class VariantRepository {
  final db = appDatabase;

  Future<void> updateVariant(VariantModel variant, int id) async =>
      _updateVariant(db, variant, id);

  Future<void> upservariant(List<VariantModel> variants, int productId) async =>
      _upsertVariant(productId, variants, db);
}

Future<void> _updateVariant(
  AppDatabase db,
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
  AppDatabase db,
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
  AppDatabase db,
) async {
  for (final v in variants) {
    final existing =
        await (db.select(db.variants)..where(
              (tbl) => tbl.id.equals(v.id ?? 0),
            ))
            .getSingleOrNull();

    if (existing == null) {
      final id = await _insertVariant(v, db, productId);
      await SizeRepository().upsertSize(v.sizes, id);
    } else {
      await _updateVariant(db, v, v.id!);
      await SizeRepository().upsertSize(v.sizes, existing.id);
    }
  }
}
