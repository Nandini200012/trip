import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';
import 'package:trip/login_variables/login_Variables.dart';

import '../flight_databse_apis/flight_details_api.dart';

List<String> bookingidList = []; 
Future<String> FlightTciketApi(String bookingid, String orderId) async {
  // List<String> bookingidList = [];
  printWhite("FlightTciketApi");
  print("booking ID: $bookingid");

  var url = Uri.parse('https://apitest.tripjack.com/oms/v1/booking-details');
  print("url : $url");

  var requestBody = {
    "bookingId": bookingid,
  };

  var requestBodyJson = jsonEncode(requestBody);

  try {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'apikey': '6122022b0e1517-2bf9-4ebe-92e7-3e2b550e5ba5',
      },
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      try {
        String responseBody = response.body;
        log(responseBody);
        if (bookingidList.contains(bookingid)) {
          print('Database already has this data');
        } else {
          bookingidList.add(bookingid);
          printyellow(bookingidList.length.toString());
           postdatabase(response, orderId);
        }

        var decodedData = jsonDecode(responseBody);
        return responseBody;
      } catch (e) {
        print('Error decoding JSON: $e');
        return 'failed';
      }
    } else {
      String errorMessage =
          'Request failed with status: ${response.statusCode}.';
      if (response.body != null && response.body.isNotEmpty) {
        errorMessage += ' Response body: ${response.body}';
      }
      log(errorMessage);
      return 'failed';
    }
  } catch (e) {
    log('Error: $e');
    return 'failed';
  }
}

void postdatabase(http.Response response, String orderid) {
  String bookingId;
  double amount;
  String createdOn;
  String fromCity;
  String toCity;
  String departureDate;
  String status;
  printred("postdatabase");
  if (response != null) {
    String res = response.body;
    Map<String, dynamic> jsonResponse = jsonDecode(res);

    // Fetching bookingId, amount, createdOn, and status
    bookingId = jsonResponse['order']['bookingId'];
    amount = jsonResponse['order']['amount'];
    createdOn = jsonResponse['order']['createdOn'];
    status = jsonResponse['order']['status'];

    print('Booking ID: $bookingId');
    print('Amount: $amount');
    print('Created On: $createdOn');
    print('Status: $status');
    print('customer id: $user_id');

    // Fetching trip details
    var tripInfos = jsonResponse['itemInfos']['AIR']['tripInfos'];
    if (tripInfos != null && tripInfos.isNotEmpty) {
      var firstTripInfo = tripInfos[0]['sI'][0];
      fromCity = firstTripInfo['da']['city'];
      toCity = firstTripInfo['aa']['city'];
      departureDate = firstTripInfo['dt'];

      print('From City: $fromCity');
      print('To City: $toCity');
      print('Departure Date: $departureDate');
    } else {
      print('No trip information available');
    }
  }
  if (bookingId != null &&
      amount != null &&
      createdOn != null &&
      fromCity != null &&
      toCity != null &&
      departureDate != null &&
      status != null &&
      orderid != null) {
    postdetailsFlightApi(
      from: fromCity,
      to: toCity,
      bookingID: bookingId,
      orderID: orderid,
      totalfare: amount.toString(),
      statuss: status,
      flightDate: createdOn,
    );
  }
}

// FlightTicketobj obj = FlightTicketobj.fromJson(jsonDecode(res));
// printred("postdatabase");
// print("obj${obj.order.bookingId}");
// print("obj${obj.order.createdOn}");
// print("obj${obj.status}");
// print("obj${user_id}");
// print("obj${obj.itemInfos.air.tripInfos[0].sI[0].da.city}");
// print("obj${obj.itemInfos.air.tripInfos[0].sI[0].aa.city}");
// print("obj${obj.order.amount}");

class FlightTicketobj {
  Order order;
  ItemInfos itemInfos;
  GstInfo gstInfo;
  Status status;

