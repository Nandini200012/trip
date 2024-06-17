import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> searchDomesticOnewayAPI(
    String cabin_class,
    String adult,
    String child,
    String infant,
    String from_code,
    String to_code,
    String date) async {
  print("Air search domestic one way");

  print("cabincalss:$cabin_class");
  print("adult:$adult");
  print("child:$child");
  print("infant:$infant");
  print("from :$from_code");
  print("to:$to_code");
  print("date:$date");

  var url = Uri.parse('https://apitest.tripjack.com/fms/v1/air-search-all');
  print("url : $url");

  // Define your request body here
  var requestBody = {
    "searchQuery": {
      "cabinClass": cabin_class,
      "paxInfo": {
        "ADULT": adult != null ? adult : '1',
        "CHILD": child != null ? child : "0",
        "INFANT": infant != null ? infant : "0"
      },
      "routeInfos": [
        {
          "fromCityOrAirport": {"code": from_code},
          "toCityOrAirport": {"code": to_code},
          "travelDate": date
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
        print('oneway responseBody');
        print(responseBody);
        var decodedData = jsonDecode(responseBody);
        // Onewayobj model = Onewayobj.fromJson(jsonDecode(responseBody));
        // print("model:$model");
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
      print(errorMessage);
      return 'failed';
    }
  } catch (e) {
    print('Error: $e');
    return 'failed';
  }
}


class Onewayobj {
  SearchResult searchResult;
  Status status;

  Onewayobj({
    this.searchResult,
    this.status,
  });

  factory Onewayobj.fromJson(Map<String, dynamic> json) => Onewayobj(
        searchResult: SearchResult.fromJson(json["searchResult"]),
        status: Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "searchResult": searchResult.toJson(),
        "status": status.toJson(),
      };
}

class SearchResult {
  TripInfos tripInfos;

  SearchResult({
    this.tripInfos,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        tripInfos: TripInfos.fromJson(json["tripInfos"]),
      );

  Map<String, dynamic> toJson() => {
        "tripInfos": tripInfos.toJson(),
      };
}

class TripInfos {
  List<Onward> onward;

  TripInfos({
    this.onward,
  });

  factory TripInfos.fromJson(Map<String, dynamic> json) => TripInfos(
        onward:
            List<Onward>.from(json["ONWARD"].map((x) => Onward.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ONWARD": List<dynamic>.from(onward.map((x) => x.toJson())),
      };
}

class Onward {
  List<SI> sI;
  List<TotalPriceList> totalPriceList;

  Onward({
    this.sI,
    this.totalPriceList,
  });

  factory Onward.fromJson(Map<String, dynamic> json) => Onward(
        sI: List<SI>.from(json["sI"].map((x) => SI.fromJson(x))),
        totalPriceList: json["totalPriceList"] == null
            ? []
            : List<TotalPriceList>.from(
                json["totalPriceList"].map((x) => TotalPriceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sI": List<dynamic>.from(sI.map((x) => x.toJson())),
        "totalPriceList":
            List<dynamic>.from(totalPriceList.map((x) => x.toJson())),
      };
}

class SI {
  String id;
  FD fD;
  int stops;
  Aa so;
  double duration;
  Aa da;
  Aa aa;
  String dt;
  String at;
  bool iand;
  bool isRs;
  double sN;
  double cT;

  SI({
    this.id,
    this.fD,
    this.stops,
    this.so,
    this.duration,
    this.da,
    this.aa,
    this.dt,
    this.at,
    this.iand,
    this.isRs,
    this.sN,
    this.cT,
  });

  factory SI.fromJson(Map<String, dynamic> json) => SI(
        id: json["id"],
        fD: FD.fromJson(json["fD"]),
        stops: json["stops"],
        so: json["so"] == null ? null : Aa.fromJson(json["so"]),
        duration: json["duration"],
        da: Aa.fromJson(json["da"]),
        aa: Aa.fromJson(json["aa"]),
        dt: json["dt"],
        at: json["at"],
        iand: json["iand"],
        isRs: json["isRs"],
        sN: json["sN"],
        cT: json["cT"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fD": fD.toJson(),
        "stops": stops,
        "so": so?.toJson(),
        "duration": duration,
        "da": da.toJson(),
        "aa": aa.toJson(),
        "dt": dt,
        "at": at,
        "iand": iand,
        "isRs": isRs,
        "sN": sN,
        "cT": cT,
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

class TotalPriceList {
  Fd fd;
  String fareIdentifier;
  String id;
  List<dynamic> msri;
  List<dynamic> messages;
  Tai tai;
  bool icca;

  TotalPriceList({
    this.fd,
    this.fareIdentifier,
    this.id,
    this.msri,
    this.messages,
    this.tai,
    this.icca,
  });


factory TotalPriceList.fromJson(Map<String, dynamic> json) => TotalPriceList(
      fd: Fd.fromJson(json["fd"]),
      fareIdentifier: json["fareIdentifier"],
      id: json["id"],
      msri: json["msri"] != null ? List<dynamic>.from(json["msri"].map((x) => x)) : [],
      messages: json["messages"] != null ? List<dynamic>.from(json["messages"].map((x) => x)) : [],
      tai: json["tai"] != null ? Tai.fromJson(json["tai"]) : null,
      icca: json["icca"] ?? false,
    );

Map<String, dynamic> toJson() => {
      "fd": fd.toJson(),
      "fareIdentifier": fareIdentifier,
      "id": id,
      "msri": msri,
      "messages": messages,
      "tai": tai?.toJson(),
      "icca": icca,
    };

}

class Fd {
  Adult child;
  Infant infant;
  Adult adult;

  Fd({
    this.child,
    this.infant,
    this.adult,
  });

  factory Fd.fromJson(Map<String, dynamic> json) => Fd(
        child: Adult.fromJson(json["CHILD"]),
        infant: Infant.fromJson(json["INFANT"]),
        adult: Adult.fromJson(json["ADULT"]),
      );

  Map<String, dynamic> toJson() => {
        "CHILD": child.toJson(),
        "INFANT": infant.toJson(),
        "ADULT": adult.toJson(),
      };
}

class Adult {
  FC fC;
  AdultAfC afC;
  double sR;
  BI bI;
  double rT;
  Cc cc;
  String cB;
  String fB;
  bool mI;

  Adult({
    this.fC,
    this.afC,
    this.sR,
    this.bI,
    this.rT,
    this.cc,
    this.cB,
    this.fB,
    this.mI,
  });

  factory Adult.fromJson(Map<String, dynamic> json) => Adult(
        fC: FC.fromJson(json["fC"]),
        afC: AdultAfC.fromJson(json["afC"]),
        sR: json["sR"],
        bI: BI.fromJson(json["bI"]),
        rT: json["rT"],
        cc: ccValues.map[json["cc"]],
        cB: json["cB"],
        fB: json["fB"],
        mI: json["mI"],
      );

  Map<String, dynamic> toJson() => {
        "fC": fC.toJson(),
        "afC": afC.toJson(),
        "sR": sR,
        "bI": bI.toJson(),
        "rT": rT,
        "cc": ccValues.reverse[cc],
        "cB": cB,
        "fB": fB,
        "mI": mI,
      };
}

class AdultAfC {
  PurpleTaf taf;

  AdultAfC({
    this.taf,
  });

  factory AdultAfC.fromJson(Map<String, dynamic> json) => AdultAfC(
        taf: PurpleTaf.fromJson(json["TAF"]),
      );

  Map<String, dynamic> toJson() => {
        "TAF": taf.toJson(),
      };
}

class PurpleTaf {
  double ot;
  double yr;
  double agst;

  PurpleTaf({
    this.ot,
    this.yr,
    this.agst,
  });

  factory PurpleTaf.fromJson(Map<String, dynamic> json) => PurpleTaf(
        ot: json["OT"],
        yr: json["YR"],
        agst: json["AGST"],
      );

  Map<String, dynamic> toJson() => {
        "OT": ot,
        "YR": yr,
        "AGST": agst,
      };
}

class BI {
  String iB;
  String cB;

  BI({
    this.iB,
    this.cB,
  });

  factory BI.fromJson(Map<String, dynamic> json) => BI(
        iB: json["iB"],
        cB: json["cB"],
      );

  Map<String, dynamic> toJson() => {
        "iB": iB,
        "cB": cB,
      };
}

// enum CB {
//     THE_7_KG
// }

// final cbValues = EnumValues({
//     "7 Kg": CB.THE_7_KG
// });

// enum IB {
//     THE_10_KG_01_PIECE_ONLY,
//     THE_15_KG,
//     THE_20_KG,
//     THE_25_KG_01_PIECE_ONLY,
//     THE_30_KG
// }

// final ibValues = EnumValues({
//     "10 Kg (01 Piece only)": IB.THE_10_KG_01_PIECE_ONLY,
//     "15 Kg": IB.THE_15_KG,
//     "20 Kg": IB.THE_20_KG,
//     "25 Kg (01 Piece only)": IB.THE_25_KG_01_PIECE_ONLY,
//     "30 Kg": IB.THE_30_KG
// });

enum Cc { BUSINESS, ECONOMY, PREMIUM_ECONOMY }

final ccValues = EnumValues({
  "BUSINESS": Cc.BUSINESS,
  "ECONOMY": Cc.ECONOMY,
  "PREMIUM_ECONOMY": Cc.PREMIUM_ECONOMY
});

class FC {
  double nf;
  double tf;
  double taf;
  double bf;

  FC({
    this.nf,
    this.tf,
    this.taf,
    this.bf,
  });

  factory FC.fromJson(Map<String, dynamic> json) => FC(
        nf: json["NF"],
        tf: json["TF"],
        taf: json["TAF"],
        bf: json["BF"],
      );

  Map<String, dynamic> toJson() => {
        "NF": nf,
        "TF": tf,
        "TAF": taf,
        "BF": bf,
      };
}

class Infant {
  FC fC;
  InfantAfC afC;
  double sR;
  BI bI;
  double rT;
  Cc cc;
  String cB;
  String fB;
  bool mI;

  Infant({
    this.fC,
    this.afC,
    this.sR,
    this.bI,
    this.rT,
    this.cc,
    this.cB,
    this.fB,
    this.mI,
  });

  factory Infant.fromJson(Map<String, dynamic> json) => Infant(
        fC: FC.fromJson(json["fC"]),
        afC: InfantAfC.fromJson(json["afC"]),
        sR: json["sR"],
        bI: BI.fromJson(json["bI"]),
        rT: json["rT"],
        cc: ccValues.map[json["cc"]],
        cB: json["cB"],
        fB: json["fB"],
        mI: json["mI"],
      );

  Map<String, dynamic> toJson() => {
        "fC": fC.toJson(),
        "afC": afC.toJson(),
        "sR": sR,
        "bI": bI.toJson(),
        "rT": rT,
        "cc": ccValues.reverse[cc],
        "cB": cB,
        "fB": fB,
        "mI": mI,
      };
}

class InfantAfC {
  FluffyTaf taf;

  InfantAfC({
    this.taf,
  });

  factory InfantAfC.fromJson(Map<String, dynamic> json) => InfantAfC(
        taf: FluffyTaf.fromJson(json["TAF"]),
      );

  Map<String, dynamic> toJson() => {
        "TAF": taf.toJson(),
      };
}

class FluffyTaf {
  int yr;
  int agst;

  FluffyTaf({
    this.yr,
    this.agst,
  });

  factory FluffyTaf.fromJson(Map<String, dynamic> json) => FluffyTaf(
        yr: json["YR"],
        agst: json["AGST"],
      );

  Map<String, dynamic> toJson() => {
        "YR": yr,
        "AGST": agst,
      };
}

class Tai {
  Map<String, List<Tbi>> tbi;

  Tai({
    this.tbi,
  });

  factory Tai.fromJson(Map<String, dynamic> json) => Tai(
        tbi: Map.from(json["tbi"]).map((k, v) => MapEntry<String, List<Tbi>>(
            k, List<Tbi>.from(v.map((x) => Tbi.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "tbi": Map.from(tbi).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class Tbi {
  BI child;
  BI infant;
  BI adult;

  Tbi({
    this.child,
    this.infant,
    this.adult,
  });

  factory Tbi.fromJson(Map<String, dynamic> json) => Tbi(
        child: json["CHILD"] == null ? null : BI.fromJson(json["CHILD"]),
        infant: json["INFANT"] == null ? null : BI.fromJson(json["INFANT"]),
        adult: json["ADULT"] == null ? null : BI.fromJson(json["ADULT"]),
      );

  Map<String, dynamic> toJson() => {
        "CHILD": child?.toJson(),
        "INFANT": infant?.toJson(),
        "ADULT": adult?.toJson(),
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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}























// class Onewayobj {
//   SearchResult searchResult;
//   Status status;

//   Onewayobj({
//     this.searchResult,
//     this.status,
//   });

//   factory Onewayobj.fromJson(Map<String, dynamic> json) => Onewayobj(
//         searchResult: SearchResult.fromJson(json["searchResult"]),
//         status: Status.fromJson(json["status"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "searchResult": searchResult.toJson(),
//         "status": status.toJson(),
//       };
// }

// class SearchResult {
//   TripInfos tripInfos;

//   SearchResult({
//     this.tripInfos,
//   });

//   factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
//         tripInfos: TripInfos.fromJson(json["tripInfos"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "tripInfos": tripInfos.toJson(),
//       };
// }

// class TripInfos {
//   List<Onward> onward;

//   TripInfos({
//     this.onward,
//   });

//   factory TripInfos.fromJson(Map<String, dynamic> json) => TripInfos(
//         onward:
//             List<Onward>.from(json["ONWARD"].map((x) => Onward.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "ONWARD": List<dynamic>.from(onward.map((x) => x.toJson())),
//       };
// }

// class Onward {
//   List<SI> sI;
//   List<TotalPriceList> totalPriceList;

//   Onward({
//     this.sI,
//     this.totalPriceList,
//   });

//   factory Onward.fromJson(Map<String, dynamic> json) => Onward(
//         sI: List<SI>.from(json["sI"].map((x) => SI.fromJson(x))),
//         totalPriceList: List<TotalPriceList>.from(
//             json["totalPriceList"].map((x) => TotalPriceList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "sI": List<dynamic>.from(sI.map((x) => x.toJson())),
//         "totalPriceList":
//             List<dynamic>.from(totalPriceList.map((x) => x.toJson())),
//       };
// }

// class so {}

// class SI {
//   String id;
//   FD fD;
//   int stops;
//   Aa so;
//   double duration;
//   Aa da;
//   Aa aa;
//   String dt;
//   String at;
//   bool iand;
//   bool isRs;
//   double sN;
//   double cT;

//   SI({
//     this.id,
//     this.fD,
//     this.stops,
//     this.so,
//     this.duration,
//     this.da,
//     this.aa,
//     this.dt,
//     this.at,
//     this.iand,
//     this.isRs,
//     this.sN,
//     this.cT,
//   });

//   factory SI.fromJson(Map<String, dynamic> json) => SI(
//         id: json["id"].toString(),
//         fD: FD.fromJson(json["fD"]),
//         stops: json["stops"],
//         so: json["so"] == null ? [] : Aa.fromJson(json["so"]),
//         duration: json["duration"],
//         da: Aa.fromJson(json["da"]),
//         aa: Aa.fromJson(json["aa"]),
//         dt: json["dt"].toString(),
//         at: json["at"].toString(),
//         iand: json["iand"],
//         isRs: json["isRs"],
//         sN: json["sN"],
//         cT: json["cT"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "fD": fD.toJson(),
//         "stops": stops,
//         "so": so == null ? [] : so.toJson(),
//         "duration": duration,
//         "da": da.toJson(),
//         "aa": aa.toJson(),
//         "dt": dt,
//         "at": at,
//         "iand": iand,
//         "isRs": isRs,
//         "sN": sN,
//         "cT": cT,
//       };
// }

// class Aa {
//   String code;
//   String name;
//   String cityCode;
//   String city;
//   String country;
//   String countryCode;
//   String terminal;

//   Aa({
//     this.code,
//     this.name,
//     this.cityCode,
//     this.city,
//     this.country,
//     this.countryCode,
//     this.terminal,
//   });

//   factory Aa.fromJson(Map<String, dynamic> json) => Aa(
//         code: json["code"],
//         name: json["name"],
//         cityCode: json["cityCode"],
//         city: json["city"],
//         country: json["country"],
//         countryCode: json["countryCode"],
//         terminal: json["terminal"],
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "name": name,
//         "cityCode": cityCode,
//         "city": city,
//         "country": country,
//         "countryCode": countryCode,
//         "terminal": terminal,
//       };
// }

// // enum City {
// //     DELHI,
// //     HYDERABAD,
// //     MUMBAI
// // }

// // final cityValues = EnumValues({
// //     "Delhi": City.DELHI,
// //     "Hyderabad": City.HYDERABAD,
// //     "Mumbai": City.MUMBAI
// // });

// // enum CityCodeEnum {
// //     BOM,
// //     DEL,
// //     HYD
// // }

// // final cityCodeEnumValues = EnumValues({
// //     "BOM": CityCodeEnum.BOM,
// //     "DEL": CityCodeEnum.DEL,
// //     "HYD": CityCodeEnum.HYD
// // });

// // enum Country {
// //     INDIA
// // }

// // final countryValues = EnumValues({
// //     "India": Country.INDIA
// // });

// // enum CountryCode {
// //     IN
// // }

// // final countryCodeValues = EnumValues({
// //     "IN": CountryCode.IN
// // });

// // enum AaName {
// //     CHHATRAPATI_SHIVAJI,
// //     DELHI_INDIRA_GANDHI_INTL,
// //     SHAMSHABAD_RAJIV_GANDHI_INTL_ARPT
// // }

// // final aaNameValues = EnumValues({
// //     "Chhatrapati Shivaji": AaName.CHHATRAPATI_SHIVAJI,
// //     "Delhi Indira Gandhi Intl": AaName.DELHI_INDIRA_GANDHI_INTL,
// //     "Shamshabad Rajiv Gandhi Intl Arpt": AaName.SHAMSHABAD_RAJIV_GANDHI_INTL_ARPT
// // });

// // enum Terminal {
// //     TERMINAL_2,
// //     TERMINAL_3
// // }

// // final terminalValues = EnumValues({
// //     "Terminal 2": Terminal.TERMINAL_2,
// //     "Terminal 3": Terminal.TERMINAL_3
// // });

// class FD {
//   AI aI;
//   String fN;
//   String eT;

//   FD({
//     this.aI,
//     this.fN,
//     this.eT,
//   });

//   factory FD.fromJson(Map<String, dynamic> json) => FD(
//         aI: AI.fromJson(json["aI"]),
//         fN: json["fN"].toString(),
//         eT: json["eT"].toString(),
//       );

//   Map<String, dynamic> toJson() => {
//         "aI": aI.toJson(),
//         "fN": fN,
//         "eT": eT,
//       };
// }

// class AI {
//   String code;
//   String name;
//   bool isLcc;

//   AI({
//     this.code,
//     this.name,
//     this.isLcc,
//   });

//   factory AI.fromJson(Map<String, dynamic> json) => AI(
//         code: json["code"],
//         name: json["name"],
//         isLcc: json["isLcc"],
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "name": name,
//         "isLcc": isLcc,
//       };
// }

// class TotalPriceList {
//   Fd fd;
//   String fareIdentifier;
//   String id;
//   List<dynamic> msri;
//   List<dynamic> messages;
//   Tai tai;
//   bool icca;

//   TotalPriceList({
//     this.fd,
//     this.fareIdentifier,
//     this.id,
//     this.msri,
//     this.messages,
//     this.tai,
//     this.icca,
//   });

//   factory TotalPriceList.fromJson(Map<String, dynamic> json) => TotalPriceList(
//         fd: Fd.fromJson(json["fd"]),
//         fareIdentifier: json["fareIdentifier"].toString(),
//         id: json["id"],
//         msri: List<dynamic>.from(json["msri"].map((x) => x)),
//         messages: List<dynamic>.from(json["messages"].map((x) => x)),
//         tai: Tai.fromJson(json["tai"]),
//         icca: json["icca"],
//       );

//   Map<String, dynamic> toJson() => {
//         "fd": fd.toJson(),
//         "fareIdentifier": fareIdentifier,
//         "id": id,
//         "msri": List<dynamic>.from(msri.map((x) => x)),
//         "messages": List<dynamic>.from(messages.map((x) => x)),
//         "tai": tai.toJson(),
//         "icca": icca,
//       };
// }

// // enum FareIdentifier {
// //     PUBLISHED
// // }

// // final fareIdentifierValues = EnumValues({
// //     "PUBLISHED": FareIdentifier.PUBLISHED
// // });

// class Fd {
//   Adult child;
//   Infant infant;
//   Adult adult;

//   Fd({
//     this.child,
//     this.infant,
//     this.adult,
//   });

//   factory Fd.fromJson(Map<String, dynamic> json) => Fd(
//         child: Adult.fromJson(json["CHILD"]),
//         infant: Infant.fromJson(json["INFANT"]),
//         adult: Adult.fromJson(json["ADULT"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "CHILD": child.toJson(),
//         "INFANT": infant.toJson(),
//         "ADULT": adult.toJson(),
//       };
// }

// class Adult {
//   FC fC;
//   AdultAfC afC;
//   double sR;
//   BI bI;
//   double rT;
//   Cc cc;
//   String cB;
//   String fB;
//   bool mI;

//   Adult({
//     this.fC,
//     this.afC,
//     this.sR,
//     this.bI,
//     this.rT,
//     this.cc,
//     this.cB,
//     this.fB,
//     this.mI,
//   });

//   factory Adult.fromJson(Map<String, dynamic> json) => Adult(
//         fC: FC.fromJson(json["fC"]),
//         afC: AdultAfC.fromJson(json["afC"]),
//         sR: json["sR"],
//         bI: BI.fromJson(json["bI"]),
//         rT: json["rT"],
//         cc: ccValues.map[json["cc"]],
//         cB: json["cB"],
//         fB: json["fB"],
//         mI: json["mI"],
//       );

//   Map<String, dynamic> toJson() => {
//         "fC": fC.toJson(),
//         "afC": afC.toJson(),
//         "sR": sR,
//         "bI": bI.toJson(),
//         "rT": rT,
//         "cc": ccValues.reverse[cc],
//         "cB": cB,
//         "fB": fB,
//         "mI": mI,
//       };
// }

// class AdultAfC {
//   PurpleTaf taf;

//   AdultAfC({
//     this.taf,
//   });

//   factory AdultAfC.fromJson(Map<String, dynamic> json) => AdultAfC(
//         taf: PurpleTaf.fromJson(json["TAF"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "TAF": taf.toJson(),
//       };
// }

// class PurpleTaf {
//   double ot;
//   double yr;
//   double agst;

//   PurpleTaf({
//     this.ot,
//     this.yr,
//     this.agst,
//   });

//   factory PurpleTaf.fromJson(Map<String, dynamic> json) => PurpleTaf(
//         ot: json["OT"],
//         yr: json["YR"],
//         agst: json["AGST"],
//       );

//   Map<String, dynamic> toJson() => {
//         "OT": ot,
//         "YR": yr,
//         "AGST": agst,
//       };
// }

// class BI {
//   String iB;
//   String cB;

//   BI({
//     this.iB,
//     this.cB,
//   });

//   factory BI.fromJson(Map<String, dynamic> json) => BI(
//         iB: json["iB"],
//         cB: json["cB"],
//       );

//   Map<String, dynamic> toJson() => {
//         "iB": iB,
//         "cB": cB,
//       };
// }

// // enum CB {
// //     THE_7_KG
// // }

// // final cbValues = EnumValues({
// //     "7 Kg": CB.THE_7_KG
// // });

// // enum IB {
// //     THE_10_KG_01_PIECE_ONLY,
// //     THE_15_KG,
// //     THE_20_KG,
// //     THE_25_KG_01_PIECE_ONLY,
// //     THE_30_KG
// // }

// // final ibValues = EnumValues({
// //     "10 Kg (01 Piece only)": IB.THE_10_KG_01_PIECE_ONLY,
// //     "15 Kg": IB.THE_15_KG,
// //     "20 Kg": IB.THE_20_KG,
// //     "25 Kg (01 Piece only)": IB.THE_25_KG_01_PIECE_ONLY,
// //     "30 Kg": IB.THE_30_KG
// // });

// enum Cc { BUSINESS, ECONOMY, PREMIUM_ECONOMY }

// final ccValues = EnumValues({
//   "BUSINESS": Cc.BUSINESS,
//   "ECONOMY": Cc.ECONOMY,
//   "PREMIUM_ECONOMY": Cc.PREMIUM_ECONOMY
// });

// class FC {
//   double nf;
//   double tf;
//   double taf;
//   double bf;

//   FC({
//     this.nf,
//     this.tf,
//     this.taf,
//     this.bf,
//   });

//   factory FC.fromJson(Map<String, dynamic> json) => FC(
//         nf: json["NF"],
//         tf: json["TF"],
//         taf: json["TAF"],
//         bf: json["BF"],
//       );

//   Map<String, dynamic> toJson() => {
//         "NF": nf,
//         "TF": tf,
//         "TAF": taf,
//         "BF": bf,
//       };
// }

// class Infant {
//   FC fC;
//   InfantAfC afC;
//   double sR;
//   BI bI;
//   double rT;
//   Cc cc;
//   String cB;
//   String fB;
//   bool mI;

//   Infant({
//     this.fC,
//     this.afC,
//     this.sR,
//     this.bI,
//     this.rT,
//     this.cc,
//     this.cB,
//     this.fB,
//     this.mI,
//   });

//   factory Infant.fromJson(Map<String, dynamic> json) => Infant(
//         fC: FC.fromJson(json["fC"]),
//         afC: InfantAfC.fromJson(json["afC"]),
//         sR: json["sR"],
//         bI: BI.fromJson(json["bI"]),
//         rT: json["rT"],
//         cc: ccValues.map[json["cc"]],
//         cB: json["cB"],
//         fB: json["fB"],
//         mI: json["mI"],
//       );

//   Map<String, dynamic> toJson() => {
//         "fC": fC.toJson(),
//         "afC": afC.toJson(),
//         "sR": sR,
//         "bI": bI.toJson(),
//         "rT": rT,
//         "cc": ccValues.reverse[cc],
//         "cB": cB,
//         "fB": fB,
//         "mI": mI,
//       };
// }

// class InfantAfC {
//   FluffyTaf taf;

//   InfantAfC({
//     this.taf,
//   });

//   factory InfantAfC.fromJson(Map<String, dynamic> json) => InfantAfC(
//         taf: FluffyTaf.fromJson(json["TAF"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "TAF": taf.toJson(),
//       };
// }

// class FluffyTaf {
//   int yr;
//   int agst;

//   FluffyTaf({
//     this.yr,
//     this.agst,
//   });

//   factory FluffyTaf.fromJson(Map<String, dynamic> json) => FluffyTaf(
//         yr: json["YR"],
//         agst: json["AGST"],
//       );

//   Map<String, dynamic> toJson() => {
//         "YR": yr,
//         "AGST": agst,
//       };
// }

// class Tai {
//   Map<String, List<Tbi>> tbi;

//   Tai({
//     this.tbi,
//   });

//   factory Tai.fromJson(Map<String, dynamic> json) => Tai(
//         tbi: Map.from(json["tbi"]).map((k, v) => MapEntry<String, List<Tbi>>(
//             k, List<Tbi>.from(v.map((x) => Tbi.fromJson(x))))),
//       );

//   Map<String, dynamic> toJson() => {
//         "tbi": Map.from(tbi).map((k, v) => MapEntry<String, dynamic>(
//             k, List<dynamic>.from(v.map((x) => x.toJson())))),
//       };
// }

// class Tbi {
//   BI child;
//   BI infant;
//   BI adult;

//   Tbi({
//     this.child,
//     this.infant,
//     this.adult,
//   });

//   factory Tbi.fromJson(Map<String, dynamic> json) => Tbi(
//         child: json["CHILD"] == null ? null : BI.fromJson(json["CHILD"]),
//         infant: json["INFANT"] == null ? null : BI.fromJson(json["INFANT"]),
//         adult: json["ADULT"] == null ? null : BI.fromJson(json["ADULT"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "CHILD": child?.toJson(),
//         "INFANT": infant?.toJson(),
//         "ADULT": adult?.toJson(),
//       };
// }

// class Status {
//   bool success;
//   int httpStatus;

//   Status({
//     this.success,
//     this.httpStatus,
//   });

//   factory Status.fromJson(Map<String, dynamic> json) => Status(
//         success: json["success"],
//         httpStatus: json["httpStatus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "httpStatus": httpStatus,
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
