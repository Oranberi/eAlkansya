import 'package:ealkansyaapp/pages/bar%20graph/bar_graph_week.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
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

  DateTime initialDay = DateTime.now();
  List<DateTime> thisWeek = [];
  String dateSpan = "- to -";

  List<double> presentSummary = List<double>.filled(7, 0);
  List<double> customSummary = List<double>.filled(7, 0);
  List<double> weekSummary = List<double>.filled(7, 0);
  List<double> weekSummary1 = List<double>.filled(7, 0);
  List<double> weekSummary2 = List<double>.filled(7, 0);

  List<double> customWeek = [];

  TextEditingController _dateController = TextEditingController();

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
    resetZero();
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
                int coinvalue = value['value'];
                weekSummaries[i][j] += double.parse(coinvalue.toString());
              }
            });
          }
        }
        weekSummary = weekSummaries[0];
        weekSummary1 = weekSummaries[1];
        weekSummary2 = weekSummaries[2];
      });
      for (int i = 0; i < weekSummary.length; i++) {
        //print('this $i is ${weekSummary[i]}');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("does not eXist"),
      ));
    }
  }

  void getCustomWeek(DateTime selectedDay) {
    int weekday = selectedDay.weekday;
    int differenceFromMonday = (weekday + 6) % 7;
    DateTime startOfWeek =
        selectedDay.subtract(Duration(days: differenceFromMonday));

    for (int i = 0; i < 7; i++) {
      thisWeek[i] = startOfWeek.add(Duration(days: i));
    }
    for (int i = 0; i < 7; i++) {
      print(thisWeek[i]);
    }
  }

  Future<void> fetchCustomCoins() async {
    List<double> customSummary = List<double>.filled(7, 0);
    final snapshot = await coinRef.get();
    final Map<dynamic, dynamic> coins = snapshot.value as Map<dynamic, dynamic>;
    if (snapshot.exists) {
      for (int j = 0; j < 7; j++) {
        coins.forEach((key, value) {
          int millis = value['dateInserted'];
          DateTime thisTime = DateTime.fromMillisecondsSinceEpoch(millis);
          //print(thisTime);
          if (isSameDate(thisTime, thisWeek[j])) {
            setState(() {
              int coinvalue = value['value'];
              customSummary[j] += double.parse(coinvalue.toString());
            });
            print(thisTime.toString() + " " + weeks[j].toString());
          }
        });
      }
      setState(() {
        changeData(customSummary);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("does not eXist"),
      ));
    }
  }

  @override
  void initState() {
    for (int i = 0; i < 7; i++) {
      thisWeek.add(DateTime.now());
    }
    getCustomWeek(initialDay);
    generateLastWeeks();
    for (int i = 0; i < 3; i++) {
      weekSummaries.add(List<double>.filled(7, 0.0));
    }
    super.initState();
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (_picked != null) {
      setState(() {
        getCustomWeek(_picked);
        fetchCustomCoins();
        dateSpan =
            "${formatMonthDay(thisWeek[0])} to ${formatMonthDay(thisWeek[6])}";
        _dateController.text = dateSpan;
      });
    }
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => setState(() {
                        changeData(weekSummary);
                        dateSpan =
                            "${formatMonthDay(weeks[0][0])} to ${formatMonthDay(weeks[0][6])}";
                        _dateController.text = dateSpan;
                      }),
                      child: Text(
                        "This Week",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => setState(() {
                        changeData(weekSummary1);
                        dateSpan =
                            "${formatMonthDay(weeks[1][0])} to ${formatMonthDay(weeks[1][6])}";
                        _dateController.text = dateSpan;
                      }),
                      child: Text("Last Week", style: TextStyle(fontSize: 11)),
                    ),
                    OutlinedButton(
                        onPressed: () => setState(() {
                              changeData(weekSummary2);
                              dateSpan =
                                  "${formatMonthDay(weeks[2][0])} to ${formatMonthDay(weeks[2][6])}";
                              _dateController.text = dateSpan;
                            }),
                        child: Text("Last 2 Weeks",
                            style: TextStyle(fontSize: 11))),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                        labelText: 'Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    readOnly: true,
                    onTap: () {
                      _selectDate();
                    },
                  )),
              SizedBox(
                height: 200,
                child: barGraph_Week(
                  weekReport: presentSummary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: Text(
                  dateSpan,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.blue[700]),
                ),
              ),
              Expanded(
                  child: ExpansionTile(
                title: const Text("Summary", textAlign: TextAlign.center),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: presentSummary.length,
                    itemBuilder: (BuildContext context, int index) {
                      return daySummary(presentSummary[index], index);
                    },
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  String formatMonthDay(DateTime date) {
    if (date.month == 1) {
      return "Jan. ${date.day}";
    } else if (date.month == 2) {
      return "Feb. ${date.day}";
    } else if (date.month == 3) {
      return "Mar. ${date.day}";
    } else if (date.month == 4) {
      return "Apr. ${date.day}";
    } else if (date.month == 5) {
      return "May. ${date.day}";
    } else if (date.month == 6) {
      return "Jun. ${date.day}";
    } else if (date.month == 7) {
      return "Jul. ${date.day}";
    } else if (date.month == 8) {
      return "Aug. ${date.day}";
    } else if (date.month == 9) {
      return "Sep. ${date.day}";
    } else if (date.month == 10) {
      return "Oct. ${date.day}";
    } else if (date.month == 11) {
      return "Nov. ${date.day}";
    } else if (date.month == 12) {
      return "Dec. ${date.day}";
    } else {
      return "";
    }
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

  void resetZero() {
    for (int i = 0; i < weekSummaries.length; i++) {
      for (int j = 0; j < weekSummaries[i].length; j++) {
        weekSummaries[i][j] = 0;
      }
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
