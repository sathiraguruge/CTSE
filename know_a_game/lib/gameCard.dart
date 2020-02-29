import 'package:flutter/material.dart';
import 'game.dart';

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
        child: Column(
          children: <Widget>[
            // Title
            new Container(
              margin: const EdgeInsets.only(left: 10),
              child: new Text(game.title,
                  style: Theme.of(context).textTheme.title),
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
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.5))),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, bottom: 5),
              child: new Text(game.gameDescription, style: new TextStyle(letterSpacing: 1, wordSpacing: 1),),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }
}
