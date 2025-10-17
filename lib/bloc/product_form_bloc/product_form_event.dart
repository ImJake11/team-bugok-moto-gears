part of 'product_form_bloc.dart';

@immutable
sealed class ProductFormEvent {}

class ProductFormUpdateData extends ProductFormEvent {
  final String key;
  final dynamic value;

  ProductFormUpdateData({
    required this.key,
    required this.value,
  });
}

class ProductFormInsertProduct extends ProductFormEvent {
  final bool isSaveOnly;

  ProductFormInsertProduct({required this.isSaveOnly});
}

class ProductFormCreateVariant extends ProductFormEvent {}

class ProductFormDeleteVariant extends ProductFormEvent {
  final int variantIndex;

  ProductFormDeleteVariant({required this.variantIndex});
}

class ProductFormUpdateVariant extends ProductFormEvent {
  final int variantIndex;
  final String colorValue;

  ProductFormUpdateVariant({
    required this.variantIndex,
    required this.colorValue,
  });
}

class ProductFormCreateSize extends ProductFormEvent {
  final int variantIndex;

  ProductFormCreateSize({required this.variantIndex});
}

class ProductFormDeleteSize extends ProductFormEvent {
  final int variantIndex;
  final int sizeIndex;

  ProductFormDeleteSize({required this.variantIndex, required this.sizeIndex});
}

class ProductFormUpdateSize extends ProductFormEvent {
  final int variantIndex;
  final int sizeIndex;
  final String? size;
  final int? isActive;
  final int? stock;

  ProductFormUpdateSize({
    required this.variantIndex,
    required this.sizeIndex,
    this.size,
    this.stock,
    this.isActive,
  });
}

class ProductFormUpdateExistingProduct extends ProductFormEvent {
  final int productId;

  ProductFormUpdateExistingProduct({required this.productId});
}

class ProductFormSaveUpdateProduct extends ProductFormEvent {
  final ProductModel productModel;

  ProductFormSaveUpdateProduct({required this.productModel});
}

class ProductFormResetForm extends ProductFormEvent {}
