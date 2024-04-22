import 'package:ealkansyaapp/services/sqlite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class changePinCode extends StatefulWidget {
  const changePinCode({super.key});

  @override
  State<changePinCode> createState() => _changePinCodeState();
}

class _changePinCodeState extends State<changePinCode> {
  late SqliteService _sqliteService;

  String newPin = "";
  String checkPin = "";
  bool? passExist;
  String? pass;

  void changePin(String pin) async {
    await _sqliteService.updatePin(pin);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.pushNamed(context, '/login');
  }

  void add(String pin) async {
    await _sqliteService.createItem(pin);
    Navigator.of(context).pop();
    Navigator.pushNamed(context, '/login');
  }

  void checkExist() async {
    pass = await _sqliteService.getPin();
    if (pass != null) {
      setState(() {
        passExist = true;
      });
    } else {
      setState(() {
        passExist = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._sqliteService = SqliteService();
    this._sqliteService.initDB().whenComplete(() => null);
    checkExist();
    print(passExist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set PIN Code"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter new PIN:",
                style: TextStyle(fontSize: 20),
              ),
            ),
            pinInput(1),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Re-enter PIN:",
                style: TextStyle(fontSize: 20),
              ),
            ),
            pinInput(2),
            OutlinedButton(
                onPressed: () {
                  if (newPin.length == 4) {
                    if (newPin == checkPin) {
                      if (passExist == true) {
                        changePin(newPin);
                      } else {
                        add(newPin);
                      }
                    } else {
                      print("not the same");
                    }
                  } else {
                    print("Pin length is too short");
                  }
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.transparent),
                    backgroundColor: Colors.blue[500]),
                child: Text(
                  "Set PIN",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  Widget pinInput(int n) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        cursorHeight: 19,
        enableActiveFill: true,
        obscureText: true,
        textStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            fieldHeight: 50,
            inactiveColor: Colors.blue[100],
            selectedColor: Colors.lightBlue,
            selectedFillColor: Colors.white,
            activeColor: Colors.blue,
            activeFillColor: Colors.blue[500],
            inactiveFillColor: Colors.white,
            borderWidth: 1,
            borderRadius: BorderRadius.circular(8)),
        onChanged: (value) {
          setState(() {
            if (n == 1) {
              newPin = value;
            } else {
              checkPin = value;
            }
          });
        },
      ),
    );
  }
}
