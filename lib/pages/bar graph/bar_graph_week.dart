import 'package:ealkansyaapp/pages/bar%20graph/bar_data_week.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class barGraph_Week extends StatelessWidget {
  final List weekReport;
  const barGraph_Week({super.key, required this.weekReport});

  @override
  Widget build(BuildContext context) {
    BarData_Week thisbarData = BarData_Week(
        monAmount: weekReport[0],
        tueAmount: weekReport[1],
        wedAmount: weekReport[2],
        thurAmount: weekReport[3],
        friAmount: weekReport[4],
        satAmount: weekReport[5],
        sunAmount: weekReport[6]);
    thisbarData.initializeBarData_Week();
    return BarChart(BarChartData(
        maxY: 200,
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
                      color: Color(0xffffcc06),
                      width: 15,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 200,
                        color: Color(0xff013174),
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
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('Th', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('Su', style: style);
        break;
      default:
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}
