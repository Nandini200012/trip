import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';

import '../../../screens/flight_model/multicity_route_model.dart';

Future<String> domestic_multiwaysearchapi(
  String cabin_class,
  String adult,
  String child,
  String infant,
  List<routes> multiroutes,
) async {
  print("Air search domestic multicity");
  print("cabincalss:$cabin_class");
  print("adult:$adult");
  print("child:$child");
  print("infant:$infant");

  var url = Uri.parse('https://apitest.tripjack.com/fms/v1/air-search-all');
  print("url : $url");

  List<Map<String, dynamic>> routeInfos = multiroutes.map((route) {
    return {
      "fromCityOrAirport": {"code": route.fromCode},
      "toCityOrAirport": {"code": route.toCode},
      "travelDate": route.date,
    };
  }).toList();

  var requestBody = {
    "searchQuery": {
      "cabinClass": cabin_class,
      "paxInfo": {
        "ADULT": adult ?? '1',
        "CHILD": child ?? '0',
        "INFANT": infant ?? '0'
      },
      "routeInfos": routeInfos,
      "searchModifiers": {"isDirectFlight": true, "isConnectingFlight": false}
    }
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

    print("domestic multicity res: ${response.body}");
    if (response.statusCode == 200) {
      String responseBody = response.body;
      print('response');
      printWhite(response.body);
      return responseBody;
    } else {
      String errorMessage =
          'Request failed with status: ${response.statusCode}.';
      if (response.body != null && response.body.isNotEmpty) {
        errorMessage += ' Response body: ${response.body}';
      }
      print(errorMessage);
      return 'failed';
    }
  } catch (e) {
    print('Error: $e');
    return 'failed';
  }
}

class ComboMultiFlightData {
  TripInfos tripInfos;

  ComboMultiFlightData({this.tripInfos});

  factory ComboMultiFlightData.fromJson(Map<String, dynamic> json) {
    return ComboMultiFlightData(
      tripInfos: TripInfos.fromJson(json['tripInfos']),
    );
  }
}

class TripInfos {
  List<Combo> combo;

  TripInfos({this.combo});

  factory TripInfos.fromJson(Map<String, dynamic> json) {
    var comboList = json['COMBO'] as List;
    List<Combo> comboObjs =
        comboList?.map((combo) => Combo.fromJson(combo))?.toList() ?? [];

    return TripInfos(
      combo: comboObjs,
    );
  }
}

class Combo {
  List<Segment> segments;
  List<TotalPriceList> totalPriceList;

  Combo({this.segments, this.totalPriceList});

  factory Combo.fromJson(Map<String, dynamic> json) {
    var segmentList = json['sI'] as List;
    List<Segment> segmentObjs =
        segmentList?.map((seg) => Segment.fromJson(seg))?.toList() ?? [];

    var priceList = json['totalPriceList'] as List;
    List<TotalPriceList> priceObjs =
        priceList?.map((price) => TotalPriceList.fromJson(price))?.toList() ??
            [];

    return Combo(
      segments: segmentObjs,
      totalPriceList: priceObjs,
    );
  }
}

class Segment {
  String id;
  FlightDetails flightDetails;
  String duration;
  String stops;
  String so;
  AirportInfo departureAirport;
  AirportInfo arrivalAirport;
  String departureTime;
  String arrivalTime;
  bool isInternational;
  String sequenceNumber;
  bool isReturnSegment;

  Segment({
    this.id,
    this.flightDetails,
    this.duration,
    this.stops,
    this.so,
    this.departureAirport,
    this.arrivalAirport,
    this.departureTime,
    this.arrivalTime,
    this.isInternational,
    this.sequenceNumber,
    this.isReturnSegment,
  });

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      id: json['id']?.toString() ?? '',
      flightDetails: FlightDetails.fromJson(json['fD']),
      duration: json['duration']?.toString() ?? '',
      stops: json['stops']?.toString() ?? '',
      so: json['so']?.toString() ?? '',
      departureAirport: AirportInfo.fromJson(json['da']),
      arrivalAirport: AirportInfo.fromJson(json['aa']),
      departureTime: json['dt']?.toString() ?? '',
      arrivalTime: json['at']?.toString() ?? '',
      isInternational: json['iand'] ?? false,
      sequenceNumber: json['sN']?.toString() ?? '',
      isReturnSegment: json['isRs'] ?? false,
    );
  }
}

