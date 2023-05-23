// ignore_for_file: avoid_print
import '/exports/exports.dart';
import 'package:nyumbayo_app/models/Power.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Powers {
  static void payElectricity(Power pow) async {

//converting power units to money used
    final double powerBill = Power.powerRate * pow.consumedUnits;

//adding different power bills

    final p = <String, dynamic>{
      "powerStatus": pow.powerStatus,
      "powerBill": powerBill,
      "tenantName": pow.tenantName,
      "consumedUnits": pow.consumedUnits,
      "datetime": pow.now,
    };

    //creating the powerbills collection in the firestore database

    db.collection("pow").add(p).then((DocumentReference doc) =>
        print('Successfully added new property ${doc.id}'));
  }
}
