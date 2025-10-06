import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_bugok_business/constants/product_form_keys.dart';

part 'product_form_event.dart';
part 'product_form_state.dart';

class ProductFormBloc extends Bloc<ProductFormEvent, ProductFormState> {
  ProductFormBloc() : super(ProductFormInitial()) {
    on<ProductFormUpdateData>(_productFormUpdate);
  }

  void _productFormUpdate(
    ProductFormUpdateData event,
    Emitter<ProductFormState> emit,
  ) {
    if (state is ProductFormInitial) {
      final currentState = state as ProductFormInitial;

      final intValue = int.tryParse(event.value.toString()) ?? 0;
      final doublevalue = double.tryParse(event.value.toString()) ?? 0.00;

      switch (event.key) {
        case ProductFormKeys.productName:
          emit(currentState.copyWith(productName: event.value as String));
          break;
        case ProductFormKeys.category:
          emit(currentState.copyWith(category: event.value as String));
          break;
        case ProductFormKeys.color:
          emit(currentState.copyWith(color: event.value as String));
          break;
        case ProductFormKeys.size:
          emit(currentState.copyWith(size: event.value as String));
          break;
        case ProductFormKeys.costPrice:
          emit(currentState.copyWith(costPrice: doublevalue));
          break;
        case ProductFormKeys.sellingPrice:
          emit(currentState.copyWith(sellingPrice: doublevalue));
          break;
        case ProductFormKeys.stock:
          emit(currentState.copyWith(stock: intValue));
          break;
        case ProductFormKeys.isActive:
          emit(currentState.copyWith(isActive: event.value as bool));
          break;
        default:
          break;
      }
    }
  }
}
