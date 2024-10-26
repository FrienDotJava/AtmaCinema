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
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, color: Colors.black),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined, color: Colors.black),
              label: 'List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_outlined, color: Colors.black),
              label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_movies, color: Colors.black),
              label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded, color: Colors.black),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
