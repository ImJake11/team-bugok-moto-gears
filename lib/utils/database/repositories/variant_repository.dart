import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:team_bugok_business/utils/database/repositories/size_repository.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

class VariantRepository {
  final SupabaseClient supabase;

  VariantRepository() : supabase = Supabase.instance.client;

  Future<void> upsertVariant(
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

  Future<void> _upsertVariant(
    int productId,
    List<VariantModel> variants,
    int expenseId,
    double costPrice,
  ) async {
    try {
      for (final v in variants) {
        final variantEntry = VariantModel(
          id: v.id,
          isActive: v.isActive,
          productId: productId,
          color: v.color,
          sizes: [],
        );

        // upsert variant
        final result = await supabase
            .from('variant')
            .upsert(
              variantEntry.toMap(),
            )
            .select();

        if (result.isEmpty) continue;

        final variantId = result.first['id'];

        await SizeRepository().upsertSize(
          v.sizes,
          variantId!,
          productId,
          expenseId,
          costPrice,
        );
      }

      print('✅ Variants updated');
    } catch (e, st) {
      print(
        "[VariantRepository] _upsertVariant Failed during upsert for productId=$productId",
      );
      print("Error: $e");
      print("Stack Trace:\n$st");
      rethrow;
    }
  }
}
