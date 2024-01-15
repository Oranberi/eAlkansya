import 'package:ealkansyaapp/pages/bar%20graph/bar_graph_week.dart';
import 'package:flutter/material.dart';

class week_report extends StatefulWidget {
  const week_report({super.key});

  @override
  State<week_report> createState() => _week_reportState();
}

class _week_reportState extends State<week_report> {
  List<double> presentSummary = [200.0, 130.0, 185.0, 98.0, 67.0, 50.0, 123.0];
  List<double> weekSummary = [200.0, 130.0, 185.0, 98.0, 67.0, 50.0, 123.0];
  List<double> weekSummary1 = [100.0, 240.0, 110.0, 290.0, 160.0, 145.0, 250.0];
  List<double> weekSummary2 = [120.0, 90.0, 10.0, 40.0, 230.0, 80.0, 120.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Align(
        alignment: Alignment.centerLeft,
        child: Text("Week Report"),
      )),
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
                      child: Text("This Week"),
                    ),
                    OutlinedButton(
                        onPressed: () => setState(() {
                              changeData(weekSummary1);
                            }),
                        child: Text("Last Week")),
                    OutlinedButton(
                        onPressed: () => setState(() {
                              changeData(weekSummary2);
                            }),
                        child: Text("Last 2 Weeks")),
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
                child: Text("Summary"),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("S: "),
                              Text(presentSummary[0].toString())
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("M: "),
                              Text(presentSummary[1].toString())
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("T: "),
                              Text(presentSummary[2].toString())
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("W: "),
                              Text(presentSummary[3].toString())
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Th: "),
                              Text(presentSummary[4].toString())
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("F: "),
                              Text(presentSummary[5].toString())
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("S: "),
                              Text(presentSummary[6].toString())
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeData(List<double> intoThis) {
    presentSummary[0] = intoThis[0];
    presentSummary[1] = intoThis[1];
    presentSummary[2] = intoThis[2];
    presentSummary[3] = intoThis[3];
    presentSummary[4] = intoThis[4];
    presentSummary[5] = intoThis[5];
    presentSummary[6] = intoThis[6];
  }
}
