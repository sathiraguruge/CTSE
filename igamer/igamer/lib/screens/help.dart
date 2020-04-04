import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igamer/common_ui_widgets/appBar.dart';
import 'package:igamer/common_ui_widgets/drawer.dart';

// Name of the page
final String pageTitle = "Help";

// Main method
void main() {
  runApp(MaterialApp(home: HelpScreenPage()));
}

class HelpScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          // Background Image
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/aboutus.png"),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.softLight)),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    "How to use the app",
                    style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 25),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "App Basics",
                    style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 20),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/help_one.png',
                    width: 400,
                    height: 900,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Manage Game Reviews",
                    style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 20),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/help_two.png',
                    width: 400,
                    height: 900,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    "That's All !",
                    style: TextStyle(fontFamily: 'SanFrancisco', fontSize: 40),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: new CustomizedDrawer(context).getDrawer(),
      // getting Custom Built Drawer
      appBar: new CustomizedAppBar(pageTitle)
          .getAppBar(), // getting Custom Built App Bar
    );
  }
}
