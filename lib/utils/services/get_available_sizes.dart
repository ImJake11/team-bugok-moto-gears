import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';

List<String> availableSizes(
  BuildContext context,
  String selectedSize,
  int variantIndex,
) {
  final s = context.read<ProductFormBloc>().state;

  if (s is! ProductFormInitial) return [];

  final availableSizes = [
    "S",
    "M",
    "L",
    "XL",
    "XXL",
  ];

  final usedSizes = s.productData.variants[variantIndex].sizes
      .map((e) => e.sizeValue)
      .toList();

  return availableSizes
      .where(
        (element) => !usedSizes.contains(element),
      )
      .toList();
}
