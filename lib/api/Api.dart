import 'package:nyumbayo_app/exports/exports.dart';

class Api {
  static String powerApi = "https://api.thingspeak.com/update.json?api_key=EIGVFVMPGBKK86VQ&field1=";
  // function to trigger the power
  static Future<Response> triggerPower(String field2)  async{
   var response = await Client().post(Uri.parse(powerApi + field2));
   return response;
  }
}