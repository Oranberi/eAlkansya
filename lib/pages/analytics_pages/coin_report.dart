import 'package:ealkansyaapp/pages/bar%20graph/bar_graph_coin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class coin_report extends StatefulWidget {
  const coin_report({super.key});

  @override
  State<coin_report> createState() => _coin_reportState();
}

class _coin_reportState extends State<coin_report> {
  List<double> coinDrop = List<double>.filled(4, 0);

  final coinRef = FirebaseDatabase.instance.ref('coin');
  @override
  void initState() {
    super.initState();
    fetchCoins();
  }

  Future<void> fetchCoins() async {
    coinDrop = [0, 0, 0, 0];
    final snapshot = await coinRef.get();
    final Map<dynamic, dynamic> coins = snapshot.value as Map<dynamic, dynamic>;
    if (snapshot.exists) {
      setState(() {
        coins.forEach((key, value) {
          int coinValue = value['value'];
          bool coinOut = value['isOut'];
          if (!coinOut) {
            switch (coinValue) {
              case 1:
                coinDrop[0]++;
                break;
              case 5:
                coinDrop[1]++;
                break;
              case 10:
                coinDrop[2]++;
                break;
              case 20:
                coinDrop[3]++;
                break;
              default:
                // Handle any other coin values
                break;
            }
          }
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("does not eXist"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Coin Drop",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                fetchCoins();
              },
              icon: Icon(Icons.refresh),
              color: Colors.white,
            )
          ],
          backgroundColor: Color(0xff013174),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
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
                child: Text(
                  "Summary",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff013174),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffffcc06),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(10),
                              height: 75,
                              width: 75,
                              child: Center(
                                  child: Text("${coinDrop[0].toInt()}",
                                      style:
                                          TextStyle(color: Color(0xff013174)))),
                            ),
                            Text(
                              "₱ 1",
                              style: TextStyle(color: Colors.white),
                            )
                          ]),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff013174),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffffcc06),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(10),
                              height: 75,
                              width: 75,
                              child: Center(
                                  child: Text("${coinDrop[1].toInt()}",
                                      style:
                                          TextStyle(color: Color(0xff013174)))),
                            ),
                            Text("₱ 5", style: TextStyle(color: Colors.white))
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff013174),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffffcc06),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(10),
                              height: 75,
                              width: 75,
                              child: Center(
                                  child: Text("${coinDrop[2].toInt()}",
                                      style:
                                          TextStyle(color: Color(0xff013174)))),
                            ),
                            Text("₱ 10", style: TextStyle(color: Colors.white))
                          ]),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff013174),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffffcc06),
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(10),
                              height: 75,
                              width: 75,
                              child: Center(
                                  child: Text("${coinDrop[3].toInt()}",
                                      style:
                                          TextStyle(color: Color(0xff013174)))),
                            ),
                            Text("₱ 20", style: TextStyle(color: Colors.white))
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
