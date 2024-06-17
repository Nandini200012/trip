import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> showPromoCodesAPI() async {
  print("showPromoCodesAPI");

  var url = Uri.parse('https://gotodestination.in/api/show_promocode.php');
  print("url : $url");

  try {
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      try {
        String responseBody = response.body;
        print('responseBody');
        print(responseBody);
        var decodedData = jsonDecode(responseBody);
        return responseBody;
      } catch (e) {
        print('Error decoding JSON: $e');
        return 'failed';
      }
    } else {
      String errorMessage =
          'Request failed with status: ${response.statusCode}.';
      if (response.body != null && response.body.isNotEmpty) {
        errorMessage += ' Response body: ${response.body}';
      }
      print(errorMessage);
      return 'failed';
    }
  } catch (e) {
    print('Error: $e');
    return 'failed';
  }
}

class PromoCodes {
  String errorCode;
  String message;
  List<CodeData> data;

  PromoCodes({
    this.errorCode,
    this.message,
    this.data,
  });

  factory PromoCodes.fromJson(Map<String, dynamic> json) => PromoCodes(
        errorCode: json["error_code"],
        message: json["message"],
        data:
            List<CodeData>.from(json["data"].map((x) => CodeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CodeData {
  String promoId;
  String promoCode;
  String discount;

  CodeData({
    this.promoId,
    this.promoCode,
    this.discount,
  });

  factory CodeData.fromJson(Map<String, dynamic> json) => CodeData(
        promoId: json["promo_id"],
        promoCode: json["promo_code"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "promo_id": promoId,
        "promo_code": promoCode,
        "discount": discount,
      };
}

class FlightCoupons {
  String errorCode;
  String message;
  List<flightCoupon> data;

  FlightCoupons({
    this.errorCode,
    this.message,
    this.data,
  });

  factory FlightCoupons.fromJson(Map<String, dynamic> json) => FlightCoupons(
        errorCode: json["error_code"],
        message: json["message"],
        data: List<flightCoupon>.from(
            json["data"].map((x) => flightCoupon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class flightCoupon {
  String promoId;
  String promoCode;
  String discount;
  String code;
  String image;
  String title;
  String description;

  flightCoupon({
    this.promoId,
    this.promoCode,
    this.discount,
    this.code,
    this.image,
    this.title,
    this.description,
  });

  factory flightCoupon.fromJson(Map<String, dynamic> json) => flightCoupon(
        promoId: json["promo_id"],
        promoCode: json["promo_code"],
        discount: json["discount"],
        code: json["code"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "promo_id": promoId,
        "promo_code": promoCode,
        "discount": discount,
        "code": code,
        "image": image,
        "title": title,
        "description": description,
      };
}
