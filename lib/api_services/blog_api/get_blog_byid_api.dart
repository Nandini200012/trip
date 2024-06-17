import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<Blog> getblogByidApi(id) async {
  var url = Uri.parse(
      'https://gotodestination.in/api/get_blog_details_by_bid.php?bid=$id');
  print(url);
  try {
    final response = await http.get(url);
    print('getblogByidApi res:${response.statusCode}');
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      return Blog.fromJson(decodedData);
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

class Blog {
  String errorCode;
  String errorMessage;
  List<BlogDatum> data;

  Blog({
    this.errorCode,
    this.errorMessage,
    this.data,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        data: List<BlogDatum>.from(
            json["Data"].map((x) => BlogDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BlogDatum {
  String bId;
  String blogName;
  String description;
  String images;

  BlogDatum({
    this.bId,
    this.blogName,
    this.description,
    this.images,
  });

  factory BlogDatum.fromJson(Map<String, dynamic> json) => BlogDatum(
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
