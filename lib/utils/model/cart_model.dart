class CartModel {
  final int id;
  final int quantity;
  final double price;
  final String model;
  final String color;
  final String size;
  final String brand;

  CartModel({
    required this.id,
    this.quantity = 1,
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
    String? brand,
    String? color,
    String? size,
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
