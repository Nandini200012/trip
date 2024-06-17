import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';

Future<String> holidayoffersAPI() async {
  print("holidayoffersAPI()api");
  var url = Uri.parse('https://gotodestination.in/api/get_coupon_codes.php');

  try {
    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);

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



class Holidaycoupon {
    String errorCode;
    List<CouponCode> couponCodes;

    Holidaycoupon({
          this.errorCode,
          this.couponCodes,
    });

    factory Holidaycoupon.fromJson(Map<String, dynamic> json) => Holidaycoupon(
        errorCode: json["error_code"],
        couponCodes: List<CouponCode>.from(json["coupon_codes"].map((x) => CouponCode.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "coupon_codes": List<dynamic>.from(couponCodes.map((x) => x.toJson())),
    };
}

class CouponCode {
    String id;
    String couponCode;
    String category;
    String description;
    String discount;
    String code;
    String image;
    String title;

    CouponCode({
          this.id,
          this.couponCode,
          this.category,
          this.description,
          this.discount,
          this.code,
          this.image,
          this.title,
    });

    factory CouponCode.fromJson(Map<String, dynamic> json) => CouponCode(
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

// class HolidayCoupons {
//     String errorCode;
//     List<CouponCode> couponCodes;

//     HolidayCoupons({
//           this.errorCode,
//           this.couponCodes,
//     });

//     factory HolidayCoupons.fromJson(Map<String, dynamic> json) => HolidayCoupons(
//         errorCode: json["error_code"],
//         couponCodes: List<CouponCode>.from(json["coupon_codes"].map((x) => CouponCode.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "error_code": errorCode,
//         "coupon_codes": List<dynamic>.from(couponCodes.map((x) => x.toJson())),
//     };
// }

// class CouponCode {
//     String id;
//     String couponCode;
//     String description;
//     String discount;

//     CouponCode({
//           this.id,
//           this.couponCode,
//           this.description,
//           this.discount,
//     });

//     factory CouponCode.fromJson(Map<String, dynamic> json) => CouponCode(
//         id: json["id"],
//         couponCode: json["coupon_code"],
//         description: json["description"],
//         discount: json["discount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "coupon_code": couponCode,
//         "description": description,
//         "discount": discount,
//     };
// }
