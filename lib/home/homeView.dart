// import 'package:flutter/material.dart';
// import 'package:tubes/profile/profile.dart';
// import 'package:tubes/movie/movie_list.dart';

// class MyHomeView extends StatefulWidget {
//   const MyHomeView({super.key});

//   @override
//   State<MyHomeView> createState() => _MyHomeViewState();
// }

// class _MyHomeViewState extends State<MyHomeView> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(color: Colors.black),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.person_2_rounded, size: 36),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ProfilePage()),
//                 );
//               },
//               color: Colors.white,
//             ),
//             IconButton(
//               icon: const Icon(Icons.notifications, size: 36),
//               onPressed: () {},
//               color: Colors.white,
//             ),
//           ],
//           title: RichText(
//             text: const TextSpan(
//               children: [
//                 TextSpan(
//                   text: "ATMA ",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Poppins-Bold',
//                     fontSize: 28,
//                   ),
//                 ),
//                 TextSpan(
//                   text: "Cinema",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Poppins-Regular',
//                     fontSize: 28,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             _buildSearchBar(),
//             const SizedBox(height: 20),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _buildSectionHeader("Now Playing", true),
//                     const SizedBox(height: 15),
//                     _buildMovieList(),
//                     _buildSectionHeader("Coming Soon", false),
//                     const SizedBox(height: 15),
//                     _buildComingSoonList(),
//                     _buildSectionHeader("ATMA News", false),
//                     const SizedBox(height: 15),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       margin: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: const Color(0xFF0A2038),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.white54),
//             onPressed: () {},
//           ),
//           Expanded(
//             child: TextField(
//               style: const TextStyle(color: Colors.white),
//               decoration: const InputDecoration(
//                 hintText: "Search for movies...",
//                 hintStyle: TextStyle(color: Colors.white54),
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.mic, color: Colors.white54),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title, bool showNowPlaying) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               color: Colors.white,
//               fontFamily: 'Poppins-SemiBold',
//               fontSize: 20,
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ListMovieView(
//                     showNowPlaying: showNowPlaying,
//                   ),
//                 ),
//               );
//             },
//             child: Row(
//               children: const [
//                 Text(
//                   "See all",
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                 ),
//                 SizedBox(width: 4),
//                 Icon(
//                   Icons.arrow_forward_ios,
//                   color: Colors.white70,
//                   size: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 12),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: movies,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMovieList() {
//     return SizedBox(
//       height: 250,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: const [
//           SizedBox(width: 16),
//           MovieCard(
//             imagePath: 'images/film1.jpg',
//             title: 'AVENGERS',
//             duration: '1h 20m',
//             ageRating: '17+',
//             format: '2D',
//           ),
//           MovieCard(
//             imagePath: 'images/film1.jpg',
//             title: 'SPIDERMAN',
//             duration: '2h 10m',
//             ageRating: '13+',
//             format: '3D',
//           ),
//           MovieCard(
//             imagePath: 'images/bg3.jpg',
//             title: 'BLACK PANTHER',
//             duration: '2h 30m',
//             ageRating: '13+',
//             format: '3D',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildComingSoonList() {
//     return SizedBox(
//       height: 220,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: const [
//           SizedBox(width: 16),
//           ComingSoonCard(
//             imagePath: 'images/film1.jpg',
//             title: 'IRON MAN',
//           ),
//           ComingSoonCard(
//             imagePath: 'images/film1.jpg',
//             title: 'IRON MAN 2',
//           ),
//           ComingSoonCard(
//             imagePath: 'images/film1.jpg',
//             title: 'IRON MAN 3',
//           ),
//         ],
//       ),
//     );
//   }
// }

// // MovieCard Widget
// class MovieCard extends StatelessWidget {
//   final String imagePath;
//   final String title;
//   final String duration;
//   final String ageRating;
//   final String format;

