import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/strings.dart';

class SpotifyData {

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