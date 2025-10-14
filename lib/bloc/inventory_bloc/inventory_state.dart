part of 'inventory_bloc.dart';

@immutable
sealed class InventoryState {}

final class InventoryInitial extends InventoryState {
  final List<ProductModel> products;
  final List<ProductModel> searchResults;
  final bool isFiltering;

  InventoryInitial({
    required this.products,
    this.searchResults = const [],
    this.isFiltering = false,
  });

  InventoryInitial copyWith({
    List<ProductModel>? products,
    bool? isFiltering,
    List<ProductModel>? searchResults,
  }) {
    return InventoryInitial(
      products: products ?? this.products,
      isFiltering: isFiltering ?? this.isFiltering,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

class InventoryLoadingState extends InventoryState {}

class InventoryNoDataFound extends InventoryState {}

class InventoryErrorState extends InventoryState {}
