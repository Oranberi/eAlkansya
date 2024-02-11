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

  int countdown = 2;
  Timer? timer;
  bool isOn = false;

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
    final timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
          update(amount);
          add(amount);
          isOn = false;
          countdown = 2;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.device.name),
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
                          ?.copyWith(color: Colors.blue),
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
                      color: Colors.blue),
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
                      color: Colors.yellow[800],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    addedDialog.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Text("$countdown")
            ],
          ),
        ));
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
