import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/inventory_bloc/inventory_bloc.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  late final StreamSubscription posBlocSub;
  late final StreamSubscription formBlocSub;

  InventoryBloc({
    required PosBloc posBloc,
    required ProductFormBloc formBloc,
  }) : super(InventoryInitial(products: [])) {
    // Listen to POS bloc
    posBlocSub = posBloc.stream.listen((posState) {
      if (posState is PosCheckOutSuccessful) {
        add(InventoryLoadInitialData());
      }
    });

    // Listen to ProductForm bloc
    formBlocSub = formBloc.stream.listen((formState) {
      if (formState is ProductFormSuccessAndSaveOnly) {
        add(InventoryLoadInitialData());
      }
    });
  }

  @override
  Future<void> close() {
    posBlocSub.cancel();
    formBlocSub.cancel();
    return super.close();
  }
}
