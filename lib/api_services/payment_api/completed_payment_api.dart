import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';

Future<String> completedPaymentAPI(String p_id) async {
  print("getHolidayreviewsAPI  ");
  var url = Uri.parse('https://gotodestination.in/api/get_successful_payments.php');
      // 'https://gotodestination.in/api/get_payments_by_id.php?id=$p_id');
      printWhite("url:$url");

  try {
    final response = await http.get(url);
    print(response.statusCode.toString());
    // print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
    //  printWhite('response:${response.body}');

      var decodedData = jsonDecode(data);
      // printWhite("byid: $data");
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



// To parse this JSON data, do
//
//     final successPayments = successPaymentsFromJson(jsonString);


class SuccessPayments {
    String errorCode;
    ErrorMessage errorMessage;
    List<SuccessPaymentData> data;

    SuccessPayments({
         this.errorCode,
         this.errorMessage,
         this.data,
    });

    factory SuccessPayments.fromJson(Map<String, dynamic> json) => SuccessPayments(
        errorCode: json["error_code"],
        errorMessage: errorMessageValues.map[json["error_message"]]  ,
        data: List<SuccessPaymentData>.from(json["data"].map((x) => SuccessPaymentData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessageValues.reverse[errorMessage],
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class SuccessPaymentData {
    String tid;
    String uId;
    String userType;
    String orderId;
    String amount;
    String trakingId;
    String status;
    String message;
    String billingName;
    String billingAddress;
    String billingZip;
    String billingCity;
    String billingState;
    String billingCountry;
    String billingTel;
    String billingEmail;
    String paymentDate;
    String packageId;
    String userId;
    String blockKey;
    String bookingId;
    String requirePaxPricing;
    // List<Package> package;

    SuccessPaymentData({
         this.tid,
         this.uId,
         this.userType,
         this.orderId,
         this.amount,
         this.trakingId,
         this.status,
         this.message,
         this.billingName,
         this.billingAddress,
         this.billingZip,
         this.billingCity,
         this.billingState,
         this.billingCountry,
         this.billingTel,
         this.billingEmail,
         this.paymentDate,
         this.packageId,
         this.userId,
         this.blockKey,
         this.bookingId,
         this.requirePaxPricing,
        //  this.package,
    });

    factory SuccessPaymentData.fromJson(Map<String, dynamic> json) => SuccessPaymentData(
        tid: json["tid"],
        uId: json["u_id"],
        userType:json["user_type"],
        //  userTypeValues.map[json["user_type"]]  ,
        orderId: json["order_id"],
        amount: json["amount"],
        trakingId: json["traking_id"],
        status: json["status"]  ,
        message: json["message"]  ,
        billingName: json["billing_name"]  ,
        billingAddress: json["billing_address"] ,
        billingZip: json["billing_zip"],
        billingCity: json["billing_city"],
        billingState: json["billing_state"]  ,
        billingCountry:json["billing_country"]  ,
        billingTel: json["billing_tel"],
        billingEmail: json["billing_email"]  ,
        paymentDate: (json["payment_date"]),
        packageId: json["package_id"],
        userId: json["user_id"],
        blockKey: json["block_key"],
        bookingId: json["booking_id"],
        requirePaxPricing: json["require_pax_pricing"],
        // package: List<Package>.from(json["package"].map((x) => Package.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "tid": tid,
        "u_id": uId,
        "user_type": userTypeValues.reverse[userType],
        "order_id": orderId,
        "amount": amount,
        "traking_id": trakingId,
        "status": errorMessageValues.reverse[status],
        "message": messageValues.reverse[message],
        "billing_name": billingNameValues.reverse[billingName],
        "billing_address": billingAddressValues.reverse[billingAddress],
        "billing_zip": billingZip,
        "billing_city": billingCityValues.reverse[billingCity],
        "billing_state": billingStateValues.reverse[billingState],
        "billing_country": billingCountryValues.reverse[billingCountry],
        "billing_tel": billingTel,
        "billing_email": billingEmailValues.reverse[billingEmail],
        "payment_date": paymentDate,
        "package_id": packageId,
        "user_id": userId,
        "block_key": blockKey,
        "booking_id": bookingId,
        "require_pax_pricing": requirePaxPricing,
        // "package": List<dynamic>.from(package.map((x) => x.toJson())),
    };
}

enum BillingAddress {
    KERALA
}

final billingAddressValues = EnumValues({
    "kerala": BillingAddress.KERALA
});

enum BillingCity {
    PALAKKAD
}

final billingCityValues = EnumValues({
    "palakkad": BillingCity.PALAKKAD
});

enum BillingCountry {
    INDIA
}

final billingCountryValues = EnumValues({
    "India": BillingCountry.INDIA
});

enum BillingEmail {
    NANDHININATARAJAN04
}

final billingEmailValues = EnumValues({
    "nandhininatarajan04@": BillingEmail.NANDHININATARAJAN04
});

enum BillingName {
    DEMO,
    NANDINI
}

final billingNameValues = EnumValues({
    "demo": BillingName.DEMO,
    "nandini": BillingName.NANDINI
});

enum BillingState {
    MAHARASHTRA
}

final billingStateValues = EnumValues({
    "Maharashtra": BillingState.MAHARASHTRA
});

enum Message {
    TRANSACTION_SUCCESSFUL_NA_0
}

final messageValues = EnumValues({
    "Transaction Successful-NA-0": Message.TRANSACTION_SUCCESSFUL_NA_0
});

class Package {
    String pId;
    Name name;
    Category category;
    String packagePrice;

    Package({
         this.pId,
         this.name,
         this.category,
         this.packagePrice,
    });

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        pId: json["p_id"],
        name: nameValues.map[json["name"]]  ,
        category: categoryValues.map[json["category"]]  ,
        packagePrice: json["package_price"],
    );

    Map<String, dynamic> toJson() => {
        "p_id": pId,
        "name": nameValues.reverse[name],
        "category": categoryValues.reverse[category],
        "package_price": packagePrice,
    };
}

enum Category {
    COUPLE
}

final categoryValues = EnumValues({
    "Couple": Category.COUPLE
});

enum Name {
    U_TESTING
}

final nameValues = EnumValues({
    "U-testing": Name.U_TESTING
});

enum ErrorMessage {
    SUCCESS
}

final errorMessageValues = EnumValues({
    "Success": ErrorMessage.SUCCESS
});

enum UserType {
    ACTIVITIES,
    HOLIDAY_PACKAGES,
    USER_TYPE,
    USER_TYPE_ACTIVITIES
}

final userTypeValues = EnumValues({
    "Activities": UserType.ACTIVITIES,
    "Holiday_packages": UserType.HOLIDAY_PACKAGES,
    "userType": UserType.USER_TYPE,
    "\"Activities\"": UserType.USER_TYPE_ACTIVITIES
});

class EnumValues<T> {
    Map<String, T> map;
     Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}









// class SuccessPayments {
//     String errorCode;
//     String message;
//     List<SuccessPaymentData> data;

//     SuccessPayments({
//            this.errorCode,
//            this.message,
//            this.data,
//     });

//     factory SuccessPayments.fromJson(Map<String, dynamic> json) => SuccessPayments(
//         errorCode: json["error_code"],
//         message: json["message"],
//         data: List<SuccessPaymentData>.from(json["data"].map((x) => SuccessPaymentData.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "error_code": errorCode,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class SuccessPaymentData {
//     String tid;
//     String uId;
//     String userType;
//     String orderId;
//     String amount;
//     String trakingId;
//     String status;
//     String message;
//     String billingName;
//     String billingAddress;
//     String billingZip;
//     String billingCity;
//     String billingState;
//     String billingCountry;
//     String billingTel;
//     String billingEmail;
//     DateTime paymentDate;
//     String packageId;
//     String userId;

//     SuccessPaymentData({
//            this.tid,
//            this.uId,
//            this.userType, 
//            this.orderId,
//            this.amount,
//            this.trakingId,
//            this.status,
//            this.message,
//            this.billingName,
//            this.billingAddress,
//            this.billingZip,
//            this.billingCity,
//            this.billingState,
//            this.billingCountry,
//            this.billingTel,
//            this.billingEmail,
//            this.paymentDate,
//            this.packageId,
//            this.userId,
//     });

//     factory SuccessPaymentData.fromJson(Map<String, dynamic> json) => SuccessPaymentData(
//         tid: json["tid"],
//         uId: json["u_id"],
//         userType: json["user_type"],
//         orderId: json["order_id"],
//         amount: json["amount"],
//         trakingId: json["traking_id"],
//         status: json["status"],
//         message: json["message"],
//         billingName: json["billing_name"],
//         billingAddress: json["billing_address"],
//         billingZip: json["billing_zip"],
//         billingCity: json["billing_city"],
//         billingState: json["billing_state"],
//         billingCountry: json["billing_country"],
//         billingTel: json["billing_tel"],
//         billingEmail: json["billing_email"],
//         paymentDate: DateTime.parse(json["payment_date"]),
//         packageId: json["package_id"],
//         userId: json["user_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "tid": tid,
//         "u_id": uId,
//         "user_type": userType,
//         "order_id": orderId,
//         "amount": amount,
//         "traking_id": trakingId,
//         "status": status,
//         "message": message,
//         "billing_name": billingName,
//         "billing_address": billingAddress,
//         "billing_zip": billingZip,
//         "billing_city": billingCity,
//         "billing_state": billingState,
//         "billing_country": billingCountry,
//         "billing_tel": billingTel,
//         "billing_email": billingEmail,
//         "payment_date": paymentDate.toIso8601String(),
//         "package_id": packageId,
//         "user_id": userId,
//     };
// }
