import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:oauth1/oauth1.dart' as oauth1;

import '../../common/print_funtions.dart';

Future<String> tripDetailsapi(id) async {
  print("trip Details api");
  print("id:$id");
  var url = Uri.parse('http://api.seatseller.travel/tripdetails?id=$id');
  final consumerKey = 'MCycaVxF6XVV0ImKgqFPBAncx0prPp';
  final consumerSecret = '5f0lpy9heMvXNQ069lQPNMomysX6rt';
  final token = "";
  final tokenSecret = "";
  final oauthClient = oauth1.Client(
    oauth1.SignatureMethods.hmacSha1,
    oauth1.ClientCredentials(
      consumerKey,
      consumerSecret,
    ),
    oauth1.Credentials(
      token,
      tokenSecret,
    ),
  );

  try {
    final response = await oauthClient.get(url);
    print("status code: ${response.statusCode}");
    if (response.statusCode != 200) print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print('trip Details api res');
      printred(response.body);
      var decodedData = jsonDecode(data);
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
  } finally {
    oauthClient.close();
  }
}

class TripDetailsObj {
  String availableSeats;
  String availableSingleSeat;
  List<IngTimes> boardingTimes;
  String callFareBreakUpApi;
  List<IngTimes> droppingTimes;
  List<FareDetail> fareDetails;
  String forcedSeats;
  String maxSeatsPerTicket;
  String noSeatLayoutEnabled;
  String primo;
  List<Seat> seats;
  String vaccinatedBus;
  String vaccinatedStaff;

  TripDetailsObj({
    this.availableSeats,
    this.availableSingleSeat,
    this.boardingTimes,
    this.callFareBreakUpApi,
    this.droppingTimes,
    this.fareDetails,
    this.forcedSeats,
    this.maxSeatsPerTicket,
    this.noSeatLayoutEnabled,
    this.primo,
    this.seats,
    this.vaccinatedBus,
    this.vaccinatedStaff,
  });
 factory TripDetailsObj.fromJson(Map<String, dynamic> json) {
  List<FareDetail> fareDetails = []; // Initialize fareDetails list here

  if (json['fareDetails'] != null) {
    var fareDetailsList = json['fareDetails'];
    print("fare: ${fareDetailsList}");
    if (fareDetailsList is List) {
      fareDetails =
          fareDetailsList.map((detail) => FareDetail.fromJson(detail)).toList();
    }
  }

  var boardingTimesJson = json["boardingTimes"];
  var droppingTimesJson = json["droppingTimes"];
  
  var boardingTimes = <IngTimes>[];
  var droppingTimes = <IngTimes>[];
  if (boardingTimesJson is List) {
    boardingTimes = boardingTimesJson
        .map((timeJson) => IngTimes.fromJson(timeJson))
        .toList();
  }
  if (droppingTimesJson is List) {
    droppingTimes = droppingTimesJson
        .map((timeJson) => IngTimes.fromJson(timeJson))
        .toList();
  }

  return TripDetailsObj(
    availableSeats: json["availableSeats"],
    availableSingleSeat: json["availableSingleSeat"],
    boardingTimes: boardingTimes,
    callFareBreakUpApi: json["callFareBreakUpAPI"].toString(),
    droppingTimes: droppingTimes,
    fareDetails: fareDetails,

    forcedSeats: json["forcedSeats"],
    maxSeatsPerTicket: json["maxSeatsPerTicket"],
    noSeatLayoutEnabled: json["noSeatLayoutEnabled"],
    primo: json["primo"],
    seats: List<Seat>.from(json["seats"].map((x) => Seat.fromJson(x))),
    vaccinatedBus: json["vaccinatedBus"],
    vaccinatedStaff: json["vaccinatedStaff"],
  );
}



