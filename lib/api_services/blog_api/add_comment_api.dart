import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> addcommentApi(
  String comment,
  String id,
  String name,String email
) async {
  print("addcommentApi");

  var url = Uri.parse('https://gotodestination.in/api/add_blog_comment.php');

  try {
    var response =
        await http.post(url, body: {'blog_id': id, 'comment': comment,'name':name,"email":email});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print('addcommentAp: $data');
      CommentObj obj = CommentObj.fromJson(jsonDecode(data));
      return obj.errorMessage;
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

class CommentObj {
  String errorCode;
  String errorMessage;

  CommentObj({
    this.errorCode,
    this.errorMessage,
  });

  factory CommentObj.fromJson(Map<String, dynamic> json) => CommentObj(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
      };
}
