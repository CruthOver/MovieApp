import 'package:flutter/material.dart';
import 'package:movie_app/application/const/commons.dart';
import 'package:movie_app/application/const/images.dart';
import 'package:movie_app/application/models/movie.dart';
import 'package:movie_app/data/contracts/movie.contract.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BaseProvider {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await onInitDB();
    return _database!;
  }

  onInitDB() async {
    var path = await getDatabasesPath();
    var dbPath = join(path, Commons.databaseName);
    Database? dbConnection = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            _buildQuery(MovieContract.tableName, MovieContract.columnName));
        await _initData(db);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {},
    );
    return dbConnection;
  }

  String _buildQuery(String tableName, Map<String, dynamic> columnName) {
    String query = "CREATE TABLE IF NOT EXISTS ";
    query += tableName;
    query += "(";
    columnName.forEach((column, field) {
      query += "$column $field,";
    });
    query = query.substring(0, query.length - 1);
    query += " )";

    return query;
  }

  Future<void> _initData(Database db) async {
    List<Movie> movies = [
      //The Expendables
      Movie(
        title: "The Expendables",
        description:
            "Barney Ross leads the 'Expendables', a band of highly skilled mercenaries including knife enthusiast Lee Christmas, martial arts expert Yin Yang, heavy weapons specialist Hale Caesar, demolitionist Toll Road and loose-cannon sniper Gunner Jensen. When the group is commissioned by the mysterious Mr. Church to assassinate the merciless dictator of a small South American island, Barney and Lee head to the remote locale to scout out their opposition. Once there, they meet with local rebel Sandra and discover the true nature of the conflict engulfing the city. When they escape the island and Sandra stays behind, Ross must choose to either walk away and save his own life - or attempt a suicidal rescue mission that might just save his soul",
        director: "Sylvester Stallone",
        genres: "Action & Adventure, Thriller",
        casts:
            "Sylvester Stallone, Jason Statham, Dolph Lundgren, Jet Li, Eric Roberts, Randy Couture, Steve Austin, David Zayas, Giselle Itié, Charisma Carpenter, Gary Daniels, Terry Crews",
        posterPortrait: PosterPortrait.posterExpendables,
        posterLandscape: PosterLandscape.posterExpendables,
        trailerUrl: "https://www.youtube.com/watch?v=8KtYRALe-xo",
        duration: 103,
        year: "2010",
        rating: 6.4,
        publishedAt: DateTime.parse("2010-08-13").millisecondsSinceEpoch,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),

      //The Expendables 2
      Movie(
        title: "The Expendables 2",
        description:
            "Mr. Church reunites the Expendables for what should be an easy paycheck, but when one of their men is murdered on the job, their quest for revenge puts them deep in enemy territory and up against an unexpected threat.",
        director: "Simon West",
        genres: "Action & Adventure, Thriller",
        casts:
            "Sylvester Stallone, Jason Statham, Dolph Lundgren, Jet Li, Liam Hemsworth,Jean-Claude Van Damme, Bruce Willis, Chuck Norris, Arnold Schwarzenegger, Terry Crews, Scott Adkins, Amanda Ooms, Nan Yu, Charisma Carpenter",
        posterPortrait: PosterPortrait.posterExpendables2,
        posterLandscape: PosterLandscape.posterExpendables2,
        trailerUrl: "https://www.youtube.com/watch?v=ip_CYHdyUBs",
        duration: 103,
        year: "2012",
        rating: 6.6,
        publishedAt: DateTime.parse("2012-08-16").millisecondsSinceEpoch,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),

      // The Expendables 3
      Movie(
        title: "The Expendables 3",
        description:
            "Barney augments his team with new blood for a personal battle: to take down Conrad Stonebanks, the Expendables co-founder and notorious arms trader who is hell bent on wiping out Barney and every single one of his associates.",
        director: "Patrick Hughes",
        genres: "Action & Adventure, Thriller",
        casts:
            "Sylvester Stallone, Jason Statham, Dolph Lundgren, Jet Li, Randy Couture, Antonio Banderas, Arnold Schwarzenegger, Terry Crews, Wesley Snipes, Kelsey Grammer, Glen Powell, Victor Ortiz, Ronda Rousey, Kellan Lutz, Mel Gibson, Harrison Ford",
        posterPortrait: PosterPortrait.posterExpendables3,
        posterLandscape: PosterLandscape.posterExpendables3,
        trailerUrl: "https://www.youtube.com/watch?v=sTte6BQndTQ",
        duration: 126,
        year: "2014",
        rating: 6.1,
        publishedAt: DateTime.parse("2014-08-15").millisecondsSinceEpoch,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),

      // Expend4bles
      Movie(
        title: "Expend4bles",
        description:
            "Armed with every weapon they can get their hands on, the Expendables are the world's last line of defense and the team that gets called when all other options are off the table.",
        director: "Patrick Hughes",
        genres: "Action & Adventure, Thriller",
        casts:
            "Sylvester Stallone, Jason Statham, Curtis James Jackson, Megan Fox, Iko Uwais, Tony Jaa, Andy Garcia, Dolph Lundgren, Randy Couture, Levy Tran, Jacob Scipio",
        posterPortrait: PosterPortrait.posterExpendables4,
        posterLandscape: PosterLandscape.posterExpendables4,
        trailerUrl: "https://www.youtube.com/watch?v=DhlaBO-SwVE",
        duration: 103,
        year: "2023",
        rating: 4.9,
        publishedAt: DateTime.parse("2023-09-22").millisecondsSinceEpoch,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),

      //Extraction
      Movie(
        title: "Extraction",
        description:
            "A hardened gun-for-hire's latest mission becomes a soul-searching race to survive when he's sent into Bangladesh to rescue a drug lord's kidnapped son.",
        director: "Sam Hargrave",
        genres: "Action & Adventure Movies, Thriller, US Movies",
        casts:
            "Chris Hemsworth, Rudhraksh Jaiswal, Randeep Hooda, Golshifteh Farahani, Pankaj Tripathi, David Harbour",
        posterPortrait: PosterPortrait.posterExtraction,
        posterLandscape: PosterLandscape.posterExtraction,
        trailerUrl: "https://www.youtube.com/watch?v=L6P3nI6VnlY",
        duration: 122,
        rating: 6.8,
        year: "2020",
        publishedAt: DateTime.parse("2020-04-24").millisecondsSinceEpoch,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),

      //Extraction 2
      Movie(
        title: "Extraction 2",
        description:
            "Back from the brink of death, highly skilled commando Tyler Rake takes on another dangerous mission: saving the imprisoned family of a ruthless gangster.",
        director: "Sam Hargrave",
        genres: "Action & Adventure Movies, Thriller, US Movies",
        casts:
            "Chris Hemsworth, Golshifteh Farahani, Adam Bessa, Tornike Gogrichiani, Daniel Bernhardt, Tinatin Dalakishvili",
        posterPortrait: PosterPortrait.posterExtraction2,
        posterLandscape: PosterLandscape.posterExtraction2,
        trailerUrl: "https://www.youtube.com/watch?v=Y274jZs5s7s",
        duration: 123,
        year: "2023",
        rating: 7.0,
        publishedAt: DateTime.parse("2023-06-09").millisecondsSinceEpoch,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),

      //The Meg
      Movie(
          title: "The Meg",
          description:
              "A group of scientists exploring the Marianas Trench encounter the largest marine predator that has ever existed - the Megalodon.",
          director: "Jon Turteltaub",
          genres: "Action, Horror, Sci-Fi",
          casts:
              "Jason Statham, Li Bingbing, Ruby Rose, Rainn Wilson, Cliff Curtis, Jessica McNamee, Shuya Sophia Cai, Page Kennedy, Masi Oka, Winston Chao, Ólafur Darri Ólafsson, Robert Taylor",
          posterPortrait: PosterPortrait.posterTheMeg,
          posterLandscape: PosterLandscape.posterTheMeg,
          trailerUrl: "https://www.youtube.com/watch?v=Uj-S1vgnLCk",
          duration: 113,
          year: "2018",
          rating: 5.6,
          publishedAt: DateTime.parse("2018-08-15").millisecondsSinceEpoch,
          createdAt: DateTime.now().millisecondsSinceEpoch),

      //The Meg 2
      Movie(
          title: "Meg 2: The Trench",
          description:
              "A research team encounters multiple threats while exploring the depths of the ocean, including a malevolent mining operation.",
          director: "Ben Wheatley",
          genres: "Action & Adventure, Horror",
          casts:
              "Jason Statham, Li Bingbing, Shuya Sophia Cai, Page Kennedy, Cliff Curtis, Jessica McNamee, Wu Jing, Sergio Peris-Mencheta",
          posterPortrait: PosterPortrait.posterTheMeg2,
          posterLandscape: PosterLandscape.posterTheMeg2,
          trailerUrl: "https://www.youtube.com/watch?v=dG91B3hHyY4",
          duration: 116,
          year: "2023",
          rating: 5.1,
          publishedAt: DateTime.parse("2023-08-02").millisecondsSinceEpoch,
          createdAt: DateTime.now().millisecondsSinceEpoch),

      //Jack Reacher
      Movie(
          title: "Jack Reacher",
          description:
              "Police arrest a sniper who contacts ex-military investigator Reacher for help. But as he and the sniper's lawyer dig into the case, a conspiracy unfolds.",
          director: "Christopher McQuarrie",
          genres: "Action & Adventure, Mystery, Thriller",
          casts:
              "Tom Cruise, Rosamund, Pike, Richard, Jenkins, Werner Herzog, Jai Courtney, Robert Duvall",
          posterPortrait: PosterPortrait.posterJackReacher,
          posterLandscape: PosterLandscape.posterJackReacher,
          trailerUrl: "https://www.youtube.com/watch?v=lvQzb1YMdtY",
          duration: 133,
          year: "2012",
          rating: 7.0,
          publishedAt: DateTime.parse("2012-12-19").millisecondsSinceEpoch,
          createdAt: DateTime.now().millisecondsSinceEpoch),

      //Jack Reacher 2
      Movie(
          title: "Jack Reacher: Never Go Back",
          description:
              "When he learns that his friend has been accused of murder, Jack Reacher suspects a vast conspiracy -- and soon finds himself on the run alongside her.",
          director: "Edward Zwick",
          genres: "Action & Adventure, Crime, Drama",
          casts:
              "Tom Cruise, Cobie Smulders, Danika Yarosh, Aldis Hodge, Robert Knepper, Holt McCallany, Patrick Heusinger",
          posterPortrait: PosterPortrait.posterJackReacherNeverGoBack,
          posterLandscape: PosterLandscape.posterJackReacherNeverGoBack,
          trailerUrl: "https://www.youtube.com/watch?v=EovL1a5I3dA",
          duration: 118,
          year: "2016",
          rating: 6.1,
          publishedAt: DateTime.parse("2016-10-19").millisecondsSinceEpoch,
          createdAt: DateTime.now().millisecondsSinceEpoch),

      //Mechanic
      Movie(
          title: "The Mechanic",
          description:
              "An elite hitman teaches his trade to an apprentice who has a connection to one of his previous victims.",
          director: "Simon West",
          genres:
              "Crime Movies, Action & Adventure Movies, Thriller, US Movies",
          casts: "Jason Statham, Ben Foster, Tony Goldwyn, Donald Sutherland",
          posterPortrait: PosterPortrait.posterMechanic,
          posterLandscape: PosterLandscape.posterMechanic,
          trailerUrl: "https://www.youtube.com/watch?v=39L8egLr518",
          duration: 93,
          year: "2011",
          rating: 6.5,
          publishedAt: DateTime.parse("2011-01-25").millisecondsSinceEpoch,
          createdAt: DateTime.now().millisecondsSinceEpoch),

      //Mechanic 2
      Movie(
          title: "Mechanic: Resurrection",
          description:
              "When the woman he loves is kidnapped by an old enemy, retired hit man Arthur Bishop is forced to tackle a list of difficult assassination missions.",
          director: "Dennis Gansel",
          genres: "Crime Movies, Action & Adventure Movies, US Movies",
          casts:
              "Jason Statham, Jessica Alba, Tommy Lee Jones, Michelle Yeoh, Sam Hazeldine, John Cenatiempo, Toby Eddington, Femi Elufowoju Jr, Anteo Quintavalle, Yayaying Rhatha Phongam",
          posterPortrait: PosterPortrait.posterMechanic2,
          posterLandscape: PosterLandscape.posterMechanic2,
          trailerUrl: "https://www.youtube.com/watch?v=QF903RaKLvs",
          duration: 98,
          year: "2016",
          rating: 5.7,
          publishedAt: DateTime.parse("2016-08-26").millisecondsSinceEpoch,
          createdAt: DateTime.now().millisecondsSinceEpoch),

      //Rambo: Last Blood
      Movie(
          title: "Rambo: Last Blood",
          description:
              "Veteran warrior John Rambo returns for one final battle as he seeks ferocious vengeance on a drug cartel targeting his family.",
          director: "Adrian Grunberg",
          genres: "Action & Adventures, Crime, Thriller",
          casts:
              "Sylvester Stallone, Paz Vega, Sergio Peris-Mencheta, Adriana Barraza, Yvette Monreal, Genie Kim, Joaquín Cosío, Óscar Jaenada",
          posterPortrait: PosterPortrait.posterRamboLastBlood,
          posterLandscape: PosterLandscape.posterRamboLastBlood,
          trailerUrl: "https://www.youtube.com/watch?v=4vWg5yJuWfs",
          duration: 96,
          year: "2019",
          rating: 6.1,
          publishedAt: DateTime.parse("2019-09-18").millisecondsSinceEpoch,
          createdAt: DateTime.now().millisecondsSinceEpoch),

      //Transformers: The Last Knight
      Movie(
          title: "Transformers: The Last Knight",
          description:
              "After Optimus Prime takes a dark turn, Cade Yeager joins forces with a group of Autobots to stop a villainous plot to destroy Earth.",
          director: "Michael Bay",
          genres: "Action & Adventures, Sci-Fi",
          casts:
              "Mark Wahlberg, Anthony Hopkins, Josh Duhamel, Laura Haddock, Stanley Tucci, John Turturro, Isabela Merced, Santiago Cabrera, Tony Hale, Liam Garrigan, Jerrod Carmichael, Mitch Pileggi",
          posterPortrait: PosterPortrait.posterTransformers,
          posterLandscape: PosterLandscape.posterTransformers,
          trailerUrl: "https://www.youtube.com/watch?v=lFBQBvaQNrQ",
          duration: 156,
          year: "2017",
          rating: 5.2,
          publishedAt: DateTime.parse("2017-07-21").millisecondsSinceEpoch,
          createdAt: DateTime.now().millisecondsSinceEpoch),

      // The Big 4
      Movie(
        title: "The Big 4",
        description:
            "Four retired assassins spring back into action when they cross paths with a straight-arrow cop who's determined to track down an elusive murderer.",
        director: "Timo Tjahjanto",
        genres: "Action, Comedy, Crime",
        casts:
            "Abimana Aryasatya, Putri Marino, Arie Kriting, Lutesha, Kristo Immanuel, Marthino Lio, Michelle Tahalea, Budi Ros, Donny Damara",
        posterPortrait: PosterPortrait.posterBig4,
        posterLandscape: PosterLandscape.posterBig4,
        trailerUrl: "https://www.youtube.com/watch?v=sQQJEiESrK0",
        duration: 141,
        year: "2022",
        rating: 6.1,
        publishedAt: DateTime.parse("2022-12-15").millisecondsSinceEpoch,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),

      //Mission Impossible
      Movie(
          title: "Mission: Impossible - Dead Reckoning Part One",
          description:
              "Ethan Hunt and his IMF team must track down a dangerous weapon before it falls into the wrong hands.",
          director: "Christopher McQuarrie",
          genres: "Action & Adventure, Thriller",
          casts:
              "Tom Cruise, Hayley Atwell, Ving Rhames, Simon Pegg, Rebecca Ferguson, Vanessa Kirby, Esai Morales, Henry Czerny, Shea Whigham, Greg Tarzan Davis, Pom Klementieff",
          posterPortrait: PosterPortrait.posterMissionImpossible,
          posterLandscape: PosterLandscape.posterMissionImpossible,
          trailerUrl: "https://www.youtube.com/watch?v=avz06PDqDbM",
          duration: 163,
          year: "2023",
          rating: 7.9,
          publishedAt: DateTime.parse("2023-07-12").millisecondsSinceEpoch,
          createdAt: DateTime.now().millisecondsSinceEpoch),

      //Fast Furious 7
      Movie(
        title: "Furious 7",
        description:
            "Deckard Shaw seeks revenge against Dominic Toretto and his family for his comatose brother.",
        director: "James Wan",
        genres: "Action & Adventure, Crime, Thriller",
        casts:
            "Vin Diesel, Paul Walker, Dwayne Johnson, Jason Statham, Jordana Brewster, Michelle Rodriguez, Tyrese Gibson, Ludacris, Kurt Russell, Elsa Pataky, Nathalie Emmanuel, Gal Gadot",
        posterPortrait: PosterPortrait.posterFurious7,
        posterLandscape: PosterLandscape.posterFurious7,
        trailerUrl: "https://www.youtube.com/watch?v=CCo9DG59yXM",
        duration: 140,
        year: "2015",
        rating: 7.1,
        publishedAt: DateTime.parse("2015-04-03").millisecondsSinceEpoch,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),

      //Fast Furious 8
      Movie(
        title: "The Fate of the Furious",
        description:
            "When a mysterious woman seduces Dominic Toretto into the world of terrorism and a betrayal of those closest to him, the crew face trials that will test them as never before.",
        director: "F. Gary Gray",
        genres: "Action & Adventure, Crime, Thriller",
        casts:
            "Vin Diesel, Dwayne Johnson, Jason Statham, Michelle Rodriguez, Tyrese Gibson, Ludacris, Kurt Russell, Nathalie Emmanuel, Charlize Theron, Scott Eastwood",
        posterPortrait: PosterPortrait.posterFateAndFurious,
        posterLandscape: PosterLandscape.posterFateAndFurious,
        trailerUrl: "https://www.youtube.com/watch?v=uisBaTkQAEs",
        duration: 136,
        year: "2017",
        rating: 7.1,
        publishedAt: DateTime.parse("2017-04-12").millisecondsSinceEpoch,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      )
    ];
    List<Map<String, dynamic>> currentMovies =
        await db.query(MovieContract.tableName);
    if (currentMovies.isEmpty) {
      debugPrint("Movie is empty");
      movies.map((element) async {
        debugPrint("Input ${element.title}");
        await db.insert(MovieContract.tableName, element.toJSON());
      }).toList();
    }
  }
}
