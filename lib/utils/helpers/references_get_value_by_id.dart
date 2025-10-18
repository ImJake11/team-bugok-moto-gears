String referencesGetValueByID(List<(int, String)> reference, int id) {
  final query = reference.where((e) => e.$1 == id);

  if (query.isEmpty) return "";

  return query.first.$2;
}
