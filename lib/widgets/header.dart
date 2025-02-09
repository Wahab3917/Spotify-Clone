import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Good evening',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Icon(Icons.notifications_outlined, color: Colors.white),
            SizedBox(width: 16),
            Icon(Icons.history, color: Colors.white),
            SizedBox(width: 16),
            Icon(Icons.settings_outlined, color: Colors.white),
          ],
        ),
      ],
    );
  }
}
