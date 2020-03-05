import 'package:cloud_firestore/cloud_firestore.dart';

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

  GameRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['gameID'] != null),
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

  GameRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$title>";
}
