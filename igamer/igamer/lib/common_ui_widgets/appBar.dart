import 'package:flutter/material.dart';
import 'package:igamer/database/crud.dart';
import 'package:igamer/database/gameRecord.dart';
import 'package:igamer/screens/main.dart';

// This class contains attributes and methods for a Customized App Bar
class CustomizedAppBar {
  final Color backgroundColor = Colors.orange;
  String title;
  BuildContext context;
  GameRecord game;

  // Constructor
  CustomizedAppBar(this.title);

  CustomizedAppBar.fromGameDetail(String title, BuildContext context, GameRecord game) {
    this.title = title;
    this.context = context;
    this.game = game;
  }

  // this function returns the Customized App Bar
  Widget getAppBar() {
    return new AppBar(
      title: Text(title, style: TextStyle(fontSize: 25, fontFamily: 'SanFrancisco'),),
      backgroundColor: backgroundColor,
      actions: <Widget>[
        //delete option
        game != null ?
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                await new CRUD().deleteGame(context, game.reference);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                ); //
              },
              child: Icon(
                  Icons.delete
              ),
            )
        ) : Container(),
      ],
    );
  }
}
