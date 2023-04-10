import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nyumbayo_app/models/Property.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Payments {
  void addProperty(Property prop) async {

    // adding new property
    
    final p = <String, dynamic>{
      "issue": prop.buildingName,
      "maintenance": prop.address,
      "negotiationsForPower": prop.numFloors,
      "others": prop.numRooms,
      "datetime": prop.now,
    };

    //creating the property collection in the firestore database

    db.collection("prop").add(p).then((DocumentReference doc) =>
        // ignore: avoid_print
        print('Successfully added new property ${doc.id}'));
  }
}
