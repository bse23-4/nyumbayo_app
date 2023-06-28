import '/exports/exports.dart';
import 'package:nyumbayo_app/models/Payment.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Payments {
  static void makePayments(Payment pay) async {

    // adding different payments

    final p = <String, dynamic>{
      "balance": pay.balance,
      "tenant_id": pay.tenantId,
      "amountPaid": pay.amount,
      "property": pay.property,
      "date": pay.date,
    };

    //creating the payments collection in the firestore database
    
    await db.collection("payment").add(p);
  }
}
