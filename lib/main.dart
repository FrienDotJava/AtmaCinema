import 'package:flutter/material.dart';
import 'package:tubes/loading_screen.dart';
import 'package:tubes/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Vince-220711806'),
        ),
      ),
=======
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoadingScreen(),
      routes: {
        '/home': (context) => LoginPage(),
      },
>>>>>>> main
    );
  }
}
