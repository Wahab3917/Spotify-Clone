import 'package:flutter/material.dart';
import 'package:spotify/utils/colors.dart';
import 'package:spotify/widgets/header.dart';
import 'package:spotify/widgets/recently_played.dart';
import 'package:spotify/widgets/made_for_you.dart';
import 'package:spotify/widgets/my_playlists.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Header(),
                SizedBox(height: 24),
                RecentlyPlayed(),
                SizedBox(height: 32),
                MadeForYou(),
                SizedBox(height: 32),
                MyPlaylists(),


              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Your Library',  
          ),
        ],
      ),
    );
  }
}
