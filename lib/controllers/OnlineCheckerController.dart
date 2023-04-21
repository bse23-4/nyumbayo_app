import '/exports/exports.dart';

class OnlineCheckerController extends Cubit<bool> {
  //
  OnlineCheckerController() : super(online);
  static bool online = false;
  // method to check online status
  bool checkOnline() {
    InternetConnectionChecker.createInstance().hasConnection.then((value) {
      if (value == true) {
        updateChecker(value);
      } else {
        updateChecker(value);
      }
    });
    return OnlineCheckerController.online;
  }
  void updateChecker(bool online) => emit(online);
}
