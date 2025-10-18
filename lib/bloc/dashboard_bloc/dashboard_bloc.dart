import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/bloc/product_form_bloc/product_form_bloc.dart';
import 'package:team_bugok_business/utils/database/repositories/expenses_repository.dart';
import 'package:team_bugok_business/utils/database/repositories/product_repository.dart';
import 'package:team_bugok_business/utils/database/repositories/sales_repository.dart';
import 'package:team_bugok_business/utils/database/repositories/size_repository.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  late final StreamSubscription posBlocSub;
  late final StreamSubscription formBlocSub;

  DashboardBloc({required PosBloc posBloc, required ProductFormBloc formBloc})
    : super(
        DashboardInitial(
          expenses: [],
          currentDate: DateTime.now(),
          sales: [],
          products: [],
          sizes: [],
        ),
      ) {
    // ======== SUBSCRIPTIONS ====== //
    posBlocSub = posBloc.stream.listen(
      (PosState s) {
        if (s is PosCheckOutSuccessful) {
          add(DashboardLoadData());
        }
      },
    );

    formBlocSub = formBloc.stream.listen((ProductFormState state) {
      if (state is ProductFormSaveProduct) {
        add(DashboardLoadData());
      }
    });

    // =========== FUNCTIONS ====== //
    on<DashboardLoadData>(_dashboardLoadData);
    on<DashboardPickDate>(_dashboardPickDate);

    // ========= INITIAL FUNCTIONS ============ //
    add(DashboardLoadData());
  }

  void _dashboardLoadData(
    DashboardLoadData event,
    Emitter<DashboardState> emit,
  ) async {
    final List<SalesModel> sales = await SalesRepository().retrieveSales(
      isFilterInCurrentMonth: true,
    );
    final List<ProductModel> products = await ProductRepository()
        .retrieveAllProduct();

    final sizes = await SizeRepository().retrieveAllSizes();

    final expenses = await ExpensesRepository().retriveAllExpenses(
      isMonthOnly: true,
    );

    emit(
      DashboardInitial(
        expenses: expenses,
        currentDate: DateTime.now(),
        sales: sales,
        products: products,
        sizes: sizes,
      ),
    );
  }

  Future<void> _dashboardPickDate(
    DashboardPickDate event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is! DashboardInitial) return;

    final referenceDate = event.referenceDate;

    final List<SalesModel> sales = await SalesRepository().retrieveSales(
      isFilterInCurrentMonth: true,
      referenceDate: referenceDate,
    );
    final List<ProductModel> products = await ProductRepository()
        .retrieveAllProduct();

    final sizes = await SizeRepository().retrieveAllSizes();

    final expenses = await ExpensesRepository().retriveAllExpenses(
      isMonthOnly: true,
      referenceDate: referenceDate,
    );

    emit(
      DashboardInitial(
        expenses: expenses,
        currentDate: referenceDate,
        sales: sales,
        products: products,
        sizes: sizes,
      ),
    );
  }

}
