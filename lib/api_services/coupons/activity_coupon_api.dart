import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getActivityCouponsAPI() async {
  print("getActivityCouponsAPI()");

  var url = Uri.parse('http://gotodestination.in/api/get_activity_coupon.php');
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



class Activitycoupons {
    String errorCode;
    List< ActivityCouponCode> couponCodes;

    Activitycoupons({
          this.errorCode,
          this.couponCodes,
    });

    factory Activitycoupons.fromJson(Map<String, dynamic> json) => Activitycoupons(
        errorCode: json["error_code"],
        couponCodes: List< ActivityCouponCode>.from(json["coupon_codes"].map((x) =>  ActivityCouponCode.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "coupon_codes": List<dynamic>.from(couponCodes.map((x) => x.toJson())),
    };
}

class  ActivityCouponCode {
    String id;
    String couponCode;
    String category;
    String description;
    String discount;
    String code;
    String image;
    String title;

     ActivityCouponCode({
          this.id,
          this.couponCode,
          this.category,
          this.description,
          this.discount,
          this.code,
          this.image,
          this.title,
    });

    factory  ActivityCouponCode.fromJson(Map<String, dynamic> json) =>  ActivityCouponCode(
        id: json["id"],
        couponCode: json["coupon_code"],
        category: json["category"],
        description: json["description"],
        discount: json["discount"],
        code: json["code"],
        image: json["image"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "coupon_code": couponCode,
        "category": category,
        "description": description,
        "discount": discount,
        "code": code,
        "image": image,
        "title": title,
    };
}
