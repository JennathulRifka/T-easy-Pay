import 'package:flutter/material.dart';
import 'package:teasy/models/train_model.dart';
import 'package:collection/collection.dart';
import 'package:teasy/repositories/train_repository.dart'; // For firstWhereOrNull

class TrainViewModel extends ChangeNotifier {
  final TrainRepository _repository = TrainRepository();

  List<Train> _allTrains = []; // All trains from DB
  List<Train> _filteredTrains = []; // Trains after filtering
  bool _isLoading = false;
  String? _selectedTrainId;

  // Getters
  List<Train> get trains => _filteredTrains; // only return filtered trains
  bool get isLoading => _isLoading;
  String? get selectedTrainId => _selectedTrainId;
  Train? get selectedTrain =>
      _allTrains.firstWhereOrNull((train) => train.trainId == _selectedTrainId);

  /// Load trains from Firebase Firestore and apply optional filters
  Future<void> loadTrains({
    required String departure,
    required String arrival,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Get name-to-code map
      final stationMap = await _repository.getStationNameToCodeMap();
      final fromCode = stationMap[departure];
      final toCode = stationMap[arrival];

      if (fromCode == null || toCode == null) {
        _filteredTrains = [];
        notifyListeners();
        return;
      }

      // Use repository to search
      final trains = await _repository.searchTrains(
        fromStationCode: fromCode,
        toStationCode: toCode,
      );

      _filteredTrains = trains;
      _allTrains = trains; // Optional caching
    } catch (e) {
      print('Error loading filtered trains: $e');
      _filteredTrains = [];
      _allTrains = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Filter trains by departure and arrival (optional manual call)
  void filterTrains(String departure, String arrival) {
    _filteredTrains = _allTrains
        .where((train) =>
            train.departureStation.toLowerCase().trim() ==
                departure.toLowerCase().trim() &&
            train.arrivalStation.toLowerCase().trim() ==
                arrival.toLowerCase().trim())
        .toList();

    notifyListeners();
  }

  // Select a train by its ID
  void selectTrain(String trainId) {
    _selectedTrainId = trainId;
    notifyListeners();
  }

  // Clear selected train
  void clearSelection() {
    _selectedTrainId = null;
    notifyListeners();
  }

  // Reset filter to show all trains
  void resetFilter() {
    _filteredTrains = _allTrains;
    notifyListeners();
  }
}
