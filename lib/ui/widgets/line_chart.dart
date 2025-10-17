import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:team_bugok_business/utils/model/chart_model.dart';
import 'package:team_bugok_business/utils/services/currency_formetter.dart';

class MyLineChart extends StatefulWidget {
  final double? interval;
  final List<ChartModel> chartData;

  const MyLineChart({
    super.key,
    required this.chartData,
    this.interval = 5000.00,
  });

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  @override
  Widget build(BuildContext context) {
    FlTitlesData tilesData = FlTitlesData(
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 40,
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index < 0 || index >= widget.chartData.length) {
              return const SizedBox();
            }
            return Center(
              child: Text(
                widget.chartData[index].label,
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
          reservedSize: 60,
          getTitlesWidget: (value, meta) => Text(
            "₱${(value / 1000).toStringAsFixed(0)}k",
            style: const TextStyle(fontSize: 12),
          ),
          interval: widget.interval,
        ),
      ),
    );

    final FlDotData dotData = FlDotData(
      show: true,
      getDotPainter: (spot, percent, barData, index) {
        return FlDotCirclePainter(
          radius: 4,
          color: Colors.grey.shade300,
          strokeWidth: 2,
          strokeColor: Theme.of(context).colorScheme.primary,
        );
      },
    );

    FlBorderData borderData = FlBorderData(
      border: Border(
        left: BorderSide(
          color: Colors.grey.shade300,
          width: 2,
        ),
        bottom: BorderSide(
          color: Colors.grey.shade300,
          width: 2,
        ),
      ),
    );

    return LineChart(
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 800),
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
                  currencyFormatter(spot.y),
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
            preventCurveOverShooting: true,
            gradientArea: LineChartGradientArea.wholeChart,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.tertiary,
              ],
            ),
            barWidth: 2,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary.withAlpha(10),
                  Theme.of(context).colorScheme.primary.withAlpha(10),
                  Theme.of(context).colorScheme.primary.withAlpha(10),
                  Theme.of(context).colorScheme.primary.withAlpha(10),
                ],
              ),
            ),
            dotData: dotData,
            spots: [
              for (int i = 0; i < widget.chartData.length; i++)
                FlSpot(i.toDouble(), widget.chartData[i].sales),
            ],
          ),
        ],
      ),
    );
  }
}
