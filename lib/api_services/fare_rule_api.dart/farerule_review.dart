import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';

Future<String> farerulrreviewAPI(String bookingid) async {
  printWhite("farerulrreviewAPI");
  print("booking ID: $bookingid");

  var url = Uri.parse('https://apitest.tripjack.com/fms/v1/farerule');
  print("url : $url");

  var requestBody = {
  "id":bookingid,
  "flowType":"REVIEW"
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
    log("farerulrreviewAPI ${response.statusCode},${response.body}");
    if (response.statusCode == 200) {
      try {
        String responseBody = response.body;
        printred("_________________farerule");
        log(responseBody);
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
