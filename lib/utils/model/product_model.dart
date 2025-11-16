import 'package:team_bugok_business/utils/model/variant_model.dart';

class ProductModel {
  final int? id;
  final int brand;
  final int category;
  final String model;
  final double costPrice;
  final double sellingPrice;
  final int isActive;
  int createdAt;
  final List<VariantModel> variants;

  ProductModel({
    this.variants = const [],
    required this.brand,
    required this.category,
    required this.model,
    required this.costPrice,
    required this.sellingPrice,
    required this.isActive,
    required this.createdAt,
    this.id,
  });

  ProductModel copyWith({
    int? id,
    int? brand,
    int? category,
    String? model,
    int? stock,
    double? costPrice,
    double? sellingPrice,
    int? isActive,
    int? createdAt,
    List<VariantModel>? variants,
  }) {
    return ProductModel(
      brand: brand ?? this.brand,
      category: category ?? this.category,
      model: model ?? this.model,
      costPrice: costPrice ?? this.costPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      variants: variants ?? this.variants,
    );
  }

  // convert json to map object
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      brand: json['brand_id'],
      category: json['category_id'],
      model: json['model_value'] ?? '',
      costPrice: (json['cost_price'] as num).toDouble(),
      sellingPrice: (json['selling_price'] as num).toDouble(),
      isActive: json['is_active'] ?? 0,
      createdAt: json['created_at'],
      variants: (json['variant'] as List<dynamic>? ?? [])
          .map((e) => VariantModel.fromJson(e))
          .toList(),
    );
  }

  // convert to map object
  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      'brand_id': brand,
      'category_id': category,
      'model_value': model,
      'cost_price': costPrice,
      'selling_price': sellingPrice,
      'is_active': isActive,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };
  }

  // convert map to object
  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel(
    brand: map['brand'] ?? "",
    category: map['category'] ?? '',
    model: map['model'] ?? '',
    costPrice: map['costPrice'] ?? 0.00,
    sellingPrice: map['sellingPrice'] ?? 0.00,
    isActive: map['isActive'] ?? 0,
    createdAt: map['createdAt'] ?? '',
  );
}
