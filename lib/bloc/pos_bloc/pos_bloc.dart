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
  late final ProductRepository productRepository;
  late final SizeRepository sizeRepository;
  late final SalesRepository salesRepository;

  PosBloc() : super(PosInitial()) {
    productRepository = ProductRepository();
    sizeRepository = SizeRepository();
    salesRepository = SalesRepository();
    // ============== Functions ============= //
    on<PosLoadProducts>(_posLoadProducts);
    on<PosSearch>(_posSearch);
    on<PosSelectProduct>(_posSelectProduct);
    on<PosAddProductCart>(_posAddProductCart);
    on<PosQuantityAction>(_posQuantityAction);
    on<PosDeleteCartItem>(_posDeleteCartItem);
    on<PosCheckOutItems>(_posCheckoutItem);
    on<PosSearchBarSuffixIconClicked>(_posSearchBarSuffixIconClicked);
  }

  // to prevent multiple api calls in the same size and variant
  int _currentSizeId = 0;
  int _currentSizeStock = 0;

  FutureOr<void> _posLoadProducts(
    PosLoadProducts event,
    Emitter<PosState> emit,
  ) async {
    try {
      // terminate the function when products is not empty
      if (state is PosProductInitialized) {
        final s = state as PosProductInitialized;

        if (s.products.isNotEmpty) return;
      }

      emit(PosLoadingState());

      List<ProductModel> products = await ProductRepository()
          .retrieveAllProduct();
      emit(PosProductInitialized(products: products));
    } catch (e) {
      emit(PosErrorState(message: "Failed to load products"));
      emit(PosInitial());
    }
  }

  void _posSearch(PosSearch event, Emitter<PosState> emit) async {
    // ensure state is initialized
    final s = state as PosProductInitialized;

    try {
      emit(s.copyWith(isSearching: true));

      final query = event.query.trim();

      // empty query => show all products
      if (query.isEmpty) {
        emit(
          s.copyWith(
            searchResults: s.products,
            query: query,
            isSearching: false,
          ),
        );
        return;
      }

      final results = await productRepository.searchProduct(query);

      emit(
        s.copyWith(
          searchResults: results,
          query: query,
          isSearching: false,
        ),
      );
    } catch (e) {
      print("search error: $e");
      emit(PosErrorState(message: "Failed to search product"));
    } finally {
      // FIX: Use the current state, NOT the old `s`
      final current = state;
      if (current is PosProductInitialized) {
        emit(current.copyWith(isSearching: false));
      }
    }
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
          cart.saleId == newItem.sizeId) {
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
    final id = event.id;

    // is the product that is being modified the same on the cache
    final isSameSize = id == _currentSizeId;

    if (!isSameSize) {
      VariantSizeModel? currentSize = await sizeRepository.getCurrentSizeStock(
        id,
      );
      _currentSizeStock = currentSize?.stock ?? 0;
      _currentSizeId = id;
    }

    final s = state as PosProductInitialized;
    final isAdd = event.isAdd;

    final currentQuantityOnCart = s.cart.firstWhere((e) => e.sizeId == id).quantity;
    final indexOnCurrentCart = s.cart.indexWhere((element) => element.sizeId == id);

    final updatedCart = [...s.cart];

    if (isAdd) {
      if (_currentSizeStock == currentQuantityOnCart) return;

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

    final updatedCart = [...s.cart]..removeWhere((element) => element.sizeId == id);

    emit(s.copyWith(cart: updatedCart));
  }

  void _posCheckoutItem(
    PosCheckOutItems event,
    Emitter<PosState> emit,
  ) async {
    try {
      final s = state as PosProductInitialized;

      List<CartModel> cart = [...s.cart];

      if (cart.isEmpty) return;

      emit(PosLoadingState());

      await salesRepository.insertSale(cart);

      emit(PosCheckOutSuccessful());
      add(PosLoadProducts());
    } catch (e, st) {
      print("Error to checkout item ${e}");
      print(st);
      emit(PosErrorState(message: "Failed to check out product"));
      final current = state;
      if (current is PosProductInitialized) {
        emit(current.copyWith());
      }
    }
  }

  void _posSearchBarSuffixIconClicked(
    PosSearchBarSuffixIconClicked event,
    Emitter<PosState> emit,
  ) {
    final s = state as PosProductInitialized;

    emit(
      s.copyWith(
        searchResults: [],
        query: "",
      ),
    );
  }
}