  // factory TripDetailsObj.fromJson(Map<String, dynamic> json) => TripDetailsObj(
  // availableSeats: json["availableSeats"],
  // availableSingleSeat: json["availableSingleSeat"],
  //   print('boardingTimes JSON: ${json["boardingTimes"]}');
  // boardingTimes: IngTimes.fromJson(json["boardingTimes"]),
  // callFareBreakUpApi: json["callFareBreakUpAPI"].toString(),
  // droppingTimes: IngTimes.fromJson(json["droppingTimes"]),
  // fareDetails: List<FareDetail>.from(json["fareDetails"].map((x) => FareDetail.fromJson(x))),
  // forcedSeats: json["forcedSeats"],
  // maxSeatsPerTicket: json["maxSeatsPerTicket"],
  // noSeatLayoutEnabled: json["noSeatLayoutEnabled"],
  // primo: json["primo"],
  // seats: List<Seat>.from(json["seats"].map((x) => Seat.fromJson(x))),
  // vaccinatedBus: json["vaccinatedBus"],
  // vaccinatedStaff: json["vaccinatedStaff"],
  // );

  Map<String, dynamic> toJson() => {
        "availableSeats": availableSeats,
        "availableSingleSeat": availableSingleSeat,
        "boardingTimes": boardingTimes,
        "callFareBreakUpAPI": callFareBreakUpApi.toString(),
        "droppingTimes": droppingTimes,
        "fareDetails": List<dynamic>.from(fareDetails.map((x) => x.toJson())),
        "forcedSeats": forcedSeats,
        "maxSeatsPerTicket": maxSeatsPerTicket,
        "noSeatLayoutEnabled": noSeatLayoutEnabled,
        "primo": primo,
        "seats": List<dynamic>.from(seats.map((x) => x.toJson())),
        "vaccinatedBus": vaccinatedBus,
        "vaccinatedStaff": vaccinatedStaff,
      };
}

class IngTimes {
  String address;
  String bpId;
  String bpName;
  String city;
  String cityId;
  String contactNumber;
  String landmark;
  String location;
  String locationId;
  String prime;
  String time;

  IngTimes({
    this.address,
    this.bpId,
    this.bpName,
    this.city,
    this.cityId,
    this.contactNumber,
    this.landmark,
    this.location,
    this.locationId,
    this.prime,
    this.time,
  });

  factory IngTimes.fromJson(Map<String, dynamic> json) => IngTimes(
        address: json["address"],
        bpId: json["bpId"],
        bpName: json["bpName"],
        city: json["city"],
        cityId: json["cityId"],
        contactNumber: json["contactNumber"],
        landmark: json["landmark"],
        location: json["location"],
        locationId: json["locationId"],
        prime: json["prime"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "bpId": bpId,
        "bpName": bpName,
        "city": city,
        "cityId": cityId,
        "contactNumber": contactNumber,
        "landmark": landmark,
        "location": location,
        "locationId": locationId,
        "prime": prime,
        "time": time,
      };
}

class FareDetail {
  String bankTrexAmt;
  String baseFare;
  String bookingFee;
  String childFare;
  String gst;
  String levyFare;
  String markupFareAbsolute;
  String markupFarePercentage;
  String opFare;
  String opGroupFare;
  String operatorServiceChargeAbsolute;
  String operatorServiceChargePercentage;
  String serviceCharge;
  String serviceTaxAbsolute;
  String serviceTaxPercentage;
  String srtFee;
  String tollFee;
  String totalFare; // Corrected spelling

  FareDetail({
    this.bankTrexAmt,
    this.baseFare,
    this.bookingFee,
    this.childFare,
    this.gst,
    this.levyFare,
    this.markupFareAbsolute,
    this.markupFarePercentage,
    this.opFare,
    this.opGroupFare,
    this.operatorServiceChargeAbsolute,
    this.operatorServiceChargePercentage,
    this.serviceCharge,
    this.serviceTaxAbsolute,
    this.serviceTaxPercentage,
    this.srtFee,
    this.tollFee,
    this.totalFare, // Corrected spelling
  });

  factory FareDetail.fromJson(Map<String, dynamic> json) => FareDetail(
        bankTrexAmt: json["bankTrexAmt"],
        baseFare: json["baseFare"],
        bookingFee: json["bookingFee"],
        childFare: json["childFare"],
        gst: json["gst"],
        levyFare: json["levyFare"],
        markupFareAbsolute: json["markupFareAbsolute"],
        markupFarePercentage: json["markupFarePercentage"],
        opFare: json["opFare"],
        opGroupFare: json["opGroupFare"],
        operatorServiceChargeAbsolute: json["operatorServiceChargeAbsolute"],
        operatorServiceChargePercentage:
            json["operatorServiceChargePercentage"],
        serviceCharge: json["serviceCharge"],
        serviceTaxAbsolute: json["serviceTaxAbsolute"],
        serviceTaxPercentage: json["serviceTaxPercentage"],
        srtFee: json["srtFee"],
        tollFee: json["tollFee"],
        totalFare: json["totalFare"], // Corrected spelling
      );

