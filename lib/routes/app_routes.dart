import 'package:flutter/material.dart';
import 'package:teasypay_kd/views/offer_details_screen.dart';
import 'package:teasypay_kd/views/search_train_screen.dart';
import 'package:teasypay_kd/views/select_your_train_screen.dart';
import 'package:teasypay_kd/views/train_details_screen.dart';

class AppRoutes {
  static const String searchTrain = '/searchTrain';
  static const String selectTrain = "/selectTrain";
  static const String trainDetails = "/trainDetails";
  static const String offerDetails = "/offerDetails";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case searchTrain:
        return MaterialPageRoute(builder: (_) => SearchTrainScreen());
      case selectTrain:
        return MaterialPageRoute(builder: (_) => SelectTrainScreen());
      case trainDetails:
        return MaterialPageRoute(builder: (_) => TrainDetailsScreen());
      case offerDetails:
        return MaterialPageRoute(builder: (_) => OfferDetailsScreen());
      default:
        return MaterialPageRoute(builder: (_) => SearchTrainScreen());
    }
  }
}
