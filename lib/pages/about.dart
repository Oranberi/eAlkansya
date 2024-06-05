import 'package:flutter/material.dart';

class about extends StatefulWidget {
  const about({super.key});

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "About",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 87, 134, 201),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    Center(
                        child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image(
                              image: AssetImage("assets/IAL.png"),
                            ))),
                    Text(
                      "eAlkansya",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "This application is developed to keep track of our savings. It is developed with a dedicated smart coin bank.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
