import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/strings.dart';

class SpotifyData {

  /// Fetches the current user's profile.
  Future<Map<String, dynamic>> fetchUserProfile() async {
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $Access_Token',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      print('Failed to fetch user profile. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to fetch user profile');
    }
  }

  /// Fetches the recently played tracks.
  Future<List<Map<String, dynamic>>> fetchRecentlyPlayed() async {
    try {
      
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/me/player/recently-played?limit=6'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $Access_Token',
        },
      );

      print("HTTP response status (recently played): ${response.statusCode}");
      print("HTTP response body (recently played): ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // The API returns a JSON object with an "items" key that is a list of tracks
        final List<Map<String, dynamic>> items =
            List<Map<String, dynamic>>.from(data['items']);
        print('Recently played fetched successfully: ${items.length} items');
        return items;
      } else {
        print('Failed to fetch recently played. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch recently played');
      }
    } catch (e) {
      print('Error fetching recently played: $e');
      throw Exception('Error fetching recently played: $e');
    }
  }

  /// Fetches new releases from Spotify
  Future<List<Map<String, dynamic>>> fetchNewReleases() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/browse/new-releases?offset=0&limit=5'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $Access_Token',
        },
      );

      print("HTTP response status (new releases): ${response.statusCode}");
      print("HTTP response body (new releases): ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // The new releases endpoint returns an "albums" object with an "items" array.
        final List<Map<String, dynamic>> albums =
            List<Map<String, dynamic>>.from(data['albums']['items']);
        print('New releases fetched successfully: ${albums.length} items');
        return albums;
      } else {
        print('Failed to fetch new releases. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch new releases');
      }
    } catch (e) {
      print('Error fetching new releases: $e');
      throw Exception('Error fetching new releases: $e');
    }
  }

  // Fetches the current user's playlists.
  Future<List<Map<String, dynamic>>> fetchMyPlaylists() async {
    try {
      print("Fetching user playlists with access token: $Access_Token");
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/me/playlists'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $Access_Token',
        },
      );

      print("HTTP response status: ${response.statusCode}");
      print("HTTP response body: ${response.body}");

      if (response.statusCode == 200) {
        // The response JSON should have an "items" key containing the playlists.
        final Map<String, dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> playlists = 
            List<Map<String, dynamic>>.from(data['items']);
        print('User playlists fetched successfully: ${playlists.length} items');
        return playlists;
      } else {
        print('Failed to fetch user playlists. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch user playlists');
      }
    } catch (e) {
      print('Error fetching user playlists: $e');
      throw Exception('Error fetching user playlists: $e');
    }
  }

}