part of 'inventory_bloc.dart';

@immutable
sealed class InventoryEvent {}

class InventoryLoadInitialData extends InventoryEvent {}

class  InventoryFilteringList extends InventoryEvent{
  final String query;

  InventoryFilteringList({required this.query});

  
}