  Map<String, dynamic> toJson() => {
        "bankTrexAmt": bankTrexAmt,
        "baseFare": baseFare,
        "bookingFee": bookingFee,
        "childFare": childFare,
        "gst": gst,
        "levyFare": levyFare,
        "markupFareAbsolute": markupFareAbsolute,
        "markupFarePercentage": markupFarePercentage,
        "opFare": opFare,
        "opGroupFare": opGroupFare,
        "operatorServiceChargeAbsolute": operatorServiceChargeAbsolute,
        "operatorServiceChargePercentage": operatorServiceChargePercentage,
        "serviceCharge": serviceCharge,
        "serviceTaxAbsolute": serviceTaxAbsolute,
        "serviceTaxPercentage": serviceTaxPercentage,
        "srtFee": srtFee,
        "tollFee": tollFee,
        "totalFare": totalFare, // Corrected spelling
      };
}

// class FareDetail {
//   String bankTrexAmt;
//   String baseFare;
//   String bookingFee;
//   String childFare;
//   String gst;
//   String levyFare;
//   String markupFareAbsolute;
//   String markupFarePercentage;
//   String opFare;
//   String opGroupFare;
//   String operatorServiceChargeAbsolute;
//   String operatorServiceChargePercentage;
//   String serviceCharge;
//   String serviceTaxAbsolute;
//   String serviceTaxPercentage;
//   String srtFee;
//   String tollFee;
//   String totallFare;

//   FareDetail({
//     this.bankTrexAmt,
//     this.baseFare,
//     this.bookingFee,
//     this.childFare,
//     this.gst,
//     this.levyFare,
//     this.markupFareAbsolute,
//     this.markupFarePercentage,
//     this.opFare,
//     this.opGroupFare,
//     this.operatorServiceChargeAbsolute,
//     this.operatorServiceChargePercentage,
//     this.serviceCharge,
//     this.serviceTaxAbsolute,
//     this.serviceTaxPercentage,
//     this.srtFee,
//     this.tollFee,
//     this.totallFare,
//   });

//   factory FareDetail.fromJson(Map<String, dynamic> json) => FareDetail(
//         bankTrexAmt: json["bankTrexAmt"],
//         baseFare: json["baseFare"],
//         bookingFee: json["bookingFee"],
//         childFare: json["childFare"],
//         gst: json["gst"],
//         levyFare: json["levyFare"],
//         markupFareAbsolute: json["markupFareAbsolute"],
//         markupFarePercentage: json["markupFarePercentage"],
//         opFare: json["opFare"],
//         opGroupFare: json["opGroupFare"],
//         operatorServiceChargeAbsolute: json["operatorServiceChargeAbsolute"],
//         operatorServiceChargePercentage:
//             json["operatorServiceChargePercentage"],
//         serviceCharge: json["serviceCharge"],
//         serviceTaxAbsolute: json["serviceTaxAbsolute"],
//         serviceTaxPercentage: json["serviceTaxPercentage"],
//         srtFee: json["srtFee"],
//         tollFee: json["tollFee"],
//         totallFare: json["totalFare"],
//       );

//   Map<String, dynamic> toJson() => {
//         "bankTrexAmt": bankTrexAmt,
//         "baseFare": baseFare,
//         "bookingFee": bookingFee,
//         "childFare": childFare,
//         "gst": gst,
//         "levyFare": levyFare,
//         "markupFareAbsolute": markupFareAbsolute,
//         "markupFarePercentage": markupFarePercentage,
//         "opFare": opFare,
//         "opGroupFare": opGroupFare,
//         "operatorServiceChargeAbsolute": operatorServiceChargeAbsolute,
//         "operatorServiceChargePercentage": operatorServiceChargePercentage,
//         "serviceCharge": serviceCharge,
//         "serviceTaxAbsolute": serviceTaxAbsolute,
//         "serviceTaxPercentage": serviceTaxPercentage,
//         "srtFee": srtFee,
//         "tollFee": tollFee,
//         "totalFare": totallFare,
//       };
// }

class Seat {
  String available;
  String baseFare;
  String column;
  String doubleBirth;
  String fare;
  String ladiesSeat;
  String length;
  String malesSeat;
  String markupFareAbsolute;
  String markupFarePercentage;
  String name;
  String operatorServiceChargeAbsolute;
  String operatorServiceChargePercent;
  String reservedForSocialDistancing;
  String row;
  String serviceTaxAbsolute;
  String serviceTaxPercentage;
  String width;
  String zIndex;

