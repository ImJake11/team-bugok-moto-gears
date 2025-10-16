import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/ui/widgets/line_chart.dart';
import 'package:team_bugok_business/utils/model/chart_model.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';

class DashboardPageChart extends StatefulWidget {
  const DashboardPageChart({super.key});

  @override
  State<DashboardPageChart> createState() => _DashboardPageChartState();
}

class _DashboardPageChartState extends State<DashboardPageChart> {
  final DateTime _today = DateTime.now();

  bool _isWeekly = true;

  Widget toggleButton(
    String label,
    bool isSelected,
    BorderRadiusGeometry borderRadius,
  ) => GestureDetector(
    onTap: () => setState(() => _isWeekly = !_isWeekly),
    child: AnimatedContainer(
      
      duration: Duration(milliseconds: 250),
      height: 35,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surfaceDim,
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.shade700,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final endOfMonth = DateTime(
      _today.year,
      _today.month + 1,
      0,
      23,
      59,
      59,
      999,
    );

    final List<String> weeklyLabels = [
      "Mon",
      "Tue",
      "Wed",
      "Thur",
      "Fri",
      "Sat",
      "Sun",
    ];

    final List<String> monthlySalesLabel = List.generate(
      endOfMonth.day,
      (index) {
        return (index + 1).toString();
      },
    );

    return BlocSelector<DashboardBloc, DashboardState, List<ChartModel>>(
      selector: (state) {
        if (state is! DashboardInitial) return [];

        List<SalesModel> sales = state.sales;

        // weekly data
        List<ChartModel> weeklyData = weeklyLabels.asMap().entries.map(
          (entry) {
            final index = entry.key;

            // get the sales based on index
            final salesPerDay = sales
                .where((element) => element.createdAt.weekday - 1 == index)
                .toList();

            final totalSales = salesPerDay.isEmpty
                ? 0.00
                : salesPerDay.fold<double>(0.00, (acc, cur) => acc + cur.total);

            return ChartModel(
              index: index,
              label: entry.value,
              sales: totalSales,
            );
          },
        ).toList();

        // monthly data
        List<ChartModel> monthlyData = monthlySalesLabel.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final value = entry.value;

            // get the sales based on index
            final salesPerDay = sales
                .where((element) => element.createdAt.day - 1 == index)
                .toList();

            final totalSales = salesPerDay.isEmpty
                ? 0.00
                : salesPerDay.fold<double>(0.00, (acc, cur) => acc + cur.total);

            return ChartModel(
              index: index,
              label: value,
              sales: totalSales,
            );
          },
        ).toList();

        return _isWeekly ? weeklyData : monthlyData;
      },
      builder: (context, chartData) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceDim,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 3,
                color: Colors.grey.shade800.withAlpha(120),
                offset: Offset(-3, -3),
              ),
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 3,
                color: Colors.black,
                offset: Offset(3, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xFF555555),
            ),
          ),
          width: double.infinity,
          height: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: Column(
              spacing: 40,
              children: [
                Row(
                  children: [
                    Text(
                      _isWeekly ? "Weekly Sales Chart" : "Monthly Sales Chart",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(2, 2),
                          ),
                          BoxShadow(
                            color: Colors.grey.shade900,
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(-2, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          toggleButton(
                            "Weekly",
                            _isWeekly,
                            BorderRadiusGeometry.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                          toggleButton(
                            "Monthly",
                            !_isWeekly,
                            BorderRadiusGeometry.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: MyLineChart(
                    chartData: chartData,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
