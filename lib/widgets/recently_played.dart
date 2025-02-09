import 'package:flutter/material.dart';
import '../service/spotify_data.dart';

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> _getRecentlyPlayed() async {
    final SpotifyData spotifyData = SpotifyData();
    return await spotifyData.fetchRecentlyPlayed();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getRecentlyPlayed(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading recently played',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No recently played tracks available',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final recentlyPlayed = snapshot.data!;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: recentlyPlayed.length,
          itemBuilder: (context, index) {
            final item = recentlyPlayed[index];
            // Each item should contain a "track" key with track details.
            final track = item['track'];
            final trackName = track != null ? track['name'] ?? 'Unknown Track' : 'Unknown Track';
            String imageUrl = '';
            if (track != null &&
                track['album'] != null &&
                track['album']['images'] != null &&
                track['album']['images'].isNotEmpty) {
              imageUrl = track['album']['images'][0]['url'];
            }
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  imageUrl.isNotEmpty
                      ? ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                          child: Image.network(
                            imageUrl,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 56,
                          height: 56,
                          color: Colors.grey[800],
                        ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      trackName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
