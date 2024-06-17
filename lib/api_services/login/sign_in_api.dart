import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> signInAPI(txt1,txt2) async {
  print("signInAPI()");

  print(" mob:$txt1 ,pass:$txt2 ");

  // Define the URL
  var url = Uri.parse('https://gotodestination.in/api/signIn.php');

  // Define the request body
  var requestBody = {
    'mobile': txt1,
    'password': txt2,
  
  };

  try {
    // Send the request
    final response = await http.post(url, body: requestBody);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print('signInAPI() res');

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
