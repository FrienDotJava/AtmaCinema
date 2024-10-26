import 'package:flutter/material.dart';
import 'package:tubes/profile.dart';
import 'package:tubes/homeView.dart';
import 'package:tubes/movie_list.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: MyHomeView(),
    ),
    Center(
      child: ListMovieView(),
    ),
    Center(
      child: ProfilePage(),
    ),
    Center(
      child: ProfilePage(),
    ),
    Center(
      child: ProfilePage(),
    ),
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
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
