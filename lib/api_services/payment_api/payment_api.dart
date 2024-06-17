import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> paymentAPI() async {
  try {
    final Map<String, dynamic> requestBody = {
      'order_id': '4',
      'customer_id': '10',
      'user_type': 'Tester',
      'amount': '100',
      'currency': 'abcd@gmail.com', // This should be the currency code, not an email
      'billing_name': 'Nandini',
      'billing_address': 'chittur palakkad',
      'billing_city': 'kerala',
      'billing_state': 'kerala',
      'billing_zip': '678101',
      'billing_country': 'india',
      'billing_tel': '9526751850',
      'billing_email': 'abcd@gmail.com',
    };

    var url = Uri.parse(
        'https://gotodestination.in/api/payment_api/payment/payment_api/NON_SEAMLESS_KIT/ccavRequestHandler.php');

    http.Response response = await http.post(
      url,
      body: jsonEncode(requestBody), // Sending request body as JSON
      headers: {'Content-Type': 'application/json'}, // Adding content type header
    );

    print('Response: ${response.statusCode}');

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return data;
    } else {
      return 'failed';
    }
  } catch (e) {
    print('Error: $e');
    return 'failed';
  }
}



