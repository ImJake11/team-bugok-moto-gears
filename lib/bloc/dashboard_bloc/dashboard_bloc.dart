import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:team_bugok_business/bloc/pos_bloc/pos_bloc.dart';
import 'package:team_bugok_business/utils/database/repositories/product_repository.dart';
import 'package:team_bugok_business/utils/database/repositories/sales_repository.dart';
import 'package:team_bugok_business/utils/database/repositories/size_repository.dart';
import 'package:team_bugok_business/utils/model/product_model.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';
import 'package:team_bugok_business/utils/model/variant_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  late final StreamSubscription posBlocSub;

  DashboardBloc({
    required PosBloc posBloc,
  }) : super(
         DashboardInitial(
           sales: [],
           products: [],
           sizes: [],
         ),
       ) {
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
      isFilterInCurrentMonth: true,
    );
    final List<ProductModel> products = await ProductRepository()
        .retrieveAllProduct();

    final sizes = await SizeRepository().retrieveAllSizes();

    emit(
      DashboardInitial(
        sales: sales,
        products: products,
        sizes: sizes,
      ),
    );
  }
}
