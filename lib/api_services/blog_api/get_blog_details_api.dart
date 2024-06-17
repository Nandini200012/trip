import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<BlogObj> getblog() async {
  var url = Uri.parse('https://gotodestination.in/api/get_blog_details.php');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      print('res:$data');
      return BlogObj.fromJson(decodedData);
      // return decodedData;
      // return activityobj.fromJson(decodedData);
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

class BlogObj {
  String errorCode;
  String errorMessage;
  List<Datum> data;

  BlogObj({
    this.errorCode,
    this.errorMessage,
    this.data,
  });

  factory BlogObj.fromJson(Map<String, dynamic> json) => BlogObj(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String bId;
  String blogName;
  String description;
  String images;

  Datum({
    this.bId,
    this.blogName,
    this.description,
    this.images,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bId: json["b_id"],
        blogName: json["blog_name"],
        description: json["description"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "b_id": bId,
        "blog_name": blogName,
        "description": description,
        "images": images,
      };
}
