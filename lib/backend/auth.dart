//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import '/models/User.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Auth {
  void signinUser(UserAuth user) async {
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

    db.collection("users").add(ur).then(
        // ignore: avoid_print
        (DocumentReference doc) => print('Successfully added user ${doc.id}'));
    //return credential;

    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     print('The password provided is too weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     print('The account already exists for that email.');
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }
}
