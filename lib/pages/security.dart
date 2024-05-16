import 'package:ealkansyaapp/services/sqlite_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class changePin extends StatefulWidget {
  const changePin({super.key});

  @override
  State<changePin> createState() => _changePinState();
}

class _changePinState extends State<changePin> {
  TextEditingController pinText = TextEditingController();
  late SqliteService _sqliteService;
  String? pass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._sqliteService = SqliteService();
    this._sqliteService.initDB().whenComplete(() => null);
    fetchPin();
  }

  void fetchPin() async {
    pass = await _sqliteService.getPin();
    if (pass != null) {
      print("Pin retrieved: $pass");
    } else {
      print("No Pin");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Security"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: PinCodeTextField(
                appContext: context,
                length: 4,
                cursorHeight: 19,
                enableActiveFill: true,
                controller: pinText,
                readOnly: true,
                obscureText: true,
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 50,
                    inactiveColor: Color(0xffffcc06),
                    selectedColor: Color(0xffffcc06),
                    selectedFillColor: Colors.white,
                    activeColor: Colors.blue,
                    activeFillColor: Color(0xff013174),
                    inactiveFillColor: Colors.white,
                    borderWidth: 1,
                    borderRadius: BorderRadius.circular(8)),
                onChanged: (value) {
                  setState(() {
                    print(value);
                    if (value.length == 4) {
                      if (value == pass) {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, "/change");
                      } else {
                        pinText.text = "";
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Does not Match"),
                        ));
                      }
                    }
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [customKeys(1), customKeys(2), customKeys(3)],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [customKeys(4), customKeys(5), customKeys(6)],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [customKeys(7), customKeys(8), customKeys(9)],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(onPressed: null, child: Text(" ")),
                    customKeys(0),
                    OutlinedButton(
                        onPressed: () {
                          deletePressed();
                        },
                        child: Text("del"))
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  void handlePressed(String digit) {
    setState(() {
      if (pinText.text.length < 4) {
        pinText.text += digit;
      }
    });
  }

  void deletePressed() {
    setState(() {
      if (pinText.text.isNotEmpty) {
        pinText.text = pinText.text.substring(0, pinText.text.length - 1);
      }
    });
  }

  Widget customKeys(int num) {
    return OutlinedButton(
        onPressed: () {
          handlePressed(num.toString());
        },
        style: OutlinedButton.styleFrom(
            side: BorderSide(color: Color(0xff6783ac)),
            backgroundColor: Color(0xff013174)),
        child: Text(num.toString(), style: TextStyle(color: Colors.white)));
  }
}
