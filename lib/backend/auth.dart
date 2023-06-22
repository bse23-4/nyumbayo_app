import '../exports/exports.dart';

FirebaseFirestore _db = FirebaseFirestore.instance;

class Auth {
  // landlord sign
  static Future<UserCredential> signInTenant(
      String email, String password) async {
    // Add a new document with a generated ID
    final credential = FirebaseAuth.instance;
    return await credential.signInWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<AuthStatus?> login(
    String email,
    String password,
  ) async {
    AuthStatus? status;
    final auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
    }
    return status;
  }

  static Future<void> signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    await FirebaseAuth.instance.signOut();
  }

  static Future<AuthStatus?> resetPassword({required String email}) async {
    AuthStatus? status;

    final auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      status = AuthExceptionHandler.handleAuthException(e);
    }

    return status;
  }
}

// exception handler

enum AuthStatus {
  wrongPassword,
  emailAlreadyExists,
  emailDoesnotExist,
  invalidEmail,
  weakPassword,
  unknown
}

class AuthExceptionHandler {
  static AuthStatus handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-doesnot-exist":
        status = AuthStatus.emailDoesnotExist;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static void generateErrorMessage(AuthStatus error, BuildContext context) {
    String? errorMessage;
    switch (error) {
      case AuthStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthStatus.weakPassword:
        errorMessage = "Your password should be at least 6 characters.";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Your email or password is wrong.";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage =
            "The email address is already in use by another account.";
        break;
      case AuthStatus.emailDoesnotExist:
        errorMessage = "The email address doesn't exist.";
        break;
      case AuthStatus.unknown:
        errorMessage = null;
        break;
    }
    if (errorMessage != null) {
      showMessage(context: context, msg: errorMessage, type: 'danger');
    }
  }
}
