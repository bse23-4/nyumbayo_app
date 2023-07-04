import '/exports/exports.dart';

class Properties {
 static Future<void> addProperty(var prop,String user_id) async {
    // adding new property
    var p = {
      "name": prop["name"],
      "address": prop["address"],
      "floors": prop["floors"],
      "rooms": prop["rooms"],
      "date": prop["date"],
      "landlord_id": user_id,
    };
    //creating the property collection in the firestore database
    await FirebaseFirestore.instance.collection("property").add(p);
  }
}
