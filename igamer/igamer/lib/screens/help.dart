import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igamer/common_ui_widgets/appBar.dart';
import 'package:igamer/common_ui_widgets/drawer.dart';

void main() {
  runApp(MaterialApp(home: HelpScreenPage()));
}

final String pageTitle = "Help";

class HelpScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/aboutus.png"),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.softLight)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  "How to use the app",
                  style: TextStyle(fontFamily: 'SanFrancisco'),
                ),
              )
            ],
          )
        ],
      ),
      drawer: new CustomizedDrawer(context).getDrawer(),
      appBar: new CustomizedAppBar(pageTitle).getAppBar(),
    );
  }
}
