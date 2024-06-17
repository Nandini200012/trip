
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


Future<String> getTidAPI({String block_key}) async {
  print("getTidAPI");
  print("blkkey: $block_key");

  var url = Uri.parse('https://gotodestination.in/api/get_bus_booking.php?block_id=$block_key');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      
      if (decodedData["error_code"] != '200') {
             print("getTidAPI null: ${response.body}");
        return 'null';
      } else {
        print("getTidAPI success: ${response.body}");
        return data;
      }
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


// Future<String> getTidAPI({String block_key}) async {
//   print("getTidAPI");
//   print("blkkey:$block_key ");

//   var url = Uri.parse(
//       'http://gotodestination.in/api/get_bus_booking.php?block_id=$block_key');

//   try {
//     final response = await http.get(url);

//     // print(response.statusCode);
//     // print(response.body);

//     if (response.statusCode == 200) {
//       String data = response.body;
//       print("getTidAPI");
//       print("getTidAPI:${response.body}");
//       var decodedData = jsonDecode(data);
//       if(response.body["error_code"]!='200'){
//         return 'failed';
//       }else
//       return data;
//     } else {
//       return 'failed';
//     }
//   } on http.ClientException catch (e) {
//     print('HTTP client error: $e');
//     return 'failed';
//   } on SocketException catch (e) {
//     print('Socket error: $e');
//     return 'failed';
//   } catch (e) {
//     print('Error: $e');
//     return 'failed';
//   }
// }

class TicketModel {
  String errorCode;
  String errorMessage;
  List<TicketData> data;

  TicketModel({
    this.errorCode,
    this.errorMessage,
    this.data,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        data: List<TicketData>.from(
            json["Data"].map((x) => TicketData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TicketData {
  String busBookingId;
  String departureCity;
  String arrivalCity;
  String tid;
  String blockId;
  String orderId;
  String boardingPoint;
  String droppingPoint;
  String userId;
  String username;
  String noOfTravellers;
  String seatNumbers;
  String bookingDetailsSentTo;
  String bookingDate;
  String paymentDate;
  String travellerName;
  String totalAmount;
  String paidAmount;

  TicketData({
    this.busBookingId,
    this.departureCity,
    this.arrivalCity,
    this.tid,
    this.blockId,
    this.orderId,
    this.boardingPoint,
    this.droppingPoint,
    this.userId,
    this.username,
    this.noOfTravellers,
    this.seatNumbers,
    this.bookingDetailsSentTo,
    this.bookingDate,
    this.paymentDate,
    this.travellerName,
    this.totalAmount,
    this.paidAmount,
  });

  factory TicketData.fromJson(Map<String, dynamic> json) => TicketData(
        busBookingId: json["bus_booking_id"],
        departureCity: json["departureCity"],
        arrivalCity: json["arrivalCity"],
        tid: json["tid"],
        blockId: json["block_id"],
        orderId: json["order_id"],
        boardingPoint: json["boardingPoint"],
        droppingPoint: json["droppingPoint"],
        userId: json["user_Id"],
        username: json["username"],
        noOfTravellers: json["no_of_travellers"],
        seatNumbers: json["seat_numbers"],
        bookingDetailsSentTo: json["booking_details_sent_to"],
        bookingDate: json["booking_date"],
        paymentDate: json["payment_date"],
        travellerName: json["traveller_name"],
        totalAmount: json["total_amount"],
        paidAmount: json["paid_amount"],
      );

  Map<String, dynamic> toJson() => {
        "bus_booking_id": busBookingId,
        "departureCity": departureCity,
        "arrivalCity": arrivalCity,
        "tid": tid,
        "block_id": blockId,
        "order_id": orderId,
        "boardingPoint": boardingPoint,
        "droppingPoint": droppingPoint,
        "user_Id": userId,
        "username": username,
        "no_of_travellers": noOfTravellers,
        "seat_numbers": seatNumbers,
        "booking_details_sent_to": bookingDetailsSentTo,
        "booking_date": bookingDate,
        "payment_date": paymentDate,
        "traveller_name": travellerName,
        "total_amount": totalAmount,
        "paid_amount": paidAmount,
      };
}
