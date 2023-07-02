// ignore_for_file: use_build_context_synchronously

import '/exports/exports.dart';
// import '/models/User.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
class Auth {
  static void signinUser(UserAuth user) async {
// Add a new document with a generated ID
    //final credential = await FirebaseAuth.instance
    //   .createUserWithEmailAndPassword(
    //  email: user.email, password: user.password);

    // adding different users
    final ur = <String, dynamic>{
      "name": user.name,
      "email": user.email,
      "contact": user.contact,
      "address": user.address,
      "roomNumber": user.roomNumber,
      "monthlyRent": user.monthlyRent,
      "powerStatus": user.isPowerOn(),
      "password": user.password,
    };
    //creating the user collection in the firestore database

    var doc = await _db.collection("users").add(ur);
    ('Successfully added user ${doc.id}');
    //return credential;
  }

  // landlord sign
  static Future<void> signinLandlord(
      String email, String password, BuildContext context) async {
    String msg = "";

    // Add a new document with a generated ID
   
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e, _) {
      if (e.code == 'wrong-passord') {
        msg = ("The password provided is incorrect");
      } else if (e.code == 'user-not-found') {
        msg = ("No user found for that email");
      } else if (e.code == 'invalid-email') {
        msg = ("Please enter a valid email");
      }
    }
    showMessage(context: context,msg: msg,type: 'warning');
  }

  // create landlord account
  static Future<void> createLandlord(
      Landlord user, BuildContext context) async {
    String msg = "";
  
    //creating the user collection in the firestore database
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        msg = ("The password provided is not strong enough");
      } else if (e.code == 'email-already-in-use') {
        msg = ('The account already exists for that email.');
      }
    }

    // adding different users
    final ur = <String, dynamic>{
      "name": user.name,
      "email": user.email,
      "contact": user.contact,
      "address": user.address,
      "profile": user.profile,
    };
    await FirebaseFirestore.instance.collection("landlords").doc(_auth.currentUser!.uid).set(ur);
    showMessage(context: context, msg: msg);
    // return await Database.insertOne("landlords",ur);
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }
}
