import 'package:team_bugok_business/utils/model/variant_model.dart';

int computeProductStock(List<VariantModel> variants) {
  return variants.fold<int>(
    0,
    (total, variant) {
      final variantStock = variant.sizes.fold<int>(
        0,
        (sum, size) => sum + size.stock,
      );
      return total + variantStock;
    },
  );
}
