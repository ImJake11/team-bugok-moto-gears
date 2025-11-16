import 'package:flutter/material.dart';
import 'package:team_bugok_business/ui/widgets/line_chart.dart';
import 'package:team_bugok_business/utils/model/chart_model.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

Widget expensesPageLineChart(
  List<ExpensesModel> expenses,
  MyThemeProvider theme,
) {
  const List<String> shortMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  List<ChartModel> chartData = shortMonths.asMap().entries.map(
    (entry) {
      final index = entry.key;
      final value = entry.value;

      // get the sales based on index
      final salesPerDay = expenses.where(
        (element) => element.createdAt - 1 == index, // fix this later
      );

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

  return Container(
    decoration: BoxDecoration(
      color: theme.surfaceDim,
      boxShadow: theme.shadow,
      borderRadius: BorderRadius.circular(10),
    ),
    width: 600,
    height: 280,
    child: Padding(
      padding: const EdgeInsets.only(
        right: 30,
        top: 30,
      ),
      child: MyLineChart(
        interval: 200000.00,
        chartData: chartData,
      ),
    ),
  );
}
