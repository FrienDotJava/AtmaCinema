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
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoadingScreen(),
      routes: {
        '/home': (context) => LoginPage(),
      },
    );
  }
}
