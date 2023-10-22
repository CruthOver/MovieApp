import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/application/models/movie.dart';
import 'package:movie_app/presentation/pages/home/controllers/home.controller.dart';
import 'package:movie_app/presentation/shared/detail.movie.modal.dart';
import 'package:movie_app/presentation/shared/movie.tile.dart';

class SearchWidget extends GetView<HomeController> {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Search Results",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black,
                  ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 250,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                ),
                itemCount: controller.searchResultMovies.length,
                itemBuilder: (context, index) {
                  Movie movie = controller.searchResultMovies[index];
                  return MovieTile(
                    movie: movie,
                    widthTitle: 145,
                    onTap: (movie) {
                      controller.getSimilarMovies(movie);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DetailMovieModal(
                            movie: movie,
                            similarMovie: controller.similarMovies,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
