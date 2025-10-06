part of 'product_form_bloc.dart';

@immutable
sealed class ProductFormState {}

final class ProductFormInitial extends ProductFormState {
  final String? productName;
  final String? category;
  final String? color;
  final String? size;
  final double? costPrice;
  final double? sellingPrice;
  final int? stock;
  final bool isActive;

  ProductFormInitial({
    this.isActive = true,
    this.productName = "",
    this.category = "",
    this.color = "",
    this.size = "",
    this.costPrice = 0,
    this.sellingPrice = 0,
    this.stock = 0,
  });

  ProductFormInitial copyWith({
    String? productName,
    String? category,
    String? color,
    String? size,
    double? costPrice,
    double? sellingPrice,
    int? stock,
    bool? isActive,
  }) {
    return ProductFormInitial(
      isActive: isActive ?? this.isActive,
      productName: productName ?? this.productName,
      category: category ?? this.category,
      color: color ?? this.color,
      size: size ?? this.size,
      costPrice: costPrice ?? this.costPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      stock: stock ?? this.stock,
    );
  }
}
