import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_bugok_business/utils/database/repositories/product_repository.dart';
import 'package:team_bugok_business/utils/database/repositories/sales_repository.dart';
import 'package:team_bugok_business/utils/database/repositories/size_repository.dart';
import 'package:team_bugok_business/utils/model/cart_model.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

part 'pos_event.dart';
part 'pos_state.dart';

class PosBloc extends Bloc<PosEvent, PosState> {
  PosBloc() : super(PosInitial()) {
    on<PosLoadProducts>(_posLoadProducts);
    on<PosSearch>(_posSearch);
    on<PosSelectProduct>(_posSelectProduct);
    on<PosAddProductCart>(_posAddProductCart);
    on<PosQuantityAction>(_posQuantityAction);
    on<PosDeleteCartItem>(_posDeleteCartItem);
    on<PosCheckOutItems>(_posCheckoutItem);

    add(PosLoadProducts());
  }

  final SizeRepository _sizeRepository = SizeRepository();

  FutureOr<void> _posLoadProducts(
    PosLoadProducts event,
    Emitter<PosState> emit,
  ) async {
    emit(PosLoadingState());
    List<ProductModel> products = await ProductRepository()
        .retrieveAllProduct();
    emit(PosProductInitialized(products: products));
  }

  void _posSearch(PosSearch event, Emitter<PosState> emit) async {
    final s = state as PosProductInitialized;
    final query = event.query.trim();
    final products = s.products;
    List<ProductModel> searchResults = [];

    // If query is empty, just reset results immediately
    if (query.isEmpty) {
      emit(s.copyWith(searchResults: products, query: query));
      return;
    }

    searchResults = products
        .where((p) => p.model.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(s.copyWith(searchResults: searchResults, query: query));
  }

  void _posSelectProduct(PosSelectProduct event, Emitter<PosState> emit) {
    final s = state as PosProductInitialized;

    emit(s.copyWith(selectedProductID: event.productID));
  }

  void _posAddProductCart(PosAddProductCart event, Emitter<PosState> emit) {
    final s = state as PosProductInitialized;

    final updatedCart = [...s.cart];

    final newItem = event.cartModel;

    //serve as index holder if current product id is existing to cart list
    final isExisting = updatedCart.any((cart) {
      if (cart.color == newItem.color &&
          cart.size == newItem.size &&
          cart.id == newItem.id) {
        return true;
      }

      return false;
    });

    if (isExisting) {
      emit(PosErrorState(message: "This product is existing on your cart"));
    } else {
      updatedCart.add(event.cartModel);
    }

    emit(
      s.copyWith(
        cart: updatedCart,
        selectedProductID: 0,
      ),
    );
  }

  void _posQuantityAction(
    PosQuantityAction event,
    Emitter<PosState> emit,
  ) async {
    final s = state as PosProductInitialized;

    final id = event.id;
    final isAdd = event.isAdd;

    VariantSizeModel currentSize = await _sizeRepository.querySize(id);
    final stock = currentSize.stock;

    final currentQuantityOnCart = s.cart.firstWhere((e) => e.id == id).quantity;
    final indexOnCurrentCart = s.cart.indexWhere((element) => element.id == id);

    final updatedCart = [...s.cart];

    if (isAdd) {
      if (stock == currentQuantityOnCart) return;

      updatedCart[indexOnCurrentCart] = s.cart[indexOnCurrentCart].copyWith(
        quantity: currentQuantityOnCart + 1,
      );
    } else {
      if (currentQuantityOnCart > 1) {
        updatedCart[indexOnCurrentCart] = s.cart[indexOnCurrentCart].copyWith(
          quantity: currentQuantityOnCart - 1,
        );
      }
    }

    emit(s.copyWith(cart: updatedCart));
  }

  void _posDeleteCartItem(
    PosDeleteCartItem event,
    Emitter<PosState> emit,
  ) {
    final s = state as PosProductInitialized;

    final id = event.id;

    final updatedCart = [...s.cart]..removeWhere((element) => element.id == id);

    emit(s.copyWith(cart: updatedCart));
  }

  void _posCheckoutItem(
    PosCheckOutItems event,
    Emitter<PosState> emit,
  ) async {
    try {
      final s = state as PosProductInitialized;

      List<CartModel> cart = [...s.cart];

      emit(PosLoadingState());

      await SalesRepository().insertSale(cart);

      emit(PosCheckOutSuccessful());
      add(PosLoadProducts());
    } catch (e, st) {
      print("Error to checkout item ${e}");
      print(st);
      emit(PosErrorState(message: "Failed to check out product"));
    }
  }
}
