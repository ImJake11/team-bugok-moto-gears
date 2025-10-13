part of 'inventory_bloc.dart';

@immutable
sealed class InventoryState {}

final class InventoryInitial extends InventoryState {
  final List<ProductModel> products;

  InventoryInitial({required this.products});
}

class InventoryLoadingState extends InventoryState {}

class InventoryNoDataFound extends InventoryState {}

class InventoryFilteredState extends InventoryState {}

class InventoryErrorState extends InventoryState {}
