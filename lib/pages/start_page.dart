import 'package:ealkansyaapp/services/sqlite_service.dart';
import 'package:ealkansyaapp/util/history_tile.dart';
import 'package:ealkansyaapp/util/drawer_tile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

int amount = 0;
String amountS = amount.toString();
bool isShown = true;
DateTime now = DateTime.now();

class start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StartPage();
  }
}

class StartPage extends State<start> {
  final dbRef = FirebaseDatabase.instance.ref('savings');
  final coinRef = FirebaseDatabase.instance.ref('coin');
  late SqliteService _sqliteService;
  String? pass;

  @override
  void initState() {
    getAmount();
    super.initState();
    this._sqliteService = SqliteService();
    this._sqliteService.initDB().whenComplete(() => null);
    fetchPin();
  }

  void fetchPin() async {
    pass = await _sqliteService.getPin();
    if (pass != null) {
      print("Pin retrieved: $pass");
    } else {
      print("No Pin");
    }
  }

  Future<void> getAmount() async {
    final snapshot = await dbRef.child("totalAmount").get();
    if (snapshot.exists) {
      var totalAmount = snapshot.value;
      setState(() {
        amount = int.parse(totalAmount.toString());
        amountS = amount.toString();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("does not eXist"),
      ));
    }
  }

  Future<int> getAmountnow() async {
    final snapshot = await dbRef.child("totalAmount").get();
    if (snapshot.exists) {
      var totalAmount = snapshot.value;
      return int.parse(totalAmount.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("does not eXist"),
      ));
      return 0;
    }
  }

  final savingRef = FirebaseDatabase.instance.ref('savings');
  final recieptRef = FirebaseDatabase.instance.ref('reciept');

  Future<void> update() async {
    DateTime nowDate = DateTime.now();
    final snapshot = await savingRef.child("totalAmount").get();
    if (snapshot.exists) {
      var totalAmount = snapshot.value.toString();
      double theAmount = double.parse(totalAmount);
      await savingRef.update({'totalAmount': 0}).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("total amount now: 0"),
        ));
      });

      recieptRef
          .push()
          .set({'value': theAmount, 'date': nowDate.millisecondsSinceEpoch});

      updateCoin();
    }
  }

  Future<void> updateCoin() async {
    final snapshot = await coinRef.get();
    final Map<dynamic, dynamic> coins = snapshot.value as Map<dynamic, dynamic>;
    coins.forEach((key, value) {
      coinRef.child(key).update({'isOut': true});
    });
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Withdraw Confirmation',
              style: TextStyle(fontSize: 20)),
          content: const Text('Do you want to withdraw savings?',
              style: TextStyle(fontSize: 15)),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                update();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          backgroundColor: Color(0xff013174),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          child: Drawer_Tile(),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff013174),
                ),
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.transparent),
                          backgroundColor: Color(0xff6783ac)),
                      child: Text("My savings",
                          style: TextStyle(color: Colors.white)),
                    ),
                    Expanded(
                        flex: 0,
                        child: Container(
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            decoration: BoxDecoration(
                              color: Color(0xff8098ba),
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
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/blue");
                                },
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.transparent),
                                    backgroundColor: Color(0xff6783ac)),
                                child: Text("Connect",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  _showAlertDialog(context);
                                },
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.transparent),
                                    backgroundColor: Color(0xff6783ac)),
                                child: Text("Withdraw",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                  flex: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(80, 10, 80, 15),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          decoration: BoxDecoration(
                            color: Color(0xff013174),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.receipt_outlined,
                                ),
                                iconSize: 70,
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(context, "/audit");
                                },
                              ),
                              Text(
                                "Audit Log",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(80, 10, 80, 15),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          decoration: BoxDecoration(
                            color: Color(0xff013174),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
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
                        ),
                      ],
                    ),
                  )),
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