class FlightDetails {
  AirlineInfo airlineInfo;
  String flightNumber;
  String equipmentType;

  FlightDetails({this.airlineInfo, this.flightNumber, this.equipmentType});

  factory FlightDetails.fromJson(Map<String, dynamic> json) {
    return FlightDetails(
      airlineInfo: AirlineInfo.fromJson(json['aI']),
      flightNumber: json['fN']?.toString() ?? '',
      equipmentType: json['eT']?.toString() ?? '',
    );
  }
}

class AirlineInfo {
  String code;
  String name;
  bool isLcc;

  AirlineInfo({this.code, this.name, this.isLcc});

  factory AirlineInfo.fromJson(Map<String, dynamic> json) {
    return AirlineInfo(
      code: json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      isLcc: json['isLcc'] ?? false,
    );
  }
}

class AirportInfo {
  String code;
  String name;
  String cityCode;
  String city;
  String country;
  String countryCode;
  String terminal;

  AirportInfo({
    this.code,
    this.name,
    this.cityCode,
    this.city,
    this.country,
    this.countryCode,
    this.terminal,
  });

  factory AirportInfo.fromJson(Map<String, dynamic> json) {
    return AirportInfo(
      code: json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      cityCode: json['cityCode']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      countryCode: json['countryCode']?.toString() ?? '',
      terminal: json['terminal']?.toString() ?? '',
    );
  }
}

class TotalPriceList {
  FareDetails fareDetails;
  String id;
  List<dynamic> msri;
  List<dynamic> messages;

  TotalPriceList({this.fareDetails, this.id, this.msri, this.messages});

  factory TotalPriceList.fromJson(Map<String, dynamic> json) {
    return TotalPriceList(
      fareDetails: FareDetails.fromJson(json['fd']),
      id: json['id']?.toString() ?? '',
      msri: json['msri'] ?? [],
      messages: json['messages'] ?? [],
    );
  }
}

class FareDetails {
  FareComponents fareComponents;
  AdditionalFareComponents additionalFareComponents;
  String seatRemaining; // Nullable String
  BaggageInfo baggageInfo;
  String refundType; // Nullable String
  String cabinClass; // Nullable String
  String bookingClass; // Nullable String
  String fareBasis; // Nullable String

  FareDetails({
    this.fareComponents,
    this.additionalFareComponents,
    this.seatRemaining,
    this.baggageInfo,
    this.refundType,
    this.cabinClass,
    this.bookingClass,
    this.fareBasis,
  });

  factory FareDetails.fromJson(Map<String, dynamic> json) {
    return FareDetails(
      fareComponents: FareComponents.fromJson(json['ADULT']['fC']),
      additionalFareComponents: AdditionalFareComponents.fromJson(json['afC']),
      seatRemaining: json['sR']?.toString() ?? '',
      baggageInfo: BaggageInfo.fromJson(json['bI']),
      refundType: json['rT']?.toString() ?? '',
      cabinClass: json['cc']?.toString() ?? '',
      bookingClass: json['cB']?.toString() ?? '',
      fareBasis: json['fB']?.toString() ?? '',
    );
  }
}

class FareComponents {
  String totalFare;
  String totalAdditionalFare;
  String baseFare;
  String netFare;

  FareComponents({
    this.totalFare,
    this.totalAdditionalFare,
    this.baseFare,
    this.netFare,
  });

  factory FareComponents.fromJson(Map<String, dynamic> json) {
    // if (json == null) {
    //   // Handle the case where the map is null
    //   print("FareComponents is null");
    //   return FareComponents();
    // }

    return FareComponents(
      totalFare: json['TF']?.toString() ?? '',
      totalAdditionalFare: json['TAF']?.toString() ?? '',
      baseFare: json['BF']?.toString() ?? '',
      netFare: json['NF']?.toString() ?? '',
    );
  }
}

class AdditionalFareComponents {
  double YR;
  double AGST;
  double MFT;
  double YQ;
  double MF;
  double OT;

  AdditionalFareComponents({
    this.YR,
    this.AGST,
    this.MFT,
    this.YQ,
    this.MF,
    this.OT,
  });

