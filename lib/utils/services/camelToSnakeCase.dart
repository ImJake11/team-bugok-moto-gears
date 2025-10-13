String camelToSnakeCase(String input) {
  final regex = RegExp(r'(?<=[a-z])[A-Z]');
  return input
      .replaceAllMapped(regex, (match) => '_${match.group(0)!.toLowerCase()}')
      .toLowerCase();
}
