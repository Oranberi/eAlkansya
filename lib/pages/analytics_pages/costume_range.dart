import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class custom_range extends StatefulWidget {
  const custom_range({super.key});

  @override
  State<custom_range> createState() => _custom_rangeState();
}

class _custom_rangeState extends State<custom_range> {
  final coinRef = FirebaseDatabase.instance.ref('coin');

  TextEditingController _dateEnd = TextEditingController();
  TextEditingController _dateStart = TextEditingController();

  late DateTime inputstart;
  late DateTime inputend;

  List<DateTime> days = [];
  List<int> value = [];
  late DateTime checkthisDay;
  late DateTime tothisDay;

  late DateTime dayHolder;
  int valueHolder = 0;

  Future<void> fetchCustomCoins(DateTime start, DateTime end) async {
    List<double> customSummary = List<double>.filled(7, 0);
    final snapshot = await coinRef.get();
    final Map<dynamic, dynamic> coins = snapshot.value as Map<dynamic, dynamic>;
    if (snapshot.exists) {
      for (int i = 0; i <= end.difference(start).inDays; i++) {
        checkthisDay = start.add(Duration(days: i));
        coins.forEach((key, value) {
          int millis = value['dateInserted'];
          DateTime tothisDay = DateTime.fromMillisecondsSinceEpoch(millis);

          if (isSameDate(checkthisDay, tothisDay)) {
            print("${tothisDay} : ${checkthisDay}");
            dayHolder = checkthisDay;
            int coin = value["value"];
            valueHolder += coin;
          }
        });
        setState(() {
          if (valueHolder != 0) {
            days.add(dayHolder);
            value.add(valueHolder);
          }
          valueHolder = 0;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("does not eXist"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Custom Date",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xff013174),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Container(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
              child: TextField(
                controller: _dateStart,
                decoration: InputDecoration(
                    labelText: 'Start',
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder()),
                readOnly: true,
                onTap: () {
                  _selectStartDate();
                },
              )),
          Container(
              margin: EdgeInsets.all(5),
              child: TextField(
                controller: _dateEnd,
                decoration: InputDecoration(
                    labelText: 'End',
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder()),
                readOnly: true,
                onTap: () {
                  _selectEndDate();
                },
              )),
          OutlinedButton(
            onPressed: () => setState(() {
              days.clear();
              value.clear();
              fetchCustomCoins(inputstart, inputend);
            }),
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.transparent),
                backgroundColor: Color(0xff013174)),
            child: Text("Generate",
                style: TextStyle(fontSize: 11, color: Colors.white)),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return customTile(value[index], days[index]);
                }),
          )),
        ]),
      ),
    );
  }

  Widget customTile(int coin, DateTime date) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 233, 234, 255),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.mode_standby_sharp),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${formatMonthDay(date)}",
                    style: TextStyle(
                        color: Color(0xff013174),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    "₱ ${coin}.00",
                    style: TextStyle(color: Color(0xff013174), fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String formatMonthDay(DateTime date) {
    if (date.month == 1) {
      return "Jan. ${date.day}, ${date.year}";
    } else if (date.month == 2) {
      return "Feb. ${date.day}, ${date.year}";
    } else if (date.month == 3) {
      return "Mar. ${date.day}, ${date.year}";
    } else if (date.month == 4) {
      return "Apr. ${date.day}, ${date.year}";
    } else if (date.month == 5) {
      return "May. ${date.day}, ${date.year}";
    } else if (date.month == 6) {
      return "Jun. ${date.day}, ${date.year}";
    } else if (date.month == 7) {
      return "Jul. ${date.day}, ${date.year}";
    } else if (date.month == 8) {
      return "Aug. ${date.day}, ${date.year}";
    } else if (date.month == 9) {
      return "Sep. ${date.day}, ${date.year}";
    } else if (date.month == 10) {
      return "Oct. ${date.day}, ${date.year}";
    } else if (date.month == 11) {
      return "Nov. ${date.day}, ${date.year}";
    } else if (date.month == 12) {
      return "Dec. ${date.day}, ${date.year}";
    } else {
      return "";
    }
  }

  Future<void> _selectStartDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (_picked != null) {
      setState(() {
        _dateStart.text = _picked.toString();
        inputstart = _picked;
      });
    }
  }

  Future<void> _selectEndDate() async {
    if (inputstart == null) {
    } else {
      DateTime? _picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: inputstart,
          lastDate: DateTime.now());

      if (_picked != null) {
        setState(() {
          _dateEnd.text = _picked.toString();
          inputend = _picked;
        });
      }
    }
  }
}
