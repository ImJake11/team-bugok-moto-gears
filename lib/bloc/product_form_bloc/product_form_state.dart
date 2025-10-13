part of 'product_form_bloc.dart';

@immutable
sealed class ProductFormState {}

final class ProductFormInitial extends ProductFormState {
  final ProductModel productData;

  ProductFormInitial({ProductModel? productData})
    : productData =
          productData ??
          ProductModel(
            brand: '',
            category: '',
            model: '',
            costPrice: 0,
            sellingPrice: 0,
            isActive: 1,
            createdAt: DateTime.now(),
            variants: [],
          );

  ProductFormInitial copyWith({
    ProductModel? productData,
  }) {
    return ProductFormInitial(
      productData: productData ?? this.productData,
    );
  }
}

class ProductFormLoadingState extends ProductFormState {}

class ProductFormSuccessAndSaveOnly extends ProductFormState {}

class ProductFormShowSnackbar extends ProductFormState {
  final String message;
  final Duration duration;

  ProductFormShowSnackbar({required this.message, required this.duration});
}

class ProductFormValidtionError extends ProductFormState {
  final String message;

  ProductFormValidtionError({required this.message});
}
