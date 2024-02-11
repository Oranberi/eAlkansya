import 'package:ealkansyaapp/util/history_tile.dart';
import 'package:ealkansyaapp/util/reciept_tile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ealkansyaapp/util/drawer_tile.dart';

class reciept_page extends StatefulWidget {
  const reciept_page({super.key});

  @override
  State<reciept_page> createState() => _reciept_pageState();
}

class _reciept_pageState extends State<reciept_page> {
  final repRef = FirebaseDatabase.instance.ref('reciept');
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
            Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  "Withdrawals",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              child: Expanded(
                  child: Container(
                      child: FirebaseAnimatedList(
                query: repRef.orderByChild('date'),
                itemBuilder: (context, snapshot, animation, index) {
                  int millis =
                      int.parse(snapshot.child('date').value.toString());
                  return Reciept_tile(
                      amount: snapshot.child('value').value.toString(),
                      date: getMonth(millis));
                },
              ))),
            )
          ],
        ),
      ),
    );
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
