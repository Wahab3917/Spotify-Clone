import 'package:flutter/material.dart';
import 'package:spotify/pages/login_page.dart';
import 'package:spotify/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Spotify Mix'),
      home: Signup(),
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
      },
    );
  }
}
