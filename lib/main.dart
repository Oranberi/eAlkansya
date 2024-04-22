import 'dart:async';

import 'package:ealkansyaapp/pages/BL/bluetooth.dart';
import 'package:ealkansyaapp/pages/Security.dart';
import 'package:ealkansyaapp/pages/analytics_page.dart';
import 'package:ealkansyaapp/pages/analytics_pages/coin_report.dart';
import 'package:ealkansyaapp/pages/analytics_pages/week_report.dart';
import 'package:ealkansyaapp/pages/bluetooth/blConnect.dart';
import 'package:ealkansyaapp/pages/changepass.dart';
import 'package:ealkansyaapp/pages/coinHistory_page.dart';
import 'package:ealkansyaapp/pages/login.dart';
import 'package:ealkansyaapp/pages/mysaving_page.dart';
import 'package:ealkansyaapp/pages/reciept_page.dart';
import 'package:ealkansyaapp/pages/start_page.dart';
import 'package:ealkansyaapp/pages/test.dart';
import 'package:ealkansyaapp/services/sqlite_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SqliteService _sqliteService;
  String? pass;
  String? inputPass;
  bool? requirePass;

  int countdown = 1;
  Timer? timer;
  bool isOn = false;

  @override
  void initState() {
    super.initState();
    this._sqliteService = SqliteService();
    this._sqliteService.initDB().whenComplete(() {});
    checkPin();
  }

  void startCount() {
    final timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
          isOn = false;
          countdown = 1;
        }
      });
    });
    isOn = true;
  }

  @override
  Widget build(BuildContext context) {
    if (requirePass == null) {
      return CircularProgressIndicator();
    } else {
      return MaterialApp(
        home: requirePass == true ? login() : changePinCode(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/start': (context) => start(),
          '/login': (context) => login(),
          '/pin': (context) => changePin(),
          '/change': (context) => changePinCode(),
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

  void checkPin() async {
    pass = await _sqliteService.getPin();
    if (pass != null) {
      setState(() {
        requirePass = true;
      });
    } else {
      setState(() {
        requirePass = false;
      });
    }
  }
}
