import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/application/models/movie.dart';
import 'package:movie_app/presentation/shared/movie.tile.dart';
import 'package:movie_app/presentation/shared/shimmers/shimmer.tile.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieModal extends StatefulWidget {
  final Movie movie;
  final List<Movie>? similarMovie;

  const DetailMovieModal({super.key, required this.movie, this.similarMovie});

  @override
  State<DetailMovieModal> createState() => _DetailMovieModalState();
}

class _DetailMovieModalState extends State<DetailMovieModal> {
  late YoutubePlayerController _controller;
  Movie? _movie;

  @override
  void initState() {
    _movie = widget.movie;
    _controller = YoutubePlayerController(
      initialVideoId: _getVideoId(),
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: false,
          showLiveFullscreenButton: false),
    );
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getVideoId() {
    String videoId =
        _movie!.trailerUrl!.substring(_movie!.trailerUrl!.length - 11) ?? "";
    return videoId;
  }

  String _duration() {
    int hour = _movie!.duration! ~/ 60;
    int minute = _movie!.duration! % 60;
    return "${hour}h ${minute}m";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blue,
                ),
                Positioned(
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 14.0,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.close, color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text(
                "${_movie!.title}",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "${_movie!.year}",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _duration(),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Text(
                        "${_movie!.rating}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                children: [
                  Text("Director : ",
                      style: Theme.of(context).textTheme.labelLarge),
                  Text("${_movie!.director}",
                      style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                children: [
                  Text("Genres : ",
                      style: Theme.of(context).textTheme.labelLarge),
                  Text("${_movie!.genres}",
                      style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Casts : ",
                      style: Theme.of(context).textTheme.labelLarge),
                  Flexible(
                    child: Text(
                      "${_movie!.casts}",
                      style: Theme.of(context).textTheme.labelLarge,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              endIndent: 10,
              indent: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Storyline",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${_movie!.description}",
                    style: Theme.of(context).textTheme.bodyMedium,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.grey,
              endIndent: 10,
              indent: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Text(
                "Similar Movies",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.start,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.similarMovie != null &&
                          widget.similarMovie!.isNotEmpty
                      ? widget.similarMovie!.length
                      : 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (widget.similarMovie != null &&
                        widget.similarMovie!.isNotEmpty) {
                      Movie movie = widget.similarMovie![index];
                      return MovieTile(
                        movie: movie,
                        widthTitle: 145,
                      );
                    } else {
                      return const ShimmerTile();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
