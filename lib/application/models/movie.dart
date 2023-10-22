import 'package:movie_app/data/contracts/movie.contract.dart';

class Movie {
  int? id;
  String? title;
  String? description;
  String? genres;
  String? casts;
  String? director;
  String? trailerUrl;
  String? year;
  String? posterPortrait;
  String? posterLandscape;
  int? duration;
  double? rating;
  int? publishedAt;
  int? createdAt;

  Movie(
      {this.id,
      this.title,
      this.description,
      this.director,
      this.genres,
      this.casts,
      this.trailerUrl,
      this.posterPortrait,
      this.posterLandscape,
      this.year,
      this.rating,
      this.duration,
      this.publishedAt,
      this.createdAt});

  factory Movie.fromJSON(Map<String, dynamic> json) => Movie(
        id: json['id'] ?? 0,
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        director: json['director'] ?? "",
        genres: json['genres'] ?? "",
        casts: json['casts'] ?? "",
        posterPortrait: json['poster_portrait'] ?? "",
        posterLandscape: json['poster_landscape'] ?? "",
        trailerUrl: json['trailer_url'] ?? "",
        year: json['year'] ?? "",
        rating: json['rating'] ?? 0.0,
        duration: json['duration'] ?? 0,
        publishedAt: json['published_at'] ?? 0,
        createdAt: json['created_at'] ?? 0,
      );

  Map<String, dynamic> toJSON() => {
        MovieContract.title: title,
        MovieContract.description: description,
        MovieContract.director: director,
        MovieContract.genres: genres,
        MovieContract.casts: casts,
        MovieContract.year: year,
        MovieContract.posterPortrait: posterPortrait,
        MovieContract.posterLandscape: posterLandscape,
        MovieContract.trailerUrl: trailerUrl,
        MovieContract.rating: rating,
        MovieContract.duration: duration,
        MovieContract.publishedAt: publishedAt,
        MovieContract.createdAt: createdAt,
      };

  @override
  String toString() {
    // TODO: implement toString
    return "Movie("
        "id=$id,"
        "title=$title,"
        "description=$description,"
        "posterP=$posterPortrait,"
        "posterL=$posterLandscape,";
  }
}
