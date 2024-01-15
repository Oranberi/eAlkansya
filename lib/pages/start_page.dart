import 'package:ealkansyaapp/util/history_tile.dart';
import 'package:ealkansyaapp/util/drawer_tile.dart';
import 'package:flutter/material.dart';

int amount = 1000;
String amountS = amount.toString();
bool isShown = true;

class Start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StartPage();
  }
}

class StartPage extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer_Tile(),
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "LOGO",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.blue[700],
          elevation: 0,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                ),
                child: Column(
                  children: [
                    Expanded(
                        flex: 0,
                        child: Container(
                            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            decoration: BoxDecoration(
                              color: Colors.blue[500],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(50, 35, 0, 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "P ${amountS}",
                                          style: TextStyle(
                                              letterSpacing: 1.0,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(50, 0, 0, 30),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "My Savings",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        margin: EdgeInsets.only(right: 40),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (isShown) {
                                              setState(() {
                                                amountS = ".....";
                                              });
                                              isShown = false;
                                            } else {
                                              setState(() {
                                                amountS = amount.toString();
                                              });
                                              isShown = true;
                                            }
                                          },
                                          child: Icon(
                                            Icons.visibility_off,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ))),
                    Expanded(
                        flex: 0,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 40, 10, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.receipt_outlined,
                                    ),
                                    iconSize: 70,
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "/reciept_page");
                                    },
                                  ),
                                  Text(
                                    "Reciept",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.analytics_outlined,
                                    ),
                                    iconSize: 70,
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "/analytics_page");
                                    },
                                  ),
                                  Text(
                                    "Analytics",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.lock,
                                    ),
                                    iconSize: 70,
                                    color: Colors.blue[100],
                                    onPressed: () {
                                      print("button 3");
                                    },
                                  ),
                                  Text(
                                    "TBU",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Coin History",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )),
              Expanded(
                  child: Container(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return History_Tile();
                  },
                ),
              ))
            ],
          ),
        ));
  }
}
