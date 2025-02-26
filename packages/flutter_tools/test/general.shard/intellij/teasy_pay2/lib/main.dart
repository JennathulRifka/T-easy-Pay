import 'package:flutter/material.dart';
import 'pages/settings.dart';
import 'pages/menuPage.dart';
import 'pages/homePage.dart';
import 'pages/profile.dart';
import 'pages/notifications.dart';
import 'pages/newsFeed.dart';
import 'pages/trainSchedule.dart';
import 'pages/myTrips.dart';
import 'pages/myTickets.dart';
import 'pages/voicePage.dart';
import 'pages/bookingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/notifications': (context) => NotificationsPage(),
        '/newsFeed': (context) => NewsFeedPage(),
        '/trainSchedule': (context) => TrainSchedulePage(),
        '/myTrips': (context) => MyTripsPage(),
        '/myTickets': (context) => MyTicketsPage(),
        '/voice': (context) => VoicePage(),
        '/booking': (context) => BookingPage(),
        '/menu': (context) => MenuPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
