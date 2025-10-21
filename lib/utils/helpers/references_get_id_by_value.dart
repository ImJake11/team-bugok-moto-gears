import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../enums/reference_types.dart' show ReferenceType;
import '../provider/references_values_cache_provider.dart';

int referenceGetIdByValue(
  BuildContext context,
  ReferenceType type,
  String value,
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

  final query = reference.where((e) => e.$2 == value);

  if (query.isEmpty) return 0;

  return query.first.$1;
}
