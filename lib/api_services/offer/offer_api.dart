import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';

Future<String> homeoffersAPI() async {
  print("homeoffersAPI() api");
  var url = Uri.parse('https://gotodestination.in/api/get_package_coupon.php');
print(url);
  try {
    final response = await http.get(url);
    print(response.statusCode);
    printred(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print('holidayPackagesAPI res');

      var decodedData = jsonDecode(data);
      // printWhite("Holiday all: $data");
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

class Homeoffers {
  String errorCode;
  String errorMessage;
  List<offerData> data;

  Homeoffers({
    this.errorCode,
    this.errorMessage,
    this.data,
  });

  factory Homeoffers.fromJson(Map<String, dynamic> json) => Homeoffers(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        data: List<offerData>.from(json["Data"].map((x) => offerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class offerData {
  String id;
  String title;
  String description;
  String discount;

  offerData({
    this.id,
    this.title,
    this.description,
    this.discount,
  });

  factory offerData.fromJson(Map<String, dynamic> json) => offerData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "discount": discount,
      };
}
