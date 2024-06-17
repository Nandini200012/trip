import 'dart:convert';

Flighttype FlighttypeFromJson(String str) =>
    Flighttype.fromJson(json.decode(str));

String FlighttypeToJson(Flighttype data) => json.encode(data.toJson());

class Flighttype {
  String errorCode;
  String message;
  List<flightData> data;

  Flighttype({
    this.errorCode,
    this.message,
    this.data,
  });

  factory Flighttype.fromJson(Map<String, dynamic> json) => Flighttype(
        errorCode: json["error_code"],
        message: json["message"],
        data: json["data"] != null
            ? List<flightData>.from(json["data"].map((x) => flightData.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": data != null ? List<dynamic>.from(data.map((x) => x.toJson())) : null,
      };
}

class flightData {
  String   uId;
  String   userType;
  String   orderId;
  String   amount;
  String   trackingId;
  String   status;
  String   message;
  String   billingName;
  String   billingAddress;
  String   billingZip;
  String   billingCity;
  String   billingState;
  String   billingCountry;
  String   billingTel;
  String   billingEmail;
  DateTime   paymentDate;
  String   bookingId;

  flightData({
    this.uId,
    this.userType,
    this.orderId,
    this.amount,
    this.trackingId,
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
    this.bookingId,
  });

  factory flightData.fromJson(Map<String, dynamic> json) => flightData(
        uId: json["u_id"],
        userType: json["user_type"],
        orderId: json["order_id"],
        amount: json["amount"],
        trackingId: json["tracking_id"],
        status: json["status"],
        message: json["message"],
        billingName: json["billing_name"],
        billingAddress: json["billing_address"],
        billingZip: json["billing_zip"],
        billingCity: json["billing_city"],
        billingState: json["billing_state"],
        billingCountry: json["billing_country"],
        billingTel: json["billing_tel"],
        billingEmail: json["billing_email"],
        paymentDate: json["payment_date"] != null
            ? DateTime.parse(json["payment_date"])
            : null,
        bookingId: json["booking_id"],
      );

  Map<String, dynamic> toJson() => {
        "u_id": uId,
        "user_type": userType,
        "order_id": orderId,
        "amount": amount,
        "tracking_id": trackingId,
        "status": status,
        "message": message,
        "billing_name": billingName,
        "billing_address": billingAddress,
        "billing_zip": billingZip,
        "billing_city": billingCity,
        "billing_state": billingState,
        "billing_country": billingCountry,
        "billing_tel": billingTel,
        "billing_email": billingEmail,
        "payment_date": paymentDate?.toIso8601String(),
        "booking_id": bookingId,
      };
}
