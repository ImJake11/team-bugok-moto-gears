import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/utils/database/repositories/sales_repository.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  late final StreamSubscription posBlocSub;

  DashboardBloc({
    required PosBloc posBloc,
  }) : super(DashboardInitial(sales: [])) {
    posBlocSub = posBloc.stream.listen(
      (PosState s) {
        if (s is PosCheckOutSuccessful) {
          add(DashboardLoadData());
        }
      },
    );

    on<DashboardLoadData>(_dashboardLoadData);

    add(DashboardLoadData());
  }

  void _dashboardLoadData(
    DashboardLoadData event,
    Emitter<DashboardState> emit,
  ) async {
    final List<SalesModel> sales = await SalesRepository().retrieveSales(
      isFilterInCurrentWeek: true,
    );
    emit(DashboardInitial(sales: sales));
  }
}
