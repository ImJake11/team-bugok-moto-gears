import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class DashboardPageTodaySales extends StatelessWidget {
  const DashboardPageTodaySales({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocSelector<DashboardBloc, DashboardState, double>(
        selector: (state) {
          if (state is DashboardInitial) {
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

            final filteredSales = state.sales.where(
              (e) =>
                  e.createdAt.isAfter(startOfDay) &&
                  e.createdAt.isBefore(endOfDay),
            );

            final total = filteredSales.fold<double>(
              0.00,
              (previousValue, element) => previousValue += element.total,
            );

            return total;
          }
          return 0.00;
        },
        builder: (context, total) {
          return Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    currencyFormatter(total),
                    style: TextStyle(
                      fontSize: 27,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black,
                          offset: Offset(3, 3),
                        ),
                        Shadow(
                          blurRadius: 5,
                          color: Colors.grey.shade800.withAlpha(120),
                          offset: Offset(-3, -3),
                        ),
                      ],
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),

              // performace indicator
              // Container(
              //   width: 80,
              //   height: 30,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(40),
              //     color: Colors.green.withAlpha(50),
              //   ),
              //   child: Center(
              //     child: Text(
              //       '+ 4.6%',
              //       style: TextStyle(
              //         color: Colors.green,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 14,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
