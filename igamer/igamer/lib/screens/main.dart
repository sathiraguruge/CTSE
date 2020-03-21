import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igamer/database/crud.dart';
import '../database/gameRecord.dart';
import '../common_ui_widgets/appBar.dart';
import '../common_ui_widgets/drawer.dart';
import '../common_ui_widgets/gameCard.dart';
import '../common_ui_widgets/alertBox.dart';
import 'addGame.dart';
import 'dart:io';

// Name of the page
final pageTitle = "Available Games";

// Main method
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: pageTitle,
      home: MyHomePage(title: pageTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // this function checks active internet connection
  // if not, it will popup an Alert Box
  _checkInternetConnection(BuildContext context) async {
    try {
      await InternetAddress.lookup('google.com');
    } on SocketException catch (_) {
      new AppAlertBox(context, "Error", "No Internet Connection", "OK")
          .showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkInternetConnection(context);
    return Scaffold(
      appBar: new CustomizedAppBar(pageTitle).getAppBar(), // Calling Custom build app bar
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddGame())); // Navigates to Add Game screen
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
      drawer: new CustomizedDrawer(context).getDrawer(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: new CRUD().getGames(), // getting a list of games
      builder: (context, snapshot) {
        // checking if data exists
        if (snapshot.hasError || !snapshot.hasData)
          // if no data a Circular Progress Indicator shows up in the middle of the screen
          return Center(
              child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  "Loading",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ));
        // if data exist build a list
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  // this function returns a ListView based on snapShot data
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapShot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20),
      children: snapShot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  // this function returns a Card embedded with Padding
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final gameRecord = GameRecord.fromSnapshot(data);
    return Padding(
        key: ValueKey(gameRecord.title),
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
        child: GameCard(game: gameRecord));
  }
}
