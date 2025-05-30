import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart'; // Required for context
import 'package:teasy/screensss/SeatSelectionScreen.dart';
import 'package:teasy/view/admin/admin_home.dart';
import 'package:teasy/view/admin/news_management.dart';
import 'package:teasy/view/homePage.dart';
import 'package:teasy/view/login_screen.dart';
import 'package:teasy/view/menu/acc_information.dart';
import 'package:teasy/view/menu/acc_security.dart';
import 'package:teasy/view/menu/feedback.dart';
import 'package:teasy/view/menu/help.dart';
import 'package:teasy/view/menu/policies.dart';
import 'package:teasy/view/menu/settings.dart';
import 'package:teasy/view/menu_page.dart';
import 'package:teasy/view/newsFeed.dart';
import 'package:teasy/view/offer_details_screen.dart';
import 'package:teasy/view/profile_page.dart';
import 'package:teasy/view/register_screen.dart';
import 'package:teasy/view/search_train_screen.dart';
import 'package:teasy/view/select_your_train_screen.dart';
import 'package:teasy/view/splash_screen.dart';
import 'package:teasy/view/start_screen.dart';
import 'package:teasy/view/trainTracker.dart';
import 'package:teasy/view/train_Shedule.dart';
import 'package:teasy/view/train_details_screen.dart';
import 'package:teasy/view/trainhistory.dart';

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
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      //GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/homePage', builder: (context, state) => HomePage()),

      // GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
      // GoRoute(path: '/notifications', builder: (context, state) => NotificationsPage()),

      // Profile by - akalanaka
      GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
      GoRoute(path: '/newsFeed', builder: (context, state) => NewsFeedPage()),
      GoRoute(
        path: '/trainSchedule',
        builder: (context, state) => TrainSearchScreen(),
      ),
      GoRoute(
        path: '/trainTracker',
        builder: (context, state) => TrainTrackingScreen(),
      ),
      GoRoute(
        path: '/trainHistory',
        builder: (context, state) => TripHistoryScreen(),
      ),
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
      GoRoute(
        path: '/seatSelection',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          if (data == null) {
            return const Scaffold(
              body: Center(child: Text("No seat selection data provided")),
            );
          }
          return SeatSelectionScreen(
            bookingId: data['bookingId'] ?? '',
            passengerName: data['passengerName'] ?? '',
            trainNo: data['trainNo'] ?? '',
            startStation: data['startStation'] ?? '',
            endStation: data['endStation'] ?? '',
            date: data['date'] ?? '',
            departureTime: data['departureTime'] ?? '',
            arrivalTime: data['arrivalTime'] ?? '',
          );
        },
      ),
      //Akalanka's routes
      GoRoute(path: '/menu', builder: (context, state) => MenuPage()),
      GoRoute(
        path: '/account-info',
        builder: (context, state) => AccountInformationPage(),
      ),
      GoRoute(
        path: '/account-sec',
        builder: (context, state) => AccountSecurityPage(),
      ),
      GoRoute(path: '/feedBack', builder: (context, state) => FeedbackPage()),
      GoRoute(path: '/help', builder: (context, state) => HelpPage()),
      GoRoute(path: '/policy', builder: (context, state) => PoliciesPage()),
      GoRoute(path: '/settings', builder: (context, state) => SettingsPage()),
    ],
  );
}
