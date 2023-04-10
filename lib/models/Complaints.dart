// ignore_for_file: file_names

class Complain {
  final now = DateTime.now().toLocal(); //declaring timestamp

  final String powerSurge, //declaring other attributes of complaint
      brokages,
      maintenance,
      negotiationsForPower,
      others,
      description,
      category,
      status,
      tenantName;

  //calling other attributes that had no values, apart from timestamp
  Complain({
    required this.powerSurge,
    required this.brokages,
    required this.maintenance,
    required this.negotiationsForPower,
    required this.others,
    required this.description,
    required this.category,
    required this.status,
    required this.tenantName,
  });
}
