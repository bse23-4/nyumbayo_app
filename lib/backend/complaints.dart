
import '/exports/exports.dart';


class Complaints {

 static Future<void> raiseComplaint(var complaint) async {
FirebaseFirestore db = FirebaseFirestore.instance;
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

  await db.collection("complaints").add(complaint);
 }
}
