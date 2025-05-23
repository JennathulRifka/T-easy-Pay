import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teasy/theme.dart';
import 'package:teasy/view/splash_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensure Flutter is ready to run the app
  await Firebase.initializeApp();  // Initialize Firebase

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system, // Supports system dark mode
      home: SplashScreen(),
    );
  }
}
