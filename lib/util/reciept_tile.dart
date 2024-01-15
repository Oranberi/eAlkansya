import 'package:flutter/material.dart';

class Reciept_tile extends StatelessWidget {
  const Reciept_tile({super.key});

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text("Total Amount: "), Text("*amount*")],
            ),
            Row(
              children: [Text("Date Coined out: "), Text("*Date*")],
            )
          ],
        ),
      ),
    );
  }
}
