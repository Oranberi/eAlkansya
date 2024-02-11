import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class blue_search extends StatefulWidget {
  const blue_search({super.key});

  @override
  State<blue_search> createState() => _blue_searchState();
}

class _blue_searchState extends State<blue_search> {
  List<BluetoothDevice> devices = [];
  void searchBlue() async {
    FlutterBlue fl_blue = FlutterBlue.instance;

    fl_blue.startScan(timeout: Duration(seconds: 5));
    fl_blue.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (!devices.contains(result.device)) {
          setState(() {
            devices.add(result.device);
          });
        }
      }
    });

    if (devices == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("null"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("idk"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.white, child: Text("BL Connection")),
      ),
      body: Container(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  searchBlue();
                },
                child: Text("Scan")),
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(devices[index].name),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
