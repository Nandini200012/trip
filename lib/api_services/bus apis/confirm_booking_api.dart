import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:oauth1/oauth1.dart' as oauth1;

Future<String> ConfirmBookingAPI(String blockKey) async {
  print("ConfirmBookingAPI");
  print("blockKey: $blockKey");

  final consumerKey = 'MCycaVxF6XVV0ImKgqFPBAncx0prPp';
  final consumerSecret = '5f0lpy9heMvXNQ069lQPNMomysX6rt';
  final token = "";
  final tokenSecret = "";

  final oauthClient = oauth1.Client(
    oauth1.SignatureMethods.hmacSha1,
    oauth1.ClientCredentials(
      consumerKey,
      consumerSecret,
    ),
    oauth1.Credentials(
      token,
      tokenSecret,
    ),
  );

  try {
    var url = Uri.parse('https://api.seatseller.travel/bookticket?blockKey=$blockKey');

    final response = await oauthClient.post(
      url,
    );

    if (response != null) {
      String data = response.body;
      // print("Response ConfirmBookingAPI: $data");
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
  } finally {
    oauthClient.close();
  }
}








// import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart' as http;
// import 'package:oauth1/oauth1.dart' as oauth1;

// Future<String> ConfirmBookingAPI(String blockKey) async {
//   print("ConfirmBookingAPI");
//   print("Key: $blockKey");
  
//   var encodedBlockKey = Uri.encodeComponent(blockKey);
//   var url = Uri.parse('https://api.seatseller.travel/bookticket?blockKey=$encodedBlockKey');
//   print("URL: $url");
  
//   final consumerKey = 'MCycaVxF6XVV0ImKgqFPBAncx0prPp';
//   final consumerSecret = '5f0lpy9heMvXNQ069lQPNMomysX6rt';
//   final token = "";
//   final tokenSecret = "";
//   final oauthClient = oauth1.Client(
//     oauth1.SignatureMethods.hmacSha1,
    
//     oauth1.ClientCredentials(
//       consumerKey,
//       consumerSecret,
//     ),
//     oauth1.Credentials(
//       token,
//       tokenSecret,
//     ),
//   );

//   try {
//     final response = await oauthClient.post(url);
    
//     if (response.statusCode == 200) {
//       String data = response.body;
//       try {
//         var decodedData = jsonDecode(data);
//         print("Data: $data");
//         return data;
//       } catch (e) {
//         print('Error parsing JSON: $e');
//         return 'failed';
//       }
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
//   } finally {
//     oauthClient.close();
//   }
// }
