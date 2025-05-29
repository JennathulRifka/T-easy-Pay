import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


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
    context.go('/startScreen'); // Navigate to StartScreen
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
              'assets/images/logoBg.png', // Replace with your app logo
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
