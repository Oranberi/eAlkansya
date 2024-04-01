import 'package:ealkansyaapp/pages/BL/bluetooth.dart';
import 'package:ealkansyaapp/pages/analytics_page.dart';
import 'package:ealkansyaapp/pages/analytics_pages/coin_report.dart';
import 'package:ealkansyaapp/pages/analytics_pages/week_report.dart';
import 'package:ealkansyaapp/pages/bluetooth/blConnect.dart';
import 'package:ealkansyaapp/pages/coinHistory_page.dart';
import 'package:ealkansyaapp/pages/mysaving_page.dart';
import 'package:ealkansyaapp/pages/reciept_page.dart';
import 'package:ealkansyaapp/pages/start_page.dart';
import 'package:ealkansyaapp/pages/test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Start(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => Start(),
        '/reciept_page': (context) => reciept_page(),
        '/analytics_page': (context) => analytics_page(),
        '/week_report': (context) => week_report(),
        '/coin_drop': (context) => coin_report(),
        '/saving': (context) => mysavings(),
        '/test': (context) => test(),
        '/blue': (context) => FlutterBluetooth(),
        '/coin': (context) => coinHistory_page(),
      },
    );
  }
}
