import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<allCommentObj> getcommentsAPI(id) async {
  print("getcommentsAPI id: $id");

  var url = Uri.parse(
      'https://gotodestination.in/api/get_comment_by_bid.php?blog_id=$id');
  print(url);
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      print('res:$data');
      return allCommentObj.fromJson(decodedData);
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



class allCommentObj {
    String errorCode;
    String message;
    List<Comments> data;

    allCommentObj({
          this.errorCode,
          this.message,
          this.data,
    });

    factory allCommentObj.fromJson(Map<String, dynamic> json) => allCommentObj(
        errorCode: json["error_code"],
        message: json["message"],
        data: List<Comments>.from(json["data"].map((x) => Comments.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Comments {
    String id;
    String bId;
    String name;
    String email;
    String comment;

    Comments({
          this.id,
          this.bId,
          this.name,
          this.email,
          this.comment,
    });

    factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        id: json["id"],
        bId: json["b_id"],
        name: json["name"],
        email: json["email"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "b_id": bId,
        "name": name,
        "email": email,
        "comment": comment,
    };
}