  factory AdditionalFareComponents.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      // Handle the case where the json object is null
      return AdditionalFareComponents();
    }

    return AdditionalFareComponents(
      YR: (json['YR'] as num)?.toDouble() ?? 0.0,
      AGST: (json['AGST'] as num)?.toDouble() ?? 0.0,
      MFT: (json['MFT'] as num)?.toDouble() ?? 0.0,
      YQ: (json['YQ'] as num)?.toDouble() ?? 0.0,
      MF: (json['MF'] as num)?.toDouble() ?? 0.0,
      OT: (json['OT'] as num)?.toDouble() ?? 0.0,
    );
  }
}

class BaggageInfo {
  String includedBaggage;
  String cabinBaggage;

  BaggageInfo({this.includedBaggage, this.cabinBaggage});

  factory BaggageInfo.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      // Handle the case where the json object is null
      return BaggageInfo();
    }

    return BaggageInfo(
      includedBaggage: json['iB']?.toString() ?? '',
      cabinBaggage: json['cB']?.toString() ?? '',
    );
  }
}




// class ComboMultiFlightData {
//     SearchResult searchResult;
//     Status status;

//     ComboMultiFlightData({
//           this.searchResult,
//           this.status,
//     });

//     factory ComboMultiFlightData.fromJson(Map<String, dynamic> json) => ComboMultiFlightData(
//         searchResult: SearchResult.fromJson(json["searchResult"]),
//         status: Status.fromJson(json["status"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "searchResult": searchResult.toJson(),
//         "status": status.toJson(),
//     };
// }

// class SearchResult {
//     TripInfos tripInfos;

//     SearchResult({
//           this.tripInfos,
//     });

//     factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
//         tripInfos: TripInfos.fromJson(json["tripInfos"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "tripInfos": tripInfos.toJson(),
//     };
// }

// class TripInfos {
//     List<Combo> combo;

//     TripInfos({
//           this.combo,
//     });

//     factory TripInfos.fromJson(Map<String, dynamic> json) => TripInfos(
//         combo: List<Combo>.from(json["COMBO"].map((x) => Combo.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "COMBO": List<dynamic>.from(combo.map((x) => x.toJson())),
//     };
// }

// class Combo {
//     List<SI> sI;
//     List<TotalPriceList> totalPriceList;

//     Combo({
//           this.sI,
//           this.totalPriceList,
//     });

//     factory Combo.fromJson(Map<String, dynamic> json) => Combo(
//         sI: List<SI>.from(json["sI"].map((x) => SI.fromJson(x))),
//         totalPriceList: List<TotalPriceList>.from(json["totalPriceList"].map((x) => TotalPriceList.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "sI": List<dynamic>.from(sI.map((x) => x.toJson())),
//         "totalPriceList": List<dynamic>.from(totalPriceList.map((x) => x.toJson())),
//     };
// }

// class SI {
//     String id;
//     FD fD;
//     int stops;
//     int duration;
//     Aa da;
//     Aa aa;
//     String dt;
//     String at;
//     bool iand;
//     bool isRs;
//     int sN;
//     String oaa;

//     SI({
//           this.id,
//           this.fD,
//           this.stops,
//           this.duration,
//           this.da,
//           this.aa,
//           this.dt,
//           this.at,
//           this.iand,
//           this.isRs,
//           this.sN,
//         this.oaa,
//     });

//     factory SI.fromJson(Map<String, dynamic> json) => SI(
//         id: json["id"],
//         fD: FD.fromJson(json["fD"]),
//         stops: json["stops"],
//         duration: json["duration"],
//         da: Aa.fromJson(json["da"]),
//         aa: Aa.fromJson(json["aa"]),
//         dt: json["dt"],
//         at: json["at"],
//         iand: json["iand"],
//         isRs: json["isRs"],
//         sN: json["sN"],
//         oaa: json["oaa"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "fD": fD.toJson(),
//         "stops": stops,
//         "duration": duration,
//         "da": da.toJson(),
//         "aa": aa.toJson(),
//         "dt": dt,
//         "at": at,
//         "iand": iand,
//         "isRs": isRs,
//         "sN": sN,
//         "oaa": oaa,
//     };
// }

// class Aa {
//     String code;
//     String name;
//     String cityCode;
//     String city;
//     String country;
//     String countryCode;
//     String terminal;

//     Aa({
//           this.code,
//           this.name,
//           this.cityCode,
//           this.city,
//           this.country,
//           this.countryCode,
//         this.terminal,
//     });

