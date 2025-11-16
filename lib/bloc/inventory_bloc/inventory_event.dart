part of 'inventory_bloc.dart';

@immutable
sealed class InventoryEvent {}

class InventoryLoadInitialData extends InventoryEvent {
  final List<ProductModel> products;

  InventoryLoadInitialData({required this.products});
}

class InventoryToggleLoadingState extends InventoryEvent {}
class InventoryErrorOccurs extends InventoryEvent {}
class InventoryFilteringList extends InventoryEvent {
  final String query;

  InventoryFilteringList({required this.query});
}
