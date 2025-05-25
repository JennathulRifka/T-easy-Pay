import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:teasypay_kd/models/train_model.dart';

class TrainRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ✅ Fetch all trains using fromJson instead of fromFirestore
  Future<List<Train>> fetchTrains() async {
    try {
      final querySnapshot = await _firestore.collection('trains').get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Train.fromJson(data, doc.id);
      }).toList();
    } catch (e) {
      debugPrint('Error fetching trains: $e');
      rethrow;
    }
  }

  // ✅ Get a specific train by ID using fromJson
  Future<Train> getTrainById(String trainId) async {
    try {
      final docSnapshot =
          await _firestore.collection('trains').doc(trainId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        return Train.fromJson(data, docSnapshot.id);
      } else {
        throw Exception('Train not found for ID: $trainId');
      }
    } on FirebaseException catch (e) {
      debugPrint('Error fetching train by ID: $e');

      if (e.code == 'unavailable') {
        throw Exception(
            'Network error: The service is currently unavailable. Please check your internet connection.');
      } else if (e.code == 'not-found') {
        throw Exception('Train not found for ID: $trainId');
      } else {
        throw Exception('Error fetching train: ${e.message}');
      }
    } catch (e) {
      debugPrint('Error fetching train by ID: $e');
      rethrow;
    }
  }

  Future<List<Train>> searchTrains({
    required String fromStationCode,
    required String toStationCode,
  }) async {
    final trainsSnapshot = await _firestore.collection('trains').get();

    List<Train> results = [];

    for (var doc in trainsSnapshot.docs) {
      final data = doc.data();
      final List<String> route = List<String>.from(data['route'] ?? []);

      if (route.contains(fromStationCode) &&
          route.contains(toStationCode) &&
          route.indexOf(fromStationCode) < route.indexOf(toStationCode)) {
        results.add(Train.fromJson(data, doc.id));
      }
    }

    return results;
  }

  Future<Map<String, String>> getStationNameToCodeMap() async {
    final stationsSnapshot = await _firestore.collection('stations').get();
    return {
      for (var doc in stationsSnapshot.docs)
        doc['name']: doc['code'] // {"Colombo Fort": "CMB"}
    };
  }
}
