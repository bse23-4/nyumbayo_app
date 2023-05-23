import 'package:nyumbayo_app/exports/exports.dart';

class UserdataController extends Cubit<String> {
  UserdataController() : super("");
// capture user data
  void captureData(){
  SharedPreferences.getInstance().then((value) {
    value.setString("tenantId",FirebaseAuth.instance.currentUser?.uid ?? "");
    emit(FirebaseAuth.instance.currentUser?.uid ?? "");
  });
  }
  getUserData(){
    SharedPreferences.getInstance().then((userData) {
      emit(userData.getString("tenantId")?? "");
    });
  }
}