import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:trip/common/print_funtions.dart';

Future<String> buscancellationDetailsAPI(String tin) async {
  print("buscancellationDetailsAPI");
  print("tin:$tin");

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
    var url = Uri.parse('http://api.seatseller.travel/cancellationdata?tin=$tin');

    final response = await oauthClient.get(
      url,
    );

    if (response != null) {
      String data = response.body;
      printred("Response busTicketAPI: data");
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