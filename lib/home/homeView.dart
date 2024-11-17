import 'package:flutter/material.dart';
import 'package:tubes/movie/movie_list.dart';
import 'package:tubes/home/home.dart';
import 'package:tubes/profile/profile.dart';

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key});

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF000000), Color(0xFF000B6D)],
            stops: [0.3, 0.7],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSearchSection(context),
            const SizedBox(height: 10),
            _buildMovieSection(
              context,
              title: 'Now Playing',
              movies: _buildNowPlayingMovies(),
              nowPlaying: true,
            ),
            const SizedBox(height: 12),
            _buildMovieSection(
              context,
              title: 'Coming Soon',
              movies: _buildComingSoonMovies(),
              nowPlaying: false,
            ),
          ],
        ),
      ),
    );
  }

  // AppBar
  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          icon: const Icon(Icons.person_2_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
          color: Colors.white,
          iconSize: 40,
        ),
        IconButton(
          icon: const Icon(Icons.notification_add_rounded),
          onPressed: () {},
          color: Colors.white,
          iconSize: 40,
        ),
      ],
      title: const Text(
        'Atma Cinema',
        style: TextStyle(
          color: Colors.white,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Search Section
  Widget _buildSearchSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello, User!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
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
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.mic, color: Colors.white54),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                iconSize: 32,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Movie Section (bisa juga pake ini buat yang playing now + coming soon)
  Widget _buildMovieSection(
    BuildContext context, {
    required String title,
    required List<Widget> movies,
    required bool nowPlaying,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // nanti direct ke movie detail
                },
                child: const Text(
                  'See all >',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: movies,
          ),
        ),
      ],
    );
  }

  // Now Playing
  List<Widget> _buildNowPlayingMovies() {
    return [
      MovieCard(
        imagePath: 'images/film1.jpg',
        title: 'AVENGERS',
        duration: '1h 20m',
        ageRating: '17+',
        format: '2D',
      ),
      MovieCard(
        imagePath: 'images/film1.jpg',
        title: 'SPIDERMAN',
        duration: '2h 10m',
        ageRating: '13+',
        format: '3D',
      ),
      MovieCard(
        imagePath: 'images/bg3.jpg',
        title: 'IRON MAN',
        duration: '2h 10m',
        ageRating: '13+',
        format: '3D',
      ),
    ];
  }

  // Coming Soon
  List<Widget> _buildComingSoonMovies() {
    return [
      ComingSoonCard(
        imagePath: 'images/film1.jpg',
        title: 'IRON MAN',
      ),
      ComingSoonCard(
        imagePath: 'images/film1.jpg',
        title: 'IRON MAN 2',
      ),
      ComingSoonCard(
        imagePath: 'images/film1.jpg',
        title: 'IRON MAN 3',
      ),
    ];
  }
}

// MovieCard Widget
class MovieCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String duration;
  final String ageRating;
  final String format;

  const MovieCard({
    required this.imagePath,
    required this.title,
    required this.duration,
    required this.ageRating,
    required this.format,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 365,
      height: 250,
      margin: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 350,
              height: 180,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MovieTag(text: duration),
              const SizedBox(width: 8),
              MovieTag(text: ageRating),
              const SizedBox(width: 8),
              MovieTag(text: format),
            ],
          ),
        ],
      ),
    );
  }
}

// MovieTag Widget
class MovieTag extends StatelessWidget {
  final String text;

  const MovieTag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ComingSoonCard Widget
class ComingSoonCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const ComingSoonCard({
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 140,
              height: 180,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
