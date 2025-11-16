part of 'product_form_bloc.dart';

@immutable
sealed class ProductFormState {}

final class ProductFormInitial extends ProductFormState {
  final ProductModel productData;

  ProductFormInitial({
    ProductModel? productData,
  }) : productData =
           productData ??
           ProductModel(
             brand: 0,
             category: 1,
             model: '',
             costPrice: 0,
             sellingPrice: 0,
             isActive: 1,
             createdAt: 0,
             variants: [],
           ); 

  ProductFormInitial copyWith({
    ProductModel? productData,
    bool? isLoading,
  }) {
    return ProductFormInitial(
      productData: productData ?? this.productData,
    );
  }
}

class ProductFormLoadingState extends ProductFormState {}
class ProductFormShowSnackbar extends ProductFormState {
  final String message;
  final Duration duration;

  ProductFormShowSnackbar({required this.message, required this.duration});
}

class ProductFormValidtionError extends ProductFormState {
  final String message;

  ProductFormValidtionError({required this.message});
}

class ProductFormSaveProduct extends ProductFormState {
  final bool isSaveOnly;
  final String message;

  ProductFormSaveProduct({required this.message, required this.isSaveOnly});
}

class ProductFormErrorState extends ProductFormState {
  final String message;

  ProductFormErrorState({required this.message});
}
