import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igamer/database/gameRecord.dart';

//  gameID|this.title|publishedDate|gameDescription|imageLink|genre|developer|releaseDate|fullDescription|esrbRating|userScore|noOfUsers

// This class contains the necessary CRUD actions and attributes for the games used in the app
class CRUD {

  //makes singleton
  static final CRUD _crud = CRUD._internal();
  Firestore _db = Firestore.instance;

  //internal constructor
  CRUD._internal();

  factory CRUD(){
    return _crud;
  }

  // Collection name
  final String _collection = "games";
  DocumentReference reference;

  // Add a new game
  Future<void> addGame(GameRecord gameRecord) async {
    await _db.collection("games").add(gameRecord.toMap()).then(
            (documentReference) {
      print(documentReference.documentID);
    }).catchError((e) {
      print("Execution terminated with the Exception : " + e);
    });
  }

  // Get all games
  Stream<QuerySnapshot> getGames(){
    return _db.collection(_collection).snapshots();
  }

  // Update an existing game
  Future<void> editGame(GameRecord gameRecord) async {
    await _db.collection("games").document(reference.documentID).updateData(gameRecord.toMap()).then(
            (documentReference) {
              print(reference.documentID);
        }).catchError((e) {
      print("Execution terminated with the Exception : " + e);
    });
  }

  //Delete an existing game
  Future<void> deleteGame(DocumentReference reference) async {
    _db.collection("games").document(reference.documentID).delete();
  }

}