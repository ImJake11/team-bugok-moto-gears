class CartModel {
  final int id;
  final int quantity;
  final double price;
  final String model;
  final int color;
  final int size;
  final int brand;
  final int? saleId;

  CartModel({
    required this.id,
    this.quantity = 1,
    this.saleId,
    required this.price,
    required this.model,
    required this.size,
    required this.color,
    required this.brand,
  });

  CartModel copyWith({
    int? id,
    int? quantity,
    double? price,
    String? model,
    int? brand,
    int? color,
    int? size,
  }) {
    return CartModel(
      id: id ?? this.id,
      price: price ?? this.price,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }
}
