import 'package:flutter/material.dart';
import 'package:tubes/loading_screen.dart';
import 'package:tubes/login/login.dart';
import 'package:camera/camera.dart';
import 'package:tubes/profile/camera_screen.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
        '/camera': (context) => CameraScreen(cameras: cameras),
      },
    );
  }
}
