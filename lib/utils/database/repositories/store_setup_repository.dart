import 'package:drift/drift.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';

class StoreSetupRepository {
  final db = appDatabase;

  Future<List<(int, String)>> getReferencesValues(
    ReferenceType referenceType,
  ) async => _getReferencesValues(referenceType);

  Future<void> saveReferenceValue(
    List<(int, String)> values,
    ReferenceType referenceType,
  ) async => _saveReferenceValue(values, referenceType);

  // ========== Private Functions ========= //
  Future<List<(int, String)>> _getReferencesValues(
    ReferenceType referenceType,
  ) async {
    try {
      List<dynamic> results = [];

      if (referenceType == ReferenceType.brands) {
        results = await db.select(db.brands).get();
      } else if (referenceType == ReferenceType.sizes) {
        results = await db.select(db.availableSizes).get();
      } else if (referenceType == ReferenceType.categories) {
        results = await db.select(db.categories).get();
      } else if (referenceType == ReferenceType.colors) {
        results = await db.select(db.availableColors).get();
      } else {
        throw Exception("Unknown reference type: $referenceType");
      }

      return [for (final result in results) (result.id, result.value)];
    } catch (e, st) {
      print("Failed to get references value: $e");
      print(st);
      rethrow;
    }
  }

  Future<void> _saveReferenceValue(
    List<(int, String)> values,
    ReferenceType referenceType,
  ) async {
    for (final v in values) {
      final id = v.$1;
      final value = v.$2;

      // if id is 0 or negative 1 inset it
      // if not update
      if (id > 0) {
        await _updateValue(referenceType, value, id);
      } else {
        await _insertValue(referenceType, value);
      }
    }
  }

  Future<void> _updateValue(
    ReferenceType referenceType,
    String value,
    int id,
  ) async {
    try {
      if (referenceType == ReferenceType.brands) {
        await (db.update(db.brands)..where(
              (tbl) => tbl.id.equals(id),
            ))
            .write(BrandsCompanion(value: Value(value)));
      } else if (referenceType == ReferenceType.categories) {
        await (db.update(db.categories)..where(
              (tbl) => tbl.id.equals(id),
            ))
            .write(CategoriesCompanion(value: Value(value)));
      } else if (referenceType == ReferenceType.sizes) {
        await (db.update(db.availableSizes)..where(
              (tbl) => tbl.id.equals(id),
            ))
            .write(AvailableSizesCompanion(value: Value(value)));
      } else if (referenceType == ReferenceType.colors) {
        await (db.update(db.availableColors)..where(
              (tbl) => tbl.id.equals(id),
            ))
            .write(AvailableColorsCompanion(value: Value(value)));
      } else {
        throw Exception("Unknown reference type: $referenceType");
      }
    } catch (e, st) {
      print("Failed to update reference value: $e");
      print(st);
      rethrow;
    }
  }

  Future<void> _insertValue(
    ReferenceType referenceType,
    String value,
  ) async {
    try {
      if (referenceType == ReferenceType.brands) {
        await db
            .into(db.brands)
            .insert(
              BrandsCompanion.insert(value: value),
            );
      } else if (referenceType == ReferenceType.categories) {
        await db
            .into(db.categories)
            .insert(
              CategoriesCompanion.insert(value: value),
            );
      } else if (referenceType == ReferenceType.sizes) {
        await db
            .into(db.availableSizes)
            .insert(
              AvailableSizesCompanion.insert(value: value),
            );
      } else if (referenceType == ReferenceType.colors) {
        await db
            .into(db.availableColors)
            .insert(
              AvailableColorsCompanion.insert(value: value),
            );
      } else {
        throw Exception("Unknown reference type: $referenceType");
      }
    } catch (e, st) {
      print("Failed to insert reference value: $e");
      print(st);
      rethrow;
    }
  }
}
