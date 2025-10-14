import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';

List<String> availableColors(
  BuildContext context,
  final String currentColor,
) {
  final s = context.read<ProductFormBloc>().state;

  if (s is! ProductFormInitial) return [];

  final List<String> colors = [
    "Matte Metalic Red",
    "Red/Gray",
    "Gloss Black",
    "Matte Black",
    "Moss Green",
    "Pearl White",
    "Pink/Blue",
    "Blue/Red",
    "Gloss Reed",
    "Gloss Cool Gray",
  ];

  final List<String> usedColors = s.productData.variants
      .map(
        (e) => e.color,
      )
      .toList();

  // remove the current color from the main list 
  usedColors.removeWhere((element) => element == currentColor);
  
  return colors
      .where(
        (color) => !usedColors.contains(color),
      )
      .toList();
}
