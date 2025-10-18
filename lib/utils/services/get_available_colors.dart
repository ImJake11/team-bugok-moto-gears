import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';

List<String> availableColors(BuildContext context, String selectedColor) {
  final references = context.read<ReferencesValuesProviderCache>();
  final s = context.read<ProductFormBloc>().state;

  if (s is! ProductFormInitial) return [];

  // Collect selected color IDs
  final selectedColorIds = s.productData.variants.map((v) => v.color).toList();

  // Filter colors:
  final unselectedColors = references.colors
      .where(
        (color) =>
            // show if it's not selected OR if it's the currently selected color
            !selectedColorIds.contains(color.$1) || selectedColor == color.$2,
      )
      .map((color) => color.$2)
      .toList();

  return unselectedColors;
}
