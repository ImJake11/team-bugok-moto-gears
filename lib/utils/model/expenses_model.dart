class ExpensesModel {
  final int? id;
  final String? note;
  final int? relatedId;
  final int createdAt;
  final double total;
  final int category;

  ExpensesModel({
    required this.category,
    this.id,
    this.note,
    this.relatedId,
    required this.createdAt,
    required this.total,
  });

  // ✅ Convert Dart object → Map (for inserting to Supabase or local DB)
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'note': note,
      'created_at': createdAt,
      'total': total,
      'category': category,
      'related_id': relatedId,
    };
  }

  // ✅ Convert Map (from Supabase/JSON) → Dart object
  factory ExpensesModel.fromJson(Map<String, dynamic> json) {
    return ExpensesModel(
      id: json['id'] as int,
      note: json['note'] as String?,
      createdAt: json['created_at'],
      total: (json['total'] as num).toDouble(),
      category: json['category'] as int,
      relatedId: json['related_id'],
    );
  }
}

class ExpenseItemModel {
  final int? expenseId;
  final int brand;
  final String model;
  final int color;
  final int size;
  final double price;
  final int quantity;

  ExpenseItemModel({
    this.expenseId,
    required this.brand,
    required this.model,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
  });

  // ✅ Convert Dart object → Map
  Map<String, dynamic> toMap() {
    return {
      'expense_id': expenseId,
      'brand': brand,
      'model': model,
      'color': color,
      'size': size,
      'price': price,
      'quantity': quantity,
    };
  }

  // ✅ Convert Map (from Supabase/JSON) → Dart object
  factory ExpenseItemModel.fromJson(Map<String, dynamic> json) {
    return ExpenseItemModel(
      expenseId: json['expense_id'],
      brand: json['variant']['product']['brand_id'],
      model: json['variant']['product']['model_value'],
      color: json['variant']['color'],
      size: json['size']['size_value'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }
}
