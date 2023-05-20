import '../exports/exports.dart';

class PowerConnectionController extends Cubit<bool>{
  PowerConnectionController():super(powerState);
  static bool powerState = true;
void setPowerState(bool value) => emit(value);
}