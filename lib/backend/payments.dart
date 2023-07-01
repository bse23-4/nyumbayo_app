import '/exports/exports.dart';
import 'package:nyumbayo_app/models/Payment.dart';


class Payments {
  static Future<void> makePayments(String tenantId,Payment pay) async {
FirebaseFirestore db = FirebaseFirestore.instance;

    // adding different payments

     var p ={
      "balance": pay.balance,
      "amountPaid": pay.amount,
      "property": pay.property,
      "tenantName": pay.tenantName,
      "paymentMode": pay.paymentMode,
      "paymentStatus": pay.status,
      "date": pay.date,
    };
    //creating the payments collection in the firestore database
   
     await db.collection("payments").doc(tenantId).set(p);
     debugPrint("Payment record saved successfully..");
  }
}
