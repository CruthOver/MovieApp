import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/application/models/movie.dart';
import 'package:movie_app/presentation/pages/home/controllers/home.controller.dart';
import 'package:movie_app/presentation/pages/home/views/widgets/top.movie.widget.dart';
import 'package:movie_app/presentation/shared/detail.movie.modal.dart';
import 'package:movie_app/presentation/shared/movie.tile.dart';
import 'package:movie_app/presentation/shared/shimmers/shimmer.carousel.dart';
import 'package:movie_app/presentation/shared/shimmers/shimmer.tile.dart';

class MainWidget extends GetView<HomeController> {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                controller.isLoading.value
                    ? const ShimmerCarousel()
                    : CarouselSlider(
                        carouselController: controller.carouselController.value,
                        items: controller.topRatedMovies
                            .map((element) => TopMovieRatedWidget(
                                  movie: element,
                                  onTap: (movie) async {
                                    await controller.getSimilarMovies(movie);
                                    showDialog(
                                      context: Get.context!,
                                      builder: (context) {
                                        return DetailMovieModal(
                                          movie: movie,
                                          similarMovie:
                                              controller.similarMovies,
                                        );
                                      },
                                    );
                                  },
                                ))
                            .toList(),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            controller.currentIndex.value = index;
                          },
                          height: MediaQuery.of(context).size.height / 3,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 10),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          viewportFraction: 1,
                          pageSnapping: true,
                          initialPage: controller.currentIndex.value,
                          enableInfiniteScroll: true,
                        ),
                      ),
                controller.isLoading.value
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            controller.topRatedMovies.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              controller.carouselController.value
                                  .animateToPage(index);
                            },
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                      .withOpacity(
                                          controller.currentIndex.value == index
                                              ? 0.9
                                              : 0.4)),
                            ),
                          );
                        }),
                      ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        "Latest Movie",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.black,
                                ),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.latestMovies.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (controller.isLoading.value) {
                            return const ShimmerTile(
                              isPopular: false,
                            );
                          } else {
                            Movie movie = controller.latestMovies[index];
                            return MovieTile(
                              movie: movie,
                              onTap: (movie) async {
                                await controller.getSimilarMovies(movie);
                                showDialog(
                                  context: Get.context!,
                                  builder: (context) {
                                    return DetailMovieModal(
                                      movie: movie,
                                      similarMovie: controller.similarMovies,
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        "Popular Movie",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.black,
                                ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 250,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: controller.isLoading.value
                            ? 4
                            : controller.popularMovies.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (controller.isLoading.value) {
                            return const ShimmerTile();
                          } else {
                            Movie movie = controller.popularMovies[index];
                            return MovieTile(
                              movie: movie,
                              widthTitle: 145,
                              onTap: (movie) async {
                                await controller.getSimilarMovies(movie);
                                showDialog(
                                  context: Get.context!,
                                  builder: (context) {
                                    return DetailMovieModal(
                                      movie: movie,
                                      similarMovie: controller.similarMovies,
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
