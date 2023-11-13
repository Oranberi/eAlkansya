import 'package:ealkansyaapp/util/history_tile.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "LOGO",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.blueAccent,
          elevation: 0,
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 0,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(50, 20, 0, 0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "P 100.00",
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
                                  alignment: Alignment.topLeft,
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
                                      var snackBar = SnackBar(
                                          content: Text(
                                              "Savings Ammount is now not visible"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
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
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          color: Colors.lightBlueAccent,
                        ),
                        Container(
                          height: 75,
                          width: 75,
                          color: Colors.lightBlueAccent,
                        ),
                        Container(
                          height: 75,
                          width: 75,
                          color: Colors.lightBlueAccent,
                        )
                      ],
                    ),
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Coin History",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[900],
                          fontSize: 20),
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
