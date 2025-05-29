import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teasy/models/train_shedule_model.dart';

class Trainlistservice {
  //reference to the firestore collection
  final CollectionReference _trainCollection = FirebaseFirestore.instance
      .collection("Trains");

  //method to get all trains from the firestore collection
  Stream<List<Train>> getTrains() {
    return _trainCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //create thr train with the document data and id
        return Train.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
