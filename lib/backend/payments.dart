import 'dart:convert';
import 'package:http/http.dart' as http;

// Create a new payment intent with the given amount
Future<Map<String, dynamic>> createPaymentIntent(int amount, String customerId) async {
  const url = 'https://api.stripe.com/v1/payment_intents';
  final headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer YOUR_STRIPE_SECRET_KEY',//replace 'YOUR_STRIPE_SECRET_KEY' with your actual Stripe secret API key. 
  };
  final body = {
    'amount': amount.toString(),
    'currency': 'usd',
    'customer': customerId,
    'payment_method_types[]': 'card',
    'capture_method': 'automatic',
  };
  final response = await http.post(Uri.parse(url), headers: headers, body: body);
  final responseData = json.decode(response.body);
  return responseData;
}
