import '/exports/exports.dart';

class TenantData {

 static Future<void> saveTenantDetails(Tenants prop,String property) async {
    final Map<String, dynamic> p = {
      "name": prop.name,
      "email": prop.email,
      "contact": prop.contact,
      "address": prop.address,
      "roomNumber": prop.roomNumber,
      "monthlyRent": prop.monthlyRent,
      "amountPaid": prop.amountPaid,
      "power_status": "on",
      "landlord_power_control": "off",
      "power_fee":"0",
      "balance":(int.parse(prop.monthlyRent) - int.parse(prop.amountPaid)).toString(),
      "property": property
    };
    // FirebaseAuth.instance.sendPasswordResetEmail(email: email)
   var usr = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: prop.email,
      password: "test123",
    );
    //creating the user collection in the firestore database
    await FirebaseFirestore.instance.collection("tenants").doc(usr.user?.uid).set(p);
  }
}
