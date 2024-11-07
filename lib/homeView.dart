import 'package:flutter/material.dart';
import 'package:tubes/movie_list.dart';
import 'package:tubes/home.dart';
import 'package:tubes/profile.dart';

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key});

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              icon: Icon(Icons.notification_add_rounded),
              onPressed: () {},
              color: Colors.white,
              iconSize: 40,
            ),
          ],
          title: const Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 1.0),
                child: Text(
                  'Atma Cinema',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF000000), Color(0xFF000B6D)],
              stops: [0.3, 0.7],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello, User!', //masih dummy buat UI
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
                                  icon: const Icon(Icons.search,
                                      color: Colors.white54),
                                  onPressed: () {
                                    // buat search
                                  },
                                ),
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.mic,
                                      color: Colors.white54),
                                  onPressed: () {
                                    // buat voice search
                                  },
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications,
                                color: Colors.white),
                            iconSize: 32,
                            onPressed: () {
                              // buat notif
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Now Playing',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (context
                                  .findAncestorStateOfType<homePageState>() !=
                              null) {
                            context
                                .findAncestorStateOfType<homePageState>()!
                                .navigateToMovies(nowPlaying: true);
                          }
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 8),
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
                        imagePath: 'images/film1.jpg',
                        title: 'SPIDERMAN',
                        duration: '2h 10m',
                        ageRating: '13+',
                        format: '3D',
                      ),
                      MovieCard(
                        imagePath: 'images/bg3.jpg',
                        title: 'SPIDERMAN',
                        duration: '2h 10m',
                        ageRating: '13+',
                        format: '3D',
                      ),
                      MovieCard(
                        imagePath: 'images/film1.jpg',
                        title: 'SPIDERMAN',
                        duration: '2h 10m',
                        ageRating: '13+',
                        format: '3D',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Coming Soon',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (context
                                  .findAncestorStateOfType<homePageState>() !=
                              null) {
                            context
                                .findAncestorStateOfType<homePageState>()!
                                .navigateToMovies(
                                    nowPlaying: false); // Direct to Coming Soon
                          }
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
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
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
                      ComingSoonCard(
                        imagePath: 'images/film1.jpg',
                        title: 'IRON MAN 3',
                      ),
                      ComingSoonCard(
                        imagePath: 'images/film1.jpg',
                        title: 'IRON MAN 3',
                      ),
                      ComingSoonCard(
                        imagePath: 'images/film1.jpg',
                        title: 'IRON MAN 3',
                      ),
                      ComingSoonCard(
                        imagePath: 'images/film1.jpg',
                        title: 'IRON MAN 3',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

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
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MovieTag(text: duration),
                const SizedBox(width: 8),
                MovieTag(text: ageRating),
                const SizedBox(width: 8),
                MovieTag(text: format),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
          Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
