import 'package:flutter/material.dart';

class History_Tile extends StatelessWidget {
  const History_Tile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Text("Coin History"),
        decoration: BoxDecoration(
            color: Colors.blueAccent[100],
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