//     factory Aa.fromJson(Map<String, dynamic> json) => Aa(
//         code: json["code"],
//         name: json["name"],
//         cityCode: json["cityCode"],
//         city: json["city"],
//         country: json["country"],
//         countryCode: json["countryCode"],
//         terminal: json["terminal"],
//     );

//     Map<String, dynamic> toJson() => {
//         "code": code,
//         "name": name,
//         "cityCode": cityCode,
//         "city": city,
//         "country": country,
//         "countryCode": countryCode,
//         "terminal": terminal,
//     };
// }

// class FD {
//     AI aI;
//     String fN;
//     String eT;

//     FD({
//           this.aI,
//           this.fN,
//           this.eT,
//     });

//     factory FD.fromJson(Map<String, dynamic> json) => FD(
//         aI: AI.fromJson(json["aI"]),
//         fN: json["fN"],
//         eT: json["eT"],
//     );

//     Map<String, dynamic> toJson() => {
//         "aI": aI.toJson(),
//         "fN": fN,
//         "eT": eT,
//     };
// }

// class AI {
//     String code;
//     String name;
//     bool isLcc;

//     AI({
//           this.code,
//           this.name,
//           this.isLcc,
//     });

//     factory AI.fromJson(Map<String, dynamic> json) => AI(
//         code: json["code"],
//         name: json["name"],
//         isLcc: json["isLcc"],
//     );

//     Map<String, dynamic> toJson() => {
//         "code": code,
//         "name": name,
//         "isLcc": isLcc,
//     };
// }

// class TotalPriceList {
//     Fd fd;
//     String fareIdentifier;
//     String id;
//     List<dynamic> msri;
//     List<dynamic> messages;
//     Tai tai;
//     bool icca;

//     TotalPriceList({
//           this.fd,
//           this.fareIdentifier,
//           this.id,
//           this.msri,
//           this.messages,
//           this.tai,
//           this.icca,
//     });

//     factory TotalPriceList.fromJson(Map<String, dynamic> json) => TotalPriceList(
//         fd: Fd.fromJson(json["fd"]),
//         fareIdentifier: json["fareIdentifier"],
//         id: json["id"],
//         msri: List<dynamic>.from(json["msri"].map((x) => x)),
//         messages: List<dynamic>.from(json["messages"].map((x) => x)),
//         tai: Tai.fromJson(json["tai"]),
//         icca: json["icca"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fd": fd.toJson(),
//         "fareIdentifier": fareIdentifier,
//         "id": id,
//         "msri": List<dynamic>.from(msri.map((x) => x)),
//         "messages": List<dynamic>.from(messages.map((x) => x)),
//         "tai": tai.toJson(),
//         "icca": icca,
//     };
// }

// class Fd {
//     Adult adult;
// Child child;
// Infant infant;
//     Fd({
//           this.adult,
//     });

//     factory Fd.fromJson(Map<String, dynamic> json) => Fd(
//         adult: Adult.fromJson(json["ADULT"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "ADULT": adult.toJson(),
//     };
// }

// class Infant{
//     FC fC;
//     AfC afC;
//     int sR;
//     BI bI;
//     int rT;
//     String cc;
//     String cB;
//     String fB;

//      Infant({
//           this.fC,
//           this.afC,
//           this.sR,
//           this.bI,
//           this.rT,
//           this.cc,
//           this.cB,
//           this.fB,
//     });

//     factory Infant.fromJson(Map<String, dynamic> json) =>  Infant(
//         fC: FC.fromJson(json["fC"]),
//         afC: AfC.fromJson(json["afC"]),
//         sR: json["sR"],
//         bI: BI.fromJson(json["bI"]),
//         rT: json["rT"],
//         cc: json["cc"],
//         cB: json["cB"],
//         fB: json["fB"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fC": fC.toJson(),
//         "afC": afC.toJson(),
//         "sR": sR,
//         "bI": bI.toJson(),
//         "rT": rT,
//         "cc": cc,
//         "cB": cB,
//         "fB": fB,
//     };
// }class Child {
//     FC fC;
//     AfC afC;
//     int sR;
//     BI bI;
//     int rT;
//     String cc;
//     String cB;
//     String fB;

//     Child({
//           this.fC,
//           this.afC,
//           this.sR,
//           this.bI,
//           this.rT,
//           this.cc,
//           this.cB,
//           this.fB,
//     });

