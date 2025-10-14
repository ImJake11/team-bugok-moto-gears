import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';
import 'package:team_bugok_business/utils/services/convertDateStringToDate.dart';
import 'package:team_bugok_business/utils/services/extract_time.dart';

class DashboardPageSales extends StatelessWidget {
  const DashboardPageSales({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 11),
      child: BlocSelector<DashboardBloc, DashboardState, List<SalesModel>>(
        selector: (state) {
          if (state is! DashboardInitial) return [];

          final now = DateTime.now();
          final startOfDay = DateTime(now.year, now.month, now.day);
          final endOfDay = DateTime(
            now.year,
            now.month,
            now.day,
            23,
            59,
            59,
            999,
          );

          List<SalesModel> todaySales = state.sales
              .where(
                (e) =>
                    e.createdAt.isAfter(startOfDay) &&
                    e.createdAt.isBefore(endOfDay),
              )
              .toList();

          return todaySales;
        },
        builder: (context, sales) {
          return SizedBox(
            child: SingleChildScrollView(
              child: Column(

                children: List.generate(
                  sales.length,
                  (index) {
                    final sale = sales[index];

                    return SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            convertDateStringToDate(sale.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            extractTime(
                              sale.createdAt,
                              showSeconds: false,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
