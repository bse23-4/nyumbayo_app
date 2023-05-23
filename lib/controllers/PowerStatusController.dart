import '/exports/exports.dart';
class PowerStatusController extends Cubit<bool>{
  PowerStatusController() : super(false);
  void setPowerStatus(String tenantId){
    FirebaseFirestore.instance.collection("tenants").doc(tenantId).get().then((value) {
      emit((value.data()?["power_status"] == "on"));
    });
  }
}