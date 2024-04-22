import 'package:flutter/material.dart';

class analytics_page extends StatefulWidget {
  const analytics_page({super.key});

  @override
  State<analytics_page> createState() => _analytics_pageState();
}

class _analytics_pageState extends State<analytics_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Analytics",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xff013174),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                "What would you like to check?",
                style: TextStyle(
                    color: Color(0xff013174),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.dataset_outlined,
                      ),
                      iconSize: 70,
                      color: Color(0xff013174),
                      onPressed: () {
                        Navigator.pushNamed(context, "/week_report");
                      },
                    ),
                    Text(
                      "Week Report",
                      style: TextStyle(color: Color(0xff013174)),
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.data_thresholding_outlined,
                      ),
                      iconSize: 70,
                      color: Color(0xff013174),
                      onPressed: () {
                        Navigator.pushNamed(context, "/coin_drop");
                      },
                    ),
                    Text(
                      "Coin Inserts",
                      style: TextStyle(color: Color(0xff013174)),
                    )
                  ],
                ),
              ],
            ),
            const Spacer(),
            Expanded(
                child: Text(
              "${'"'}Savings is a commitment,\n Not an amount${'"'}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Color(0xff013174),
                  fontSize: 22),
            ))
          ],
        ),
      ),
    );
  }
}
