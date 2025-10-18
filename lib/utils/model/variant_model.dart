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
      "size_value": sizeValue,
      "stock": stock,
    };
  }
}
