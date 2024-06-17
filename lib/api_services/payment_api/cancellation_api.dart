import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';

Future<String> cancellationAPI(String tid) async {
  print("cancelledPaymentAPI ");
  var url = Uri.parse('https://gotodestination.in/api/cancel_payment.php');

  // 'https://gotodestination.in/api/get_payments_by_id.php?id=$p_id');
  printWhite("url:$url");
  var requestBody = {
    'tid': tid,
  };
  try {
    final response = await http.post(url, body: requestBody);
    print(response.statusCode.toString());
    // print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      // print('holidayPackages byid res');

      var decodedData = jsonDecode(data);
      // printWhite("byid: $data");
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
