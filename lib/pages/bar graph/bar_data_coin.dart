import 'package:ealkansyaapp/pages/bar%20graph/individual_bar.dart';

class BarData_Coin {
  final double oneCount;
  final double fiveCount;
  final double tenCount;
  final double twentyCount;

  BarData_Coin(
      {required this.oneCount,
      required this.fiveCount,
      required this.tenCount,
      required this.twentyCount});

  List<IndividualBar> barData_Coin = [];

  void initializeBarData_Coin() {
    barData_Coin = [
      IndividualBar(x: 1, y: oneCount),
      IndividualBar(x: 5, y: fiveCount),
      IndividualBar(x: 10, y: tenCount),
      IndividualBar(x: 20, y: twentyCount)
    ];
  }
}
