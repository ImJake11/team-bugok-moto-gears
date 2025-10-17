import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';
import 'package:team_bugok_business/utils/database/repositories/product_repository.dart';
import 'package:team_bugok_business/utils/database/repositories/variant_repository.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

part 'product_form_event.dart';
part 'product_form_state.dart';

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  ProductFormBloc() : super(ProductFormInitial()) {
    on<ProductFormUpdateData>(_productFormUpdate);
    on<ProductFormInsertProduct>(_productFormInsertProduct);
    on<ProductFormCreateVariant>(_productFormCreateVariant);
    on<ProductFormDeleteVariant>(_productFormDeleteVariant);
    on<ProductFormUpdateVariant>(_productFormUpdateVariant);
    on<ProductFormCreateSize>(_productFormCreateSize);
    on<ProductFormDeleteSize>(_productFormDeleteSize);
    on<ProductFormUpdateSize>(_productFormUpdateSize);
    on<ProductFormUpdateExistingProduct>(_productFormUpdateExistingProduct);
    on<ProductFormSaveUpdateProduct>(_productFormSaveUpdateProduct);
    on<ProductFormResetForm>(_productFormResetForm);
  }

  void _productFormUpdate(
    ProductFormUpdateData event,
    Emitter<ProductFormState> emit,
  ) {
    if (state is! ProductFormInitial) return;

    final s = state as ProductFormInitial;
    final doubleValue = double.tryParse(event.value.toString()) ?? 0.00;

    if (event.key == ProductFormKeys.costPrice) {
      emit(
        ProductFormInitial(
          productData: s.productData.copyWith(
            costPrice: doubleValue,
          ),
        ),
      );
      return;
    }

    if (event.key == ProductFormKeys.sellingPrice) {
      emit(
        ProductFormInitial(
          productData: s.productData.copyWith(
            sellingPrice: doubleValue,
          ),
        ),
      );
      return;
    }

    if (event.key == ProductFormKeys.isActive) {
      emit(
        ProductFormInitial(
          productData: s.productData.copyWith(
            isActive: event.value ? 1 : 0,
          ),
        ),
      );
      return;
    }

    // Preserve variants when updating other fields
    final updatedProduct = s.productData.copyWith(
      brand: event.key == ProductFormKeys.brand
          ? event.value
          : s.productData.brand,
      category: event.key == ProductFormKeys.category
          ? event.value
          : s.productData.category,
      model: event.key == ProductFormKeys.model
          ? event.value
          : s.productData.model,
      variants: s.productData.variants,
    );

    emit(ProductFormInitial(productData: updatedProduct));
  }

  void _productFormCreateVariant(
    ProductFormCreateVariant event,
    Emitter<ProductFormState> emit,
  ) {
    if (state is! ProductFormInitial) return;

    final s = state as ProductFormInitial;

    final updatedVariants = [
      ...s.productData.variants,
      VariantModel(color: "", sizes: []),
    ];

    emit(
      ProductFormInitial(
        productData: s.productData.copyWith(
          variants: updatedVariants,
        ),
      ),
    );
  }

  Future<void> _productFormInsertProduct(
    ProductFormInsertProduct event,
    Emitter<ProductFormState> emit,
  ) async {
    if (state is! ProductFormInitial) return;
    final s = state as ProductFormInitial;

    final category = s.productData.category;
    final brand = s.productData.brand;
    final model = s.productData.model;
    final sellingPrice = s.productData.sellingPrice;
    final costPrice = s.productData.costPrice;
    final variants = s.productData.variants;

    emit(ProductFormLoadingState());

    if (category.isEmpty ||
        brand.isEmpty ||
        model.isEmpty ||
        sellingPrice <= 0 ||
        costPrice <= 0 ||
        variants.isEmpty) {
      emit(
        ProductFormValidtionError(message: "Required fields cannot be empty"),
      );
      emit(ProductFormInitial(productData: s.productData));
      return;
    }

    final errorVariants = s.productData.variants.any(
      (element) =>
          element.color.isEmpty ||
          element.sizes.isEmpty ||
          element.sizes.any(
            (size) => size.stock <= 0 || size.sizeValue.isEmpty,
          ),
    );

    if (errorVariants) {
      emit(
        ProductFormValidtionError(
          message: "Please complete all fields for each variant before saving.",
        ),
      );

      emit(ProductFormInitial(productData: s.productData));
      return;
    }

    final isModelExisting = (await ProductRepository().retrieveProductModel())
        .any((e) => e == model);

    if (isModelExisting) {
      emit(
        ProductFormValidtionError(
          message: "Product model is already existing",
        ),
      );

      emit(ProductFormInitial(productData: s.productData));
      return;
    }

    await ProductRepository().insertProduct(s.productData);
    // call success state
    emit(
      ProductFormSaveProduct(
        isSaveOnly: event.isSaveOnly,
        message: "Product Saved Successfull",
      ),
    );
    emit(ProductFormInitial());
  }

  void _productFormDeleteVariant(
    ProductFormDeleteVariant event,
    Emitter<ProductFormState> emit,
  ) async {
    // Ensure the current state is ProductFormInitial before proceeding
    if (state is! ProductFormInitial) return;

    var s = state as ProductFormInitial;
    var i = event.variantIndex;

    // Create a copy of the current variants list to work with
    List<VariantModel> updatedVariantList = [
      ...s.productData.variants,
    ];

    // Get the variant at the specified index
    final VariantModel variant = updatedVariantList.elementAt(i);

    /// Check if the variant has an ID
    /// - If ID is null → this is a **newly added variant** that hasn't been saved yet
    /// - If ID is not null → this is an **existing variant** in the database
    if (variant.id != null) {
      // Toggle the isActive status of the variant
      if (variant.isActive == 0) {
        variant.isActive = 1;
      } else {
        variant.isActive = 0;
      }

      // Update the local list with the modified variant
      List<VariantModel> updatedVariantList = List.from(s.productData.variants)
        ..[i] = s.productData.variants[i].copyWith(isActive: variant.isActive);

      // Persist the updated variant to the database
      await VariantRepository().updateVariant(variant, variant.id!);

      // If the variant was deactivated, show a snackbar notification
      if (variant.isActive == 0) {
        emit(
          ProductFormShowSnackbar(
            message: "Variant ${variant.color} is tagged as inactive",
            duration: Duration(seconds: 10),
          ),
        );
      }

      // Emit the updated state with the modified variants list
      emit(
        ProductFormInitial(
          productData: s.productData.copyWith(variants: updatedVariantList),
        ),
      );

      // Exit the function early since we've handled the existing variant
      return;
    }

    updatedVariantList.removeAt(i);

    emit(
      ProductFormInitial(
        productData: s.productData.copyWith(
          variants: updatedVariantList,
        ),
      ),
    );
  }

  void _productFormUpdateVariant(
    ProductFormUpdateVariant event,
    Emitter<ProductFormState> emit,
  ) {
    if (state is! ProductFormInitial) return;

    final s = state as ProductFormInitial;
    final i = event.variantIndex;
    final color = event.colorValue;

    // check if the picked color is existing
    final isExisting = s.productData.variants.any((e) => e.color == color);

    if (isExisting) {
      emit(
        ProductFormValidtionError(
          message:
              "This color has already been added. Please choose a different color",
        ),
      );
      emit(ProductFormInitial(productData: s.productData.copyWith()));
      return;
    }

    final updatedVariantList = List<VariantModel>.from(s.productData.variants)
      ..[i] = s.productData.variants[i].copyWith(
        color: color,
      );

    emit(
      ProductFormInitial(
        productData: s.productData.copyWith(
          variants: updatedVariantList,
        ),
      ),
    );
  }

  void _productFormCreateSize(
    ProductFormCreateSize event,
    Emitter<ProductFormState> emit,
  ) {
    if (state is! ProductFormInitial) return;

    final s = state as ProductFormInitial;
    final i = event.variantIndex;

    final updatedVariant = s.productData.variants[i].copyWith(
      sizes: [
        ...s.productData.variants[i].sizes,
        VariantSizeModel(sizeValue: "", stock: 0),
      ],
    );

    final updatedVariants = List<VariantModel>.from(s.productData.variants)
      ..[i] = updatedVariant;

    emit(
      ProductFormInitial(
        productData: s.productData.copyWith(
          variants: updatedVariants,
        ),
      ),
    );
  }

  void _productFormDeleteSize(
    ProductFormDeleteSize event,
    Emitter<ProductFormState> emit,
  ) {
    if (state is! ProductFormInitial) return;
    final s = state as ProductFormInitial;
    final variantI = event.variantIndex;
    final sizeI = event.sizeIndex;

    List<VariantSizeModel> sizes = [...s.productData.variants[variantI].sizes];

    VariantSizeModel size = sizes.elementAt(sizeI);

    if (size.id != null) {
      sizes[sizeI] = size.copyWith(
        isActive: size.isActive == 1 ? 0 : 1,
      );

      final updatedVariants = List<VariantModel>.from(s.productData.variants)
        ..[variantI] = s.productData.variants[variantI].copyWith(sizes: sizes);

      if (sizes[sizeI].isActive == 0) {
        emit(
          ProductFormShowSnackbar(
            message: "Size ${size.sizeValue} is set as inactive",
            duration: Duration(seconds: 5),
          ),
        );
      }

      emit(
        ProductFormInitial(
          productData: s.productData.copyWith(
            variants: updatedVariants,
          ),
        ),
      );
      return;
    }

    sizes.removeAt(sizeI);

    final updatedVariant = List<VariantModel>.from(s.productData.variants)
      ..[variantI] = s.productData.variants[variantI].copyWith(
        sizes: sizes,
      );

    emit(
      ProductFormInitial(
        productData: s.productData.copyWith(
          variants: updatedVariant,
        ),
      ),
    );
  }

  void _productFormUpdateSize(
    ProductFormUpdateSize event,
    Emitter<ProductFormState> emit,
  ) {
    if (state is! ProductFormInitial) return;

    final s = state as ProductFormInitial;
    final variantI = event.variantIndex;
    final sizeI = event.sizeIndex;

    final sizes = [...s.productData.variants[variantI].sizes];

    VariantSizeModel size = sizes.elementAt(sizeI);

    sizes[sizeI] = size.copyWith(
      isActive: event.isActive ?? size.isActive,
      sizeValue: event.size ?? size.sizeValue,
      stock: event.stock ?? size.stock,
    );

    final updatedVariants = [...s.productData.variants]
      ..[variantI] = s.productData.variants[variantI].copyWith(sizes: sizes);

    emit(
      ProductFormInitial(
        productData: s.productData.copyWith(
          variants: updatedVariants,
        ),
      ),
    );
  }

  void _productFormUpdateExistingProduct(
    ProductFormUpdateExistingProduct event,
    Emitter<ProductFormState> emit,
  ) async {
    try {
      emit(ProductFormLoadingState());
      final productModel = await ProductRepository().fetchSingleProduct(
        event.productId,
      );
      await Future.delayed(Duration(seconds: 1));
      emit(
        ProductFormInitial(
          productData: productModel,
        ),
      );
    } catch (e, st) {
      print("Error fetching product ${e}");
      print(st);
      emit(ProductFormErrorState(message: "Failed to fetched product"));
    }
  }

  void _productFormResetForm(
    ProductFormResetForm event,
    Emitter<ProductFormState> emit,
  ) {
    emit(ProductFormInitial());
  }

  void _productFormSaveUpdateProduct(
    ProductFormSaveUpdateProduct event,
    Emitter<ProductFormState> emit,
  ) async {
    if (state is! ProductFormInitial) return;

    final s = state as ProductFormInitial;

    try {
      await ProductRepository().updateProduct(event.productModel);
      emit(
        ProductFormSaveProduct(
          isSaveOnly: true,
          message: "Product Updated Successful",
        ),
      );
      emit(ProductFormInitial());
    } catch (e) {
      emit(ProductFormErrorState(message: "Failed to update product"));
      emit(s.copyWith());
    }
  }
}
