import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'images/bg3.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: const Text(
              'ABOUT',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
