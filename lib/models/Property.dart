// ignore_for_file: file_names

class Property {
  final String now; //declaring timestamp
//declaring other attributes of property
  final String buildingName, address;
  final String numFloors, numRooms;

  //calling other attributes that had no values, apart from timestamp
  Property({
    required this.buildingName,
    required this.address,
    required this.numFloors,
    required this.numRooms,
    this.now = "",
  });
}
