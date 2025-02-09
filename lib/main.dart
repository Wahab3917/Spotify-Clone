import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// SCREENS
import 'package:spotify/screens/get_started.dart';
import 'package:spotify/screens/login.dart';
import 'package:spotify/screens/signup.dart';
import 'package:spotify/screens/home.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Spotify Mix'),
      home: GetStarted(),
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/home': (context) => Home(),
      },

    );
  }
}
