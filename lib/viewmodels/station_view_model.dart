import 'package:flutter/material.dart';
import '../repositories/station_repository.dart';

class StationViewModel extends ChangeNotifier {
  final StationRepository _repository = StationRepository();

  List<String> _stationNames = [];
  List<String> get stationNames => _stationNames;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadStationNames() async {
    _isLoading = true;
    notifyListeners();

    _stationNames = await _repository.fetchStationNames();

    _isLoading = false;
    notifyListeners();
  }
}
