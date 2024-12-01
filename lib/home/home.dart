import 'package:flutter/material.dart';
import 'package:tubes/fnb/fnb.dart';
import 'package:tubes/profile/profile.dart';
import 'package:tubes/home/homeView.dart';
import 'package:tubes/movie/movie_list.dart';
import 'package:tubes/ticket/ticketPage.dart';

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
    Center(child: TicketsPage()),
    Center(child: ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? Icon(Icons.home_filled, color: Colors.white)
                  : Icon(Icons.home_outlined, color: Colors.white),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? Icon(Icons.movie_creation, color: Colors.white)
                  : Icon(Icons.movie_creation_outlined, color: Colors.white),
              label: 'Movies'),
          BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? Icon(Icons.food_bank, color: Colors.white)
                  : Icon(Icons.food_bank_outlined, color: Colors.white),
              label: 'FnB'),
          BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? Icon(Icons.local_movies, color: Colors.white)
                  : Icon(Icons.local_movies_outlined, color: Colors.white),
              label: 'Tickets'),
          BottomNavigationBarItem(
              icon: _selectedIndex == 4
                  ? Icon(Icons.person_2, color: Colors.white)
                  : Icon(Icons.person_2_outlined, color: Colors.white),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontFamily: 'Poppins-Bold', fontSize: 14),
        unselectedLabelStyle:
            TextStyle(fontFamily: 'Poppins-Medium', fontSize: 12),
        onTap: _onItemTapped,
      ),
      body: _selectedIndex == 1
          ? ListMovieView()
          : _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
