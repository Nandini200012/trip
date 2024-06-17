import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> signUpAPI(name,mobile,email,password) async {
  print("signUpAPi");
  print("name:$name  ,mobile:$mobile ,email:$email ,password:$password ");

  // Define the URL
  var url = Uri.parse('https://gotodestination.in/api/signup.php');

  // Define the request body
  var requestBody = {
    'email': email,
    'name': name,
    'mobile': mobile,
    'password': password,
  };

  try {
    // Send the request
    final response = await http.post(url, body: requestBody);

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print("signUpAPi");

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
