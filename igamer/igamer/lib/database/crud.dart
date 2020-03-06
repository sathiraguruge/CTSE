import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igamer/database/gameRecord.dart';

//  gameID|this.title|publishedDate|gameDescription|imageLink|genre|developer|releaseDate|fullDescription|esrbRating|userScore|noOfUsers

class CRUD {

  Future<void> addGame(GameRecord gameRecord) async {
    final db = Firestore.instance;
    await db.collection("games").add({
      'gameID': gameRecord.gameID,
      'title': gameRecord.title,
      'publishedDate': gameRecord.publishedDate,
      'gameDescription': gameRecord.gameDescription,
      'imageLink': gameRecord.imageLink,
      'genre': gameRecord.genre,
      'developer': gameRecord.developer,
      'releaseDate': gameRecord.releaseDate,
      'fullDescription': gameRecord.fullDescription,
      'esrbRating': gameRecord.esrbRating,
      'userScore': gameRecord.userScore,
      'noOfUsers': gameRecord.noOfUsers,
    }).then((documentReference) {
      print(documentReference.documentID);
    }).catchError((e) {
      print(e);
    });
  }
}
