import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/utils/database/repositories/product_repository.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  late final StreamSubscription posBlocSub;
  late final StreamSubscription formBlocSub;

  InventoryBloc({
    required PosBloc posBloc,
    required ProductFormBloc formBloc,
  }) : super(InventoryInitial(products: [])) {
    // SUBSCRIPTIONS
    posBlocSub = posBloc.stream.listen(
      (PosState s) {
        if (s is PosCheckOutSuccessful) {
          add(InventoryLoadInitialData());
        }
      },
    );

    formBlocSub = formBloc.stream.listen((ProductFormState s) {
      if (s is ProductFormSaveProduct) {
        add(InventoryLoadInitialData());
      }
    });

    on<InventoryLoadInitialData>(_inventoryLoadInitialData);
    on<InventoryFilteringList>(_inventoryFilteringList);

    add(InventoryLoadInitialData());
  }

  Future<void> _inventoryLoadInitialData(
    InventoryLoadInitialData event,
    Emitter<InventoryState> emit,
  ) async {
    try {
      emit(InventoryLoadingState());

      final List<ProductModel> products = await ProductRepository()
          .retrieveAllProduct();

      await Future.delayed(Duration(seconds: 2));
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
}
