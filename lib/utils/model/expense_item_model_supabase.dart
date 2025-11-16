class ExpenseItemModelSupabase {
  final int? id;
  final int expenseId;
  final double price;
  final int quantity;
  final int variantId;
  final int sizeId;

  ExpenseItemModelSupabase({
    this.id,
    required this.expenseId,
    required this.price,
    required this.quantity,
    required this.variantId,
    required this.sizeId,
  });

  /// Convert Dart object → Map (for Supabase insert/update)
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'expense_id': expenseId,
      'price': price,
      'quantity': quantity,
      'variant_id': variantId,
      'size_id': sizeId,
    };
  }

  /// Convert Map (from Supabase query) → Dart object
  factory ExpenseItemModelSupabase.fromJson(Map<String, dynamic> json) {
    return ExpenseItemModelSupabase(
      id: json['id'] as int?,
      expenseId: json['expense_id'] as int,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      variantId: json['variant_id'] as int,
      sizeId: json['size_id'] as int,
    );
  }
}
