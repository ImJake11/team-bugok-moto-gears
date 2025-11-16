import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';

class StoreSetupRepository {
  late final SupabaseClient supabase;

  StoreSetupRepository() : supabase = Supabase.instance.client;

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
      final table = getTableName(referenceType);

      List<dynamic> results = await supabase.from(table).select();

      print("✅ Reference value of $referenceType fetched");

      return [
        for (final result in results)
          (
            result['id'],
            result['value'],
          ),
      ];
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
      final table = getTableName(referenceType);

      await supabase
          .from(table)
          .update({
            "value": value,
          })
          .eq('id', id);

      print('✅ $referenceType updated');
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
      final table = getTableName(referenceType);

      await supabase.from(table).insert({
        "value": value,
      });

      print('✅ New $referenceType inserted');
    } catch (e, st) {
      print("Failed to insert reference value: $e");
      print(st);
      rethrow;
    }
  }
}

String getTableName(ReferenceType reference) {
  switch (reference) {
    case ReferenceType.brands:
      return 'brand';
    case ReferenceType.categories:
      return "category";
    case ReferenceType.colors:
      return "available_color";
    case ReferenceType.models:
      return 'model';

    default:
      return 'available_size';
  }
}
