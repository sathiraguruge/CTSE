import 'package:flutter/material.dart';

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
                      style: TextStyle(fontSize: 38, letterSpacing: 1.5 ),),
                  ),
                  new Container(
                    child: new Image.asset('assets/images/gamer.png'),
                    height: 90,
                    width: 100,
                  )
                ],
              ),
              decoration: BoxDecoration(color: Colors.orange),
            ),
            ListTile(
              title: Text('Help'),
              onTap: () => {Navigator.pop(context)},
            ),
            ListTile(
              title: Text('About App'),
              onTap: () => {Navigator.pop(context)},
            )
          ],
        ),
      );
  }
}
