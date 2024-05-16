import 'dart:async';
import 'package:ealkansyaapp/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  int value = 0;
  double amount = 0;
  String addedDialog = "";

  int countdown = 1;
  Timer? timer;
  bool isOn = false;

  List<int> coinInserted = [];

  late BluetoothCharacteristic request;

  @override
  void initState() {
    super.initState();
    connectToDevice(widget.device);
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      service.characteristics.forEach((char) {
        if (char.uuid.toString() == '19b10001-e8f2-537e-4f6c-d104768a1216') {
          setState(() {
            request = char;
          });
        }
        if (char.properties.notify) {
          char.setNotifyValue(true);
          char.value.listen((event) {
            if (event.isNotEmpty) {
              setState(() {
                value++;
                amount = pulseValue(value);
                if (!isOn) {
                  startCount();
                }
              });
            }
          });
        }
      });
    });
  }

  void startCount() {
    final timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
          update(amount);
          add(amount);
          _writeValue(amount.toString());
          isOn = false;
          countdown = 1;
          amount = 0;
          value = 0;
        }
      });
    });
    isOn = true;
  }

  void add(double amount) {
    DateTime now = DateTime.now();
    dbref.push().set({
      'value': amount,
      'isOut': false,
      "dateInserted": now.millisecondsSinceEpoch
    });
    coinInserted.add(amount.toInt());
  }

  Future<void> update(double add) async {
    final snapshot = await savingRef.child("totalAmount").get();
    if (snapshot.exists) {
      var totalAmount = snapshot.value.toString();
      double oldamount = double.parse(totalAmount);
      double newAmount = oldamount + add.toInt();
      await savingRef.update({'totalAmount': newAmount}).then((value) {});
    }
  }

  Future<void> _writeValue(String value) async {
    List<int> bytes = value.codeUnits;
    await request.write(bytes);
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Disconnect?', style: TextStyle(fontSize: 20)),
          content: const Text('Do you want to disconnect from the coin bank?',
              style: TextStyle(fontSize: 15)),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                widget.device.disconnect();
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void addItem() {
    setState(() {
      coinInserted.add(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.device.name,
            style: TextStyle(color: Colors.white),
          ),
          leading: BackButton(
            onPressed: () {
              _showAlertDialog(context);
            },
          ),
          backgroundColor: Color(0xff013174),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          actions: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: widget.device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) {
                VoidCallback? onPressed;
                String text;
                switch (snapshot.data) {
                  case BluetoothDeviceState.connected:
                    onPressed = () => widget.device.disconnect();
                    text = 'DISCONNECT';
                    break;
                  case BluetoothDeviceState.disconnected:
                    onPressed = () => widget.device.connect();
                    text = 'CONNECT';
                    break;
                  default:
                    onPressed = null;
                    text = snapshot.data.toString().substring(21).toUpperCase();
                    break;
                }
                return TextButton(
                    onPressed: onPressed,
                    child: Text(
                      text,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .button
                          ?.copyWith(color: Colors.white),
                    ));
              },
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xff013174)),
                  child: Container(
                    width: 150,
                    height: 150,
                    padding: EdgeInsets.all(50),
                    child: Center(
                      child: Text(
                        amount.toInt().toString(),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffffcc06),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: Text(
                  "History",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Color(0xff013174)),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: coinInserted.length,
                    itemBuilder: (context, index) {
                      return customTile(coinInserted[index]);
                    }),
              )),
            ],
          ),
        ));
  }

  Widget customTile(int coin) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Color(0xffffcc06),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Color(0xff0000cc), width: 5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Inserted " + coin.toString(),
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  double pulseValue(int pulse) {
    if (pulse == 1) {
      return 1;
    } else if (pulse == 2) {
      return 5;
    } else if (pulse == 3) {
      return 10;
    } else if (pulse == 4) {
      return 20;
    } else {
      return 0;
    }
  }
}
