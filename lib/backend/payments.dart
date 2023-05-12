//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nyumbayo_app/models/Payment.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Payments {
  void makePayments(Payment pay) async {

    // adding different payments

    final p = <String, dynamic>{
      "issue": pay.rentBalance,
      "maintenance": pay.powerBill,
      "negotiationsForPower": pay.percentageBalance,
      "others": pay.completedPayments,
      "status": pay.landlordId,
      "tenantName": pay.tenantName,
      "category": pay.totalBalance,
      "datetime": pay.now,
    };

    //creating the payments collection in the firestore database
    
    db.collection("pay").add(p).then((DocumentReference doc) =>
        // ignore: avoid_print
        print('Successfully added new payment ${doc.id}'));
  }
}