  FlightTicketobj({
    this.order,
    this.itemInfos,
    this.gstInfo,
    this.status,
  });

  factory FlightTicketobj.fromJson(Map<String, dynamic> json) =>
      FlightTicketobj(
        order: Order.fromJson(json["order"]),
        itemInfos: ItemInfos.fromJson(json["itemInfos"]),
        gstInfo: GstInfo.fromJson(json["gstInfo"]),
        status: Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "itemInfos": itemInfos.toJson(),
        "gstInfo": gstInfo.toJson(),
        "status": status.toJson(),
      };
}

class GstInfo {
  String gstNumber;
  String email;
  String mobile;
  String address;
  String registeredName;
  String bookingId;
  String bookingUserId;
  int id;

  GstInfo({
    this.gstNumber,
    this.email,
    this.mobile,
    this.address,
    this.registeredName,
    this.bookingId,
    this.bookingUserId,
    this.id,
  });

  factory GstInfo.fromJson(Map<String, dynamic> json) => GstInfo(
        gstNumber: json["gstNumber"],
        email: json["email"],
        mobile: json["mobile"],
        address: json["address"],
        registeredName: json["registeredName"],
        bookingId: json["bookingId"],
        bookingUserId: json["bookingUserId"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "gstNumber": gstNumber,
        "email": email,
        "mobile": mobile,
        "address": address,
        "registeredName": registeredName,
        "bookingId": bookingId,
        "bookingUserId": bookingUserId,
        "id": id,
      };
}

class ItemInfos {
  Air air;

  ItemInfos({
    this.air,
  });

  factory ItemInfos.fromJson(Map<String, dynamic> json) => ItemInfos(
        air: Air.fromJson(json["AIR"]),
      );

  Map<String, dynamic> toJson() => {
        "AIR": air.toJson(),
      };
}

class Air {
  List<TripInfo> tripInfos;
  List<TravellerInfo> travellerInfos;
  TotalPriceInfo totalPriceInfo;

  Air({
    this.tripInfos,
    this.travellerInfos,
    this.totalPriceInfo,
  });

  factory Air.fromJson(Map<String, dynamic> json) => Air(
        tripInfos: List<TripInfo>.from(
            json["tripInfos"].map((x) => TripInfo.fromJson(x))),
        travellerInfos: List<TravellerInfo>.from(
            json["travellerInfos"].map((x) => TravellerInfo.fromJson(x))),
        totalPriceInfo: TotalPriceInfo.fromJson(json["totalPriceInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "tripInfos": List<dynamic>.from(tripInfos.map((x) => x.toJson())),
        "travellerInfos":
            List<dynamic>.from(travellerInfos.map((x) => x.toJson())),
        "totalPriceInfo": totalPriceInfo.toJson(),
      };
}

class TotalPriceInfo {
  TotalFareDetail totalFareDetail;

  TotalPriceInfo({
    this.totalFareDetail,
  });

  factory TotalPriceInfo.fromJson(Map<String, dynamic> json) => TotalPriceInfo(
        totalFareDetail: TotalFareDetail.fromJson(json["totalFareDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "totalFareDetail": totalFareDetail.toJson(),
      };
}

class TotalFareDetail {
  FC fC;
  AfC afC;

  TotalFareDetail({
    this.fC,
    this.afC,
  });

  factory TotalFareDetail.fromJson(Map<String, dynamic> json) =>
      TotalFareDetail(
        fC: FC.fromJson(json["fC"]),
        afC: AfC.fromJson(json["afC"]),
      );

  Map<String, dynamic> toJson() => {
        "fC": fC.toJson(),
        "afC": afC.toJson(),
      };
}

class AfC {
  Taf taf;

  AfC({
    this.taf,
  });

  factory AfC.fromJson(Map<String, dynamic> json) => AfC(
        taf: Taf.fromJson(json["TAF"]),
      );

  Map<String, dynamic> toJson() => {
        "TAF": taf.toJson(),
      };
}

class Taf {
  int yr;
  int agst;
  int ot;

  Taf({
    this.yr,
    this.agst,
    this.ot,
  });

  factory Taf.fromJson(Map<String, dynamic> json) => Taf(
        yr: json["YR"],
        agst: json["AGST"],
        ot: json["OT"],
      );

  Map<String, dynamic> toJson() => {
        "YR": yr,
        "AGST": agst,
        "OT": ot,
      };
}

class FC {
  int taf;
  int tf;
  int nf;
  int bf;

  FC({
    this.taf,
    this.tf,
    this.nf,
    this.bf,
  });

  factory FC.fromJson(Map<String, dynamic> json) => FC(
        taf: json["TAF"],
        tf: json["TF"],
        nf: json["NF"],
        bf: json["BF"],
      );

  Map<String, dynamic> toJson() => {
        "TAF": taf,
        "TF": tf,
        "NF": nf,
        "BF": bf,
      };
}

class TravellerInfo {
  RDetails pnrDetails;
  RDetails ticketNumberDetails;
  CheckinStatusMap checkinStatusMap;
  String ti;
  String pt;
  String fN;
  String lN;
  DateTime dob;
  String pNum;
  DateTime eD;
  String pNat;

  TravellerInfo({
    this.pnrDetails,
    this.ticketNumberDetails,
    this.checkinStatusMap,
    this.ti,
    this.pt,
    this.fN,
    this.lN,
    this.dob,
    this.pNum,
    this.eD,
    this.pNat,
  });

  factory TravellerInfo.fromJson(Map<String, dynamic> json) => TravellerInfo(
        pnrDetails: RDetails.fromJson(json["pnrDetails"]),
        ticketNumberDetails: RDetails.fromJson(json["ticketNumberDetails"]),
        checkinStatusMap: CheckinStatusMap.fromJson(json["checkinStatusMap"]),
        ti: json["ti"],
        pt: json["pt"],
        fN: json["fN"],
        lN: json["lN"],
        dob: DateTime.parse(json["dob"]),
        pNum: json["pNum"],
        eD: DateTime.parse(json["eD"]),
        pNat: json["pNat"],
      );

  Map<String, dynamic> toJson() => {
        "pnrDetails": pnrDetails.toJson(),
        "ticketNumberDetails": ticketNumberDetails.toJson(),
        "checkinStatusMap": checkinStatusMap.toJson(),
        "ti": ti,
        "pt": pt,
        "fN": fN,
        "lN": lN,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "pNum": pNum,
        "eD":
            "${eD.year.toString().padLeft(4, '0')}-${eD.month.toString().padLeft(2, '0')}-${eD.day.toString().padLeft(2, '0')}",
        "pNat": pNat,
      };
}

class CheckinStatusMap {
  bool delBom;

  CheckinStatusMap({
    this.delBom,
  });

  factory CheckinStatusMap.fromJson(Map<String, dynamic> json) =>
      CheckinStatusMap(
        delBom: json["DEL-BOM"],
      );

  Map<String, dynamic> toJson() => {
        "DEL-BOM": delBom,
      };
}

class RDetails {
  String delBom;

  RDetails({
    this.delBom,
  });

  factory RDetails.fromJson(Map<String, dynamic> json) => RDetails(
        delBom: json["DEL-BOM"],
      );

  Map<String, dynamic> toJson() => {
        "DEL-BOM": delBom,
      };
}

class TripInfo {
  List<SI> sI;

  TripInfo({
    this.sI,
  });

  factory TripInfo.fromJson(Map<String, dynamic> json) => TripInfo(
        sI: List<SI>.from(json["sI"].map((x) => SI.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sI": List<dynamic>.from(sI.map((x) => x.toJson())),
      };
}

class SI {
  String id;
  FD fD;
  int stops;
  int duration;
  Aa da;
  Aa aa;
  String dt;
  String at;
  bool iand;
  bool isRs;
  int sN;

  SI({
    this.id,
    this.fD,
    this.stops,
    this.duration,
    this.da,
    this.aa,
    this.dt,
    this.at,
    this.iand,
    this.isRs,
    this.sN,
  });

  factory SI.fromJson(Map<String, dynamic> json) => SI(
        id: json["id"],
        fD: FD.fromJson(json["fD"]),
        stops: json["stops"],
        duration: json["duration"],
        da: Aa.fromJson(json["da"]),
        aa: Aa.fromJson(json["aa"]),
        dt: json["dt"],
        at: json["at"],
        iand: json["iand"],
        isRs: json["isRs"],
        sN: json["sN"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fD": fD.toJson(),
        "stops": stops,
        "duration": duration,
        "da": da.toJson(),
        "aa": aa.toJson(),
        "dt": dt,
        "at": at,
        "iand": iand,
        "isRs": isRs,
        "sN": sN,
      };
}

class Aa {
  String code;
  String name;
  String cityCode;
  String city;
  String country;
  String countryCode;
  String terminal;

  Aa({
    this.code,
    this.name,
    this.cityCode,
    this.city,
    this.country,
    this.countryCode,
    this.terminal,
  });

  factory Aa.fromJson(Map<String, dynamic> json) => Aa(
        code: json["code"],
        name: json["name"],
        cityCode: json["cityCode"],
        city: json["city"],
        country: json["country"],
        countryCode: json["countryCode"],
        terminal: json["terminal"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "cityCode": cityCode,
        "city": city,
        "country": country,
        "countryCode": countryCode,
        "terminal": terminal,
      };
}

class FD {
  AI aI;
  String fN;
  String eT;

  FD({
    this.aI,
    this.fN,
    this.eT,
  });

  factory FD.fromJson(Map<String, dynamic> json) => FD(
        aI: AI.fromJson(json["aI"]),
        fN: json["fN"],
        eT: json["eT"],
      );

  Map<String, dynamic> toJson() => {
        "aI": aI.toJson(),
        "fN": fN,
        "eT": eT,
      };
}

class AI {
  String code;
  String name;
  bool isLcc;

  AI({
    this.code,
    this.name,
    this.isLcc,
  });

  factory AI.fromJson(Map<String, dynamic> json) => AI(
        code: json["code"],
        name: json["name"],
        isLcc: json["isLcc"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "isLcc": isLcc,
      };
}

class Order {
  String bookingId;
  double amount;
  double markup;
  DeliveryInfo deliveryInfo;
  String status;
  DateTime createdOn;

  Order({
    this.bookingId,
    this.amount,
    this.markup,
    this.deliveryInfo,
    this.status,
    this.createdOn,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        bookingId: json["bookingId"],
        amount: json["amount"],
        markup: json["markup"],
        deliveryInfo: DeliveryInfo.fromJson(json["deliveryInfo"]),
        status: json["status"],
        createdOn: DateTime.parse(json["createdOn"]),
      );

  Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "amount": amount,
        "markup": markup,
        "deliveryInfo": deliveryInfo.toJson(),
        "status": status,
        "createdOn": createdOn.toIso8601String(),
      };
}

class DeliveryInfo {
  List<String> emails;
  List<String> contacts;

  DeliveryInfo({
    this.emails,
    this.contacts,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
        emails: List<String>.from(json["emails"].map((x) => x)),
        contacts: List<String>.from(json["contacts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "emails": List<dynamic>.from(emails.map((x) => x)),
        "contacts": List<dynamic>.from(contacts.map((x) => x)),
      };
}

class Status {
  bool success;
  int httpStatus;

  Status({
    this.success,
    this.httpStatus,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        success: json["success"],
        httpStatus: json["httpStatus"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "httpStatus": httpStatus,
      };
}
