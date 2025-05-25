import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart'; // Required for context
import 'package:teasypay_kd/views/offer_details_screen.dart';
import 'package:teasypay_kd/views/search_train_screen.dart';
import 'package:teasypay_kd/views/select_your_train_screen.dart';
import 'package:teasypay_kd/views/train_details_screen.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
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
