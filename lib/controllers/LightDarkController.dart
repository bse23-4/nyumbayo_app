import "/exports/exports.dart";

class LightDarkController extends Cubit<bool> {
  LightDarkController() : super(false);
  void setSwitcher(bool b) => emit(b);
}
