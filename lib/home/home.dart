import 'package:flutter/material.dart';
import 'package:tubes/fnb/fnb.dart';
import 'package:tubes/profile/profile.dart';
import 'package:tubes/home/homeView.dart';
import 'package:tubes/movie/movie_list.dart';
import 'package:tubes/news/news_list.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => homePageState();
}

class homePageState extends State<homePage> {
  int _selectedIndex = 0;
  bool showNowPlaying = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) showNowPlaying = true;
    });
  }

  void navigateToMovies({required bool nowPlaying}) {
    setState(() {
      _selectedIndex = 1;
      showNowPlaying = nowPlaying;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: MyHomeView()),
    Center(child: ListMovieView()),
    Center(child: FnBPage()),
    Center(child: NewsList()),
    Center(child: ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, color: Colors.white),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined, color: Colors.white),
              label: 'Movies'),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_outlined, color: Colors.white),
              label: 'FnB'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_movies, color: Colors.white),
              label: 'Tickets'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded, color: Colors.white),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
      ),
      body: _selectedIndex == 1
          ? ListMovieView(showNowPlaying: showNowPlaying)
          : _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
