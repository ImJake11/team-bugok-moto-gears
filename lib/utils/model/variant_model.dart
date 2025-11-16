class VariantModel {
  int? id;
  int color;
  List<VariantSizeModel> sizes;
  int isActive;
  int? productId;

  VariantModel({
    required this.color,
    required this.sizes,
    this.id,
    this.productId,
    this.isActive = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'color': color,
      'is_active': isActive,
      'product_id': productId,
    };
  }

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      id: json['id'] as int?,
      color: json['color'] is Map
          ? json['color']['id']
                as int // if joined with available_color table
          : json['color'] as int,
      productId: json['product_id'] is Map
          ? json['product_id']['id']
                as int // if joined with product table
          : json['product_id'] as int?,
      isActive: json['is_active'] ?? 1,
      sizes: (json['size'] as List<dynamic>? ?? [])
          .map((e) => VariantSizeModel.fromJson(e))
          .toList(),
    );
  }

  VariantModel copyWith({
    int? color,
    List<VariantSizeModel>? sizes,
    int? isActive,
    int? id,
    int? productId,
  }) {
    return VariantModel(
      color: color ?? this.color,
      id: id ?? this.id,
      productId: productId ?? this.productId,
      sizes: sizes ?? this.sizes,
      isActive: isActive ?? this.isActive,
    );
  }
}

class VariantSizeModel {
  int? id;
  final int sizeValue;
  final int stock;
  int isActive;
  int? variantId;
  int? productId;

  VariantSizeModel({
    required this.sizeValue,
    required this.stock,
    this.isActive = 1,
    this.variantId,
    this.id,
    this.productId,
  });

  factory VariantSizeModel.fromJson(Map<String, dynamic> json) {
    return VariantSizeModel(
      id: json['id'] as int?,
      sizeValue: json['size_value'] as int? ?? 0,
      stock: json['stock'] as int? ?? 0,
      isActive: json['is_active'] ?? 1,
      variantId: json['variant_id'],
      productId: json['product_id'],
    );
  }

  VariantSizeModel copyWith({
    int? sizeValue,
    int? stock,
    int? id,
    int? variantId,
    int? productId,
    int? isActive,
  }) {
    return VariantSizeModel(
      sizeValue: sizeValue ?? this.sizeValue,
      stock: stock ?? this.stock,
      isActive: isActive ?? this.isActive,
      variantId: variantId ?? this.variantId,
      id: id ?? this.id,
      productId: productId ?? this.productId,
    );
  }

  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      "variant_id": variantId,
      "product_id": productId,
      "size_value": sizeValue,
      "stock": stock,
      "is_active": isActive,
    };
  }
}
