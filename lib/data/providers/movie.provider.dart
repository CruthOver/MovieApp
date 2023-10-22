import 'package:flutter/cupertino.dart';
import 'package:movie_app/application/models/movie.dart';
import 'package:movie_app/data/contracts/movie.contract.dart';
import 'package:movie_app/data/providers/base.provider.dart';

class MovieProvider {
  Future<int> addMovie(Movie movie) async {
    var db = await BaseProvider().database;

    return await db.insert(MovieContract.tableName, movie.toJSON());
  }

  Future<List<Movie>> getMovieTopRated() async {
    var db = await BaseProvider().database;
    List<Map<String, dynamic>> data = await db.query(MovieContract.tableName,
        orderBy: "${MovieContract.rating} DESC", limit: 3);

    return List.generate(data.length, (index) {
      return Movie.fromJSON(data[index]);
    });
  }

  Future<List<Movie>> getMovieLatest() async {
    var db = await BaseProvider().database;
    List<Map<String, dynamic>> data = await db.query(MovieContract.tableName,
        orderBy: "${MovieContract.publishedAt} DESC", limit: 3);

    return List.generate(data.length, (index) {
      debugPrint("${data[index]['poster_portrait']}");
      return Movie.fromJSON(data[index]);
    });
  }

  Future<List<Movie>> getAllMovie({String query = ''}) async {
    var db = await BaseProvider().database;
    List<Map<String, dynamic>> data = await db.query(MovieContract.tableName,
        where: 'LOWER(${MovieContract.title}) LIKE ?',
        whereArgs: ['%$query%'],
        orderBy: "${MovieContract.id} DESC");

    return List.generate(data.length, (index) {
      return Movie.fromJSON(data[index]);
    });
  }

  Future<List<Movie>> getSimilarMovies(
      {String cast = '', String genres = ''}) async {
    var db = await BaseProvider().database;
    List<Map<String, dynamic>> data = await db.query(MovieContract.tableName,
        where:
            'LOWER(${MovieContract.casts}) LIKE ? OR LOWER(${MovieContract.genres}) LIKE ? ',
        whereArgs: ['%$cast%', '%$genres%'],
        orderBy: "${MovieContract.id} DESC",
        limit: 6);

    return List.generate(data.length, (index) {
      return Movie.fromJSON(data[index]);
    });
  }
}
