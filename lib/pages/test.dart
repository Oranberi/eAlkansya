import 'dart:async';
import 'package:async/async.dart';
import 'package:ealkansyaapp/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

final DatabaseReference dbref = FirebaseDatabase.instance.ref("coin");
final DatabaseReference savingRef = FirebaseDatabase.instance.ref("savings");

class _testState extends State<test> {
  int value = 0;
  double amount = 0;
  String addedDialog = "";

  int countdown = 4;
  Timer? timer;
  bool isOn = false;

  @override
  void initState() {
    super.initState();
  }

  void startCount() {
    final timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("$amount"),
          ));
          isOn = false;
          countdown = 4;
          amount = 0;
          value = 0;
        }
      });
    });
    isOn = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Test",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.blue[700],
          elevation: 0,
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue),
                  child: Container(
                    width: 150,
                    height: 150,
                    padding: EdgeInsets.all(50),
                    child: Center(
                      child: Text(
                        amount.toInt().toString(),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.yellow[800],
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => setState(() {
                        value++;
                        amount = pulseValue(value);
                        if (!isOn) {
                          startCount();
                        }
                      }),
                  child: Text("Add")),
              Expanded(
                child: Container(
                  child: Text(
                    addedDialog.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Text("$countdown")
            ],
          ),
        ));
  }

  double pulseValue(int pulse) {
    if (pulse == 1) {
      return 1;
    } else if (pulse == 2) {
      return 5;
    } else if (pulse == 3) {
      return 10;
    } else if (pulse == 4) {
      return 20;
    }
    return 0;
  }
}
