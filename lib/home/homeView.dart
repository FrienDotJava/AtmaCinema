import 'package:flutter/material.dart';
import 'package:tubes/profile/profile.dart';
import 'package:tubes/movie/movie_list.dart';

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key});

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.person_2_rounded, size: 36),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              color: Colors.white,
            ),
            IconButton(
              icon: const Icon(Icons.notifications, size: 36),
              onPressed: () {},
              color: Colors.white,
            ),
          ],
          title: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "ATMA ",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins-Bold',
                    fontSize: 28,
                  ),
                ),
                TextSpan(
                  text: "Cinema",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins-Regular',
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSectionHeader("Now Playing", true),
                    const SizedBox(height: 15),
                    _buildMovieList(),
                    _buildSectionHeader("Coming Soon", false),
                    const SizedBox(height: 15),
                    _buildComingSoonList(),
                    _buildSectionHeader("ATMA News", false),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2038),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white54),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Search for movies...",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.white54),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool showNowPlaying) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins-SemiBold',
              fontSize: 20,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListMovieView(
                    showNowPlaying: showNowPlaying,
                  ),
                ),
              );
            },
            child: Row(
              children: const [
                Text(
                  "See all",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList() {
    return SizedBox(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          SizedBox(width: 16),
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
            title: 'BLACK PANTHER',
            duration: '2h 30m',
            ageRating: '13+',
            format: '3D',
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoonList() {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          SizedBox(width: 16),
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
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String duration;
  final String ageRating;
  final String format;

  const MovieCard({
    super.key,
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
      margin: const EdgeInsets.symmetric(horizontal: 8),
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

class MovieTag extends StatelessWidget {
  final String text;

  const MovieTag({super.key, required this.text});

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

class ComingSoonCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const ComingSoonCard({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8),
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
