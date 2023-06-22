import 'package:flutter/foundation.dart';

import '/exports/exports.dart';
import 'package:nyumbayo_app/models/Complaints.dart';


class Complaints {

 static Future<DocumentReference<Map<String, dynamic>>> raiseComplaint(var complaint) async {
FirebaseFirestore db = FirebaseFirestore.instance;

 DocumentReference<Map<String, dynamic>> ref ;
    // adding different complaints
    
    // final Map<String, dynamic> c = {
    //   "brokages": comp.brokages,
    //   "powerSurge": comp.powerSurge,
    //   "maintenance": comp.maintenance,
    //   "negotiationsForPower": comp.negotiationsForPower,
    //   "others": comp.others,
    //   "description": comp.description,
    //   "status": comp.status,
    //   "tenantName": comp.tenantName,
    //   "category": comp.category,
    //   "datetime" : comp.now,
    // };

    //creating the payments collection in the firestore database

 ref = await db.collection("complaints").add(complaint);
  return ref;
 }
}
