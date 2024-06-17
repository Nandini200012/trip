import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';

Future<String> CompletedpaymentFlightAPI(String id) async {
  print("CompletedpaymentflightAPI() $id");


  var url = Uri.parse(
      'https://gotodestination.in/api/get_payment_by_typeflight.php?id=$id');

 

  try {
    // Send the request
    final response = await http.get(
      url,
    );

    print(response.statusCode);
    printred(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      // printWhite('CompletedpaymentflightAPI() res: $data');

      var decodedData = jsonDecode(data);
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
