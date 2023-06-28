class Payment {
     final String date;
     final String amount;
     final String tenantId;
     final String tenantName;
     final String property;
     final String balance;

  //calling other attributes that had no values, apart from timestamp
  Payment( {
    required this.date,
    required this.amount,
    required this.tenantName,
    required this.property,
    required this.balance,
   required this.tenantId,
  });
}
