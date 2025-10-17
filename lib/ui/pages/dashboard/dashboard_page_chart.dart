import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/ui/widgets/animated_text_value_change.dart';
import 'package:team_bugok_business/ui/widgets/line_chart.dart';
import 'package:team_bugok_business/utils/helpers/dashboard_get_chart_data_and_sales_total.dart';
import 'package:team_bugok_business/utils/model/chart_model.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';

class DashboardPageChart extends StatefulWidget {
  const DashboardPageChart({super.key});

  @override
  State<DashboardPageChart> createState() => _DashboardPageChartState();
}

class _DashboardPageChartState extends State<DashboardPageChart> {
  bool _isWeekly = true;

  Widget toggleButton(
    String label,
    bool isSelected,
    BorderRadiusGeometry borderRadius,
  ) => GestureDetector(
    onTap: () => setState(() => _isWeekly = !_isWeekly),
    child: AnimatedContainer(
      duration: Duration(milliseconds: 250),
      height: 30,
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DashboardBloc,
      DashboardState,
      ({List<ChartModel> chartData, double totalSales})?
    >(
      selector: (state) {
        if (state is! DashboardInitial) return null;

        List<SalesModel> sales = state.sales;

        return getChartData(
          sales: sales,
          referenceDate: state.currentDate,
          isWeekly: _isWeekly,
        );
      },
      builder: (context, data) {
        if (data == null) return const SizedBox();

        final chartData = data.chartData;
        final totalSales = data.totalSales;

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
          height: 380,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: Column(
              spacing: 20,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 5,
                      children: [
                        Text(
                          _isWeekly
                              ? "Weekly Sales Chart"
                              : "Monthly Sales Chart",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AnimatedTextValueChange(
                          value: totalSales,
                          isCurrency: true,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          duration: Duration(seconds: 1),
                        ),
                      ],
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