  Seat({
    this.available,
    this.baseFare,
    this.column,
    this.doubleBirth,
    this.fare,
    this.ladiesSeat,
    this.length,
    this.malesSeat,
    this.markupFareAbsolute,
    this.markupFarePercentage,
    this.name,
    this.operatorServiceChargeAbsolute,
    this.operatorServiceChargePercent,
    this.reservedForSocialDistancing,
    this.row,
    this.serviceTaxAbsolute,
    this.serviceTaxPercentage,
    this.width,
    this.zIndex,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        available: json["available"],
        baseFare: json["baseFare"],
        column: json["column"],
        doubleBirth: json["doubleBirth"],
        fare: json["fare"],
        ladiesSeat: json["ladiesSeat"],
        length: json["length"],
        malesSeat: json["malesSeat"],
        markupFareAbsolute: json["markupFareAbsolute"],
        markupFarePercentage: json["markupFarePercentage"],
        name: json["name"],
        operatorServiceChargeAbsolute: json["operatorServiceChargeAbsolute"],
        operatorServiceChargePercent: json["operatorServiceChargePercent"],
        reservedForSocialDistancing: json["reservedForSocialDistancing"],
        row: json["row"],
        serviceTaxAbsolute: json["serviceTaxAbsolute"],
        serviceTaxPercentage: json["serviceTaxPercentage"],
        width: json["width"],
        zIndex: json["zIndex"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "baseFare": baseFare,
        "column": column,
        "doubleBirth": doubleBirth,
        "fare": fare,
        "ladiesSeat": ladiesSeat,
        "length": length,
        "malesSeat": malesSeat,
        "markupFareAbsolute": markupFareAbsolute,
        "markupFarePercentage": markupFarePercentage,
        "name": name,
        "operatorServiceChargeAbsolute": operatorServiceChargeAbsolute,
        "operatorServiceChargePercent": operatorServiceChargePercent,
        "reservedForSocialDistancing": reservedForSocialDistancing,
        "row": row,
        "serviceTaxAbsolute": serviceTaxAbsolute,
        "serviceTaxPercentage": serviceTaxPercentage,
        "width": width,
        "zIndex": zIndex,
      };
}

// class TripDetailsObj {
//   String availableSeats;
//   String availableSingleSeat;
//   IngTimes boardingTimes;
//   String callFareBreakUpApi;
//   IngTimes droppingTimes;
//   FareDetails fareDetails;
//   String forcedSeats;
//   String maxSeatsPerTicket;
//   String noSeatLayoutEnabled;
//   String primo;
//   List<Seat> seats;
//   String vaccinatedBus;
//   String vaccinatedStaff;

//   TripDetailsObj({
//     this.availableSeats,
//     this.availableSingleSeat,
//     this.boardingTimes,
//     this.callFareBreakUpApi,
//     this.droppingTimes,
//     this.fareDetails,
//     this.forcedSeats,
//     this.maxSeatsPerTicket,
//     this.noSeatLayoutEnabled,
//     this.primo,
//     this.seats,
//     this.vaccinatedBus,
//     this.vaccinatedStaff,
//   });

//   factory TripDetailsObj.fromJson(Map<String, dynamic> json) => TripDetailsObj(
//         availableSeats: json["availableSeats"],
//         availableSingleSeat: json["availableSingleSeat"],
//         boardingTimes: IngTimes.fromJson(json["boardingTimes"]),
//         callFareBreakUpApi: json["callFareBreakUpAPI"],
//         droppingTimes: IngTimes.fromJson(json["droppingTimes"]),
//         fareDetails: FareDetails.fromJson(json["fareDetails"]),
//         forcedSeats: json["forcedSeats"],
//         maxSeatsPerTicket: json["maxSeatsPerTicket"],
//         noSeatLayoutEnabled: json["noSeatLayoutEnabled"],
//         primo: json["primo"],
//         seats: List<Seat>.from(json["seats"].map((x) => Seat.fromJson(x))),
//         vaccinatedBus: json["vaccinatedBus"],
//         vaccinatedStaff: json["vaccinatedStaff"],
//       );

//   Map<String, dynamic> toJson() => {
//         "availableSeats": availableSeats,
//         "availableSingleSeat": availableSingleSeat,
//         "boardingTimes": boardingTimes.toJson(),
//         "callFareBreakUpAPI": callFareBreakUpApi,
//         "droppingTimes": droppingTimes.toJson(),
//         "fareDetails": fareDetails.toJson(),
//         "forcedSeats": forcedSeats,
//         "maxSeatsPerTicket": maxSeatsPerTicket,
//         "noSeatLayoutEnabled": noSeatLayoutEnabled,
//         "primo": primo,
//         "seats": List<dynamic>.from(seats.map((x) => x.toJson())),
//         "vaccinatedBus": vaccinatedBus,
//         "vaccinatedStaff": vaccinatedStaff,
//       };
// }

// class IngTimes {
//   String address;
//   String bpId;
//   String bpName;
//   String city;
//   String cityId;
//   String contactNumber;
//   String landmark;
//   String location;
//   String locationId;
//   String prime;
//   String time;

//   IngTimes({
//     this.address,
//     this.bpId,
//     this.bpName,
//     this.city,
//     this.cityId,
//     this.contactNumber,
//     this.landmark,
//     this.location,
//     this.locationId,
//     this.prime,
//     this.time,
//   });

//   factory IngTimes.fromJson(Map<String, dynamic> json) => IngTimes(
//         address: json["address"],
//         bpId: json["bpId"],
//         bpName: json["bpName"],
//         city: json["city"],
//         cityId: json["cityId"],
//         contactNumber: json["contactNumber"],
//         landmark: json["landmark"],
//         location: json["location"],
//         locationId: json["locationId"],
//         prime: json["prime"],
//         time: json["time"],
//       );

//   Map<String, dynamic> toJson() => {
//         "address": address,
//         "bpId": bpId,
//         "bpName": bpName,
//         "city": city,
//         "cityId": cityId,
//         "contactNumber": contactNumber,
//         "landmark": landmark,
//         "location": location,
//         "locationId": locationId,
//         "prime": prime,
//         "time": time,
//       };
// }

// class FareDetails {
//   String bankTrexAmt;
//   String baseFare;
//   String bookingFee;
//   String childFare;
//   String gst;
//   String levyFare;
//   String markupFareAbsolute;
//   String markupFarePercentage;
//   String opFare;
//   String opGroupFare;
//   String operatorServiceChargeAbsolute;
//   String operatorServiceChargePercentage;
//   String serviceCharge;
//   String serviceTaxAbsolute;
//   String serviceTaxPercentage;
//   String srtFee;
//   String tollFee;
//   String totalFare;

//   FareDetails({
//     this.bankTrexAmt,
//     this.baseFare,
//     this.bookingFee,
//     this.childFare,
//     this.gst,
//     this.levyFare,
//     this.markupFareAbsolute,
//     this.markupFarePercentage,
//     this.opFare,
//     this.opGroupFare,
//     this.operatorServiceChargeAbsolute,
//     this.operatorServiceChargePercentage,
//     this.serviceCharge,
//     this.serviceTaxAbsolute,
//     this.serviceTaxPercentage,
//     this.srtFee,
//     this.tollFee,
//     this.totalFare,
//   });

//   factory FareDetails.fromJson(Map<String, dynamic> json) => FareDetails(
//         bankTrexAmt: json["bankTrexAmt"],
//         baseFare: json["baseFare"],
//         bookingFee: json["bookingFee"],
//         childFare: json["childFare"],
//         gst: json["gst"],
//         levyFare: json["levyFare"],
//         markupFareAbsolute: json["markupFareAbsolute"],
//         markupFarePercentage: json["markupFarePercentage"],
//         opFare: json["opFare"],
//         opGroupFare: json["opGroupFare"],
//         operatorServiceChargeAbsolute: json["operatorServiceChargeAbsolute"],
//         operatorServiceChargePercentage:
//             json["operatorServiceChargePercentage"],
//         serviceCharge: json["serviceCharge"],
//         serviceTaxAbsolute: json["serviceTaxAbsolute"],
//         serviceTaxPercentage: json["serviceTaxPercentage"],
//         srtFee: json["srtFee"],
//         tollFee: json["tollFee"],
//         totalFare: json["totalFare"],
//       );

//   Map<String, dynamic> toJson() => {
//         "bankTrexAmt": bankTrexAmt,
//         "baseFare": baseFare,
//         "bookingFee": bookingFee,
//         "childFare": childFare,
//         "gst": gst,
//         "levyFare": levyFare,
//         "markupFareAbsolute": markupFareAbsolute,
//         "markupFarePercentage": markupFarePercentage,
//         "opFare": opFare,
//         "opGroupFare": opGroupFare,
//         "operatorServiceChargeAbsolute": operatorServiceChargeAbsolute,
//         "operatorServiceChargePercentage": operatorServiceChargePercentage,
//         "serviceCharge": serviceCharge,
//         "serviceTaxAbsolute": serviceTaxAbsolute,
//         "serviceTaxPercentage": serviceTaxPercentage,
//         "srtFee": srtFee,
//         "tollFee": tollFee,
//         "totalFare": totalFare,
//       };
// }

// class Seat {
//   String available;
//   String baseFare;
//   String column;
//   String doubleBirth;
//   String fare;
//   String ladiesSeat;
//   String length;
//   String malesSeat;
//   String markupFareAbsolute;
//   String markupFarePercentage;
//   String name;
//   String operatorServiceChargeAbsolute;
//   String operatorServiceChargePercent;
//   String reservedForSocialDistancing;
//   String row;
//   String serviceTaxAbsolute;
//   String serviceTaxPercentage;
//   String width;
//   String zIndex;

//   Seat({
//     this.available,
//     this.baseFare,
//     this.column,
//     this.doubleBirth,
//     this.fare,
//     this.ladiesSeat,
//     this.length,
//     this.malesSeat,
//     this.markupFareAbsolute,
//     this.markupFarePercentage,
//     this.name,
//     this.operatorServiceChargeAbsolute,
//     this.operatorServiceChargePercent,
//     this.reservedForSocialDistancing,
//     this.row,
//     this.serviceTaxAbsolute,
//     this.serviceTaxPercentage,
//     this.width,
//     this.zIndex,
//   });

//   factory Seat.fromJson(Map<String, dynamic> json) => Seat(
//         available: json["available"],
//         baseFare: json["baseFare"],
//         column: json["column"],
//         doubleBirth: json["doubleBirth"],
//         fare: json["fare"],
//         ladiesSeat: json["ladiesSeat"],
//         length: json["length"],
//         malesSeat: json["malesSeat"],
//         markupFareAbsolute: json["markupFareAbsolute"],
//         markupFarePercentage: json["markupFarePercentage"],
//         name: json["name"],
//         operatorServiceChargeAbsolute: json["operatorServiceChargeAbsolute"],
//         operatorServiceChargePercent: json["operatorServiceChargePercent"],
//         reservedForSocialDistancing: json["reservedForSocialDistancing"],
//         row: json["row"],
//         serviceTaxAbsolute: json["serviceTaxAbsolute"],
//         serviceTaxPercentage: json["serviceTaxPercentage"],
//         width: json["width"],
//         zIndex: json["zIndex"],
//       );

//   Map<String, dynamic> toJson() => {
//         "available": available,
//         "baseFare": baseFare,
//         "column": column,
//         "doubleBirth": doubleBirth,
//         "fare": fare,
//         "ladiesSeat": ladiesSeat,
//         "length": length,
//         "malesSeat": malesSeat,
//         "markupFareAbsolute": markupFareAbsolute,
//         "markupFarePercentage": markupFarePercentage,
//         "name": name,
//         "operatorServiceChargeAbsolute": operatorServiceChargeAbsolute,
//         "operatorServiceChargePercent": operatorServiceChargePercent,
//         "reservedForSocialDistancing": reservedForSocialDistancing,
//         "row": row,
//         "serviceTaxAbsolute": serviceTaxAbsolute,
//         "serviceTaxPercentage": serviceTaxPercentage,
//         "width": width,
//         "zIndex": zIndex,
//       };
// }
