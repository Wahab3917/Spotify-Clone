import 'package:flutter/material.dart';
import '../service/spotify_data.dart';
import '../utils/colors.dart';

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  // Helper widget to build the user profile avatar
  Widget _buildProfileAvatar() {
    return FutureBuilder<Map<String, dynamic>>(
      future: SpotifyData().fetchUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While loading, display a placeholder avatar.
          return const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey,
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          // If error or no data, fallback to a default image or placeholder.
          return const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://placekitten.com/100/100'),
          );
        }
        final profileData = snapshot.data!;
        String imageUrl = '';
        if (profileData['images'] != null && profileData['images'].isNotEmpty) {
          imageUrl = profileData['images'][0]['url'];
        }
        // If no image found, fallback to a placeholder.
        if (imageUrl.isEmpty) {
          return const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://placekitten.com/100/100'),
          );
        }
        return CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(imageUrl),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildProfileAvatar(), // Display the user's profile image
                  const SizedBox(width: 12),
                  const Text(
                    'Your Library',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('Playlists'),
                      selected: true,
                      onSelected: (bool selected) {},
                      backgroundColor: Colors.grey[900],
                      selectedColor: Colors.white,
                      labelStyle: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Artists'),
                      selected: false,
                      onSelected: (bool selected) {},
                      backgroundColor: Colors.grey[900],
                      labelStyle: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Albums'),
                      selected: false,
                      onSelected: (bool selected) {},
                      backgroundColor: Colors.grey[900],
                      labelStyle: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.music_note, color: Colors.white),
                      ),
                      title: Text(
                        'Playlist ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        'Playlist • User',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
