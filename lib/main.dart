import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teasy/theme.dart';
import 'package:teasy/view/search_train_screen.dart';
import 'package:teasy/view/splash_screen.dart'; 
import 'package:provider/provider.dart';
import 'package:teasy/viewmodels/search_train_view_model.dart';
import 'package:teasy/viewmodels/station_view_model.dart';
import 'package:teasy/viewmodels/train_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensure Flutter is ready to run the app
  await Firebase.initializeApp();  // Initialize Firebase

  //runApp(const MyApp());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TrainViewModel()),
      ChangeNotifierProvider(create: (_) => TrainSearchViewModel()),
      ChangeNotifierProvider(create: (_) => StationViewModel()),
    ],
    child: const MyApp(),
  ));
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
      //home: SplashScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),

      '/searchTrain': (context) => SearchTrainScreen(),
      },

    );
  }
}
