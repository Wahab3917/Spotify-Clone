import 'package:flutter/material.dart';
import '../service/spotify_data.dart';
import '../utils/colors.dart';

class Playlist extends StatelessWidget {
  final Map<String, dynamic> playlist;
  const Playlist({Key? key, required this.playlist}) : super(key: key);

  Future<List<Map<String, dynamic>>> _getPlaylistTracks() async {
    final SpotifyData spotifyData = SpotifyData();
    return await spotifyData.fetchPlaylistTracks(playlist['id']);
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    if (playlist['images'] != null && playlist['images'].isNotEmpty) {
      imageUrl = playlist['images'][0]['url'];
    }
    final playlistName = playlist['name'] ?? 'Playlist Details';
    final ownerName = playlist['owner']?['display_name'] ?? 'Unknown Owner';

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: themeColor,
        title: Text(
          playlistName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: themeColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Playlist header: image, name, owner
            Center(
              child: imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              playlistName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'By $ownerName',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 32),
            // Fetch and display tracks without duration
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _getPlaylistTracks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading tracks',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No tracks available',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  final tracks = snapshot.data!;
                  return ListView.builder(
                    itemCount: tracks.length,
                    itemBuilder: (context, index) {
                      final trackData = tracks[index]['track'];
                      final trackName =
                          trackData != null ? trackData['name'] : 'Unknown Track';
                      final artists = trackData != null &&
                              trackData['artists'] != null
                          ? (trackData['artists'] as List)
                              .map((a) => a['name'])
                              .join(', ')
                          : '';
                      return ListTile(
                        leading: trackData != null &&
                                trackData['album'] != null &&
                                trackData['album']['images'] != null &&
                                (trackData['album']['images'] as List).isNotEmpty
                            ? Image.network(
                                trackData['album']['images'][0]['url'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.music_note, color: Colors.white),
                        title: Text(
                          trackName,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          artists,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
