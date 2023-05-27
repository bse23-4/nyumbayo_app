// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import '/exports/exports.dart';

class Api {
  static String power_consumed_api =
      "https://api.thingspeak.com/channels/2164430/feeds/last.json?api_key=JTALSBOUTUJS9Z04";
  static String power_status_api =
      "https://api.thingspeak.com/channels/2164396/feeds/last.json?api_key=P7DE1Z4O2CTVID3V";
  static String power_status_api_write =
      "https://api.thingspeak.com/update?api_key=EIGVFVMPGBKK86VQ&field1=";

  static Future<String> getCurrentPowerStatus() async {
    var response = await Client().get(Uri.parse(power_status_api));
    Map<String, String> data = json.decode(response.body);
    return data['field1'] ?? "0";
  }

  // control tenant's power
  static Future<Response> controlPower(String powerStatus) async {
    var response = await Client().post(
      Uri.parse(power_status_api_write + powerStatus),
    );
    return response;
  }
}
