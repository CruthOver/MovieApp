import 'package:flutter/material.dart';
import 'package:movie_app/application/models/movie.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final double? widthTitle;
  final void Function(Movie movie)? onTap;

  const MovieTile(
      {super.key, required this.movie, this.widthTitle = 200, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(movie),
      child: Stack(
        children: [
          // Image.asset(
          //   movie.posterPortrait!,
          //   fit: BoxFit.fill,
          // ),
          Container(
            width: 200,
            height: 300,
            margin: const EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(movie.posterPortrait!),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 18.0,
                  ),
                  Text(
                    "${movie.rating}",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: widthTitle,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              color: Colors.black.withOpacity(.7),
              child: Text(
                "${movie.title} (${movie.year})",
                softWrap: true,
                style: widthTitle == 200
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white)
                    : Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
