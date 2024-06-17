import 'dart:io';
import 'package:http/http.dart' as http;

Future<String> addDetailsAPI(
    String id, String gender, address, dob, pincode, state) async {
  print("addDetailsApi");

  var url = Uri.parse('https://gotodestination.in/api/add_user_details.php');

  try {
    var response = await http.post(url, body: {
      'id': id,
      'gender': gender,
      'address': address,
      'dob': "",
      'pincode': pincode,
      'state': state
    });

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


class Profilepostobj {
    String errorCode;
    String errorMessage;

    Profilepostobj({
           this.errorCode,
           this.errorMessage,
    });

    factory Profilepostobj.fromJson(Map<String, dynamic> json) => Profilepostobj(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
    };
}
