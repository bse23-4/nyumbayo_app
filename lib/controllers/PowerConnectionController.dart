import '/exports/exports.dart';

 class PowerConnectionController extends Cubit<bool> {
  PowerConnectionController() : super(powerState);
  static bool powerState = true;

  void setPowerState(String tenantId,bool v) {
      // SharedPreferences.getInstance().then((val) {
      //   val.setBool(tenantId, !v);
      // });
    emit(v);

    // });

  }

  // void getPowerState(String tenantId) {
  //   SharedPreferences.getInstance().then((value) {
  //     emit(value.getBool(tenantId) ?? true);
  //   });
  // }
}
