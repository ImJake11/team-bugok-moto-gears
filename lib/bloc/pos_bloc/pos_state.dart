part of 'pos_bloc.dart';

@immutable
sealed class PosState {}

final class PosInitial extends PosState {}

class PosProductInitialized extends PosState {
  final String query;
  final List<ProductModel> products;
  final List<ProductModel> searchResults;
  final List<CartModel> cart;
  final int selectedProductID;

  PosProductInitialized({
    required this.products,
    this.searchResults = const [],
    this.query = '',
    this.cart = const [],
    this.selectedProductID = 0,
  });

  PosProductInitialized copyWith({
    List<ProductModel>? products,
    List<ProductModel>? searchResults,
    String? query,
    int? selectedProductID,
    List<CartModel>? cart,
  }) {
    return PosProductInitialized(
      products: products ?? this.products,
      query: query ?? this.query,
      searchResults: searchResults ?? this.searchResults,
      cart: cart ?? this.cart,
      selectedProductID: selectedProductID ?? this.selectedProductID,
    );
  }
}

class PosLoadingState extends PosState {}

class PosErrorState extends PosState {
  final String message;

  PosErrorState({required this.message});
}

class PosCheckOutSuccessful extends PosState {}
