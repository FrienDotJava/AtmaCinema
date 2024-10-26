import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String director;
  final String posterUrl;

  Movie({required this.title, required this.director, required this.posterUrl});
}

final List<Movie> movies = [
  Movie(
    title: 'Inception',
    director: 'Christopher Nolan',
    posterUrl: 'images/inception.jpg',
  ),
  Movie(
    title: 'The Matrix',
    director: 'Lana & Lilly Wachowski',
    posterUrl: 'images/matrix.jpg',
  ),
  Movie(
    title: 'Frozen',
    director: 'Jennifer Lee & Chris Buck',
    posterUrl: 'images/frozen.jpeg',
  ),
  Movie(
    title: 'Inside Out',
    director: 'Pete Docter & Amy Poehler',
    posterUrl: 'images/inside_out.jpg',
  ),
  Movie(
    title: 'The Divine Fury',
    director: 'Jason Kim, Rain, Ahn Sung-Ki',
    posterUrl: 'images/fury.jpg',
  ),
  Movie(
    title: 'V.I.P',
    director: 'Park Hoon-Jung',
    posterUrl: 'images/vip.jpg',
  ),
  Movie(
    title: 'Dilwale',
    director: 'Shah Rukh Khan & Rohit Shetty',
    posterUrl: 'images/dilwale.jpg',
  ),
  Movie(
    title: 'Dilan 1990',
    director: 'Fajar Bustomi',
    posterUrl: 'images/dilan.jpg',
  ),
  Movie(
    title: 'Spongebob The Movie',
    director: 'Stephen Hillenburg',
    posterUrl: 'images/spongebob.jpg',
  ),
  Movie(
    title: 'The Good Dinosaur',
    director: 'Jon Favreau',
    posterUrl: 'images/dino.jpeg',
  ),
];
