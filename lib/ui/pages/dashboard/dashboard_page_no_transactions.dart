import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';

class DashboardPageNoTransactions extends StatelessWidget {
  const DashboardPageNoTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocSelector<DashboardBloc, DashboardState, int>(
            selector: (state) {
              if (state is! DashboardInitial) return 0;
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

              return todaySales.length;
            },
            builder: (context, sales) {
              return Text(
                sales.toString(),
                style: TextStyle(
                  fontSize: 60,
                  color: Theme.of(context).colorScheme.primary,
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
                ),
              );
            },
          ),
          Text(
            'Today',
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
