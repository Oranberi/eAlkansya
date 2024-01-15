import 'package:ealkansyaapp/pages/analytics_page.dart';
import 'package:ealkansyaapp/pages/analytics_pages/coin_report.dart';
import 'package:ealkansyaapp/pages/analytics_pages/week_report.dart';
import 'package:ealkansyaapp/pages/reciept_page.dart';
import 'package:ealkansyaapp/pages/start_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Start(),
      routes: {
        '/home': (context) => Start(),
        '/reciept_page': (context) => reciept_page(),
        '/analytics_page': (context) => analytics_page(),
        '/week_report': (context) => week_report(),
        '/coin_drop': (context) => coin_report(),
      },
    );
  }
}
