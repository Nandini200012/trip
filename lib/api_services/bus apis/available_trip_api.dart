import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:oauth1/oauth1.dart' as oauth1;

Future<String> availableTripsAPI(
  String destination,
  String source,
  String doj,
) async {
  print("get trips api");

  // String destination = "6";
  // String source = "3";
  // String doj = "2024-03-20";
  var url = Uri.parse(
      'http://api.seatseller.travel/availabletrips?source=$source&destination=$destination&doj=$doj');

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
    // if (response.statusCode != 200) print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
  
      print(data.length);

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



class AvailableTrip {
    String ac;
    String additionalCommission;
    String agentServiceCharge;
    String agentServiceChargeAllowed;
    String arrivalTime;
    String availCatCard;
    String availSrCitizen;
    String availableSeats;
    String availableSingleSeat;
    String avlWindowSeats;
    String boCommission;
    String boPriorityOperator;
    dynamic boardingTimes;
    String bookable;
    String bpDpSeatLayout;
    String busCancelled;
    String busImageCount;
    String busRoutes;
    String busType;
    String busTypeId;
    String callFareBreakUpApi;
    String cancellationCalculationTimestamp;
    String cancellationPolicy;
    String departureTime;
    String destination;
    DateTime doj;
    String dropPointMandatory;
    // DroppingTimes droppingTimes;
    String duration;
    String exactSearch;
     dynamic fareDetails;
// List<FareDetails> fareDetails;


     dynamic fares;
    // List<String> fares;
    String flatComApplicable;
    String flatSsComApplicable;
    String gdsCommission;
    String groupOfferPriceEnabled;
    String happyHours;
    String id;
    String idProof  ;
    // ImagesMetadataUrl imagesMetadataUrl;
    String isLmbAllowed;
    String liveTrackingAvailable;
    String maxSeatsPerTicket;
    String nextDay;
    String noSeatLayoutEnabled;
    String nonAc;
    String offerPriceEnabled;
    String availableTripOperator;
    String otgEnabled;
    String partialCancellationAllowed;
    String partnerBaseCommission;
    String primaryPaxCancellable;
    String primo;
    String rbServiceId;
    String routeId;
    String rtc;
    String ssAgentAccount;
    String seater;
    String selfInventory;
    DateTime serviceStartTime;
    String singleLadies;
    String sleeper;
    String source;
    String tatkalTime;
    String travels;
    String unAvailable;
    String vaccinatedBus;
    String vaccinatedStaff;
    // VehicleType vehicleType;
    String zeroCancellationTime;
    String mTicketEnabled;
    String cpId;

    AvailableTrip({
           this.ac,
           this.additionalCommission,
           this.agentServiceCharge,
           this.agentServiceChargeAllowed,
           this.arrivalTime,
           this.availCatCard,
           this.availSrCitizen,
           this.availableSeats,
           this.availableSingleSeat,
           this.avlWindowSeats,
           this.boCommission,
           this.boPriorityOperator,
           this.boardingTimes,
           this.bookable,
           this.bpDpSeatLayout,
           this.busCancelled,
           this.busImageCount,
           this.busRoutes,
           this.busType,
           this.busTypeId,
           this.callFareBreakUpApi,
           this.cancellationCalculationTimestamp,
           this.cancellationPolicy,
           this.departureTime,
           this.destination,
           this.doj,
           this.dropPointMandatory,
          //  this.droppingTimes,
           this.duration,
           this.exactSearch,
           this.fareDetails,
           this.fares,
           this.flatComApplicable,
           this.flatSsComApplicable,
           this.gdsCommission,
           this.groupOfferPriceEnabled,
           this.happyHours,
           this.id,
           this.idProof  ,
          //  this.imagesMetadataUrl,
           this.isLmbAllowed,
           this.liveTrackingAvailable,
           this.maxSeatsPerTicket,
           this.nextDay,
           this.noSeatLayoutEnabled,
           this.nonAc,
           this.offerPriceEnabled,
           this.availableTripOperator,
           this.otgEnabled,
           this.partialCancellationAllowed,
           this.partnerBaseCommission,
           this.primaryPaxCancellable,
           this.primo,
           this.rbServiceId,
           this.routeId,
           this.rtc,
           this.ssAgentAccount,
           this.seater,
           this.selfInventory,
           this.serviceStartTime,
           this.singleLadies,
           this.sleeper,
           this.source,
        this.tatkalTime,
           this.travels,
           this.unAvailable,
           this.vaccinatedBus,
           this.vaccinatedStaff,
          //  this.vehicleType,
        this.zeroCancellationTime,
           this.mTicketEnabled,
        this.cpId,
    });

    factory AvailableTrip.fromJson(Map<String, dynamic> json) => AvailableTrip(
        ac: json["AC"],
        additionalCommission: json["additionalCommission"],
        agentServiceCharge: json["agentServiceCharge"],
        agentServiceChargeAllowed: json["agentServiceChargeAllowed"],
        arrivalTime: json["arrivalTime"],
        availCatCard: json["availCatCard"],
        availSrCitizen: json["availSrCitizen"],
        availableSeats: json["availableSeats"],
        availableSingleSeat: json["availableSingleSeat"],
        avlWindowSeats: json["avlWindowSeats"],
        boCommission: json["boCommission"],
        boPriorityOperator: json["boPriorityOperator"],
        boardingTimes: json["boardingTimes"],
        bookable: json["bookable"],
        bpDpSeatLayout: json["bpDpSeatLayout"],
        busCancelled: json["busCancelled"],
        busImageCount: json["busImageCount"],
        busRoutes: json["busRoutes"],
        busType: json["busType"],
        busTypeId: json["busTypeId"],
        callFareBreakUpApi: json["callFareBreakUpAPI"],
        cancellationCalculationTimestamp: json["cancellationCalculationTimestamp"],
        cancellationPolicy: json["cancellationPolicy"],
        departureTime: json["departureTime"],
        destination: json["destination"],
        doj: DateTime.parse(json["doj"]),
        dropPointMandatory: json["dropPointMandatory"],
        // droppingTimes: DroppingTimes.fromJson(json["droppingTimes"]),
        duration: json["duration"],
        exactSearch: json["exactSearch"],
       fareDetails: json["fareDetails"][0],
        //  fareDetails: List<FareDetails>.from(json["fareDetails"].map((x) => FareDetails.fromJson(x))),
        fares: json["fares"],
        flatComApplicable: json["flatComApplicable"],
        flatSsComApplicable: json["flatSSComApplicable"],
        gdsCommission: json["gdsCommission"],
        groupOfferPriceEnabled: json["groupOfferPriceEnabled"],
        happyHours: json["happyHours"],
        id: json["id"],
        idProof  : json["idProof  "],
        // imagesMetadataUrl: imagesMetadataUrlValues.map[json["imagesMetadataUrl"]],
        isLmbAllowed: json["isLMBAllowed"],
        liveTrackingAvailable: json["liveTrackingAvailable"],
        maxSeatsPerTicket: json["maxSeatsPerTicket"],
        nextDay: json["nextDay"],
        noSeatLayoutEnabled: json["noSeatLayoutEnabled"],
        nonAc: json["nonAC"],
        offerPriceEnabled: json["offerPriceEnabled"],
        availableTripOperator: json["operator"],
        otgEnabled: json["otgEnabled"],
        partialCancellationAllowed: json["partialCancellationAllowed"],
        partnerBaseCommission: json["partnerBaseCommission"],
        primaryPaxCancellable: json["primaryPaxCancellable"],
        primo: json["primo"],
        rbServiceId: json["rbServiceId"],
        routeId: json["routeId"],
        rtc: json["rtc"],
        ssAgentAccount: json["SSAgentAccount"],
        seater: json["seater"],
        selfInventory: json["selfInventory"],
        serviceStartTime: DateTime.parse(json["serviceStartTime"]),
        singleLadies: json["singleLadies"],
        sleeper: json["sleeper"],
        source: json["source"],
        tatkalTime: json["tatkalTime"],
        travels: json["travels"],
        unAvailable: json["unAvailable"],
        vaccinatedBus: json["vaccinatedBus"],
        vaccinatedStaff: json["vaccinatedStaff"],
        // vehicleType: vehicleTypeValues.map[json["vehicleType"]],
        zeroCancellationTime: json["zeroCancellationTime"],
        mTicketEnabled: json["mTicketEnabled"],
        cpId: json["cpId"],
    );

    Map<String, dynamic> toJson() => {
        "AC": ac,
        "additionalCommission": additionalCommission,
        "agentServiceCharge": agentServiceCharge,
        "agentServiceChargeAllowed": agentServiceChargeAllowed,
        "arrivalTime": arrivalTime,
        "availCatCard": availCatCard,
        "availSrCitizen": availSrCitizen,
        "availableSeats": availableSeats,
        "availableSingleSeat": availableSingleSeat,
        "avlWindowSeats": avlWindowSeats,
        "boCommission": boCommission,
        "boPriorityOperator": boPriorityOperator,
        "boardingTimes": boardingTimes,
        "bookable": bookable,
        "bpDpSeatLayout": bpDpSeatLayout,
        "busCancelled": busCancelled,
        "busImageCount": busImageCount,
        "busRoutes": busRoutes,
        "busType": busType,
        "busTypeId": busTypeId,
        "callFareBreakUpAPI": callFareBreakUpApi,
        "cancellationCalculationTimestamp": cancellationCalculationTimestamp,
        "cancellationPolicy": cancellationPolicy,
        "departureTime": departureTime,
        "destination": destination,
        "doj": doj.toIso8601String(),
        "dropPointMandatory": dropPointMandatory,
        // "droppingTimes": droppingTimes.toJson(),
        "duration": duration,
        "exactSearch": exactSearch,
        
          "fareDetails": fareDetails,
        //  "fareDetails": fareDetails.map((x) => x.toJson()).toList(),
        "fares": fares,
        "flatComApplicable": flatComApplicable,
        "flatSSComApplicable": flatSsComApplicable,
        "gdsCommission": gdsCommission,
        "groupOfferPriceEnabled": groupOfferPriceEnabled,
        "happyHours": happyHours,
        "id": id,
        "idProof  ": idProof  ,
        // "imagesMetadataUrl": imagesMetadataUrlValues.reverse[imagesMetadataUrl],
        "isLMBAllowed": isLmbAllowed,
        "liveTrackingAvailable": liveTrackingAvailable,
        "maxSeatsPerTicket": maxSeatsPerTicket,
        "nextDay": nextDay,
        "noSeatLayoutEnabled": noSeatLayoutEnabled,
        "nonAC": nonAc,
        "offerPriceEnabled": offerPriceEnabled,
        "operator": availableTripOperator,
        "otgEnabled": otgEnabled,
        "partialCancellationAllowed": partialCancellationAllowed,
        "partnerBaseCommission": partnerBaseCommission,
        "primaryPaxCancellable": primaryPaxCancellable,
        "primo": primo,
        "rbServiceId": rbServiceId,
        "routeId": routeId,
        "rtc": rtc,
        "SSAgentAccount": ssAgentAccount,
        "seater": seater,
        "selfInventory": selfInventory,
        "serviceStartTime": serviceStartTime.toIso8601String(),
        "singleLadies": singleLadies,
        "sleeper": sleeper,
        "source": source,
        "tatkalTime": tatkalTime,
        "travels": travels,
        "unAvailable": unAvailable,
        "vaccinatedBus": vaccinatedBus,
        "vaccinatedStaff": vaccinatedStaff,
        // "vehicleType": vehicleTypeValues.reverse[vehicleType],
        "zeroCancellationTime": zeroCancellationTime,
        "mTicketEnabled": mTicketEnabled,
        "cpId": cpId,
    };
}






class FareDetails {
  final String bankTrexAmt;
  final String baseFare;
  final String bookingFee;
  final String childFare;
  final String gst;
  final String levyFare;
  final String markupFareAbsolute;
  final String markupFarePercentage;
  final String opFare;
  final String opGroupFare;
  final String operatorServiceChargeAbsolute;
  final String operatorServiceChargePercentage;
  final String serviceCharge;
  final String serviceTaxAbsolute;
  final String serviceTaxPercentage;
  final String srtFee;
  final String tollFee;
  final String totalFare;

  FareDetails({
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
        this.totalFare,
  });

factory FareDetails.fromJson(Map<String, dynamic> json) {
    return FareDetails(
      bankTrexAmt: json['bankTrexAmt'] ?? "",
      baseFare: json['baseFare'] ?? "",
      bookingFee: json['bookingFee'] ?? "",
      childFare: json['childFare'] ?? "",
      gst: json['gst'] ?? "",
      levyFare: json['levyFare'] ?? "",
      markupFareAbsolute: json['markupFareAbsolute'] ?? "",
      markupFarePercentage: json['markupFarePercentage'] ?? "",
      opFare: json['opFare'] ?? "",
      opGroupFare: json['opGroupFare'] ?? "",
      operatorServiceChargeAbsolute: json['operatorServiceChargeAbsolute'] ?? "",
      operatorServiceChargePercentage: json['operatorServiceChargePercentage'] ?? "",
      serviceCharge: json['serviceCharge'] ?? "",
      serviceTaxAbsolute: json['serviceTaxAbsolute'] ?? "",
      serviceTaxPercentage: json['serviceTaxPercentage'] ?? "",
      srtFee: json['srtFee'] ?? "",
      tollFee: json['tollFee'] ?? "",
      totalFare: json['totalFare'] ?? "",
    );
}

Map<String, dynamic> toJson() => {
    'bankTrexAmt': bankTrexAmt,
    'baseFare': baseFare,
    'bookingFee': bookingFee,
    'childFare': childFare,
    'gst': gst,
    'levyFare': levyFare,
    'markupFareAbsolute': markupFareAbsolute,
    'markupFarePercentage': markupFarePercentage,
    'opFare': opFare,
    'opGroupFare': opGroupFare,
    'operatorServiceChargeAbsolute': operatorServiceChargeAbsolute,
    'operatorServiceChargePercentage': operatorServiceChargePercentage,
    'serviceCharge': serviceCharge,
    'serviceTaxAbsolute': serviceTaxAbsolute,
    'serviceTaxPercentage': serviceTaxPercentage,
    'srtFee': srtFee,
    'tollFee': tollFee,
    'totalFare': totalFare,
};
}
// class DroppingTimes {
//     String address;
//     String bpId;
//     String bpName;
//     String contactNumber;
//     String landmark;
//     String location;
//     String prime;
//     String time;

//     DroppingTimes({
//            this.address,
//            this.bpId,
//            this.bpName,
//            this.contactNumber,
//            this.landmark,
//            this.location,
//            this.prime,
//            this.time,
//     });

//     factory DroppingTimes.fromJson(Map<String, dynamic> json) => DroppingTimes(
//         address: json["address"],
//         bpId: json["bpId"],
//         bpName: json["bpName"],
//         contactNumber: json["contactNumber"],
//         landmark: json["landmark"],
//         location: json["location"],
//         prime: json["prime"],
//         time: json["time"],
//     );

//     Map<String, dynamic> toJson() => {
//         "address": address,
//         "bpId": bpId,
//         "bpName": bpName,
//         "contactNumber": contactNumber,
//         "landmark": landmark,
//         "location": location,
//         "prime": prime,
//         "time": time,
//     };
// }

// class FareDetail {
//     String bankTrexAmt;
//     String baseFare;
//     String bookingFee;
//     String childFare;
//     String gst;
//     String levyFare;
//     String markupFareAbsolute;
//     String markupFarePercentage;
//     String opFare;
//     String opGroupFare;
//     String operatorServiceChargeAbsolute;
//     String operatorServiceChargePercentage;
//     String serviceCharge;
//     String serviceTaxAbsolute;
//     String serviceTaxPercentage;
//     String srtFee;
//     String tollFee;
//     String totalFare;

//     FareDetail({
//            this.bankTrexAmt,
//            this.baseFare,
//            this.bookingFee,
//            this.childFare,
//            this.gst,
//            this.levyFare,
//            this.markupFareAbsolute,
//            this.markupFarePercentage,
//            this.opFare,
//            this.opGroupFare,
//            this.operatorServiceChargeAbsolute,
//            this.operatorServiceChargePercentage,
//            this.serviceCharge,
//            this.serviceTaxAbsolute,
//            this.serviceTaxPercentage,
//            this.srtFee,
//            this.tollFee,
//            this.totalFare,
//     });

//     factory FareDetail.fromJson(Map<String, dynamic> json) => FareDetail(
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
//         operatorServiceChargePercentage: json["operatorServiceChargePercentage"],
//         serviceCharge: json["serviceCharge"],
//         serviceTaxAbsolute: json["serviceTaxAbsolute"],
//         serviceTaxPercentage: json["serviceTaxPercentage"],
//         srtFee: json["srtFee"],
//         tollFee: json["tollFee"],
//         totalFare: json["totalFare"],
//     );

//     Map<String, dynamic> toJson() => {
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
//     };
// }

// enum ImagesMetadataUrl {
//     IMAGES_NULL
// }

// final imagesMetadataUrlValues = EnumValues({
//     "/images/null": ImagesMetadataUrl.IMAGES_NULL
// });

// enum VehicleType {
//     BUS
// }

// final vehicleTypeValues = EnumValues({
//     "BUS": VehicleType.BUS
// });

// class EnumValues<T> {
//     Map<String, T> map;
//    Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }
