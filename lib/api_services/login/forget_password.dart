import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trip/login_variables/login_Variables.dart';
import 'package:trip/screens/activities/widgets/form.dart';

Future<String> forgetPassword(mobile,password,confirm_password) async {
  print("forgetPassword");
  print("  ,mobile:$mobile ,password:$password ,confirm_password:$confirm_password ");
String _id =user_id;

  // Define the URL
  var url = Uri.parse('https://gotodestination.in/api/forget_password.php');
if(id==""){
  print(" null id");
}
  // Define the request body
  var requestBody = {
    'id': _id,  
    'mobile': mobile,
    'new_password': password,
    'confirm_password': confirm_password,
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
