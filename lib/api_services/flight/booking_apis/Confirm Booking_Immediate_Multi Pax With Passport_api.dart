import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../common/print_funtions.dart';

Future<String> Confirm_Booking_Passport_api(
    {String booking_id,
    String fare,
    String gstNumber,
    String gstEmail,
    String gstMobile,
    String gstAddress,
    String gstName,
    String deliveryEmail,
    String deliveryContact,
    List<Map<String, String>> travelerDetails,
    bool igm,
    bool gstappl}) async {
  print("Confirm Booking - Immediate Ticket - Multi Pax With Passport");
  print("booking :$booking_id,fare:$fare");

  var url = Uri.parse('https://apitest.tripjack.com/oms/v1/air/book');
  // 'https://apitest.tripjack.com/oms/v1/air/book');
  print("url : $url");
  var requestBody;
  // Define your request body here
  // if (gstappl || igm) {
  //   print("request with gst ");
  //   requestBody = {
  //     "bookingId": booking_id,
  //     "paymentInfos": [
  //       {"amount": fare}
  //     ],
  //     "travellerInfo": travelerDetails,
  //     "gstInfo": {
  //       "gstNumber": gstNumber,
  //       "email": gstEmail,
  //       "registeredName": gstName,
  //       "mobile": gstMobile,
  //       "address": gstAddress,
  //     },
  //     "deliveryInfo": {
  //       "emails": [deliveryEmail],
  //       "contacts": [deliveryContact],
  //     }
  //   };
  // } else {
    print("request without gst ");
    requestBody = {
      "bookingId": booking_id,
      "paymentInfos": [
        {"amount": fare}
      ],
      "travellerInfo": travelerDetails,
      "deliveryInfo": {
        "emails": [deliveryEmail],
        "contacts": [deliveryContact],
      }
    };
  // }
  print("requestbody: $requestBody");
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
    printWhite("response: $requestBody");
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








// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:trip/common/print_funtions.dart';

// Future<String> Confirm_Booking_Passport_api({
//   String booking_id,
//   String fare,
//   String gstNumber,
//   String gstEmail,
//   String gstMobile,
//   String gstAddress,
//   String gstName,
//   String deliveryEmail,
//   String deliveryContact,
//   List<Map<String,String>> travelerDetails
// }) async {
//   print("Confirm Booking - Immediate Ticket - Multi Pax With Passport");
//   print("booking :$booking_id,fare:$fare");

//   var url = Uri.parse('https://apitest.tripjack.com/oms/v1/air/book');
//   print("url : $url");

//   // Define your request body here
//   var requestBody = {
//     "bookingId": booking_id, // Include the bookingId parameter here
//     "paymentInfos": [
//       {"amount": fare}
//     ],
//     "travellerInfo": [
//       {
//         "ti": "Mr",
//         "fN": "Test",
//         "lN": "AdultA",
//         "pt": "ADULT",
//         "dob": "2000-08-09",
//         "pNat": "IN",
//         "pNum": "87UYITB",
//         "eD": "2030-09-08"
//       }
//     ],
//       "gstInfo": {
//     "gstNumber":  gstNumber,
//     "email":  gstEmail,
//     "registeredName": gstName,
//     "mobile": gstMobile,
//     "address": gstAddress,
//   },
//   "deliveryInfo": {
//     "emails": [
//      deliveryEmail,
//     ],
//     "contacts": [
//      deliveryContact
//     ]
//   }

//     // "gstInfo": {
//     //   "gstNumber": gstNumber,
//     //   "email": gstEmail,
//     //   "registeredName": gstName,
//     //   "mobile": gstMobile,
//     //   "address": gstAddress,
//     // },
//     // "deliveryInfo": {"emails": deliveryEmail, "contacts": deliveryContact}
//   };

//   // Encode the request body to JSON
//   var requestBodyJson = jsonEncode(requestBody);

//   try {
//     // Make the POST request
//     var response = await http.post(
//       url,
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'apikey': '6122022b0e1517-2bf9-4ebe-92e7-3e2b550e5ba5',
//       },
//       body: requestBodyJson,
//     );
//     printWhite("response: $requestBody");
//     if (response.statusCode == 200) {
//       try {
//         String responseBody = response.body;
//         print('responseBody');
//         print(responseBody);
//         var decodedData = jsonDecode(responseBody);
//         return responseBody;
//       } catch (e) {
//         print('Error decoding JSON: $e');
//         return 'failed';
//       }
//     } else {
//       String errorMessage =
//           'Request failed with status: ${response.statusCode}.';
//       if (response.body != null && response.body.isNotEmpty) {
//         errorMessage += ' Response body: ${response.body}';
//       }
//       print(errorMessage);
//       return 'failed';
//     }
//   } catch (e) {
//     print('Error: $e');
//     return 'failed';
//   }
// }




// "bookingId":booking_id,
//   "paymentInfos": [
//     {
//       "amount": "5747"
      
//     }
//   ],
//   "travellerInfo": [
//     {
//       "ti": "Mr",
//       "fN": "Test",
//       "lN": "AdultA",
//       "pt": "ADULT",
//       "dob":"2006-08-09",
//       "pNat":"IN",
//       "pNum":"87UYITB",
//       "eD":"2030-09-08"
//     },
//     // {
//     //   "ti": "Mr",
//     //   "fN": "Test",
//     //   "lN": "AdultB",
//     //   "pt": "ADULT",
//     //   "dob": "2018-08-06",
//     //    "pNat":"IN",
//     //   "pNum":"87UYI89",
//     //   "eD":"2030-09-08"
//     // },
//     // {
//     //   "ti": "Master",
//     //   "fN": "Test",
//     //   "lN": "ChildA",
//     //   "pt": "CHILD",
//     //   "dob": "2014-08-06",
//     //    "pNat":"IN",
//     //   "pNum":"87UYI89",
//     //   "eD":"2030-09-08"
//     // },
//     //  {
//     //   "ti": "Ms",
//     //   "fN": "Test",
//     //   "lN": "InfantA",
//     //   "pt": "INFANT",
//     //   "dob": "2019-02-06",
//     //    "pNat":"IN",
//     //   "pNum":"87UYI89",
//     //   "eD":"2030-09-08"
//     // }
//   ],
//   "gstInfo": {
//     "gstNumber": "07ZZAS7YY6XXZF",
//     "email": "apitest@apitest.com ",
//     "registeredName": "XYZ Pvt Ltd",
//     "mobile": "9728408906",
//     "address": "Delhi"
//   },
//   "deliveryInfo": {
//     "emails": [
//       "xyz@xyz.com"
//     ],
//     "contacts": [
//       "9489275524"
//     ]
//   }