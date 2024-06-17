import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';

Future<String> getHolidayreviewsAPI(String p_id) async {
  print("getHolidayreviewsAPI  ");
  var url = Uri.parse(
      'https://gotodestination.in/api/get_reviews_by_package_id.php?package_id=$p_id');
      printWhite("url:$url");

  try {
    final response = await http.get(url);
    print(response.statusCode.toString());
    // print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      // print('holidayPackages byid res');

      var decodedData = jsonDecode(data);
      // printWhite("byid: $data");
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



class HolidayReviews {
    String errorCode;
    String errorMessage;
    List<HolidayReviewData> data;

    HolidayReviews({
          this.errorCode,
          this.errorMessage,
          this.data,
    });

    factory HolidayReviews.fromJson(Map<String, dynamic> json) => HolidayReviews(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        data: List<HolidayReviewData>.from(json["Data"].map((x) => HolidayReviewData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class HolidayReviewData {
    String packageId;
    String packageName;
    String username;
    String email;
    String review;

    HolidayReviewData({
          this.packageId,
          this.packageName,
          this.username,
          this.email,
          this.review,
    });

    factory HolidayReviewData.fromJson(Map<String, dynamic> json) => HolidayReviewData(
        packageId: json["package_id"],
        packageName: json["package_name"],
        username: json["username"],
        email: json["email"],
        review: json["review"],
    );

    Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "package_name": packageName,
        "username": username,
        "email": email,
        "review": review,
    };
}

