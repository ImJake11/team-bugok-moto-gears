import 'package:team_bugok_business/utils/model/chart_model.dart';
import 'package:team_bugok_business/utils/model/sales_model.dart';

({List<ChartModel> chartData, double totalSales}) getChartData({
  required List<SalesModel> sales,
  required DateTime referenceDate,
  required bool isWeekly,
}) {
  final endOfMonth = DateTime(
    referenceDate.year,
    referenceDate.month + 1,
    0,
    23,
    59,
    59,
    999,
  );

  List<String> monthlyLabels = List.generate(
    endOfMonth.day,
    (index) {
      return (index + 1).toString();
    },
  );

  List<String> weekLabels = [
    "Mon",
    "Tue",
    "Wed",
    "Thur",
    "Fri",
    "Sat",
    "Sun",
  ];

  List<ChartModel> chartData = [];
  double totalSales = 0.00;

  if (isWeekly) {
    final startOfWeek = referenceDate.subtract(
      Duration(days: referenceDate.weekday - 1),
    );

    chartData = List.generate(7, (index) {
      final day = startOfWeek.add(Duration(days: index));

      final salesPerDay = sales.where((element) {
        final created = element.createdAt;
        return created.year == day.year &&
            created.month == day.month &&
            created.day == day.day;
      }).toList();

      final totalSales = salesPerDay.fold<double>(
        0.00,
        (acc, cur) => acc + cur.total,
      );

      return ChartModel(
        index: index,
        label: weekLabels[index], // e.g., "Mon", "Tue", etc.
        sales: totalSales,
      );
    });
  } else {
    chartData = monthlyLabels.asMap().entries.map(
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
  }

  totalSales = chartData.fold<double>(
    0.00,
    (acc, cur) => acc + cur.sales,
  );

  return (
    chartData: chartData,
    totalSales: totalSales,
  );
}
