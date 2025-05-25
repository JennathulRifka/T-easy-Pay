import 'package:flutter/material.dart';

class TrainSearchViewModel extends ChangeNotifier {
  String _fromStation = '';
  String _toStation = '';
  DateTime? _departureDate;

  String get fromStation => _fromStation;
  String get toStation => _toStation;
  DateTime? get departureDate => _departureDate;

  void setFromStation(String value) {
    _fromStation = value;
    notifyListeners();
  }

  void setToStation(String value) {
    _toStation = value;
    notifyListeners();
  }

  void setDepartureDate(DateTime date) {
    _departureDate = date;
    notifyListeners();
  }

  void clear() {
    _fromStation = '';
    _toStation = '';
    _departureDate = null;
    notifyListeners();
  }
}
