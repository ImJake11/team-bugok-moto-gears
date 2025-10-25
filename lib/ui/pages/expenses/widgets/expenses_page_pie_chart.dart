import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:team_bugok_business/utils/constants/expenses_options.dart';
import 'package:team_bugok_business/utils/model/expenses_model.dart';
import 'package:team_bugok_business/utils/provider/theme_provider.dart';

Widget expensesPagePieChart(
  List<ExpensesModel> expenses,
  MyThemeProvider theme,
) {
  final expensesOption = expensesOptions.asMap();

  Map<int, double> pieData = {};

  expensesOption.forEach(
    (key, value) {
      final expensesTotal = expenses
          .where((e) => e.category == key)
          .fold(0.00, (p, c) => p + c.total);

      pieData[key] = expensesTotal;
    },
  );

  final total = pieData.values.reduce((a, b) => a + b);

  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: theme.surfaceDim,
        boxShadow: theme.shadow,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 280,
      child: Column(
        spacing: 10,
        children: [
          const SizedBox(height: 3),
          Text('Expenses Breakdown'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade800,
                        width: 2,
                      ),
                      color: Colors.grey.shade900,
                      shape: BoxShape.circle,
                    ),
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 29,
                        sections: pieData.entries.map((e) {
                          final percentage = (e.value / total) * 100;
                          final color = _getColorForLabel(
                            expensesOptions[e.key],
                          );
                          return PieChartSectionData(
                            color: color,
                            value: e.value,
                            title: '${percentage.toStringAsFixed(1)}%',
                            radius: 50,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    direction: Axis.horizontal,
                    children: List.generate(
                      pieData.keys.length,
                      (index) {
                        final keys = pieData.keys.toList();

                        final label = expensesOptions[keys[index]];

                        return Row(
                          spacing: 5,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: _getColorForLabel(label),
                                shape: BoxShape.circle,
                              ),
                            ),

                            Text(
                              label,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Color _getColorForLabel(String label) {
  switch (label) {
    case 'Salary':
      return Color(0xFF4CAF50);
    case 'Utility Bills':
      return Color(0xFF2196F3);
    case 'Product Stocking':
      return Color(0xFFFFC107);
    case 'Rent':
      return Color(0xFF9C27B0);
    default:
      return Color(0xFF9E9E9E);
  }
}
