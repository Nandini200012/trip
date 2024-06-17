import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> flightCancellation_api(
  String booking_id,String remarks
) async {
  print("flightCancellation_api");
  print("booking :$booking_id,");

  var url = Uri.parse(
      ' https://apitest.tripjack.com/oms/v1/air/amendment/submit-amendment');
  print("url : $url");

  // Define your request body here
  var requestBody = {
    "bookingId": booking_id,
    "type": "CANCELLATION",
    "remarks": remarks
  };

  // Encode the request body to JSON
  var requestBodyJson = jsonEncode(requestBody);

  try {
    // Make the POST request
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'apikey': '6122022b0e1517-2bf9-4ebe-92e7-3e2b550e5ba5',
      },
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      try {
        String responseBody = response.body;
        print('responseBody');
        print(responseBody);
        var decodedData = jsonDecode(responseBody);
        return responseBody;
      } catch (e) {
        print('Error decoding JSON: $e');
        return 'failed';
      }
    } else {
       print('responseBody');
        print(response.body);
      String errorMessage =
          'Request failed with status: ${response.statusCode}.';
      if (response.body != null && response.body.isNotEmpty) {
        errorMessage += ' Response body: ${response.body}';
      }
      print(errorMessage);
      return 'failed';
    }
  } catch (e) {
    print('Error: $e');
    return 'failed';
  }
}
