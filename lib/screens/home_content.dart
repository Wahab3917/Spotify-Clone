import 'package:flutter/material.dart';
import 'package:spotify/utils/colors.dart';
import 'package:spotify/widgets/header.dart';
import 'package:spotify/widgets/recently_played.dart';
import 'package:spotify/widgets/made_for_you.dart';
import 'package:spotify/widgets/my_playlists.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);
  
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
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
    );
  }
}
