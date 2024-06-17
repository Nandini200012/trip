import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;



Future<String> getreviewAPI(String id) async {
  print("get review api");
  var url = Uri.parse('https://gotodestination.in/api/get_activity_review_by_id.php?activity_id=$id');
  // ('https://gotodestination.in/api/get_activity_review_by_id.php?activity_id=$id');
  
  
try {
  final response = await http.get(url);
  print(response.statusCode);
  print(response.body);
  
  if (response.statusCode == 200) {
    String data = response.body;
    print('get review  api res');
  
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








class reviewobj{
    String errorCode;
    String errorMessage;
    List<ReviewData> data;

    reviewobj({
   this.errorCode,
    this.errorMessage,
   this.data,
    });

    factory reviewobj.fromJson(Map<String, dynamic> json) => reviewobj(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        data: List<ReviewData>.from(json["Data"].map((x) => ReviewData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ReviewData {
    String rId;
    String email;
    String name;
    String review;
    String rating;
    String image;

   ReviewData({
  this.rId,
   this.email,
     this.name,
   this.review,
        this.rating,
     this.image,
    });

    factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        rId: json["r_id"],
        email: json["email"],
        name: json["name"],
        review: json["review"],
        rating: json["rating"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "r_id": rId,
        "email": email,
        "name": name,
        "review": review,
        "rating": rating,
        "image": image,
    };
}
