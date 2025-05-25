import 'package:cloud_firestore/cloud_firestore.dart';

class StationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> fetchStationNames() async {
    final snapshot = await _firestore.collection('stations').get();

    return snapshot.docs.map((doc) => doc.data()['name'] as String).toList();
  }

  // Optional: Fetch name + code if needed
  Future<List<Map<String, String>>> fetchStationsWithCodes() async {
    final snapshot = await _firestore.collection('stations').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'name': data['name'] as String,
        'code': data['code'] as String,
      };
    }).toList();
  }
}
