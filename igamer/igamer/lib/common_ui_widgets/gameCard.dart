import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import '../database/gameRecord.dart';
import 'gameDetail.dart';

// this class contains methods and attributes used for Card in the List in the app
class GameCard extends StatelessWidget {

  //Constructor
  const GameCard({Key key, this.game, this.selected: false}) : super(key: key);

  final GameRecord game;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    //if the option is selected, returning a card
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return new Container(
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Colors.transparent,
            blurRadius: 50
          )
        ]
      ),
     child : new Card(
        margin: const EdgeInsets.only(bottom: 30),
        color: Colors.white,
        child: new InkWell(
          // if the card is pressed navigate to Detailed Screen
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GameDetailPage(game),),),
          },
          child: Column(
            children: <Widget>[
              // Title
              new Container(
                margin: const EdgeInsets.only(left: 10),
                child: new Text(game.title,
                    style: new TextStyle(
                        fontSize: 30, letterSpacing: 1.5, height: 1, fontFamily: 'SanFrancisco'),),
              ),
              // Image of the Game
              new Container(
//                child: Image.network(game.imageLink),
                child: CachedNetworkImage(
                  imageUrl: game.imageLink, width: 400, height: 187, fit: BoxFit.fitWidth,
                  placeholder: (context, url) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: JumpingDotsProgressIndicator(fontSize: 20, numberOfDots: 5, dotSpacing: 10, milliseconds: 250,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                    child: Center(
                      child: Image.asset("assets/images/no-image-available.png"),
                    ),
                  ),
                ),
              ),
              //Published Date
              new Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        Text(game.publishedDate,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5), fontFamily: 'NunitoSansBlack')),
                      ],
                    )
                  ],
                ),
              ),
              // Game Description
              Container(
                margin: const EdgeInsets.only(left: 10, bottom: 5),
                child: new Text(
                  game.gameDescription,
                  style: new TextStyle(wordSpacing: 1, height: 1.5, fontFamily: 'NunitoSans'),
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        )));
  }
}
