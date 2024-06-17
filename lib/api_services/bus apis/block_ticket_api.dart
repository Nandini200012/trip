import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';
import '../../screens/bus/models/usermodel.dart';

Future<String> blockTicketAPI(
    {String id,
    String boardingpnt,
    String droppingpnt,
    String source,
    String destination,
    String fare,
    List<User> passengers}) async {
  print("block Ticket api");
  String uri =
      'https://api.seatseller.travel/blockTicket?oauth_consumer_key=MCycaVxF6XVV0ImKgqFPBAncx0prPp&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1712565694&oauth_nonce=pq916RChG3J&oauth_version=1.0&oauth_signature=qFD4eLNIt75jCIy8drIa3njP1tk%3D';
  // API endpoint URL
  var url = Uri.parse(uri);

  // Request headers
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie':
        'ak_bmsc=A1D69CD093FF444CDC3D88985E10C6A2~000000000000000000000000000000~YAAQdfY3F60RZZiOAQAAWfXevBcP7+U2KrBoCCUMZMN7HwAFiXfxVIjgZ30GFJV4SCV2wXlrNSFHjvjZhi0at6n/oQJkF6OwcUCWIkcGgbWQ7t+kJNkZflls2FRmI26/+tU0dt5Puzr76Xm+P9VQYlBwhmrMP7ab0OtkKGYPUq0rK3MzgG01Eq+gwFpVdESa/zbXRG9f4E7AMMbzLk9gHxbVkgp0Z/b5SArenDPcXMPVoSAUXpdCngTTqaJ5a7kROelgliwvI+VH9cB/LIviHMAOr4OUVrK58sjTEa2Hjd3go8TyybLmUENvuOQezL8qvD6pWPp+iRJpwpAc5Q==; bm_sv=1CE7C061A88C4AA0BCAD824E4C59CC28~YAAQJaRqKv2RzLiOAQAAnfXevBcd/gtsJ3Poz3HymnC4jpJG0AavKKdgAdGKnvtHfnpvC/Grdl+Di91CfU8XcdyGrEGd495lsjmwsoLxu6mVMLFJoI/6z0aHn64pnzddpPxiWQGSQ+9BsKkS5KlLQZZRZj1m4j3HDw3BooNau0W7fVv7wyHXKq5Hat8og/sX1rzvxsKc00afW3Gm0NRCpFrvhxllDdKdbfB4W6IgRby51HVQ66JVb0qWsdJ/28ZuoK0VL0PnrQ==~1',
  };

  // Request body
  // Construct the inventoryItems list dynamically
  List<Map<String, dynamic>> inventoryItems = passengers.map((passenger) {
    return {
      "fare": fare,
      "ladiesSeat": passenger.ladiesSeat.toString(),
      "seatName": passenger.seatNo,
      "passenger": {
        "address": passenger.address,
        "age": passenger.age.toString(),
        "email": passenger.email,
        "gender": passenger.gender.toUpperCase(),
        "idNumber": passenger.idNumber,
        "idType": passenger.idType,
        "mobile": passenger.mobile,
        "name": passenger.name,
        "primary": passengers.first == passenger ? "true" : "false",
        "title": passenger.title,
      }
    };
  }).toList();

// Construct the request body dynamically
  String requestBody = jsonEncode({
    "availableTripId": id,
    "boardingPointId": boardingpnt,
    "droppingPointId": droppingpnt,
    "source": source,
    "destination": destination,
    "inventoryItems": inventoryItems,
  });
  try {
    print("try");
    printred("req:  $requestBody");
    // Make POST request
    final response = await http.post(
      url,
      headers: headers,
      body: requestBody,
    );

    // Print response for debugging
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Check response status
    if (response != null) {
      return response.body;
    } else {
      return 'Failed: ${response.statusCode}';
    }
  } on http.ClientException catch (e) {
    print('HTTP client error: $e');
    return 'Failed: HTTP client error';
  } on SocketException catch (e) {
    print('Socket error: $e');
    return 'Failed: Socket error';
  } catch (e) {
    print('Error: $e');
    return 'Failed: $e';
  }
}

// --------------Working model
// {
//     "availableTripId": "2000005548530074400",
//     "boardingPointId": "68220",
//     "droppingPointId": "43227",
//     "source": "102",
//     "destination": "3",
//     "inventoryItems": [
//         {
//             "fare": "945.00",
//             "ladiesSeat": "false",
//             "seatName": "33",
//             "passenger": {
//                 "address": "4th Floor, Office no 408, Kubera Towers, Himayatnagar Hyderabad",
//                 "age": "23",
//                 "email": "test.com@gmail.com",
//                 "gender": "MALE",
//                 "idNumber": "125Hyd675",
//                 "idType": "DrivingLicence",
//                 "mobile": "9999999999",
//                 "name": "test",
//                 "primary": "true",
//                 "title": "Mr"
//             }
//         },
//         {
//             "fare": "945.00",
//             "ladiesSeat": "false",
//             "seatName": "18",
//             "passenger": {
//                 "address": "4th Floor, Office no 408, Kubera Towers, Himayatnagar Hyderabad",
//                 "age": "28",
//                 "email": "test1.com@gmail.com",
//                 "gender": "FEMALE",
//                 "idNumber": "125Hyd675",
//                 "idType": "DrivingLicence",
//                 "mobile": "9999999999",
//                 "name": "test1",
//                 "primary": "false",
//                 "title": "Mrs"
//             }
//         }
//     ]
// }


// --------------using model
// {
//     "availableTripId": " 2000005548590074400",
//     "boardingPointId": "68220",
//     "droppingPointId": "43227",
//     "source": "102",
//     "destination": "3",
//     "inventoryItems": [
//         {
//             "fare": "945.00",
//             "ladiesSeat": "false",
//             "seatName": "1",
//             "passenger": {
//                 "address": "123 Main St, City",
//                 "age": "30",
//                 "email": "john@example.com",
//                 "gender": "MALE",
//                 "idNumber": "ABC123",
//                 "idType": "DrivingLicence",
//                 "mobile": "1234567890",
//                 "name": "John Doe",
//                 "primary": "false",
//                 "title": "Mr"
//             }
//         },
//         {
//             "fare": "945.00",
//             "ladiesSeat": "false",
//             "seatName": "8",
//             "passenger": {
//                 "address": "456 Elm St, Town",
//                 "age": "25",
//                 "email": "jane@example.com",
//                 "gender": "FEMALE",
//                 "idNumber": "XYZ456",
//                 "idType": "DrivingLicence",
//                 "mobile": "9876543210",
//                 "name": "Jane Doe",
//                 "primary": "false",
//                 "title": "Mrs"
//             }
//         },
//         {
//             "fare": "945.00",
//             "ladiesSeat": "false",
//             "seatName": "9",
//             "passenger": {
//                 "address": "789 Oak St, Village",
//                 "age": "35",
//                 "email": "alex@example.com",
//                 "gender": "MALE",
//                 "idNumber": "DEF789",
//                 "idType": "DrivingLicence",
//                 "mobile": "5555555555",
//                 "name": "Alex Smith",
//                 "primary": "true",
//                 "title": "Mr"
//             }
//         }
//     ]
// }