import 'dart:math';

import 'package:ealkansyaapp/pages/bar%20graph/bar_graph_coin.dart';
import 'package:flutter/material.dart';

class coin_report extends StatefulWidget {
  const coin_report({super.key});

  @override
  State<coin_report> createState() => _coin_reportState();
}

class _coin_reportState extends State<coin_report> {
  List<double> coinDrop = [32.0, 65.0, 30.0, 20.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text("Coin Drop"),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 200,
                  child: barGraph_Coin(
                    coinReport: coinDrop,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text("Summary"),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("S: "),
                              Text(coinDrop[0].toString())
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("M: "),
                              Text(coinDrop[1].toString())
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Th: "),
                              Text(coinDrop[2].toString())
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("F: "),
                              Text(coinDrop[3].toString())
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
