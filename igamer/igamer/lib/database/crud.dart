// This class contains the necessary CRUD actions and attributes for the games used in the app
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igamer/database/gameRecord.dart';

//  gameID|this.title|publishedDate|gameDescription|imageLink|genre|developer|releaseDate|fullDescription|esrbRating|userScore|noOfUsers

class CRUD {
  //makes singleton
  static final CRUD _crud = CRUD._internal();
  Firestore _db = Firestore.instance;

  //internal constructor
  CRUD._internal();

  factory CRUD() {
    return _crud;
  }

  // Collection name
  final String _collection = "games";

  // Add a new game
  Future<void> addGame(GameRecord gameRecord) async {
    await _db
        .collection("games")
        .add(gameRecord.toMap())
        .then((documentReference) {
      print(documentReference.documentID);
    }).catchError((e) {
      print("Execution terminated with the Exception : " + e);
    });
  }

  // Get all games
  Stream<QuerySnapshot> getGames() {
    return _db.collection(_collection).snapshots();
  }

  // Update an existing game
  Future<void> editGame(
      GameRecord gameRecord, DocumentReference reference) async {
    await _db
        .collection("games")
        .document(reference.documentID)
        .updateData(gameRecord.toMap())
        .then((documentReference) {
      print(reference.documentID);
    }).catchError((e) {
      print("Execution terminated with the Exception : " + e);
    });
  }

  //Delete an existing game
  Future<void> deleteGame(
      BuildContext context, DocumentReference reference) async {
    if (await showConfirmationDialog(context)) {
      try {
        await _db.collection("games").document(reference.documentID).delete();
      } catch (e) {
        print(e);
      }
    }
  }

  //show confirmation box when deleting
  Future<bool> showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text('Are you sure you want to delete?'),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text('Delete'),
                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  textColor: Colors.black,
                  child: Text('No'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }
}
