import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../login_variables/login_Variables.dart';

Future<String> saveReviewAPI(
    String email, String name, String review, String pid) async {
  print("save review api");

  var url = Uri.parse('https://gotodestination.in/api/add_activity_review.php');

  try {
    // Replace 'user_id' with the actual user ID variable you have or remove if not needed

    var response = await http.post(
      url,
      body: {
        'name': name,
        'activity_id': pid,
        'review': review,
        'email': email,
        'user_id': user_id,
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print('save review api response: $data');
      return data; // Return success message or data
    } else {
      return 'failed'; // Return failure message
    }
  } on http.ClientException catch (e) {
    print('HTTP client error: $e');
    return 'failed'; // Return failure message
  } on SocketException catch (e) {
    print('Socket error: $e');
    return 'failed'; // Return failure message
  } catch (e) {
    print('Error: $e');
    return 'failed'; // Return failure message
  }
}




// import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart' as http;
// import 'package:trip/login_variables/login_Variables.dart';

// Future<String> saveReviewAPI(String email, String name, String review, String pid) async {
//   print("save review api");

 
//   var url = Uri.parse('https://gotodestination.in/api/add_activity_review.php');

//   try {

//     var response = await http.post(url, body: {
//       'name':name,
//       "activity_id":pid,
//      'review':review,
//      'email':email,
//      'user_id':user_id
//     });

//     print(response.statusCode);
//     print(response.body);

//     if (response.statusCode == 200) {
//       String data = response.body;
//       print('save review api response: $data');
//       return data; 
//     } else {
//       return 'failed';
//     }
//   } on http.ClientException catch (e) {
//     print('HTTP client error: $e');
//     return 'failed'; 
//   } on SocketException catch (e) {
//     print('Socket error: $e');
//     return 'failed'; 
//   } catch (e) {
//     print('Error: $e');
//     return 'failed'; // Return failure message
//   }
// }
