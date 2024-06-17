import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';
import 'package:trip/login_variables/login_Variables.dart';

Future<String> postdetailsFlightApi({
  String from,
  String to,
  String bookingID,
  String orderID,
  String totalfare,
  String statuss,
  String flightDate,
}) async {
  print("Post Flight Details");

  var url = Uri.parse('https://gotodestination.in/api/booking.php');

  try {
    var response = await http.post(url, body: {
      'booking_id': bookingID,
      'order_id': orderID,
      'customer_name': user_id,
      'date': flightDate,
      'location': "$from to $to",
      'amount': totalfare,
      'status': statuss
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      printWhite('postdetailsFlightApi: $data');
      // CommentObj obj = CommentObj.fromJson(jsonDecode(data));
      return data;
    } else {
      return 'failed';
    }
  } on http.ClientException catch (e) {
    print('HTTP client error: $e');
    return 'failed';
  } on SocketException catch (e) {
    print('Socket error: $e');
    return 'failed';
  } catch (e) {
    print('Error: $e');
    return 'failed';
  }
}
