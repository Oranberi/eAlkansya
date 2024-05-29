import 'package:flutter/material.dart';

class audit_log extends StatefulWidget {
  const audit_log({super.key});

  @override
  State<audit_log> createState() => _audit_logState();
}

class _audit_logState extends State<audit_log> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Audit Log",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xff013174),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
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
                              Icons.radar,
                            ),
                            iconSize: 70,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pushNamed(context, "/coin");
                            },
                          ),
                          Text(
                            "Coin Deposit",
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
                              Icons.output_sharp,
                            ),
                            iconSize: 70,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pushNamed(context, "/reciept_page");
                            },
                          ),
                          Text(
                            "Withdraw",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
