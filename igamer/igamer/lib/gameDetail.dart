import 'package:flutter/material.dart';
import 'package:igamer/pageTitle.dart';
import 'gameRecord.dart';

void main() {
  runApp(GameDetailPage(null));
}

// --title|
// --imageLink|
//  --genre|
//  --developer|
// --releaseDate|
// --fullDescription|
// --esrbRating|
// --userScore|
// --noOfUsers


// ignore: must_be_immutable
class GameDetailPage extends StatelessWidget {
  GameRecord game;

  GameDetailPage(this.game);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: game.title,
        home: Scaffold(
            appBar: new CustomizedAppBar(game.title).getAppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Image
                  new Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(game.imageLink)),

                  // Released Date
                  getDetailRow("Released On", game.releaseDate),

                  // Full Description
                  new Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
                    child: new Text(
                      game.fullDescription,
                      style: new TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.justify,
                    ),
                  ),

                  // Genre
                  getDetailRow("Genre", game.genre),

                  // Developer
                  getDetailRow("Developer", game.developer),

                  // ESRB Rating
                  getDetailRowHorizontal("ESRB Rating", game.esrbRating),

                  // User Score
                  getDetailRowHorizontal("User Score", game.userScore),

                  // No of Users
                  getDetailRowHorizontal("User Score", game.noOfUsers),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ))),
            );
  }
}

Widget getDetailRow(String label, String value){
  return new Container(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          child: new Text(label , style: new TextStyle(fontSize: 18),),
          margin: const EdgeInsets.only(bottom: 5),
        ),
        new Column(
          children: <Widget>[
            Text(value,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5), fontSize: 18))
          ],
        )
      ],
    ),
  );
}

Widget getDetailRowHorizontal(String label, String value){
  return new Container(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          child: new Text(label, style: new TextStyle(fontSize: 18),),
          margin: const EdgeInsets.only(right: 8),
        ),
        new Column(
          children: <Widget>[
            Text(value,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5), fontSize: 28))
          ],
        )
      ],
    ),
  );
}