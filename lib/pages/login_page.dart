import 'package:flutter/material.dart';
import 'package:spotify/utils/colors.dart';
import 'package:spotify/service/spotify_auth_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  bool _obscureText = true;
  Color _forgotTextColor = Colors.white;
  Color _signupTextColor = Colors.white;
  int _hoveredButtonIndex = -1;
  bool _isLoading = false;
   
  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Spotify Authentication
  Future<void> _authenticateSpotify() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await SpotifyAuthService.remoteService();
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('Spotify authentication failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Image.asset('assets/spotify_icon_white.png'),
                  SizedBox(height: 20),
                  Text(
                    'Log in to Spotify',
                    style: TextStyle(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [

                        ...List.generate(3, (index) {
                        final List<Map<String, String>> buttonData = [
                          {'text': 'Sign up with Google', 'icon': 'assets/google_icon.png'},
                          {'text': 'Sign up with Facebook', 'icon': 'assets/facebook_icon.png'},
                          {'text': 'Sign up with Apple', 'icon': 'assets/apple_icon.png'},
                        ];

                          return Column(
                            children: [
                              MouseRegion(
                                onEnter: (_) => setState(() => _hoveredButtonIndex = index),
                                onExit: (_) => setState(() => _hoveredButtonIndex = -1),
                                child: GestureDetector(
                                  onTapDown: (_) => setState(() => _hoveredButtonIndex = index),
                                  onTapUp: (_) => setState(() => _hoveredButtonIndex = -1),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // Button Functionality
                                      },
                                    style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ).copyWith(
                                      side: MaterialStateProperty.resolveWith((states) {
                                        if (states.contains(MaterialState.hovered) || _hoveredButtonIndex == index) {
                                          return BorderSide(color: Colors.white, width: 1);
                                        }
                                        return BorderSide(color: Colors.grey, width: 1);
                                      }),
                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          buttonData[index]['icon']!,
                                          height: 32,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          buttonData[index]['text']!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      }),
                    ]),
                  ),
                  SizedBox(height: 40),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email or username',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email or username',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: _togglePasswordView,
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureText,
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _isLoading ? null : _authenticateSpotify();
                            },
                            child: Text(
                              _isLoading ? 'Logging in...' : 'Log In',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor,
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => _forgotTextColor = accentColor),
                          onExit: (_) => setState(() => _forgotTextColor = Colors.white),
                          child: GestureDetector(
                            onTapDown: (_) => setState(() => _forgotTextColor = accentColor),
                            onTapUp: (_) => setState(() => _forgotTextColor = Colors.white),
                            onTap: () {
                              Navigator.pushNamed(context, '/forgot_password');
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Forgot your password?',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _forgotTextColor,
                                  fontFamily: 'Spotify Mix',
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Spotify Mix',
                            ),
                            children: <InlineSpan>[
                              WidgetSpan(
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  onEnter: (_) => setState(() => _signupTextColor = accentColor),
                                  onExit: (_) => setState(() => _signupTextColor = Colors.white),
                                  child: GestureDetector(
                                    onTapDown: (_) => setState(() => _signupTextColor = accentColor),
                                    onTapUp: (_) => setState(() => _signupTextColor = Colors.white),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Sign up for Spotify.',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: _signupTextColor,
                                          fontFamily: 'Spotify Mix',
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 50),
                      ],
                    ), 
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}