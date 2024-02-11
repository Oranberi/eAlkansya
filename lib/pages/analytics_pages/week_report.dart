import 'package:ealkansyaapp/pages/bar%20graph/bar_graph_week.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class week_report extends StatefulWidget {
  const week_report({super.key});

  @override
  State<week_report> createState() => _week_reportState();
}

class _week_reportState extends State<week_report> {
  final coinRef = FirebaseDatabase.instance.ref('coin');
  List<List<DateTime>> weeks = [];
  List<List<double>> weekSummaries = [];

  List<double> presentSummary = List<double>.filled(7, 0);
  List<double> weekSummary = List<double>.filled(7, 0);
  List<double> weekSummary1 = List<double>.filled(7, 0);
  List<double> weekSummary2 = List<double>.filled(7, 0);

  List<List<DateTime>> generateLastWeeks() {
    DateTime now = DateTime.now();

    int weekday = now.weekday;
    int differenceFromMonday = (weekday + 6) % 7;
    DateTime startOfWeek = now.subtract(Duration(days: differenceFromMonday));

    List<DateTime> currentWeekDates = [];
    for (int i = 0; i < 7; i++) {
      currentWeekDates.add(startOfWeek.add(Duration(days: i)));
    }
    weeks.add(currentWeekDates);

    // Modify for past weeks generation
    for (int week = 1; week < 3; week++) {
      List<DateTime> pastWeekDates = [];
      DateTime pastWeekStart = startOfWeek.subtract(Duration(days: week * 7));
      for (int i = 0; i < 7; i++) {
        pastWeekDates.add(pastWeekStart.add(Duration(days: i)));
      }
      weeks.add(pastWeekDates); // Insert at the beginning for past weeks
    }

    return weeks;
  }

  Future<void> fetchCoins() async {
    final snapshot = await coinRef.get();
    final Map<dynamic, dynamic> coins = snapshot.value as Map<dynamic, dynamic>;
    if (snapshot.exists) {
      setState(() {
        for (int i = 0; i < 3; i++) {
          for (int j = 0; j < 7; j++) {
            coins.forEach((key, value) {
              int millis = value['dateInserted'];
              DateTime thisTime = DateTime.fromMillisecondsSinceEpoch(millis);
              //print(thisTime);
              if (isSameDate(thisTime, weeks[i][j])) {
                print(thisTime.toString() + " " + weeks[i][j].toString());
                weekSummaries[i][j] += value['value'];
              }
            });
          }
        }
        weekSummary = weekSummaries[0];
        weekSummary1 = weekSummaries[1];
        weekSummary2 = weekSummaries[2];
      });
      for (int i = 0; i < weekSummary.length; i++) {
        print('this $i is ${weekSummary[i]}');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("does not eXist"),
      ));
    }
  }

  @override
  void initState() {
    generateLastWeeks();
    for (int i = 0; i < 3; i++) {
      weekSummaries.add(List<double>.filled(7, 0.0));
    }
    for (int i = 0; i < weeks.length; i++) {
      print('Week ${i + 1}:');
      for (int j = 0; j < weeks[i].length; j++) {
        print('${weeks[i][j]}');
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text("Week Report"),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              fetchCoins();
            },
            icon: Icon(Icons.refresh),
            color: Colors.blue,
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => setState(() {
                        changeData(weekSummary);
                      }),
                      child: Text(
                        "This Week",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => setState(() {
                        changeData(weekSummary1);
                      }),
                      child: Text("Last Week", style: TextStyle(fontSize: 11)),
                    ),
                    OutlinedButton(
                        onPressed: () => setState(() {
                              changeData(weekSummary2);
                            }),
                        child: Text("Last 2 Weeks",
                            style: TextStyle(fontSize: 11))),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: barGraph_Week(
                  weekReport: presentSummary,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  "Summary",
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(70, 0, 70, 30),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  daySummary(presentSummary[0], 0),
                  daySummary(presentSummary[1], 1),
                  daySummary(presentSummary[2], 2),
                  daySummary(presentSummary[3], 3),
                  daySummary(presentSummary[4], 4),
                  daySummary(presentSummary[5], 5),
                  daySummary(presentSummary[6], 6),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget daySummary(double amount, int day) {
    switch (day) {
      case 0:
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Mon:",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "$amount",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      case 1:
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Tue:",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "$amount",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      case 2:
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Wed:",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "$amount",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      case 3:
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Thu:",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "$amount",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      case 4:
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Fri:",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "$amount",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      case 5:
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sat:",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "$amount",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      case 6:
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sun:",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "$amount",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      default:
        return Container();
    }
  }

  void changeData(List<double> intoThis) {
    presentSummary[0] = intoThis[0];
    presentSummary[1] = intoThis[1];
    presentSummary[2] = intoThis[2];
    presentSummary[3] = intoThis[3];
    presentSummary[4] = intoThis[4];
    presentSummary[5] = intoThis[5];
    presentSummary[6] = intoThis[6];

    for (int i = 0; i < presentSummary.length; i++) {
      print('this $i is ${presentSummary[i]}');
    }
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  getCoins() async {}
}
