import 'package:flutter/material.dart';
import 'package:tubes/movie.dart';

class ListMovieView extends StatelessWidget {
  const ListMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Film"),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: MovieList(),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          color: Colors.grey[850],
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Image.asset(
              movie.posterUrl,
              width: 50,
              height: 75,
              fit: BoxFit.cover,
            ),
            title: Text(
              movie.title,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            subtitle: Text(
              "Directed by: ${movie.director}",
              style: const TextStyle(color: Colors.grey),
            ),
            onTap: () {
              print("Tapped on ${movie.title}");
            },
          ),
        );
      },
    );
  }
}
