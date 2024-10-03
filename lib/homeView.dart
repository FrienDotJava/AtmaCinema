import 'package:flutter/material.dart';

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
              icon: Icon(Icons.person_2_rounded),
              onPressed: () {},
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
              colors: [
                Color(0xFF000000), // Warna awal
                Color(0xFF000B6D) // Warna akhir
              ],
              stops: [0.3, 0.7],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFF1F1F1F),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'images/film1.jpg',
                  fit: BoxFit.cover,
                  width: 350,
                ),
              ],
            ),
          ),
        ));
  }
}
