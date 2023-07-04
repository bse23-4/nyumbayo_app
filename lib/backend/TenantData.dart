import '/exports/exports.dart';

class TenantData {

 static Future<String> saveTenantDetails(Tenants prop,String property,String landlordId) async {
String errorCode = "";
     Map<String, dynamic> p = {};
  try{
   // Create user with email and password on firebase
   var usr = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: prop.email,
      password: "test123",
    );
 p = {
      "name": prop.name,
      "email": prop.email,
      "contact": prop.contact,
      "acontact": prop.acontact,
      "address": prop.address,
      "roomNumber": prop.roomNumber,
      "monthlyRent": prop.monthlyRent,
      "amountPaid": prop.amountPaid,
      "power_status": "off",
      "landlord_id":landlordId,
      "landlord_power_control": "off",
      "power_fee":"0",
      "balance":(int.parse(prop.monthlyRent) - int.parse(prop.amountPaid)).toString(),
      "property": property,
      "date": DateTime.now().toString(),
    };
    await FirebaseFirestore.instance.collection("tenants").doc(usr.user!.uid).set(p);

  } on FirebaseAuthException catch (e,_) {
    errorCode = e.code;
  }
  return errorCode;
  }
}
