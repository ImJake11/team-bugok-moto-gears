import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';

List<String> availableSizes(
  BuildContext context,
  int variantIndex,
  String sizeValue,
) {
  final references = context.read<ReferencesValuesProviderCache>();
  final s = context.read<ProductFormBloc>().state;

  if (s is! ProductFormInitial) return [];

  final sizesReference = references.sizes;

  final usedSizes = s.productData.variants[variantIndex].sizes
      .map((e) => e.sizeValue)
      .toList();

  final availableSizes = sizesReference
      .where((e) => !usedSizes.contains(e.$1) || e.$2 == sizeValue)
      .toList();

  return availableSizes.map((e) => e.$2).toList();
}
