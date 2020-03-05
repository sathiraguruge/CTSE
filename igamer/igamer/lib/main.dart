import 'package:flutter/material.dart';
import 'package:igamer/drawer.dart';
import 'package:igamer/pageTitle.dart';
import 'game.dart';
import 'gameList.dart';
import 'gameCard.dart';
import 'drawer.dart';

//Know a Game	AS a Game reviewer app user I need to be able to see a list of games that are available and selecting one will show more details of the game
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final pageTitle = "Available Games";

  @override
  Widget build(BuildContext context) {
    // Get Available Games List
    List<Game> availableGames = new GameList().renderGameList();
    return MaterialApp(
        title: pageTitle,
        home: Scaffold(
          appBar: new CustomizedAppBar(pageTitle).getAppBar(),
          body: new Container(
            margin: const EdgeInsets.only(top: 20),
            child: new ListView(
                children: List.generate(availableGames.length, (index) {
                  return Center(
                    child: GameCard(
                        game: availableGames[index], item: availableGames[index]),
                  );
                })),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: null,
            tooltip: 'Increment',
            child: Icon(Icons.add),
            backgroundColor: Colors.orange,
          ),
          drawer: new CustomizedDrawer(context).getDrawer(),
        ));
  }
}