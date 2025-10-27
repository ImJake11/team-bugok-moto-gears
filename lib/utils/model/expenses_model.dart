class ExpensesModel {
  final int id;
  final String? note;
  final DateTime createdAt;
  final double total;
  final int category;

  ExpensesModel({
    required this.category,
    required this.id,
    required this.note,
    required this.createdAt,
    required this.total,
  });
}

class EpxenseItemModel {
  final int brand;
  final String model;
  final int color;
  final int size;
  final double price;
  final int quantity;

  EpxenseItemModel({
    required this.brand,
    required this.model,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
  });
}
