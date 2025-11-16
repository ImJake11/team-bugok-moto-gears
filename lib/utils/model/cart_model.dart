class CartModel {
  final int quantity;
  final double price;
  final String model;
  final int color;
  final int size;
  final int brand;
  final int? saleId;
  final int sizeId;

  CartModel({
    this.quantity = 1,
    this.saleId,
    required this.price,
    required this.model,
    required this.size,
    required this.color,
    required this.brand,
    required this.sizeId,
  });

  CartModel copyWith({
    int? quantity,
    double? price,
    String? model,
    int? brand,
    int? color,
    int? size,
    int? sizeId,
  }) {
    return CartModel(
      price: price ?? this.price,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      size: size ?? this.size,
      sizeId: sizeId ?? this.sizeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sale_id': saleId,
      'price': price,
      'quantity': quantity,
      'brand': brand,
      'model': model,
      'size': size,
      'color': color,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      quantity: json['quantity'],
      price: json['price'],
      model: json['model'],
      size: json['size'],
      color: json['color'],
      brand: json['brand'],
      sizeId: json['size_id'],
    );
  }
}
