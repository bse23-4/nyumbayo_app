class Payment {
  final String date;
  final String amount;
  final String tenantName;
  final String property;
  final String balance;
  final String status;
  final String electricityBill;
  final String paymentMode;

  //calling other attributes that had no values, apart from timestamp
  Payment({
    required this.status,
    required this.paymentMode,
    required this.date,
    required this.amount,
    required this.tenantName,
    required this.property,
    required this.balance,
    required this.electricityBill,
  });
}
