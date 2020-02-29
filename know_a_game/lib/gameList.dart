import 'game.dart';

class GameList {
  final String _imageDefaultImageLocation = 'assets/images/';
  List<Game> _games = [];

  List renderGameList() {
    _games.add(new Game(
        "DreadOut",
        "1 June 2019",
        "A unique take on third-person action-adventure survival horror with Indonesian supernatural in veins.",
        _imageDefaultImageLocation + "dreadout.jpg"));
    _games.add(new Game(
        "Forza Horizon",
        "1 June 2016",
        "Dynamic seasons change everything at the world’s greatest automotive festival.",
        _imageDefaultImageLocation + "forzahorizon.jpg"));
    _games.add(new Game(
        "Need for Speed - ProStreet",
        "1 June 2019",
        "A new spin on the Need for Speed franchise, ProStreet thrusts players into a head-to-head competition against the best street racers in a multitude of racing showdowns.",
        _imageDefaultImageLocation + "nfspro.jpg"));
    _games.add(new Game(
        "Grand Theft Auto V",
        "1 June 2017",
        "Grand Theft Auto V for PC offers players the option to explore the award-winning world of Los Santos and Blaine County in resolutions of up to 4k and beyond",
        _imageDefaultImageLocation + "gta5.jpg"));
    _games.add(new Game(
        "Need for Speed Rivals",
        "1 June 2018",
        "Need for Speed Rivals captures the adrenaline and intensity of the street’s ultimate rivalry between cops and racers in a stunning open road environment.",
        _imageDefaultImageLocation + "nfsrivals.jpg"));
    return _games;
  }
}
