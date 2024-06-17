import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> postTidAPI(
    {String tid, String block_id, String orderid, String user_id}) async {
  print("postTidAPI");
  print("tid: $tid, block_id: $block_id, orderid: $orderid, user_id: $user_id");

  // Define the URL
  var url = Uri.parse('https://gotodestination.in/api/add_blockid_tid_bus.php');

  // Define the request body
  var requestBody = {
    'tid': tid,
    'block_id': block_id,
    'order_id': orderid,
    'user_id': user_id,
  };

  print("request body: $requestBody");

  try {
    // Send the request
    final response = await http.post(url, body: requestBody);

    // Print the response details
    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      // Check if the API response indicates success
      if (decodedData["error_code"] == '200') {
        print("postTidAPI success: $data");
        return data;
      } else {
        print("postTidAPI error: ${decodedData["error_message"]}");
        return 'failed';
      }
    } else {
      print("Failed to post TID, server returned status code ${response.statusCode}");
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









// import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart' as http;

// Future<String> postTidAPI(
//     {String tid, String block_id, String orderid, String user_id}) async {
//   print("postTidAPI");
//   print("tid:$tid  ,block_id:$block_id ,orderid:$orderid ,user_id:$user_id ");

//   // Define the URL
//   var url = Uri.parse('http://gotodestination.in/api/add_blockid_tid_bus.php');

//   // Define the request body
//   var requestBody = {
//     'tid': tid,
//     'block_id': block_id,
//     'order_id': orderid,
//     'user_id': user_id,
//   };

//   print("requst body:$requestBody");
//   try {
//     // Send the request
//     final response = await http.post(url, body: requestBody);

//     print(response.statusCode);
//     print(response.body);

//     if (response.statusCode == 200) {
//       String data = response.body;
//       print("postTidAPI");

//       var decodedData = jsonDecode(data);
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
//     return 'failed';
//   }
// }
