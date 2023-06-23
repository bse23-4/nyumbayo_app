// ignore_for_file: file_names

class UserAuth {
  final String name, email, contact, address, roomNumber, monthlyRent, password;
  //power status of the tenant
  isPowerOn(){
    return bool;}
  UserAuth(
      {required this.name,
      required this.email,
      required this.contact,
      required this.address,
      required this.roomNumber,
      required this.monthlyRent,
      required this.password,});
}

class Landlord{
  final String name, email, contact, address, password,profile;
  Landlord(
      {
        required this.profile,
        required this.name,
        required this.email,
        required this.contact,
        required this.address,
        required this.password,
      });
}