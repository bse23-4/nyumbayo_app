import '/exports/exports.dart';

class OnlineController extends Cubit<bool>{
  OnlineController() : super(false);
  // check connectivity
  void checkConnection(){
    InternetConnectionChecker.createInstance().hasConnection.then((value) {
      emit(value);
    });
  }
}