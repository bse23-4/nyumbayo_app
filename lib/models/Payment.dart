// ignore_for_file: file_names
import 'dart:ffi';

class Payment {
  final now = DateTime.now().toLocal(); //declaring timestamp

  final Float rentBalance, //declaring other attributes of payments
      powerBill,
      percentageBalance,
      totalBalance,
      completedPayments;
  final String tenantName,landlordId;

  //calling other attributes that had no values, apart from timestamp
  Payment({
    required this.rentBalance,
    required this.powerBill,
    required this.percentageBalance,
    required this.completedPayments,
    required this.tenantName,
    required this.landlordId,
    required this.totalBalance,
  });
}
