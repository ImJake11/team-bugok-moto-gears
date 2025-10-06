class ProductModel {
  final int? id;
  final String productName;
  final String category;
  final String color;
  final String size;
  final int stock;
  final double costPrice;
  final double sellingPrice;
  final int isActive;
  final String dateAdded;

  ProductModel({
    this.id = 0,
    required this.productName,
    required this.dateAdded,
    required this.category,
    required this.color,
    required this.size,
    required this.stock,
    required this.costPrice,
    required this.sellingPrice,
    required this.isActive,
  });

  // convert to map object
  Map<String, Object?> toMap() {
    return {
      'product_name': productName,
      'category': category,
      'color': color,
      'size': size,
      'cost_price': costPrice,
      'selling_price': sellingPrice,
      'stock': stock,
      'is_active': isActive,
      'date_added': dateAdded,
    };
  }
}
