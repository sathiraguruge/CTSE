import 'package:flutter/material.dart';
import 'game.dart';
import 'gameList.dart';
import 'gameCard.dart';

//Know a Game	AS a Game reviewer app user I need to be able to see a list of games that are available and selecting one will show more details of the game
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageTitle = "Available Games";
    // Get Available Games List
    List<Game> availableGames = new GameList().renderGameList();

    return MaterialApp(
        title: pageTitle,
        home: Scaffold(
            appBar: AppBar(
              title: Text(pageTitle),
            ),
            body: new Container(
              margin: const EdgeInsets.only(top: 20),
              child: new ListView(
                  children: List.generate(availableGames.length, (index) {
                    return Center(
                      child: GameCard(
                          game: availableGames[index], item: availableGames[index]),
                    );
                  })),
            )));
  }
}
