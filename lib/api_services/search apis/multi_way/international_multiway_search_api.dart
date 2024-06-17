import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> International_multiwaysearchapi(
     String cabin_class,
    String adult,
    String child,
    String infant,
    String from_code,
    String to_code,
    String date1,
    String from_code1,
    String to_code1,
    String date2
    ) async {
  print("Air search International multiway");

  print("cabincalss:$cabin_class");
  print("adult:$adult");
  print("child:$child");
  print("infant:$infant");
  print("from :$from_code");
  print("to:$to_code");
  print("date:$date1");
    print("2 from :$from_code1");
  print("2 to:$to_code1");
  print("date 2 :$date2");

  var url = Uri.parse('https://apitest.tripjack.com/fms/v1/air-search-all');
  print("url : $url");

  // Define your request body here
  var requestBody = {

  "searchQuery": {
    "cabinClass": cabin_class,
    "paxInfo": {
      "ADULT": adult!=null?adult:'1', 
      "CHILD": child!=null? child:"0",
      "INFANT": infant!=null? infant:"0"
    },
    "routeInfos": [
      {
        "fromCityOrAirport": {
          "code": from_code
        },
        "toCityOrAirport": {
          "code":  to_code,
        },
        "travelDate": date1
      },
      {
        "fromCityOrAirport": {
          "code": from_code1
        },
        "toCityOrAirport": {
          "code": to_code1
        },
        "travelDate":date2,
      },
      // {
      //   "fromCityOrAirport": {
      //     "code": "DEL"
      //   },
      //   "toCityOrAirport": {
      //     "code": "CCU"
      //   },
      //   "travelDate": "2024-12-19"
      // }
    ],
    "searchModifiers": {
      "isDirectFlight": true,
      "isConnectingFlight": false
    }
  }
  };

  // Encode the request body to JSON
  var requestBodyJson = jsonEncode(requestBody);

  try {
    // Make the POST request
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'apikey':
            '6122022b0e1517-2bf9-4ebe-92e7-3e2b550e5ba5',
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
  String errorMessage = 'Request failed with status: ${response.statusCode}.';
  if (response.body != null && response.body.isNotEmpty) {
    errorMessage += ' Response body: ${response.body}';
  }
  print(errorMessage);
  return 'failed';
} } catch (e) {
    print('Error: $e');
    return 'failed';
  }
}