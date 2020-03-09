import 'package:flutter/material.dart';
import 'package:igamer/screens/about.dart';
import 'package:igamer/screens/help.dart';
import 'package:igamer/screens/main.dart';

class CustomizedDrawer {
  final Color backgroundColor = Colors.orange;
  BuildContext context;

  CustomizedDrawer(this.context);

  Widget getDrawer() {
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: Text('iGamer',
                    style: TextStyle(fontSize: 38, letterSpacing: 1.5 , fontFamily: 'NunitoSansSemiBold'),),
                ),
                new Container(
                  child: new Image.asset('assets/images/gamer.png'),
                  height: 80,
                  width: 100,
                )
              ],
            ),
            decoration: BoxDecoration(color: Colors.orange),
          ),
          ListTile(
            title: Text('Home', style: TextStyle(fontFamily: 'NunitoSansSemiBold', fontSize: 19),),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => new MyHomePage()))},
          ),
          ListTile(
            title: Text('Help', style: TextStyle(fontFamily: 'NunitoSansSemiBold', fontSize: 19),),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => new HelpScreenPage()))},
          ),
          ListTile(
            title: Text('About App', style: TextStyle(fontFamily: 'NunitoSansSemiBold', fontSize: 19),),
            onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => new AboutScreenPage()))},
          )
        ],
      ),
    );
  }
}