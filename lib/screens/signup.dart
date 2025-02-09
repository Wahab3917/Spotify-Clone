import 'package:flutter/material.dart';
import 'package:spotify/utils/colors.dart';

class Signup extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<Signup> {
  Color _loginTextColor = Colors.white;
  int _hoveredButtonIndex = -1;


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
                    'Sign up to \nstart listening',
                    style: TextStyle(
                      fontSize: 42,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email address',
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
                            hintText: 'name@domain.com',
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
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Button Functionality
                            },
                            child: Text(
                              'Next',
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
                        SizedBox(height: 40),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Container(
                          // padding: EdgeInsets.symmetric(horizontal: 20),
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
                        RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: 'Spotify Mix',
                              fontWeight: FontWeight.w500,
                            ),
                            children: <InlineSpan>[
                              WidgetSpan(
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  onEnter: (_) => setState(() => _loginTextColor = accentColor),
                                  onExit: (_) => setState(() => _loginTextColor = Colors.white),
                                  child: GestureDetector(
                                    onTapDown: (_) => setState(() => _loginTextColor = accentColor),
                                    onTapUp: (_) => setState(() => _loginTextColor = Colors.white),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Log in here.',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: _loginTextColor,
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
                        SizedBox(height: 30),
                        Text(
                          'This site is protected by reCAPTCHA and the Google \n Privacy Policy and Terms of Service apply.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
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