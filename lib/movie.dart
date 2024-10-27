import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String director;
  final String posterUrl;

  Movie({required this.title, required this.director, required this.posterUrl});
}

final List<Movie> movies = [
  Movie(
    title: 'AVENGERS',
    director: 'Joss Whedon',
    posterUrl: 'images/img_poster/avengers.jpg',
  ),
  Movie(
    title: 'AVENGERS: INFINITY WAR',
    director: 'Anthony & Joe Russo',
    posterUrl: 'images/img_poster/infinity_war.jpg',
  ),
  Movie(
    title: 'AVENGERS: ENDGAME',
    director: 'Anthony & Joe Russo',
    posterUrl: 'images/img_poster/endgame.jpg',
  ),
  Movie(
    title: 'AVENGERS: AGE OF ULTRON',
    director: 'Joss Whedon',
    posterUrl: 'images/img_poster/age_of_ultron.jpg',
  ),
];
