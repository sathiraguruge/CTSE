import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:igamer/screens/updateGame.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'appBar.dart';
import '../database/gameRecord.dart';
import 'drawer.dart';

void main() {
  runApp(GameDetailPage(null));
}

// ignore: must_be_immutable
class GameDetailPage extends StatelessWidget {
  GameRecord game;

  GameDetailPage(this.game);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: game.title,
      home: Scaffold(
        appBar: new CustomizedAppBar.fromGameDetail(game.title, context, this.game).getAppBar(),
        // get customized app bar
        drawer: new CustomizedDrawer(context).getDrawer(),
        // get customized app drawer
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            // Image
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: game.imageLink,
                width: 400,
                height: 187,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: JumpingDotsProgressIndicator(
                              fontSize: 20,
                              numberOfDots: 5,
                              dotSpacing: 10,
                              milliseconds: 250,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
                  child: Center(
                    child: Image.asset("assets/images/no-image-available.png"),
                  ),
                ),
              ),
            ),

            // Published Date
            getDetailRow("Published On", game.publishedDate),

            // Released Date
            getDetailRow("Released On", game.releaseDate),

            // Full Description
            new Container(
              margin: const EdgeInsets.only(left: 10, bottom: 5, right: 10),
              child: new Text(
                game.fullDescription,
                style: new TextStyle(
                    fontSize: 16, height: 1.5, fontFamily: 'SanFrancisco'),
                textAlign: TextAlign.justify,
              ),
            ),

            // Genre
            getDetailRow("Genre", game.genre),

            // Developer
            getDetailRow("Developer", game.developer),

            // ESRB Rating
            getDetailRow("ESRB Rating", game.esrbRating),

            // User Score
            getDetailRowHorizontal("User Score", game.userScore),

            // No of Users
            getDetailRowHorizontal("No of Users", game.noOfUsers),

          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )),
        //update option
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UpdateGame(game: game))); // Navigates to Add Game screen
          },
          tooltip: 'Increment',
          child: Icon(Icons.edit),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }

  // this function returns a Row in which the label is on top and the value is at bottom
  Widget getDetailRow(String label, String value) {
    return new Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Text(
              label,
              style: new TextStyle(fontSize: 18, fontFamily: 'NunitoSans'),
            ),
            margin: const EdgeInsets.only(bottom: 5),
          ),
          new Column(
            children: <Widget>[
              Text(value,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 18,
                      fontFamily: 'SanFrancisco'))
            ],
          )
        ],
      ),
    );
  }

  // this function returns a Row in which the value is place next to the label
  Widget getDetailRowHorizontal(String label, String value) {
    return new Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            child: new Text(
              label,
              style: new TextStyle(fontSize: 18, fontFamily: 'NunitoSans'),
            ),
            margin: const EdgeInsets.only(right: 8),
          ),
          new Column(
            children: <Widget>[
              Text(value,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 38,
                      fontFamily: 'SanFrancisco'))
            ],
          )
        ],
      ),
    );
  }
}
