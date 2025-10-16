class ExpensesModel {
  final int id;
  final String? note;
  final DateTime createdAt;
  final double total;

  ExpensesModel({
    required this.id,
    required this.note,
    required this.createdAt,
    required this.total,
  });
}
