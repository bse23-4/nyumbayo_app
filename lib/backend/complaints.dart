import 'dart:convert';
import 'package:http/http.dart' as http;

// Create a new complaint for the given charge ID and message
Future<Map<String, dynamic>> createComplaint(
    String chargeId, String message) async {
  const url = 'https://api.stripe.com/v1/sigma/scheduled_query_runs';
  final headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer YOUR_STRIPE_SECRET_KEY', //replace 'YOUR_STRIPE_SECRET_KEY' with your actual Stripe secret API key.
    // You can find your API keys in the Stripe Dashboard under Developers > API keys.
  };
  final body = {
    'query': 'CREATE COMPLAINT ON $chargeId REASON "$message"',
  };
  final response =
      await http.post(Uri.parse(url), headers: headers, body: body);
  final responseData = json.decode(response.body);
  return responseData;
}
