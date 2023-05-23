// ignore_for_file: file_names

//import 'dart:ffi';

class Power {
  final now = DateTime.now().toLocal(); //declaring timestamp
//declaring other attributes of power
  final String powerStatus, tenantName;
  final double consumedUnits;
  static const double powerRate = 500;
  //final Float powerBill;  //= final Float powerRate * consumedUnits (Float);

  //calling other attributes that had no values, apart from timestamp
  Power({
    required this.powerStatus,
    required this.tenantName,
    //required this.powerBill,
    required this.consumedUnits,
  });
}
