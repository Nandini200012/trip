import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:oauth1/oauth1.dart' as oauth1;

Future<String> getCitiesAPI() async {
  print("get cities api");
  var url = Uri.parse('http://api.seatseller.travel/cities');
  // http.Response response = await http.get(url);
  final consumerKey = 'MCycaVxF6XVV0ImKgqFPBAncx0prPp';
  final consumerSecret = '5f0lpy9heMvXNQ069lQPNMomysX6rt';
   final token ="";
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
  // print(response.statusCode);
  // print(response.body);
  
  if (response.statusCode == 200) {
    String data = response.body;
    print('get cities api res');
    // print(data);
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
}  catch (e) {
  print('Error: $e');
  return 'failed';
} finally {
  oauthClient.close();
}

}


class CityModel {
  List<City> cities;

  CityModel({
    this.cities,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
    );
  }
}

class City {
  String id;
  String latitude;
  String locationType;
  String longitude;
  String name;
  String state;
  String stateId;


  City({
    this.id,
    this.latitude,
    this.locationType,
    this.longitude,
    this.name,
    this.state,
    this.stateId,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"],
      latitude: json["latitude"],
      locationType: json["locationType"],
      longitude: json["longitude"],
      name: json["name"],
      state: json["state"],
      stateId: json["stateId"],
    );
  }
}
  // if (response.statusCode == 200) {
  //   String data = response.body;
  //   var decodedData = jsonDecode(data);
  //   return CityModel.fromJson(decodedData);
  // } else {
  //   throw Exception('Failed to load cities');
  // }