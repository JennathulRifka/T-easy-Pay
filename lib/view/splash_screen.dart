import 'dart:async';
import 'package:flutter/material.dart';
import 'package:teasy/view/start_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToStartScreen();
  }

  Future<void> _navigateToStartScreen() async {
    await Future.delayed(Duration(seconds: 3)); // Simulating loading delay
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StartScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Color(0xFFFFF9C4), // Light pastel yellow color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpeg', // Replace with your app logo
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              "T-Easy Pay",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(
              color: isDarkMode ? Colors.white : Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
