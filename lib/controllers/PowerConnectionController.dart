import '/exports/exports.dart';

class PowerConnectionController extends Cubit<bool> {
  PowerConnectionController() : super(powerState);
  static bool powerState = true;
  void setPowerState(String tenantId, bool val) {
    SharedPreferences.getInstance().then((value) {
      value.setBool(tenantId, val);
    });
    
    emit(val);
  }

  getPowerState(String tenant_id) {
    SharedPreferences.getInstance().then((value) {
      emit(value.getBool(tenant_id) ?? true);
    });
  }
}
