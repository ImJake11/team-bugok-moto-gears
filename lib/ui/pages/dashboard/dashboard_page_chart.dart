import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_bugok_business/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:team_bugok_business/ui/widgets/line_chart.dart';

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
  ) => Container(
    height: 40,
    decoration: BoxDecoration(
      borderRadius: borderRadius,
      color: isSelected
          ? Theme.of(context).colorScheme.primary
          : Colors.transparent,
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
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DashboardBloc, DashboardState, int>(
      selector: (state) {
        return 0;
      },
      builder: (context, state) {
        return Container(
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
                      "Weekly Sales Chart",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
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
                Expanded(
                  child: MyLineChart(
                    sales: [
                      5000.00,
                      4300.00,
                      6200.00,
                      6500.00,
                      1200.00,
                      4000.00,
                      2400.00,
                    ],
                    labels: [
                      "Mon",
                      "Tue",
                      "Wed",
                      "Thur",
                      "Fri",
                      "Sat",
                      "Sun",
                    ],
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
