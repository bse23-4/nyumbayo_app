import '/exports/exports.dart';

class Properties {
 static Future<void> addProperty(var prop,String user_id) async {
    // adding new property
    /**
     *   "name": formControllers[0].text,
                        "address": formControllers[1].text,
                        "floors": formControllers[2].text,
                        "rooms": formControllers[3].text,
                        "date": DateTime.now().toString(),
     */
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
