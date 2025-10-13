import 'package:team_bugok_business/utils/model/variant_model.dart';

class ProductModel {
  final int? id;
  final String brand;
  final String category;
  final String model;
  final double costPrice;
  final double sellingPrice;
  final int isActive;
  final DateTime createdAt;
  final List<VariantModel> variants;

  ProductModel({
    this.variants = const [],
    this.id = 0,
    required this.brand,
    required this.category,
    required this.model,
    required this.costPrice,
    required this.sellingPrice,
    required this.isActive,
    required this.createdAt,
  });

  ProductModel copyWith({
    int? id,
    String? brand,
    String? category,
    String? model,
    int? stock,
    double? costPrice,
    double? sellingPrice,
    int? isActive,
    DateTime? createdAt,
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

  // convert to map object
  Map<String, Object?> toMap() {
    return {
      'brand': brand,
      'category': category,
      'model': model,
      'cost_price': costPrice,
      'selling_price': sellingPrice,
      'is_active': isActive,
      'created_at': createdAt,
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
