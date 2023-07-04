import 'dart:convert';

import '../exports/exports.dart';

class PowerBillController extends Cubit<double>{
  PowerBillController() : super(0.0);

 void setSavePowerBill(double bill){
    double total = 0;
    SharedPreferences.getInstance().then((value) {
      if(bill < 0){
          value.setDouble("savePowerBill", (total += 0));
      } else {
          value.setDouble("savePowerBill", (total += bill));
      }
    });
  }
  // method to fetch save bill
  void getSavePowerBill(){
    SharedPreferences.getInstance().then((value) {
      emit(value.getDouble("savePowerBill") ?? 0.0);
    });
  }
}