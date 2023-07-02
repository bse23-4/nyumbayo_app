
import '/exports/exports.dart';


class Complaints {

 static Future<void> raiseComplaint(var complaint) async {
FirebaseFirestore db = FirebaseFirestore.instance;

  await db.collection("complaints").add(complaint);
 }
}
