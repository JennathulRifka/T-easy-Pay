import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart'; // Required for context
import 'package:teasy/view/admin/admin_home.dart';
import 'package:teasy/view/admin/news_management.dart';
import 'package:teasy/view/homePage.dart';
import 'package:teasy/view/offer_details_screen.dart';
import 'package:teasy/view/register_screen.dart';
import 'package:teasy/view/search_train_screen.dart';
import 'package:teasy/view/select_your_train_screen.dart';
import 'package:teasy/view/splash_screen.dart';
import 'package:teasy/view/start_screen.dart';
import 'package:teasy/view/train_Shedule.dart';
import 'package:teasy/view/train_details_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashScreen()),
      GoRoute(
        path: '/registerScreen',
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(path: '/startScreen', builder: (context, state) => StartScreen()),
      //GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/homePage', builder: (context, state) => HomePage()),
      // GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
      // GoRoute(path: '/notifications', builder: (context, state) => NotificationsPage()),
      // GoRoute(path: '/newsFeed', builder: (context, state) => NewsFeedPage()),
       GoRoute(path: '/trainSchedule', builder: (context, state) => TrainSearchScreen()),
      // GoRoute(path: '/myTrips', builder: (context, state) => MyTripsPage()),
      // GoRoute(path: '/myTickets', builder: (context, state) => MyTicketsPage()),
      // GoRoute(path: '/voice', builder: (context, state) => VoicePage()),
      // GoRoute(path: '/booking', builder: (context, state) => BookingPage()),
      // GoRoute(path: '/menu', builder: (context, state) => MenuPage()),
      // GoRoute(path: '/settings', builder: (context, state) => SettingsPage()),
      // GoRoute(path: '/adminLogin', builder: (context, state) => AdminLoginScreen()),
       GoRoute(path: '/adminHome', builder: (context, state) => AdminHome()),
       GoRoute(path: '/newsManage', builder: (context, state) => newsManage()),
      GoRoute(
        path: '/searchTrain',
        builder: (context, state) => const SearchTrainScreen(),
      ),
      GoRoute(
        path: '/selectTrain',
        builder: (context, state) {
          final searchData = state.extra as Map<String, dynamic>?;
          if (searchData == null) {
            return const Scaffold(
              body: Center(child: Text("No search data provided")),
            );
          }
          return SelectTrainScreen(searchData: searchData);
        },
      ),
      GoRoute(
        path: '/trainDetails/:trainId',
        builder: (context, state) {
          final trainId = state.pathParameters['trainId']!;
          return TrainDetailsScreen(trainId: trainId);
        },
      ),
      GoRoute(
        path: '/offerDetails',
        builder: (context, state) => const OfferDetailsScreen(),
      ),
    ],
  );
}
