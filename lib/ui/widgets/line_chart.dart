import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyLineChart extends StatefulWidget {
  final List<double> sales;
  final List<String> labels;

  const MyLineChart({
    super.key,
    required this.sales,
    required this.labels,
  });

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    FlTitlesData tilesData = FlTitlesData(
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 40,
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 0 || index >= widget.labels.length) {
              return const SizedBox();
            }
            return Center(
              child: Text(
                widget.labels[index],
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            );
          },
          interval: 1,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          maxIncluded: false,
          minIncluded: false,
          showTitles: true,
          reservedSize: 50,
          getTitlesWidget: (value, meta) => Text(
            '₱${value ~/ 1000}k',
            style: const TextStyle(fontSize: 12),
          ),
          interval: 2000,
        ),
      ),
    );

    final FlDotData dotData = FlDotData(
      show: true,
      getDotPainter: (spot, percent, barData, index) {
        return FlDotCirclePainter(
          radius: 5,
          color: Colors.grey.shade600,
          strokeWidth: 2,
          strokeColor: Theme.of(context).colorScheme.primary,
        );
      },
    );

    FlBorderData borderData = FlBorderData(
      border: Border(
        left: BorderSide(
          color: Colors.grey.shade600,
          width: 3,
        ),
        bottom: BorderSide(
          color: Colors.grey.shade600,
          width: 3,
        ),
      ),
    );

    return LineChart(
      LineChartData(
        minY: 0,
        gridData: FlGridData(
          drawHorizontalLine: false,
          drawVerticalLine: false,
        ),
        borderData: borderData,
        titlesData: tilesData,
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => Colors.grey.shade600,
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            tooltipMargin: 8,
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  // 👇 Custom text inside tooltip
                  '₱${spot.y.toStringAsFixed(2)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: theme.primary,
            barWidth: 2,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withAlpha(150),
                  Theme.of(context).colorScheme.primary.withAlpha(70),
                   Theme.of(context).colorScheme.primary.withAlpha(30)
                ],
              ),
            ),
            dotData: dotData,
            spots: [
              for (int i = 0; i < widget.sales.length; i++)
                FlSpot(i.toDouble(), widget.sales[i]),
            ],
          ),
        ],
      ),
    );
  }
}
