import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_app/application/models/movie.dart';
import 'package:movie_app/data/providers/movie.provider.dart';

class HomeController extends GetxController {
  final MovieProvider movieProvider = MovieProvider();
  var carouselController = CarouselController().obs;
  var searchController = TextEditingController().obs;
  var topRatedMovies = <Movie>[].obs;
  var latestMovies = <Movie>[].obs;
  var popularMovies = <Movie>[].obs;
  var searchResultMovies = <Movie>[].obs;
  var similarMovies = <Movie>[].obs;
  var isLoading = true.obs;
  var currentIndex = 0.obs;
  var onSearch = false.obs;

  @override
  void onInit() async {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        isLoading.toggle();
      },
    );

    searchController.value.addListener(() async {
      if (searchController.value.text.isNotEmpty) {
        await getAllMovie();
      }
    });

    await getTopRatedMovie();
    await getLatestMovie();
    await getAllMovie();
    super.onInit();
  }

  Future<void> getTopRatedMovie() async {
    topRatedMovies.value = await movieProvider.getMovieTopRated();
  }

  Future<void> getLatestMovie() async {
    latestMovies.value = await movieProvider.getMovieLatest();
    debugPrint("${latestMovies.length}");
  }

  Future<void> getAllMovie() async {
    if (searchController.value.text.isNotEmpty) {
      searchResultMovies.value =
          await movieProvider.getAllMovie(query: searchController.value.text);
    } else {
      popularMovies.value = await movieProvider.getAllMovie();
    }
  }

  Future<void> getSimilarMovies(Movie movieSelected) async {
    String genre = movieSelected.genres!.split(",")[0];
    String cast = movieSelected.casts!.split(",")[0];
    similarMovies.value =
        await movieProvider.getSimilarMovies(genres: genre, cast: cast);
  }

  void changeSearch() {
    onSearch.toggle();
    searchController.value.clear();
    searchResultMovies.clear();
  }
}
