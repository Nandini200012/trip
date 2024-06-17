import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<activityobj> getActivitiesdetailsAPI(id) async {
  var url =
      Uri.parse('https://gotodestination.in/api/get_activity_by_id.php?id=$id');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return activityobj.fromJson(decodedData);
    } else {
      throw Exception('Failed to load activity details');
    }
  } on http.ClientException catch (e) {
    print('HTTP client error: $e');
    throw Exception('Failed to load activity details');
  } on SocketException catch (e) {
    print('Socket error: $e');
    throw Exception('Failed to load activity details');
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load activity details');
  }
}




class  activityobj {
    String errorCode;
    String message;
    List<Datum> data;
    List<PackageOption> packageOption;

     activityobj({
          this.errorCode,
          this.message,
          this.data,
          this.packageOption,
    });

    factory  activityobj.fromJson(Map<String, dynamic> json) =>  activityobj(
        errorCode: json["error_code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        packageOption: List<PackageOption>.from(json["package option"].map((x) => PackageOption.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "package option": List<dynamic>.from(packageOption.map((x) => x.toJson())),
    };
}

class Datum {
    String packageId;
    String categoryName;
    String packageName;
    String location;
    String startTime;
    String endTime;
    String ageLimit;
    String permissionWeight;
    String image1;
    String image2;
    String image3;
    String image4;
    String packageDesc;
    String confirmationPolicy;
    String cancellationPolicy;
    String faq;

    Datum({
          this.packageId,
          this.categoryName,
          this.packageName,
          this.location,
          this.startTime,
          this.endTime,
          this.ageLimit,
          this.permissionWeight,
          this.image1,
          this.image2,
          this.image3,
          this.image4,
          this.packageDesc,
          this.confirmationPolicy,
          this.cancellationPolicy,
          this.faq,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        packageId: json["package_id"],
        categoryName: json["category_name"],
        packageName: json["package_name"],
        location: json["location"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        ageLimit: json["age_limit"],
        permissionWeight: json["permission_weight"],
        image1: json["image_1"],
        image2: json["image_2"],
        image3: json["image_3"],
        image4: json["image_4"],
        packageDesc: json["package_desc"],
        confirmationPolicy: json["confirmation_policy"],
        cancellationPolicy: json["cancellation_policy"],
        faq: json["faq"],
    );

    Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "category_name": categoryName,
        "package_name": packageName,
        "location": location,
        "start_time": startTime,
        "end_time": endTime,
        "age_limit": ageLimit,
        "permission_weight": permissionWeight,
        "image_1": image1,
        "image_2": image2,
        "image_3": image3,
        "image_4": image4,
        "package_desc": packageDesc,
        "confirmation_policy": confirmationPolicy,
        "cancellation_policy": cancellationPolicy,
        "faq": faq,
    };
}

class PackageOption {
    String pkopId;
    String packageId;
    String description;
    String timeDuration;
    String agePolicy;
    String priceIncludes;
    String price;

    PackageOption({
          this.pkopId,
          this.packageId,
          this.description,
          this.timeDuration,
          this.agePolicy,
          this.priceIncludes,
          this.price,
    });

    factory PackageOption.fromJson(Map<String, dynamic> json) => PackageOption(
        pkopId: json["pkop_id"],
        packageId: json["package_id"],
        description: json["description"],
        timeDuration: json["time_duration"],
        agePolicy: json["age_policy"],
        priceIncludes: json["price_includes"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "pkop_id": pkopId,
        "package_id": packageId,
        "description": description,
        "time_duration": timeDuration,
        "age_policy": agePolicy,
        "price_includes": priceIncludes,
        "price": price,
    };
}







