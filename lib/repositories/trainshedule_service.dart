import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trainapp2/models/trainListModel.dart';



class Trainlistservice {
  //reference to the firestore collection
  final CollectionReference _trainCollection = FirebaseFirestore.instance.collection("trains");

  //method to get all trains from the firestore collection
   Stream<List<Train>> getTrains(){
    return _trainCollection.snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        
          //create thr train with the document data and id
          return Train.fromJson(
            doc.data() as Map<String, dynamic>,
            doc.id
          );
      }).toList();
    });
   }
}

