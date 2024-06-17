import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:oauth1/oauth1.dart' as oauth1;
BusCancellationAPI(
  String tin
) async {
  print("BusCancellation api");

  // String destination = "6";
  // String source = "3";
  // String doj = "2024-03-20";
  var url = Uri.parse(
      'http://api.seatseller.travel/cancellationdata?tin=$tin');

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
    final response = await oauthClient.get(url);
    print("status code: ${response.statusCode}");
    // if (response.statusCode != 200) print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
  
      print(data.length);

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



