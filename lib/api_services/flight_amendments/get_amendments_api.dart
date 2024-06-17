import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';
import 'package:trip/login_variables/login_Variables.dart';

import '../flight_databse_apis/flight_details_api.dart';

Future<String> cancellationAmendmentApi(String bookingid,String src,String dest) async {
  printWhite("cancellationAmendmentApi");
  print("booking ID: $bookingid");

  var url = Uri.parse(
      'https://apitest.tripjack.com/oms/v1/air/amendment/amendment-charges');
  print("url : $url");

  var requestBody = {
    "bookingId": bookingid,
    "type": "CANCELLATION",
    "trips": [
      {
        "src": src,
        "dest": dest,
        "departureDate": "2024-06-11",
        "travellers": [
          {"fn": "TESTA", "ln": "TESTA"},
         
        ]
      }
    ]
  };

  var requestBodyJson = jsonEncode(requestBody);

  try {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'apikey': '6122022b0e1517-2bf9-4ebe-92e7-3e2b550e5ba5',
      },
      body: requestBodyJson,
    );
    log("cancellationAmendmentApi ${response.statusCode},body: ${response.body},bookingid:$bookingid");
    if (response.statusCode == 200) {
      try {
        String responseBody = response.body;
        log("cancellationAmendmentApi");
        log("cancellationAmendmentApi $responseBody");

        var decodedData = jsonDecode(responseBody);
        return responseBody;
      } catch (e) {
        print('Error decoding JSON: $e');
        return 'failed';
      }
    } else {
      String errorMessage =
          'Request failed with status: ${response.statusCode}.';
      if (response.body != null && response.body.isNotEmpty) {
        errorMessage += ' Response body: ${response.body}';
      }
      log(errorMessage);
      return 'failed';
    }
  } catch (e) {
    log('Error: $e');
    return 'failed';
  }
}
