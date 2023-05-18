import '/exports/exports.dart';

class TenantData {

 static Future<void> saveTenantDetails(Tenants prop) async {
    final Map<String, dynamic> p = {
      "name": prop.name,
      "email": prop.email,
      "contact": prop.contact,
      "address": prop.address,
      "roomNumber": prop.roomNumber,
      "monthlyRent": prop.monthlyRent
    };
    // FirebaseAuth.instance.sendPasswordResetEmail(email: email)
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: prop.email,
      password: "test123",
    );
    // 
    //creating the user collection in the firestore database
    await FirebaseFirestore.instance.collection("tenants").add(p);
  }
}
