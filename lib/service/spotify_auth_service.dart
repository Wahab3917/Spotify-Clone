import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../utils/strings.dart';

class SpotifyAuthService {

  static final String CLIENT_ID = dotenv.env['CLIENT_ID'] ?? '';
  static final String CLIENT_SECRET = dotenv.env['CLIENT_SECRET'] ?? '';

  static Future<void> remoteService() async {
    AccessTokenResponse? accessToken;
    SpotifyOAuth2Client client = SpotifyOAuth2Client(
      customUriScheme: 'spotify',
      redirectUri: 'spotify://callback',
    );

    var authResp = await client.requestAuthorization(
      clientId: CLIENT_ID,

      customParams: {'show_dialog': 'true'},
      scopes: ['user-read-private', 'user-read-playback-state', 'user-modify-playback-state', 'user-read-currently-playing', 'user-read-email']
    );
    
    var authCode = authResp.code;

    accessToken = await client.requestAccessToken(
      code: authCode.toString(),
      clientId: CLIENT_ID,
      clientSecret: CLIENT_SECRET
    );

    Access_Token = accessToken.accessToken ?? '';
    Refresh_Token = accessToken.refreshToken ?? '';

  }
}

