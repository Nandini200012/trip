import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:oauth1/oauth1.dart' as oauth1;

Future<String> boardingDetailsAPI(
  String id,
) async {
  print("boardingDetailsAPIi");

  // String destination = "6";
  // String source = "3";
  // String doj = "2024-03-20";
  var url = Uri.parse('https://api.seatseller.travel/bpdpDetails?id=$id');

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



class BoardingDetailsobj {
    IngPoints boardingPoints;
    IngPoints droppingPoints;

    BoardingDetailsobj({
          this.boardingPoints,
          this.droppingPoints,
    });

    factory BoardingDetailsobj.fromJson(Map<String, dynamic> json) => BoardingDetailsobj(
        boardingPoints: IngPoints.fromJson(json["boardingPoints"]),
        droppingPoints: IngPoints.fromJson(json["droppingPoints"]),
    );

    Map<String, dynamic> toJson() => {
        "boardingPoints": boardingPoints.toJson(),
        "droppingPoints": droppingPoints.toJson(),
    };
}

class IngPoints {
    String address;
    String contactnumber;
    String id;
    String landmark;
    String locationName;
    String name;
    String rbMasterId;

    IngPoints({
          this.address,
          this.contactnumber,
          this.id,
          this.landmark,
          this.locationName,
          this.name,
          this.rbMasterId,
    });

    factory IngPoints.fromJson(Map<String, dynamic> json) => IngPoints(
        address: json["address"],
        contactnumber: json["contactnumber"],
        id: json["id"],
        landmark: json["landmark"],
        locationName: json["locationName"],
        name: json["name"],
        rbMasterId: json["rbMasterId"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "contactnumber": contactnumber,
        "id": id,
        "landmark": landmark,
        "locationName": locationName,
        "name": name,
        "rbMasterId": rbMasterId,
    };
}
