import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trip/login_variables/login_Variables.dart';

Future<String> AmendmentFlightApi(
  String amendment_id,
  String genaratedTime,
  String bookingID,
  String orderID,
  String totalfare,
  String status,
  String depDate,
  String actionDate,
  String  refund,
  String type,
  String remark,

) async {
  print("AmendmentFlightApi");

  var url = Uri.parse('https://gotodestination.in/api/amendments_air.php');

  try {
    var response = await http.post(url, body: {
      'generation_time': genaratedTime,
      'departure_date': depDate,
      'closest_action_date': actionDate,
      'booking_id': bookingID,
      'order_id': orderID,
      'flight_amount': totalfare,
      'refund_amount': refund,
      'status': status,
      'booked_by': user_name,
      'type': type,
      'remark': remark,
      'amendment_id': amendment_id,
    });

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print('AmendmentFlightApi: $data');
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
