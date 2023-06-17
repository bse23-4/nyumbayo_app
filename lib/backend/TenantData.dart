import '/exports/exports.dart';

class TenantData {

 static Future<void> saveTenantDetails(Tenants prop,String property) async {
   // Create user with email and password on firebase
   var usr = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: prop.email,
      password: "test123",
    );

    final Map<String, dynamic> p = {
      "name": prop.name,
      "email": prop.email,
      "contact": prop.contact,
      "address": prop.address,
      "roomNumber": prop.roomNumber,
      "monthlyRent": prop.monthlyRent,
      "amountPaid": prop.amountPaid,
      "power_status": "on",
      "landlord_id":usr.user?.uid,
      "landlord_power_control": "off",
      "power_fee":"0",
      "balance":(int.parse(prop.monthlyRent) - int.parse(prop.amountPaid)).toString(),
      "property": property,
      "date": DateTime.now().toString(),
    };
    //creating the user collection in the firestore database¡
    // await Database.insertOne("tenants",p);
    await FirebaseFirestore.instance.collection("tenants").doc(usr.user?.uid).set(p);
  }
}
