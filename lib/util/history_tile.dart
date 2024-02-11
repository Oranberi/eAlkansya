import 'package:flutter/material.dart';

class History_Tile extends StatelessWidget {
  final String amount;
  final String timestamp;
  const History_Tile(
      {super.key, required this.amount, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.blueAccent[100],
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Inserted " + amount,
              style: TextStyle(color: Colors.black87),
            ),
            Text("@ " + timestamp.toString(),
                style: TextStyle(color: Colors.black87))
          ],
        ),
      ),
    );
  }
}
