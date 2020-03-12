import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igamer/common_ui_widgets/appBar.dart';
import 'package:igamer/common_ui_widgets/drawer.dart';

// Page Title
final String pageTitle = "About";

// Main method
void main() {
  runApp(MaterialApp(
    home: AboutScreenPage(),
    theme: ThemeData(fontFamily: 'SanFrancisco'),
  ));
}

class AboutScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          // background image
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
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Text(
                  "iGamer",
                  style: TextStyle(fontSize: 60, fontFamily: 'NunitoSans'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Text(
                  "Version 2.20.211",
                  style: TextStyle(fontSize: 18, fontFamily: 'SanFrancisco'),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                height: 200,
                child: Image.asset('assets/images/gamer.png'),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                child: Text(
                  '© 2019- 2020 iTeam Inc.',
                  style: TextStyle(fontSize: 20, fontFamily: 'SanFrancisco'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: RaisedButton(
                  child: Text(
                    'Terms and Conditions',
                    style: TextStyle(fontSize: 18, fontFamily: 'SanFrancisco'),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: RaisedButton(
                  child: Text('Open source licenses',
                      style: TextStyle(fontSize: 18, fontFamily: 'SanFrancisco')),
                ),
              ),
            ],
          )
        ],
      ),
      drawer: new CustomizedDrawer(context).getDrawer(),
      appBar: new CustomizedAppBar(pageTitle).getAppBar(),
    );
  }
}
