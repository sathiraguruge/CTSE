import 'game.dart';

class GameList {
  final String _imageDefaultImageLocation = 'assets/images/';
  List<Game> _games = [];

//  gameID|this.title|publishedDate|gameDescription|imageLink|genre|developer|releaseDate|fullDescription|esrbRating|userScore|noOfUsers

  List renderGameList() {
    _games.add(new Game(1,
        "DreadOut",
        "1 June 2019",
        "A unique take on third-person action-adventure survival horror with Indonesian supernatural in veins.",
        _imageDefaultImageLocation + "dreadout.jpg",
        "Action, Adventure, Horror",
        "Digital Happiness",
        "22 Feb, 2020",
        "A unique take on third-person action-adventure survival horror with Indonesian supernatural in veins. Mixed gameplay of city exploring, “DreadOut” style smartphone ghost hunting and new action-packed combat within DreadOut supernatural realm. Even though it is a Horror game in veins, but with the touch of silly high school problems, satiric social commentaries, and yet touchy memorable moments, DreadOut 2 will become a fresh take on the survival horror genre.",
        "E",
        "7.5",
        "1"));
    _games.add(new Game(2,
        "Forza Horizon 4",
        "1 June 2016",
        "Dynamic seasons change everything at the world’s greatest automotive festival.",
        _imageDefaultImageLocation + "forzahorizon.jpg",
        "Racing, Simulation, Automobile",
        "Playground Games",
        "2 Oct, 2018",
        "Dynamic seasons change everything at the world’s greatest automotive festival. Go it alone or team up with others to explore beautiful and historic Britain in a shared open world. Collect, modify, and drive over 450 cars. Race, stunt, create, and explore – choose your own path to become a Horizon Superstar. The Forza Horizon 4 Ultimate Edition digital bundle includes the Car Pass, VIP Membership, Formula Drift Car Pack, Best of Bond Car Pack, and two game expansions when they become available.",
        "E",
        "7.8",
        "Up to 12 Players"));
    _games.add(new Game(3,
        "Need for Speed - ProStreet",
        "1 June 2019",
        "A new spin on the Need for Speed franchise, ProStreet thrusts players into a head-to-head competition against the best street racers in a multitude of racing showdowns.",
        _imageDefaultImageLocation + "nfspro.jpg",
        "Arcade, Racing",
        "Black Box",
        "November 13, 2017",
        "A new spin on the Need for Speed franchise, ProStreet thrusts players into a head-to-head competition against the best street racers in a multitude of racing showdowns. The game is a true taste of raw adrenaline and racing with consequences. Every dent, every scratch and every crumpled body panel is a battle scar, proof of your commitment and competitive mettle. With an aggressive and skilled AI system, you become immersed in an unmatched believable race experience. Add in a revolutionary online mode that will redefine the meaning of competitive social play, and Need for Speed ProStreet is the ultimate formula for an emotionally charged street racing showdown. It also pushes the “Autosculpt” technology to a new level, allowing you to directly impact your car’s performance for the first time as well as personalize its appearance.",
        "E10",
        "6.2",
        "8 Players Online"));
    _games.add(new Game(4,
        "Grand Theft Auto V",
        "1 June 2017",
        "Grand Theft Auto V for PC offers players the option to explore the award-winning world of Los Santos and Blaine County in resolutions of up to 4k and beyond",
        _imageDefaultImageLocation + "gta5.jpg",
        "Action, Adventure",
        "Rockstar",
        "14 Apr, 2015",
        "When a young street hustler, a retired bank robber and a terrifying psychopath find themselves entangled with some of the most frightening and deranged elements of the criminal underworld, the U.S. government and the entertainment industry, they must pull off a series of dangerous heists to survive in a ruthless city in which they can trust nobody, least of all each other."
            "Grand Theft Auto V for PC offers players the option to explore the award-winning world of Los Santos and Blaine County in resolutions of up to 4k and beyond, as well as the chance to experience the game running at 60 frames per second."
            "The game offers players a huge range of PC-specific customization options, including over 25 separate configurable settings for texture quality, shaders, tessellation, anti-aliasing and more, as well as support and extensive customization for mouse and keyboard controls. Additional options include a population density slider to control car and pedestrian traffic, as well as dual and triple monitor support, 3D compatibility, and plug-and-play controller support.Grand Theft Auto V for PC also includes Grand Theft Auto Online, with support for 30 players and two spectators. Grand Theft Auto Online for PC will include all existing gameplay upgrades and Rockstar-created content released since the launch of Grand Theft Auto Online, including Heists and Adversary modes.",
        "M",
        "7.8",
        "Up to 32 Players"));
    _games.add(new Game(5,
        "Need for Speed Rivals",
        "1 June 2018",
        "Need for Speed Rivals captures the adrenaline and intensity of the street’s ultimate rivalry between cops and racers in a stunning open road environment.",
        _imageDefaultImageLocation + "nfsrivals.jpg",
        "Arcade, Racing",
        "Ghost, Criterion Games",
        "18 Nov, 2013",
        "Need for Speed Rivals captures the adrenaline and intensity of the street’s ultimate rivalry between cops and racers in a stunning open road environment. Built on the Frostbite 3 game engine, Need for Speed Rivals allows gamers play as either a cop or racer, where each side of the law has its own set of high stakes challenges, rewards and consequences. As a racer, the goal is to become infamous for taking risks behind the wheel and capturing your most intense escapes on video for the world to see. The more cops players evade, the more Speed Points they collect, enabling them to unlock new cars and items. Keep raising the stakes race after race to become an ever-more valuable target to the cops — but risk losing it all if busted. As a cop, players work together as part of a team in pursuit of racers, earning prominence and rising in the ranks of the Police Force with every bust. Achieving higher ranks unlocks new police-only cars and more powerful pursuit tech."
            "At the heart of Need for Speed Rivals is AllDrive, an innovative new online feature that allows gamers to seamlessly transition from playing alone to playing with friends, eliminating the line between single player and multiplayer. Players will have to keep one eye on their rearview mirror as friends will be able to enter and exit races on-the-fly, creating a world where no two events will ever be the same.",
        "E10+",
        "3.5",
        "Upto 8 Players"));
    return _games;
  }
}
