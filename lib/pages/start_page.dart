import 'package:ealkansyaapp/util/history_tile.dart';
import 'package:ealkansyaapp/util/drawer_tile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

int amount = 0;
String amountS = amount.toString();
bool isShown = true;
DateTime now = DateTime.now();

class Start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StartPage();
  }
}

class StartPage extends State<Start> {
  final dbRef = FirebaseDatabase.instance.ref('savings');
  final coinRef = FirebaseDatabase.instance.ref('coin');

  @override
  void initState() {
    getAmount();
    super.initState();
  }

  Future<void> getAmount() async {
    final snapshot = await dbRef.child("totalAmount").get();
    if (snapshot.exists) {
      var totalAmount = snapshot.value;
      setState(() {
        amount = int.parse(totalAmount.toString());
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
        // drawer: Drawer_Tile(),
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "eAlkansya",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                getAmount();
              },
              icon: Icon(Icons.refresh),
              color: Colors.white,
            )
          ],
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
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/saving");
                      },
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.transparent),
                          backgroundColor: Colors.blue[500]),
                      child: Text("My Saving",
                          style: TextStyle(color: Colors.white)),
                    ),
                    Expanded(
                        flex: 0,
                        child: Container(
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      padding: EdgeInsets.all(30),
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
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 20),
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
                      constraints: BoxConstraints(minHeight: 200),
                      child: FirebaseAnimatedList(
                        query: coinRef.orderByChild('dateInserted'),
                        reverse: true,
                        itemBuilder: (context, snapshot, animation, index) {
                          int millis = int.parse(
                              snapshot.child('dateInserted').value.toString());
                          return History_Tile(
                              amount: snapshot.child('value').value.toString(),
                              timestamp: getMonth(millis));
                        },
                      )))
            ],
          ),
        ));
  }

  String formatDate(int millis) {
    DateTime thisDate = DateTime.fromMillisecondsSinceEpoch(millis);
    String month = "${thisDate.month}";
    String day = "${thisDate.day}";

    String formattedDate = month + " " + day;
    return formattedDate;
  }

  String getMonth(int millis) {
    DateTime thisDate = DateTime.fromMillisecondsSinceEpoch(millis);
    String timeAgoStatus = "";
    final duration = DateTime.now().difference(thisDate);
    if (duration.inSeconds < 60) {
      timeAgoStatus = "Just now";
    } else if (duration.inMinutes < 60) {
      timeAgoStatus = "${duration.inMinutes} minutes ago";
    } else if (duration.inHours < 24) {
      timeAgoStatus = "${duration.inHours} hours ago";
    } else {
      timeAgoStatus = "${duration.inDays} days ago";
    }

    return timeAgoStatus;
  }
}
