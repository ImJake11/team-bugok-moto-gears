import 'dart:convert';

void prettyPrintJson(dynamic json) {
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  final pretty = encoder.convert(json);
  print(pretty);
}
