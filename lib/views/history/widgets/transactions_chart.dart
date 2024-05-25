import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spendwise/core/models/transaction_model/transaction_model.dart';
import 'package:spendwise/views/themes/app_colors.dart';

class SimpleLineChart extends StatelessWidget {
  final List<Transaction> transactions;

  const SimpleLineChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> data = transactions
        .asMap()
        .entries
        .map(
          (entry) => FlSpot(
            entry.key.toDouble(),
            entry.value.value,
          ),
        )
        .toList();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 1,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: AppColors.white,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: Colors.grey,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < transactions.length) {
                  final transaction = transactions[index];
                  final date = transaction.date;
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      "${date.day}/${date.month}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                return Center(
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d)),
        ),
        minX: 0,
        maxX: (transactions.length - 1).toDouble(),
        minY: 0,
        maxY: transactions.map((t) => t.value).reduce((a, b) => a > b ? a : b),
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: true,
            gradient: const LinearGradient(
              colors: [AppColors.primaryColor, AppColors.primaryLightColor],
            ),
            barWidth: 5,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.cyan.withOpacity(0.3),
                  Colors.blue.withOpacity(0.3)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
