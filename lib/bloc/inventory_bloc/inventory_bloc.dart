import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_bugok_business/utils/database/repositories/product_repository.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc() : super(InventoryInitial(products: [])) {
    on<InventoryLoadInitialData>(_inventoryLoadInitialData);
    on<InventoryFilteringList>(_inventoryFilteringList);
    on<InventoryErrorOccurs>(_inventoryErrorOccurs);
    on<InventoryToggleLoadingState>(_inventoryToggleLoadingState);
  }

  Future<void> _inventoryLoadInitialData(
    InventoryLoadInitialData event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      final products = event.products;
      emit(
        InventoryInitial(
          products: products,
        ),
      );
    } catch (e) {
      emit(InventoryErrorState());
    }
  }

  void _inventoryFilteringList(
    InventoryFilteringList event,
    Emitter<InventoryState> emit,
  ) {
    final query = event.query;
    final s = state as InventoryInitial;

    // guard to check if query is empty we will return initial state instead
    if (query.isEmpty) {
      emit(
        s.copyWith(
          isFiltering: false,
        ),
      );
      return;
    }

    // get the current product list for reference
    List<ProductModel> listReference = s.products;

    // filtered list reference as search results
    List<ProductModel> searchResult = listReference
        .where(
          (e) => e.model.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    // emit new state
    emit(
      s.copyWith(
        isFiltering: true,
        searchResults: searchResult,
      ),
    );
  }

  void _inventoryErrorOccurs(
    InventoryErrorOccurs event,
    Emitter<InventoryState> emit,
  ) {
    emit(InventoryErrorState());
  }

  void _inventoryToggleLoadingState(
    InventoryToggleLoadingState event,
    Emitter<InventoryState> emit,
  ) {
    emit(InventoryLoadingState());
  }
}
