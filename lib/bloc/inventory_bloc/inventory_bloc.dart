import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_bugok_business/utils/database/app_database.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc()
    : super(
        InventoryInitial(products: []),
      ) {
    on<InventoryLoadInitialData>(_inventoryLoadInitialData);

    add(InventoryLoadInitialData());
  }

  FutureOr<void> _inventoryLoadInitialData(
    InventoryLoadInitialData event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      emit(InventoryLoadingState());

      // final List<ProductModel> products = await ProductDB()
      //     .retriveAllProducts();

      emit(InventoryInitial(products: []));
    } catch (e) {
      emit(InventoryErrorState());
    }
  }
}
