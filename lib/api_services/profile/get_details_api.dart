import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';

Future<String> getDetailsAPI(String uid) async {
  print("getDetailsAPI");
  var url = Uri.parse(
      'https://gotodestination.in/api/get_user_details_by_id.php?id=$uid');

  try {
    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      // print('holidayPackagesAPI res');

      var decodedData = jsonDecode(data);
      // printWhite("Holiday all: $data");
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


class Profileobj {
    String errorCode;
    String message;
    List<profileData> data;

    Profileobj({
           this.errorCode,
           this.message,
           this.data,
    });

    factory Profileobj.fromJson(Map<String, dynamic> json) => Profileobj(
        errorCode: json["error_code"],
        message: json["message"],
        data: List<profileData>.from(json["data"].map((x) => profileData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class profileData {
    String srNo;
    String name;
    String mobile;
    String email;
    String gender;
    String dob;
    String address;
    String pincode;
    String state;
    String password;

    profileData({
           this.srNo,
           this.name,
           this.mobile,
           this.email,
           this.gender,
           this.dob,
           this.address,
           this.pincode,
           this.state,
           this.password,
    });

    factory profileData.fromJson(Map<String, dynamic> json) => profileData(
        srNo: json["sr_no"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        gender: json["gender"],
        dob: json["dob"],
        address: json["address"],
        pincode: json["pincode"],
        state: json["state"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "sr_no": srNo,
        "name": name,
        "mobile": mobile,
        "email": email,
        "gender": gender,
        "dob": dob,
        "address": address,
        "pincode": pincode,
        "state": state,
        "password": password,
    };
}
