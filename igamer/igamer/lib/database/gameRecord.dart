import 'package:cloud_firestore/cloud_firestore.dart';

// This class contains attributes and relevant methods for the Game entity
class GameRecord {
  final int gameID;
  final String title;
  final String publishedDate;
  final String gameDescription;
  final String imageLink;
  final String genre;
  final String developer;
  final String releaseDate;
  final String fullDescription;
  final String esrbRating;
  final String userScore;
  final String noOfUsers;
  final DocumentReference reference;

  // Constructor
  GameRecord(this.gameID, this.title, this.publishedDate, this.gameDescription,
      this.imageLink, this.genre, this.developer, this.releaseDate,
      this.fullDescription, this.esrbRating, this.userScore, this.noOfUsers, this.reference);

  // this function maps the attributes received from map to GameRecord class
  // meanwhile this function also asserts if the all the mapping attributes are null
  GameRecord.fromMap(Map<String, dynamic> map, {this.reference}):
        assert(map['gameID'] != null),
        assert(map['title'] != null),
        assert(map['publishedDate'] != null),
        assert(map['gameDescription'] != null),
        assert(map['imageLink'] != null),
        assert(map['genre'] != null),
        assert(map['developer'] != null),
        assert(map['releaseDate'] != null),
        assert(map['fullDescription'] != null),
        assert(map['esrbRating'] != null),
        assert(map['userScore'] != null),
        assert(map['noOfUsers'] != null),
        gameID = map['gameID'],
        title = map['title'],
        publishedDate = map['publishedDate'],
        gameDescription = map['gameDescription'],
        imageLink = map['imageLink'],
        genre = map['genre'],
        developer = map['developer'],
        releaseDate = map['releaseDate'],
        fullDescription = map['fullDescription'],
        esrbRating = map['esrbRating'],
        userScore = map['userScore'],
        noOfUsers = map['noOfUsers'];

  // this function maps the attributes received to map to GameRecord class
  Map<String, dynamic> toMap(){
    return {
      'gameID': gameID,
      'title': title,
      'publishedDate': publishedDate,
      'gameDescription': gameDescription,
      'imageLink': imageLink,
      'genre': genre,
      'developer': developer,
      'releaseDate': releaseDate,
      'fullDescription': fullDescription,
      'esrbRating': esrbRating,
      'userScore': userScore,
      'noOfUsers': noOfUsers,
    };
  }

  GameRecord.fromSnapshot(DocumentSnapshot snapshot):
        this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$title>";
}
