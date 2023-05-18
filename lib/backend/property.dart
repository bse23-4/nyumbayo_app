import '/exports/exports.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Properties {
 static Future<DocumentReference<Map<String, dynamic>>> addProperty(var prop) async {
    // adding new property
    final Map<String, dynamic> p = {
      "issue": prop["buildingName"],
      "maintenance": prop["address"],
      "floors": prop["numFloors"],
      "rooms": prop["numRooms"],
      "datetime": prop["now"],
    };
    //creating the property collection in the firestore database
    return await db.collection("properties").add(p);
  }
}
