import '/exports/exports.dart';
import 'package:nyumbayo_app/models/Complaints.dart';


class Complaints {

 static void raiseComplaint(Complain comp) async {
FirebaseFirestore db = FirebaseFirestore.instance;


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
