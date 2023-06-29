import '/exports/exports.dart';
import 'package:nyumbayo_app/models/Payment.dart';


class Payments {
  static Future<DocumentReference<Map<String, dynamic>>> makePayments(Payment pay) async {
FirebaseFirestore db = FirebaseFirestore.instance;

    // adding different payments

    final Map<String, dynamic> p ={
      "balance": pay.balance,
      "tenant_id": pay.tenantId,
      "amountPaid": pay.amount,
      "property": pay.property,
      "tenant_name": pay.tenantName,
    
      "date": pay.date,
    };

    //creating the payments collection in the firestore database
    
    return await db.collection("payments").add(p);
  }
}
