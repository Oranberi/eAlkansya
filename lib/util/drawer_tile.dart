import 'package:flutter/material.dart';

class Drawer_Tile extends StatelessWidget {
  const Drawer_Tile({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(color: Color(0xff013174)),
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image(image: AssetImage("assets/IAL.png"))),
                ),
                ListTile(
                  title: Text(
                    "eAlkansya",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(255, 255, 255, 1)),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text("Security"),
            onTap: () {
              Navigator.pushNamed(context, "/pin");
            },
          ),
          Divider(),
          ListTile(
            title: Text("About"),
            onTap: () {
              Navigator.pushNamed(context, "/about");
            },
          ),
          ListTile(
            title: Text("Development Team"),
            onTap: () {
              Navigator.pushNamed(context, "/devteam");
            },
          )
        ],
      ),
    );
  }
}
