import 'package:flutter/material.dart';
import 'package:tubes/movieDetail.dart';
import 'movie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ListMovieView extends StatefulWidget {
  final bool showNowPlaying;

  const ListMovieView({Key? key, this.showNowPlaying = true}) : super(key: key);

  @override
  _ListMovieViewState createState() => _ListMovieViewState();
}

class _ListMovieViewState extends State<ListMovieView> {
  late bool showNowPlaying;
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    showNowPlaying = widget.showNowPlaying;
    _speech = stt.SpeechToText();
  }

  // Function to start or stop listening
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showNowPlaying = true;
                    });
                  },
                  child: FilterButton(
                    label: "Now Playing",
                    isSelected: showNowPlaying,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showNowPlaying = false;
                    });
                  },
                  child: FilterButton(
                    label: "Coming Soon",
                    isSelected: !showNowPlaying,
                  ),
                ),
              ],
            ),
          ),
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
            child: MovieGrid(
              movies: showNowPlaying ? nowPlayingMovies : comingSoonMovies,
              isComingSoon: !showNowPlaying,
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterButton({
    required this.label,
    required this.isSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;
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
  final Movie movie;
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
            builder: (context) =>
                //Ini dipakai buat nyimpen movie (indeks ?) dari movie yang diklik. Disimpan ke dalam variabel movie
                //Untuk isComingSoon dipakai untuk penanda di movie detail agar tombol beli tiket tidak bisa diklik
                //Semua variabel bisa disimpan karena di movieDetailPage membutuhkan semua variabel yang ada di movie (Atribut Class)
                MovieDetailPage(movie: movie, isComingSoon: isComingSoon),
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
                movie.posterUrl,
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
                    movie.title,
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
