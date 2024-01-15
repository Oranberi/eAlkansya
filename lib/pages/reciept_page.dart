import 'package:ealkansyaapp/util/history_tile.dart';
import 'package:ealkansyaapp/util/reciept_tile.dart';
import 'package:flutter/material.dart';
import 'package:ealkansyaapp/util/drawer_tile.dart';

class reciept_page extends StatefulWidget {
  const reciept_page({super.key});

  @override
  State<reciept_page> createState() => _reciept_pageState();
}

class _reciept_pageState extends State<reciept_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Reciept",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text("Coined Out"),
            Container(
              child: Expanded(
                  child: ListView.builder(itemBuilder: (context, index) {
                return Reciept_tile();
              })),
            )
          ],
        ),
      ),
    );
  }
}
