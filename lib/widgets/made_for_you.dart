import 'package:flutter/material.dart';
import '../service/spotify_data.dart';

class MadeForYou extends StatelessWidget {
  const MadeForYou({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> _getNewReleases() async {
    final SpotifyData spotifyData = SpotifyData();
    return await spotifyData.fetchNewReleases();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getNewReleases(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading Made for You',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No items available',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final albums = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Made for you',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final album = albums[index];
                  String imageUrl = '';
                  if (album['images'] != null && album['images'].isNotEmpty) {
                    imageUrl = album['images'][0]['url'];
                  }
                  final albumName = album['name'] ?? 'Unnamed Album';
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        imageUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  imageUrl,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                height: 150,
                                width: 150,
                                color: Colors.grey[800],
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            albumName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
