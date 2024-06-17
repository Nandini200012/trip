import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getLocationListAPI() async {
  String res = "";
  var url = Uri.parse('https://gotodestination.in/api/showlocations.php');
  http.Response response = await http.get(url);
  try {
    print('res*');
    print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      String data = response.body;
      // print('res');
      // print(data);
      var decodedData = jsonDecode(data);
      return data;
    } else {
      return 'failed';
    }
  } catch (e) {
    return 'failed';
  }
  // try {
  //
  //   var fullurl = 'https://gotodestination.in/api/showlocations.php';
  //
  //   print('fullurl = $fullurl');
  //   var request = http.MultipartRequest('GET',
  //       Uri.parse(fullurl));
  //
  //   http.StreamedResponse response = await request.send();
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     res=await response.stream.bytesToString();
  //     print('res');
  //     print(res);
  //     return res;
  //   }
  //   else {
  //     print('res1');
  //     print(res);
  //     // res="error";
  //     return res;
  //   }
  //   // return res;
  // }catch(exception, stackTrace)
  // {
  //   print("Exception- "+exception.toString());
  //   res="error";
  //   return res;
  // }
}

class LocationObj {
  String errorCode;
  String message;
  List<LocationData> data;

  LocationObj({this.errorCode, this.message, this.data});

  LocationObj.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LocationData>[];
      json['data'].forEach((v) {
        data.add(new LocationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationData {
  String id;
  String code;
  String name;
  String citycode;
  String city;
  String country;
  String countrycode;

  LocationData(
      {this.id,
        this.code,
        this.name,
        this.citycode,
        this.city,
        this.country,
        this.countrycode});

  LocationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    citycode = json['citycode'];
    city = json['city'];
    country = json['country'];
    countrycode = json['countrycode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['citycode'] = this.citycode;
    data['city'] = this.city;
    data['country'] = this.country;
    data['countrycode'] = this.countrycode;
    return data;
  }
}