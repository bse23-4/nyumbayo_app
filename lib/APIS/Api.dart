// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import '/exports/exports.dart';

class Api {
  static String power_consumed_api =
      "https://api.thingspeak.com/channels/2164430/feeds/last.json?api_key=JTALSBOUTUJS9Z04";
  static String power_status_api =
      "https://api.thingspeak.com/channels/2164396/feeds/last.json?api_key=P7DE1Z4O2CTVID3V";
  static String power_status_api_write =
      "https://api.thingspeak.com/update?api_key=EIGVFVMPGBKK86VQ&field1=";
      // https://api.thingspeak.com/update?api_key=EIGVFVMPGBKK86VQ&field1=0

  static Future<String> getCurrentPowerStatus() async {
    String msgCoded = "";
    try {
      var response = await Client().get(Uri.parse(power_status_api));
      Map<String, String> data = json.decode(response.body);
      msgCoded = data['field1'] ?? "0";
    } on ClientException catch (e, _) {
      debugPrint(e.message);
    }
    return msgCoded;
  }

  // control tenant's power
  static Future<Response> controlPower(String powerStatus) async {
    Response response = Response("", 200);
    try {
      response = await Client().post(
        Uri.parse(power_status_api_write + powerStatus),
      );
    } on ClientException catch (e, _) {
      // debugPrint(e.message);
    } on HandshakeException catch(e,_){
      debugPrint(e.message);
    }

    return response;
  }

  // units consumed
  static Future<String> getPowerConsumed() async {
    String msg = "";
    try {
      var response = await Client().get(Uri.parse(power_consumed_api));
      var result = json.decode(response.body);
      msg = result["field1"];
    } on Exception catch (e, _) {
    //  
    }
    return msg;
  }
}
