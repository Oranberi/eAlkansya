import 'package:ealkansyaapp/pages/bar%20graph/bar_data_coin.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class barGraph_Coin extends StatelessWidget {
  final List coinReport;
  const barGraph_Coin({super.key, required this.coinReport});

  @override
  Widget build(BuildContext context) {
    BarData_Coin thisbarData = BarData_Coin(
        oneCount: coinReport[0],
        fiveCount: coinReport[1],
        tenCount: coinReport[2],
        twentyCount: coinReport[3]);
    thisbarData.initializeBarData_Coin();
    return BarChart(BarChartData(
        maxY: 200,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: thisbarData.barData_Coin
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.blue[700],
                      width: 15,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 200,
                        color: Colors.blue[200],
                      ))
                ]))
            .toList()));
  }
}
