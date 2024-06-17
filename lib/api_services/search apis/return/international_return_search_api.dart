import 'dart:convert';
import 'package:http/http.dart' as http;


Future<String> International_returnsearchapi(
    String cabin_class,
    String adult,
    String child,
    String infant,
    String from_code,
    String to_code,
    String date1,
    String date2) async {
  print("Air search International Return");

  print("cabincalss:$cabin_class");
  print("adult:$adult");
  print("child:$child");
  print("infant:$infant");
  print("from :$from_code");
  print("to:$to_code");
  print("depdate:$date1");
  print("retdate:$date2");

  var url = Uri.parse('https://apitest.tripjack.com/fms/v1/air-search-all');
  print("url : $url");

  // Define your request body here
  var requestBody = {
    "searchQuery": {
      "cabinClass": cabin_class,
      "paxInfo": {
        "ADULT": adult == null ? adult : '1',
        "CHILD": child == null ? child : "0",
        "INFANT": infant == null ? infant : "0"
      },
      "routeInfos": [
        {
          "fromCityOrAirport": {"code": from_code},
          "toCityOrAirport": {"code": to_code},
          "travelDate": date1
        },
        {
          "fromCityOrAirport": {"code": to_code},
          "toCityOrAirport": {"code": from_code},
          "travelDate": date2
        }
      ],
      "searchModifiers": {"isDirectFlight": true, "isConnectingFlight": false}
    }
  };

  // Encode the request body to JSON
  var requestBodyJson = jsonEncode(requestBody);

  try {
    // Make the POST request
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
        // print('responseBody');
        // printred(responseBody);
        var decodedData = jsonDecode(responseBody);
        return responseBody;
      } catch (e) {
        print('Error decoding JSON: $e');
        return 'failed';
      }
    } else {
      String errorMessage =
          'Request failed with status: ${response.statusCode}.';
      if (response.body == null && response.body.isNotEmpty) {
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



class ComboFlightData {
  TripInfos tripInfos;

  ComboFlightData({this.tripInfos});

  factory ComboFlightData.fromJson(Map<String, dynamic> json) {
    return ComboFlightData(
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
        priceList?.map((price) => TotalPriceList.fromJson(price))?.toList() ?? [];

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


// class FareDetails {
//   FareComponents fareComponents;
//   AdditionalFareComponents additionalFareComponents;
//   String seatRemaining;
//   BaggageInfo baggageInfo;
//   String refundType;
//   String cabinClass;
//   String bookingClass;
//   String fareBasis;

//   FareDetails({
//     this.fareComponents,
//     this.additionalFareComponents,
//     this.seatRemaining,
//     this.baggageInfo,
//     this.refundType,
//     this.cabinClass,
//     this.bookingClass,
//     this.fareBasis,
//   });

//   factory FareDetails.fromJson(Map<String, dynamic> json) {
//     return FareDetails(
//       fareComponents: FareComponents.fromJson(json['fC']),
//       additionalFareComponents: AdditionalFareComponents.fromJson(json['afC']),
//       seatRemaining: json['sR'].toString(),
//       baggageInfo: BaggageInfo.fromJson(json['bI']),
//       refundType: json['rT'].toString(),
//       cabinClass: json['cc'],
//       bookingClass: json['cB'],
//       fareBasis: json['fB'],
//     );
//   }
// }

// class FareComponents {
//   double totalFare;
//   double totalAdditionalFare;
//   double baseFare;
//   double netFare;

//   FareComponents({
//     this.totalFare,
//     this.totalAdditionalFare,
//     this.baseFare,
//     this.netFare,
//   });

//   factory FareComponents.fromJson(Map<String, dynamic> json) {
//     return FareComponents(
//       totalFare: json['TF'],
//       totalAdditionalFare: json['TAF'],
//       baseFare: json['BF'],
//       netFare: json['NF'],
//     );
//   }
// }

// class AdditionalFareComponents {
//   double YR;
//   double AGST;
//   double MFT;
//   double YQ;
//   double MF;
//   double OT;

//   AdditionalFareComponents({
//     this.YR,
//     this.AGST,
//     this.MFT,
//     this.YQ,
//     this.MF,
//     this.OT,
//   });

//   factory AdditionalFareComponents.fromJson(Map<String, dynamic> json) {
//     return AdditionalFareComponents(
//       YR: json['YR'],
//       AGST: json['AGST'],
//       MFT: json['MFT'],
//       YQ: json['YQ'],
//       MF: json['MF'],
//       OT: json['OT'],
//     );
//   }
// }

// class BaggageInfo {
//   String includedBaggage;
//   String cabinBaggage;

//   BaggageInfo({this.includedBaggage, this.cabinBaggage});

//   factory BaggageInfo.fromJson(Map<String, dynamic> json) {
//     return BaggageInfo(
//       includedBaggage: json['iB'],
//       cabinBaggage: json['cB'],
//     );
//   }
// }






















