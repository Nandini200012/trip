import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String> postcommentApi(
  String review,
  String pid,String user,
  String pname,String email
) async {
  print("postcommentApi");

  var url = Uri.parse('https://gotodestination.in/api/add_review_for_holiday_package.php');

  try {
    var response =
        await http.post(url, body: {'p_id': pid, 'review': review,'package_name':pname,"email":email, 'user_name':user});

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print('addcommentAp: $data');
      // CommentObj obj = CommentObj.fromJson(jsonDecode(data));
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
