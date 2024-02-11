import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class mysavings extends StatefulWidget {
  const mysavings({super.key});

  @override
  State<mysavings> createState() => _mysavingsState();
}

class _mysavingsState extends State<mysavings> {
  final savingRef = FirebaseDatabase.instance.ref('savings');
  final recieptRef = FirebaseDatabase.instance.ref('reciept');
  final coinRef = FirebaseDatabase.instance.ref('coin');

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
      appBar: AppBar(
        title: Title(color: Colors.white, child: Text("My saving")),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Column(
            children: [
              Icon(
                Icons.monetization_on,
                size: 120,
                color: Colors.yellow[800],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/blue");
                    },
                    style: OutlinedButton.styleFrom(
                        minimumSize: Size(200, 75),
                        side: BorderSide(color: Colors.transparent),
                        backgroundColor: Colors.blue[500]),
                    child: Text("Connect",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      _showAlertDialog(context);
                    },
                    style: OutlinedButton.styleFrom(
                        minimumSize: Size(200, 75),
                        side: BorderSide(color: Colors.transparent),
                        backgroundColor: Colors.blue[500]),
                    child: Text("Withdraw",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
