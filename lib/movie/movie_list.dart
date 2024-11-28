import 'package:flutter/material.dart';
import 'package:tubes/movie/movieDetail.dart';
import 'movie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:tubes/client/FilmClient.dart';
import 'package:tubes/entity/Film.dart';

class ListMovieView extends StatefulWidget {
  const ListMovieView({Key? key}) : super(key: key);

  @override
  _ListMovieViewState createState() => _ListMovieViewState();
}

class _ListMovieViewState extends State<ListMovieView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _searchQuery = "";
  late Future<List<Film>> nowPlayingMovies; // List<Film> untuk 'Now Playing'
  late Future<List<Film>> comingSoonMovies; // List<Film> untuk 'Coming Soon'

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _speech = stt.SpeechToText();

    // Panggil API berdasarkan status
    nowPlayingMovies = FilmClient.fetchByStatus('now playing');
    comingSoonMovies = FilmClient.fetchByStatus('coming soon');
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print("onStatus: $status"),
        onError: (error) => print("onError: $error"),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _searchQuery = result.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Movies",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          tabs: const [
            Tab(text: "Now Playing"),
            Tab(text: "Coming Soon"),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white54),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      controller: TextEditingController(text: _searchQuery),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search movies...',
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white54,
                    ),
                    onPressed: _listen,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Menampilkan data film yang sedang tayang
                // Disini pakai FutureBuilder untuk menampilkan data film yang sedang tayang
                FutureBuilder<List<Film>>(
                  future: nowPlayingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No movies found'));
                    } else {
                      return MovieGrid(
                        movies: snapshot.data!,
                        isComingSoon: false,
                      );
                    }
                  },
                ),

                // Menampilkan data film yang akan tayang
                // Disini pakai FutureBuilder untuk menampilkan data film yang akan tayang
                FutureBuilder<List<Film>>(
                  future: comingSoonMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No movies found'));
                    } else {
                      return MovieGrid(
                        movies: snapshot.data!,
                        isComingSoon: true,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  final List<Film> movies;
  final bool isComingSoon;

  const MovieGrid({
    required this.movies,
    required this.isComingSoon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie: movie, isComingSoon: isComingSoon);
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Film movie;
  final bool isComingSoon;

  const MovieCard({
    required this.movie,
    required this.isComingSoon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(
              movie: movie,
              isComingSoon: isComingSoon,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                movie.poster,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    movie.judul_film,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
