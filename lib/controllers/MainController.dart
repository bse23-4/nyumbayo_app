import 'package:nyumbayo_app/APIS/Api.dart';

import '../exports/exports.dart';

class MainController extends ChangeNotifier { 
  bool _power = false;
  final List<Map<String, dynamic>> _complaints = [];

  String _property = "";
  bool _online = false;
  // getters
  bool get power => _power;
  // power consumed
  double _powerConsumed = 0;
  double get powerConsumed => _powerConsumed;
  String get property => _property;
  List<Map<String, dynamic>> get complaints => _complaints;
  bool get online => _online;
  // setter
  void setPower(String id) {
    FirebaseFirestore.instance
        .collection("tenants")
        .doc(id)
        .get()
        .then((value) {
      //  _power = (value.data()?["power_status"] == "on" || value.data()?["landlord_power_control"] == "on");
      if (value.data()?["power_status"] == "on" ||
          value.data()?["landlord_power_control"] == "on") {
        _power = true;
      } else if (value.data()?["power_status"] == "off" &&
          value.data()?['landlord_power_control'] == 'on') {
        _power = true;
      } else if (value.data()?["power_status"] == "on" &&
          value.data()?['landlord_power_control'] == 'off') {
        _power = true;
      } else {
        _power = false;
      }
      notifyListeners();
    });
  }

  controlPower(String id, int percentage, {int x = 0}) {
    if (x == 1) {
      // function to trigger power off or on for the tenant
      Api.controlPower("1");
      FirebaseFirestore.instance.collection("tenants").doc(id).update({
        "power_status": percentage < 80 ? "off" : "on",
      }).then((value) {});
    } else {
      Api.controlPower("0");
      FirebaseFirestore.instance.collection("tenants").doc(id).update({
        "power_status": percentage < 80 ? "off" : "on",
      }).then((value) {});
    }
  }

  // complaints
  void fetchPowerConsumed() {
    Api.getPowerConsumed().then((value) {
      _powerConsumed =
          double.parse(value.isEmpty || value == "?" ? "0" : value);
      notifyListeners();
    });
  }

  // function to computed tenant electricity bill based on the units consumed
  double computeBill(double units) {
    return (units * 500);
  }
// property name
void propertyName(String name) {
  
  FirebaseFirestore.instance
      .collection('properties')
      .doc(name)
      .get()
      .then((value) {
    _property = value.data()?['name'] ?? "";
    notifyListeners();
  });

}


  checkOnline() {
    InternetConnectionChecker.createInstance()
        .hasConnection
        .asStream()
        .listen((event) {
      _online = event;
      notifyListeners();
    });
  }
}
