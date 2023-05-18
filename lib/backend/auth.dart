import '/exports/exports.dart';
// import '/models/User.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;

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
    print('Successfully added user ${doc.id}');
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
  // landlord sign
  static Future<UserCredential> signinLandlord(String email,String password) async {
    // Add a new document with a generated ID
    final credential = FirebaseAuth.instance;
    return await credential.signInWithEmailAndPassword(email: email, password: password);
  }
  // create landlord account
  static Future<void> createLandlord(Landlord user) async {
    // Add a new document with a generated ID
    final credential = FirebaseAuth.instance;
              //  email: user.email, password: user.password);

    //creating the user collection in the firestore database
 var detail =  await credential.createUserWithEmailAndPassword(email: user.email, password: user.password);

    // adding different users
    final ur = <String, dynamic>{
      "name": user.name,
      "email": user.email,
      "contact": user.contact,
    };
   
      return await _db.collection("landlords").doc(detail.user!.uid).set(ur);
  }
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
