
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> getholidayCategoryAPI() async {
  print("getholidayCategoryAPI api");
  var url = Uri.parse(
      'https://gotodestination.in/api/get_all_holiday_category.php');

  try {
    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print('getholidayCategoryAPI res');

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
  } catch (e) {
    print('Error: $e');
    return 'failed';
  }
}


class HolidayPackagecategory {
    String errorCode;
    String errorMessage;
    List<HolidayPackagecategoryDatum> data;

    HolidayPackagecategory({
          this.errorCode,
          this.errorMessage,
          this.data,
    });

    factory HolidayPackagecategory.fromJson(Map<String, dynamic> json) => HolidayPackagecategory(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        data: List<HolidayPackagecategoryDatum>.from(json["Data"].map((x) => HolidayPackagecategoryDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class HolidayPackagecategoryDatum {
    String errorCode;
    String errorMessage;
    List<DatumDatum> data;

    HolidayPackagecategoryDatum({
          this.errorCode,
          this.errorMessage,
          this.data,
    });

    factory HolidayPackagecategoryDatum.fromJson(Map<String, dynamic> json) => HolidayPackagecategoryDatum(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        data: List<DatumDatum>.from(json["Data"].map((x) => DatumDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DatumDatum {
    String cId;
    String categoryName;

    DatumDatum({
          this.cId,
          this.categoryName,
    });

    factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
        cId: json["c_id"],
        categoryName: json["category_name"],
    );

    Map<String, dynamic> toJson() => {
        "c_id": cId,
        "category_name": categoryName,
    };
}

