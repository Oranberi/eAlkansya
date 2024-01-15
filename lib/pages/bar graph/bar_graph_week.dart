import 'package:ealkansyaapp/pages/bar%20graph/bar_data_week.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class barGraph_Week extends StatelessWidget {
  final List weekReport;
  const barGraph_Week({super.key, required this.weekReport});

  @override
  Widget build(BuildContext context) {
    BarData_Week thisbarData = BarData_Week(
        sunAmount: weekReport[0],
        monAmount: weekReport[1],
        tueAmount: weekReport[2],
        wedAmount: weekReport[3],
        thurAmount: weekReport[4],
        friAmount: weekReport[5],
        satAmount: weekReport[6]);
    thisbarData.initializeBarData_Week();
    return BarChart(BarChartData(
        maxY: 300,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles:
                SideTitles(showTitles: true, getTitlesWidget: getBottomTiles),
          ),
        ),
        barGroups: thisbarData.barData_Week
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.blue[700],
                      width: 15,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 300,
                        color: Colors.blue[200],
                      ))
                ]))
            .toList()));
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 11);

    Widget text = const Text('M', style: style);
    switch (value.toInt()) {
      case 0:
        text = const Text('S', style: style);
        break;
      case 1:
        text = const Text('M', style: style);
        break;
      case 2:
        text = const Text('T', style: style);
        break;
      case 3:
        text = const Text('W', style: style);
        break;
      case 4:
        text = const Text('TH', style: style);
        break;
      case 5:
        text = const Text('F', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}
