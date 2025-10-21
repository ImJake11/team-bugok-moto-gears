import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/utils/enums/reference_types.dart';
import 'package:team_bugok_business/utils/provider/references_values_cache_provider.dart';

String referencesGetValueByID(
  BuildContext context,
  ReferenceType type,
  int id,
) {
  final ref = context.read<ReferencesValuesProviderCache>();

  List<(int, String)> reference = [];

  switch (type) {
    case ReferenceType.brands:
      reference = ref.brands;
    case ReferenceType.categories:
      reference = ref.categories;
    case ReferenceType.colors:
      reference = ref.colors;
    default:
      reference = ref.sizes;
  }

  final query = reference.where((e) => e.$1 == id);

  if (query.isEmpty) return "";

  return query.first.$2;
}
