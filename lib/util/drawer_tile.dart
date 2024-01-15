import 'package:flutter/material.dart';

class Drawer_Tile extends StatelessWidget {
  const Drawer_Tile({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Hello, User!",
                style: TextStyle(fontSize: 30, color: Colors.white),
              )),
          ListTile(
            title: Text("Home"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Profile"),
            onTap: () {},
          ),
          ListTile(
            title: Text("About"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
