import 'package:flutter/material.dart';

class Reciept_tile extends StatelessWidget {
  final String amount;
  final String date;
  const Reciept_tile({super.key, required this.amount, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Color(0xff013174), borderRadius: BorderRadius.circular(5)),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Total Amount: ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("$amount",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text("${date}", style: TextStyle(color: Colors.white))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