//     factory Child.fromJson(Map<String, dynamic> json) => Child(
//         fC: FC.fromJson(json["fC"]),
//         afC: AfC.fromJson(json["afC"]),
//         sR: json["sR"],
//         bI: BI.fromJson(json["bI"]),
//         rT: json["rT"],
//         cc: json["cc"],
//         cB: json["cB"],
//         fB: json["fB"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fC": fC.toJson(),
//         "afC": afC.toJson(),
//         "sR": sR,
//         "bI": bI.toJson(),
//         "rT": rT,
//         "cc": cc,
//         "cB": cB,
//         "fB": fB,
//     };
// }

// class Adult {
//     FC fC;
//     AfC afC;
//     int sR;
//     BI bI;
//     int rT;
//     String cc;
//     String cB;
//     String fB;

//     Adult({
//           this.fC,
//           this.afC,
//           this.sR,
//           this.bI,
//           this.rT,
//           this.cc,
//           this.cB,
//           this.fB,
//     });

//     factory Adult.fromJson(Map<String, dynamic> json) => Adult(
//         fC: FC.fromJson(json["fC"]),
//         afC: AfC.fromJson(json["afC"]),
//         sR: json["sR"],
//         bI: BI.fromJson(json["bI"]),
//         rT: json["rT"],
//         cc: json["cc"],
//         cB: json["cB"],
//         fB: json["fB"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fC": fC.toJson(),
//         "afC": afC.toJson(),
//         "sR": sR,
//         "bI": bI.toJson(),
//         "rT": rT,
//         "cc": cc,
//         "cB": cB,
//         "fB": fB,
//     };
// }

// class AfC {
//     Taf taf;

//     AfC({
//           this.taf,
//     });

//     factory AfC.fromJson(Map<String, dynamic> json) => AfC(
//         taf: Taf.fromJson(json["TAF"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "TAF": taf.toJson(),
//     };
// }

// class Taf {
//     double ot;
//     double yq;
//     double agst;

//     Taf({
//           this.ot,
//           this.yq,
//           this.agst,
//     });

//     factory Taf.fromJson(Map<String, dynamic> json) => Taf(
//         ot: json["OT"],
//         yq: json["YQ"],
//         agst: json["AGST"],
//     );

//     Map<String, dynamic> toJson() => {
//         "OT": ot,
//         "YQ": yq,
//         "AGST": agst,
//     };
// }

// class BI {
//     String iB;
//     String cB;

//     BI({
//           this.iB,
//           this.cB,
//     });

//     factory BI.fromJson(Map<String, dynamic> json) => BI(
//         iB: json["iB"],
//         cB: json["cB"],
//     );

//     Map<String, dynamic> toJson() => {
//         "iB": iB,
//         "cB": cB,
//     };
// }

// class FC {
//     double tf;
//     double nf;
//    double bf;
//    double taf;

//     FC({
//           this.tf,
//           this.nf,
//           this.bf,
//           this.taf,
//     });

//     factory FC.fromJson(Map<String, dynamic> json) => FC(
//         tf: json["TF"],
//         nf: json["NF"],
//         bf: json["BF"],
//         taf: json["TAF"],
//     );

//     Map<String, dynamic> toJson() => {
//         "TF": tf,
//         "NF": nf,
//         "BF": bf,
//         "TAF": taf,
//     };
// }

// class Tai {
//     Map<String, List<Tbi>> tbi;

//     Tai({
//           this.tbi,
//     });

//     factory Tai.fromJson(Map<String, dynamic> json) => Tai(
//         tbi: Map.from(json["tbi"]).map((k, v) => MapEntry<String, List<Tbi>>(k, List<Tbi>.from(v.map((x) => Tbi.fromJson(x))))),
//     );

//     Map<String, dynamic> toJson() => {
//         "tbi": Map.from(tbi).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
//     };
// }

// class Tbi {
//     BI adult;

//     Tbi({
//           this.adult,
//     });

//     factory Tbi.fromJson(Map<String, dynamic> json) => Tbi(
//         adult: BI.fromJson(json["ADULT"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "ADULT": adult.toJson(),
//     };
// }

// class Status {
//     bool success;
//     int httpStatus;

//     Status({
//           this.success,
//           this.httpStatus,
//     });

//     factory Status.fromJson(Map<String, dynamic> json) => Status(
//         success: json["success"],
//         httpStatus: json["httpStatus"],
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "httpStatus": httpStatus,
//     };
// }



