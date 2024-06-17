import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;



Future<String> getActivitiesAPI() async {
  print("get activities api");
  var url = Uri.parse('https://gotodestination.in/api/get_activity.php');
  
  
try {
  final response = await http.get(url);
  print(response.statusCode);
  print(response.body);
  
  if (response.statusCode == 200) {
    String data = response.body;
    print('get activities  api res');
  
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
} 

}




class getActivitiesobj {
    String errorCode;
    String message;
    List<Datum> data;
    // List<Map<String, String>> data;

    getActivitiesobj({
       this.errorCode,
       this.message,
       this.data,
    });

    factory getActivitiesobj.fromJson(Map<String, dynamic> json) => getActivitiesobj(
        errorCode: json["error_code"],
        message: json["message"], data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        // data: List<Map<String, String>>.from(json["data"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        // "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
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
    String price;

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
          this.price,
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
        price: json["price"],
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
        "price": price,
    };
}
