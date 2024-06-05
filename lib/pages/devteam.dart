import 'dart:math';

import 'package:flutter/material.dart';

class devteam extends StatefulWidget {
  const devteam({super.key});

  @override
  State<devteam> createState() => _devteamState();
}

class _devteamState extends State<devteam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "About Us",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(10),
                child: Text(
                  "Get to know the people behind the development of the eAlkansya",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ExpansionTile(
                title: Text(
                  "Developer",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                children: [
                  ListTile(
                    title: Text(
                      "Troy Joshua C. Madriaga",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text("Main Programmer"),
                    tileColor: Colors.blue[100],
                  ),
                  ListTile(
                    title: Text(
                      "Nilo Bert B. Banganan",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text("Documenter"),
                  ),
                  ListTile(
                    title: Text(
                      "Kennedy P. Pascua",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text("Programmer, Designer"),
                    tileColor: Colors.blue[100],
                  )
                ],
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text(
                  "Adviser",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                children: [
                  ListTile(
                    title: Text(
                      "Gian Paolo Martin Cabanas",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text("MIT  |  Thesis Adviser"),
                    tileColor: Colors.blue[100],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
