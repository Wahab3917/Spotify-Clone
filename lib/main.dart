import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// SCREENS
import 'package:spotify/pages/get_started.dart';
import 'package:spotify/pages/login_page.dart';
import 'package:spotify/pages/signup_page.dart';
import 'package:spotify/pages/home_page.dart';

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
      home: GetStartedPage(),
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/home': (context) => HomePage(),
      },

    );
  }
}
