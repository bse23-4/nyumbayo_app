import '../exports/exports.dart';

class MainController extends ChangeNotifier{
  bool _power = false;

  // getters
  bool get power => _power;
  // setter
  void setPower(String id){
   FirebaseFirestore.instance.collection("tenants").doc(id).get().then((value) {
     _power = (value.data()?["power_status"] == "on");
     notifyListeners();
    });
  }
}