//   const MovieCard({
//     super.key,
//     required this.imagePath,
//     required this.title,
//     required this.duration,
//     required this.ageRating,
//     required this.format,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 365,
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12.0),
//             child: Image.asset(
//               imagePath,
//               fit: BoxFit.cover,
//               width: 350,
//               height: 180,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               MovieTag(text: duration),
//               const SizedBox(width: 8),
//               MovieTag(text: ageRating),
//               const SizedBox(width: 8),
//               MovieTag(text: format),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // MovieTag Widget
// class MovieTag extends StatelessWidget {
//   final String text;

//   const MovieTag({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1F1F1F),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 12,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

// // ComingSoonCard Widget
// class ComingSoonCard extends StatelessWidget {
//   final String imagePath;
//   final String title;

//   const ComingSoonCard({
//     super.key,
//     required this.imagePath,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 160,
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12.0),
//             child: Image.asset(
//               imagePath,
//               fit: BoxFit.cover,
//               width: 140,
//               height: 180,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:tubes/profile/profile.dart';
import 'package:tubes/movie/movie_list.dart';
import 'package:tubes/movie/movie.dart';
import 'package:tubes/movie/movieDetail.dart';
import 'package:tubes/movie/topMovieList.dart';
import 'package:tubes/home/home.dart';
import 'package:tubes/profile/profile.dart';
import 'package:tubes/news/news_list.dart';
import 'package:tubes/news/news_detail.dart';

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
                    const SizedBox(height: 15),
                    _buildSectionHeader("Coming Soon", false),
                    const SizedBox(height: 15),
                    _buildComingSoonList(),
                    const SizedBox(height: 30),
                    buildAtmaNewsSection(context),
                    const SizedBox(height: 30),
                    buildTopMoviesSection(context),
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
                  builder: (context) => ListMovieView(),
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
            imagePath: 'images/film1.jpg',
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

// MovieCard Widget
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

// MovieTag Widget
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

// ComingSoonCard Widget
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

Widget buildAtmaNewsSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ATMA news',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsList()),
                );
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            AtmaNewsCard(
              imagePath: 'images/bg2.jpg',
              description:
                  'Spider-Man: Way Back Home Confirmed for 2025 Release!',
            ),
            AtmaNewsCard(
              imagePath: 'images/bg2.jpg',
              description:
                  'Robert Downey Jr. Officially Returns as Iron Man: Announcement Delights Marvel Fans!',
            ),
            AtmaNewsCard(
              imagePath: 'images/bg2.jpg',
              description:
                  'Chris Evans Wields the Shield Again: Marvel Fans Cheer for the Return of Captain America!',
            ),
          ],
        ),
      ),
    ],
  );
}

// ATMA News Card Widget
class AtmaNewsCard extends StatelessWidget {
  final String imagePath;
  final String description;

  const AtmaNewsCard({
    required this.imagePath,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetail(
              imagePath: imagePath,
              title: description,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildTopMoviesSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Top Movies For You!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TopMovieList()),
                );
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            MovieListCard(
              imagePath: 'images/bg2.jpg',
              title: 'AVENGERS: ENDGAME',
              duration: '1h 20m',
              rating: '5/5',
              ageRating: '17+',
              format: '2D',
            ),
            MovieListCard(
              imagePath: 'images/bg2.jpg',
              title: 'AVENGERS: AGE OF ULTRON',
              duration: '1h 20m',
              rating: '4.9/5',
              ageRating: '17+',
              format: '2D',
            ),
            MovieListCard(
              imagePath: 'images/bg2.jpg',
              title: 'CAPTAIN AMERICA: CIVIL WAR',
              duration: '1h 20m',
              rating: '4.9/5',
              ageRating: '17+',
              format: '2D',
            ),
          ],
        ),
      ),
    ],
  );
}

class MovieListCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String duration;
  final String rating;
  final String ageRating;
  final String format;

  const MovieListCard({
    required this.imagePath,
    required this.title,
    required this.duration,
    required this.rating,
    required this.ageRating,
    required this.format,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 100,
              height: 120,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    MovieTag(text: duration),
                    const SizedBox(width: 8),
                    MovieTag(text: ageRating),
                    const SizedBox(width: 8),
                    MovieTag(text: format),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
