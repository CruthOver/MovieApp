class MovieContract {
  static const String tableName = "movies";
  static const String id = "id";
  static const String title = "title";
  static const String description = "description";
  static const String director = "director";
  static const String genres = "genres";
  static const String casts = "casts";
  static const String posterPortrait = "poster_portrait";
  static const String posterLandscape = "poster_landscape";
  static const String trailerUrl = "trailer_url";
  static const String year = "year";
  static const String rating = "rating";
  static const String duration = "duration";
  static const String publishedAt = "published_at";
  static const String createdAt = "createdAt";

  static const columnName = {
    id: "INTEGER PRIMARY KEY AUTOINCREMENT ",
    title: "TEXT ",
    description: "TEXT ",
    director: "TEXT ",
    genres: "TEXT ",
    casts: "TEXT ",
    posterPortrait: "TEXT ",
    posterLandscape: "TEXT ",
    trailerUrl: "TEXT ",
    year: "TEXT ",
    rating: "REAL ",
    duration: "INTEGER ",
    publishedAt: "INTEGER ",
    createdAt: "INTEGER ",
  };
}
