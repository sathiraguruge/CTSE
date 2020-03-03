import 'package:flutter/material.dart';
import 'game.dart';
import 'gameDetail.dart';

class GameCard extends StatelessWidget {
  const GameCard(
      {Key key,
      this.game,
      this.onTap,
      @required this.item,
      this.selected: false})
      : super(key: key);

  final Game game;
  final VoidCallback onTap;
  final Game item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Card(
        margin: const EdgeInsets.only(bottom: 30),
        color: Colors.white,
        child: new InkWell(
          onTap: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GameDetailPage(game)))
          },
          child: Column(
            children: <Widget>[
              // Title
              new Container(
                margin: const EdgeInsets.only(left: 10),
                child: new Text(game.title,
                    style: new TextStyle(
                        fontSize: 30, letterSpacing: 1.5, height: 1)),
              ),
              // Image
              new Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(game.imageLink)),
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
                                color: Colors.black.withOpacity(0.5))),
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
                  style: new TextStyle(wordSpacing: 1, height: 1.5),
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ));
  }
}
