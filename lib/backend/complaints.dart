//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nyumbayo_app/models/Complaints.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Complaints {

  void raiseComplaint(Complain comp) async {

    // adding different complaints
    
    final c = <String, dynamic>{
      "brokages": comp.brokages,
      "powerSurge": comp.powerSurge,
      "maintenance": comp.maintenance,
      "negotiationsForPower": comp.negotiationsForPower,
      "others": comp.others,
      "description": comp.description,
      "status": comp.status,
      "tenantName": comp.tenantName,
      "category": comp.category,
      "datetime" : comp.now,
    };

    //creating the payments collection in the firestore database

    db.collection("comp").add(c).then((DocumentReference doc) =>
        // ignore: avoid_print
        print('Successfully added new complaint ${doc.id}'));
  }
}
