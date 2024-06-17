import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';

Future<String> revalidateDomesticOnewayAPI(List<String> priceid) async {
  print("revalidateDomesticOnewayAPI called");
  print("priceid: $priceid");

  var url = Uri.parse('https://apitest.tripjack.com/fms/v1/review');
  print("url: $url");

  // Prepare the request body
  var requestBody = {"priceIds": priceid};
  var requestBodyJson = jsonEncode(requestBody);

  printWhite("revalidate requestBodyJson: $requestBodyJson");

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

        printWhite("revalidateDomesticOnewayAPI responseBody: $responseBody");

        // Return the response body directly as a string
        return responseBody;
      } catch (e) {
        print('Error decoding JSON: $e');
        return 'failed';
      }
    } else {
      String errorMessage =
          'Request failed with status: ${response.statusCode}.';
      if (response.body.isNotEmpty) {
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

class Revalidate {
  List<TripInfo> tripInfos;
  SearchQuery searchQuery;
  String bookingId;
  revalidateTotalPriceInfo totalPriceInfo;
  Status status;
  Conditions conditions;

  Revalidate({
    this.tripInfos,
    this.searchQuery,
    this.bookingId,
    this.totalPriceInfo,
    this.status,
    this.conditions,
  });

  factory Revalidate.fromJson(Map<String, dynamic> json) => Revalidate(
        tripInfos: List<TripInfo>.from(
            json["tripInfos"].map((x) => TripInfo.fromJson(x))),
        searchQuery: SearchQuery.fromJson(json["searchQuery"]),
        bookingId: json["bookingId"],
        totalPriceInfo:
            revalidateTotalPriceInfo.fromJson(json["totalPriceInfo"]),
        status: Status.fromJson(json["status"]),
        conditions: Conditions.fromJson(json["conditions"]),
      );

  Map<String, dynamic> toJson() => {
        "tripInfos": List<dynamic>.from(tripInfos.map((x) => x.toJson())),
        "searchQuery": searchQuery.toJson(),
        "bookingId": bookingId,
        "totalPriceInfo": totalPriceInfo.toJson(),
        "status": status.toJson(),
        "conditions": conditions.toJson(),
      };
}

class Conditions {
  List<dynamic> ffas;
  bool isa;
  Dob dob;
  bool iecr;
  Dc dc;
  bool ipa;
  bool isBa;
  int st;
  DateTime sct;
  Gst gst;

  Conditions({
    this.ffas,
    this.isa,
    this.dob,
    this.iecr,
    this.dc,
    this.ipa,
    this.isBa,
    this.st,
    this.sct,
    this.gst,
  });

  factory Conditions.fromJson(Map<String, dynamic> json) => Conditions(
        ffas: List<dynamic>.from(json["ffas"].map((x) => x)),
        isa: json["isa"],
        dob: Dob.fromJson(json["dob"]),
        iecr: json["iecr"],
        dc: Dc.fromJson(json["dc"]),
        ipa: json["ipa"],
        isBa: json["isBA"],
        st: json["st"],
        sct: DateTime.parse(json["sct"]),
        gst: Gst.fromJson(json["gst"]),
      );

  Map<String, dynamic> toJson() => {
        "ffas": List<dynamic>.from(ffas.map((x) => x)),
        "isa": isa,
        "dob": dob.toJson(),
        "iecr": iecr,
        "dc": dc.toJson(),
        "ipa": ipa,
        "isBA": isBa,
        "st": st,
        "sct": sct.toIso8601String(),
        "gst": gst.toJson(),
      };
}

class Dc {
  bool ida;
  bool idm;

  Dc({
    this.ida,
    this.idm,
  });

  factory Dc.fromJson(Map<String, dynamic> json) => Dc(
        ida: json["ida"],
        idm: json["idm"],
      );

  Map<String, dynamic> toJson() => {
        "ida": ida,
        "idm": idm,
      };
}

class Dob {
  bool adobr;
  bool cdobr;
  bool idobr;

  Dob({
    this.adobr,
    this.cdobr,
    this.idobr,
  });

  factory Dob.fromJson(Map<String, dynamic> json) => Dob(
        adobr: json["adobr"],
        cdobr: json["cdobr"],
        idobr: json["idobr"],
      );

  Map<String, dynamic> toJson() => {
        "adobr": adobr,
        "cdobr": cdobr,
        "idobr": idobr,
      };
}

class Gst {
  bool gstappl;
  bool igm;

  Gst({
    this.gstappl,
    this.igm,
  });

  factory Gst.fromJson(Map<String, dynamic> json) => Gst(
        gstappl: json["gstappl"],
        igm: json["igm"],
      );

  Map<String, dynamic> toJson() => {
        "gstappl": gstappl,
        "igm": igm,
      };
}

class SearchQuery {
  List<RouteInfo> routeInfos;
  String cabinClass;
  PaxInfo paxInfo;
  String requestId;
  String searchType;
  SearchModifiers searchModifiers;
  bool isDomestic;

  SearchQuery({
    this.routeInfos,
    this.cabinClass,
    this.paxInfo,
    this.requestId,
    this.searchType,
    this.searchModifiers,
    this.isDomestic,
  });

  factory SearchQuery.fromJson(Map<String, dynamic> json) => SearchQuery(
        routeInfos: List<RouteInfo>.from(
            json["routeInfos"].map((x) => RouteInfo.fromJson(x))),
        cabinClass: json["cabinClass"],
        paxInfo: PaxInfo.fromJson(json["paxInfo"]),
        requestId: json["requestId"],
        searchType: json["searchType"],
        searchModifiers: SearchModifiers.fromJson(json["searchModifiers"]),
        isDomestic: json["isDomestic"],
      );

  Map<String, dynamic> toJson() => {
        "routeInfos": List<dynamic>.from(routeInfos.map((x) => x.toJson())),
        "cabinClass": cabinClass,
        "paxInfo": paxInfo.toJson(),
        "requestId": requestId,
        "searchType": searchType,
        "searchModifiers": searchModifiers.toJson(),
        "isDomestic": isDomestic,
      };
}

class PaxInfo {
  int adult;
  int child;
  int infant;

  PaxInfo({
    this.adult,
    this.child,
    this.infant,
  });

  factory PaxInfo.fromJson(Map<String, dynamic> json) => PaxInfo(
        adult: json["ADULT"],
        child: json["CHILD"],
        infant: json["INFANT"],
      );

  Map<String, dynamic> toJson() => {
        "ADULT": adult,
        "CHILD": child,
        "INFANT": infant,
      };
}

class RouteInfo {
  FromCityOrAirport fromCityOrAirport;
  FromCityOrAirport toCityOrAirport;
  DateTime travelDate;

  RouteInfo({
    this.fromCityOrAirport,
    this.toCityOrAirport,
    this.travelDate,
  });

  factory RouteInfo.fromJson(Map<String, dynamic> json) => RouteInfo(
        fromCityOrAirport:
            FromCityOrAirport.fromJson(json["fromCityOrAirport"]),
        toCityOrAirport: FromCityOrAirport.fromJson(json["toCityOrAirport"]),
        travelDate: DateTime.parse(json["travelDate"]),
      );

  Map<String, dynamic> toJson() => {
        "fromCityOrAirport": fromCityOrAirport.toJson(),
        "toCityOrAirport": toCityOrAirport.toJson(),
        "travelDate":
            "${travelDate.year.toString().padLeft(4, '0')}-${travelDate.month.toString().padLeft(2, '0')}-${travelDate.day.toString().padLeft(2, '0')}",
      };
}

class FromCityOrAirport {
  String code;
  String name;
  String cityCode;
  String city;
  String country;
  String countryCode;
  String terminal;

  FromCityOrAirport({
    this.code,
    this.name,
    this.cityCode,
    this.city,
    this.country,
    this.countryCode,
    this.terminal,
  });

  factory FromCityOrAirport.fromJson(Map<String, dynamic> json) =>
      FromCityOrAirport(
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

class SearchModifiers {
  bool isDirectFlight;
  bool isConnectingFlight;
  String pft;
  List<String> pfts;

  SearchModifiers({
    this.isDirectFlight,
    this.isConnectingFlight,
    this.pft,
    this.pfts,
  });

  factory SearchModifiers.fromJson(Map<String, dynamic> json) =>
      SearchModifiers(
        isDirectFlight: json["isDirectFlight"],
        isConnectingFlight: json["isConnectingFlight"],
        pft: json["pft"],
        pfts: List<String>.from(json["pfts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "isDirectFlight": isDirectFlight,
        "isConnectingFlight": isConnectingFlight,
        "pft": pft,
        "pfts": List<dynamic>.from(pfts.map((x) => x)),
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

class revalidateTotalPriceInfo {
  TotalFareDetail totalFareDetail;

  revalidateTotalPriceInfo({
    this.totalFareDetail,
  });

  factory revalidateTotalPriceInfo.fromJson(Map<String, dynamic> json) =>
      revalidateTotalPriceInfo(
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
  double agst;
  double mft;
  double mf;
  double yq;
  double ot;

  Taf({
    this.agst,
    this.mft,
    this.mf,
    this.yq,
    this.ot,
  });

  factory Taf.fromJson(Map<String, dynamic> json) => Taf(
        agst: json["AGST"]?.toDouble(),
        mft: json["MFT"]?.toDouble(),
        mf: json["MF"]?.toDouble(),
        yq: json["YQ"]?.toDouble(),
        ot: json["OT"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "AGST": agst,
        "MFT": mft,
        "MF": mf,
        "YQ": yq,
        "OT": ot,
      };
}

class FC {
  double tf;
  double taf;
  double nf;
  double bf;

  FC({
    this.tf,
    this.taf,
    this.nf,
    this.bf,
  });

  factory FC.fromJson(Map<String, dynamic> json) => FC(
        tf: json["TF"]?.toDouble(),
        taf: json["TAF"]?.toDouble(),
        nf: json["NF"]?.toDouble(),
        bf: json["BF"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "TF": tf,
        "TAF": taf,
        "NF": nf,
        "BF": bf,
      };
}

class TripInfo {
  List<SI> sI;
  List<TotalPriceList> totalPriceList;

  TripInfo({
    this.sI,
    this.totalPriceList,
  });

  factory TripInfo.fromJson(Map<String, dynamic> json) => TripInfo(
        sI: List<SI>.from(json["sI"].map((x) => SI.fromJson(x))),
        totalPriceList: List<TotalPriceList>.from(
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
  List<dynamic> so;
  int duration;
  FromCityOrAirport da;
  FromCityOrAirport aa;
  String dt;
  String at;
  bool iand;
  bool isRs;
  int sN;
  // SsrInfo ssrInfo;
  List<dynamic> ac;

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
    // this.ssrInfo,
    this.ac,
  });

  factory SI.fromJson(Map<String, dynamic> json) => SI(
        id: json["id"],
        fD: FD.fromJson(json["fD"]),
        stops: json["stops"],
        so: List<dynamic>.from(json["so"].map((x) => x)),
        duration: json["duration"],
        da: FromCityOrAirport.fromJson(json["da"]),
        aa: FromCityOrAirport.fromJson(json["aa"]),
        dt: json["dt"],
        at: json["at"],
        iand: json["iand"],
        isRs: json["isRs"],
        sN: json["sN"],
        // ssrInfo: SsrInfo.fromJson(json["ssrInfo"]),
        ac: List<dynamic>.from(json["ac"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fD": fD.toJson(),
        "stops": stops,
        "so": List<dynamic>.from(so.map((x) => x)),
        "duration": duration,
        "da": da.toJson(),
        "aa": aa.toJson(),
        "dt": dt,
        "at": at,
        "iand": iand,
        "isRs": isRs,
        "sN": sN,
        // "ssrInfo": ssrInfo.toJson(),
        "ac": List<dynamic>.from(ac.map((x) => x)),
      };
}

class FD {
  Pc aI;
  String fN;
  String eT;

  FD({
    this.aI,
    this.fN,
    this.eT,
  });

  factory FD.fromJson(Map<String, dynamic> json) => FD(
        aI: Pc.fromJson(json["aI"]),
        fN: json["fN"],
        eT: json["eT"],
      );

  Map<String, dynamic> toJson() => {
        "aI": aI.toJson(),
        "fN": fN,
        "eT": eT,
      };
}

class Pc {
  String code;
  String name;
  bool isLcc;

  Pc({
    this.code,
    this.name,
    this.isLcc,
  });

  factory Pc.fromJson(Map<String, dynamic> json) => Pc(
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

// class SsrInfo {
//   List<Baggage> baggage;
//   List<Baggage> meal;

//   SsrInfo({
//     this.baggage,
//     this.meal,
//   });

//   factory SsrInfo.fromJson(Map<String, dynamic> json) => SsrInfo(
//         baggage:
//             List<Baggage>.from(json["BAGGAGE"].map((x) => Baggage.fromJson(x))),
//         meal: List<Baggage>.from(json["MEAL"].map((x) => Baggage.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "BAGGAGE": List<dynamic>.from(baggage.map((x) => x.toJson())),
//         "MEAL": List<dynamic>.from(meal.map((x) => x.toJson())),
//       };
// }

class Baggage {
  String code;
  double amount;
  String desc;

  Baggage({
    this.code,
    this.amount,
    this.desc,
  });

  factory Baggage.fromJson(Map<String, dynamic> json) => Baggage(
        code: json["code"],
        amount: json["amount"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "amount": amount,
        "desc": desc,
      };
}

class TotalPriceList {
  Fd fd;
  String fareIdentifier;
  String id;
  List<dynamic> messages;
  Pc pc;
  FareRuleInformation fareRuleInformation;

  TotalPriceList({
    this.fd,
    this.fareIdentifier,
    this.id,
    this.messages,
    this.pc,
    this.fareRuleInformation,
  });

  factory TotalPriceList.fromJson(Map<String, dynamic> json) => TotalPriceList(
        fd: Fd.fromJson(json["fd"]),
        fareIdentifier: json["fareIdentifier"],
        id: json["id"],
        messages: List<dynamic>.from(json["messages"].map((x) => x)),
        pc: Pc.fromJson(json["pc"]),
        fareRuleInformation:
            FareRuleInformation.fromJson(json["fareRuleInformation"]),
      );

  Map<String, dynamic> toJson() => {
        "fd": fd.toJson(),
        "fareIdentifier": fareIdentifier,
        "id": id,
        "messages": List<dynamic>.from(messages.map((x) => x)),
        "pc": pc.toJson(),
        "fareRuleInformation": fareRuleInformation.toJson(),
      };
}

class FareRuleInformation {
  Fr fr;
  Tfr tfr;

  FareRuleInformation({
    this.fr,
    this.tfr,
  });

  factory FareRuleInformation.fromJson(Map<String, dynamic> json) =>
      FareRuleInformation(
        fr: Fr.fromJson(json["fr"]),
        tfr: Tfr.fromJson(json["tfr"]),
      );

  Map<String, dynamic> toJson() => {
        "fr": fr.toJson(),
        "tfr": tfr.toJson(),
      };
}

class Fr {
  Fr();

  factory Fr.fromJson(Map<String, dynamic> json) => Fr();

  Map<String, dynamic> toJson() => {};
}

// class Tfr {
//   String id;
//   String code;
//   String name;
//   List<dynamic> rules;

//   Tfr({
//     this.id,
//     this.code,
//     this.name,
//     this.rules,
//   });

//   factory Tfr.fromJson(Map<String, dynamic> json) {
//   var rules = json["Rules"];
//   if (rules != null) {
//     return Tfr(
//       id: json["Id"],
//       code: json["Code"],
//       name: json["Name"],
//       rules: List<dynamic>.from(rules.map((x) => x)),
//     );
//   } else {
//     // Provide a default value for rules or handle the null case gracefully
//     return Tfr(
//       id: json["Id"],
//       code: json["Code"],
//       name: json["Name"],
//       rules: [], // Default empty list
//     );
//   }
// }


//   Map<String, dynamic> toJson() => {
//         "Id": id,
//         "Code": code,
//         "Name": name,
//         "Rules": List<dynamic>.from(rules.map((x) => x)),
//       };
// }

class Tfr {
    List<dynamic> noShow;
    List<Cancellation> datechange;
    List<Cancellation> cancellation;
    List<dynamic> seatChargeable;

    Tfr({
           this.noShow,
           this.datechange,
           this.cancellation,
           this.seatChargeable,
    });
factory Tfr.fromJson(Map<String, dynamic> json) {
  return Tfr(
    noShow: json["NO_SHOW"] != null ? List<dynamic>.from(json["NO_SHOW"].map((x) => x)) : [],
    datechange: json["DATECHANGE"] != null ? List<Cancellation>.from(json["DATECHANGE"].map((x) => Cancellation.fromJson(x))) : [],
    cancellation: json["CANCELLATION"] != null ? List<Cancellation>.from(json["CANCELLATION"].map((x) => Cancellation.fromJson(x))) : [],
    seatChargeable: json["SEAT_CHARGEABLE"] != null ? List<dynamic>.from(json["SEAT_CHARGEABLE"].map((x) => x)) : [],
  );
}

    // factory Tfr.fromJson(Map<String, dynamic> json) => Tfr(
    //     noShow: List<dynamic>.from(json["NO_SHOW"].map((x) => x)),
    //     datechange: List<Cancellation>.from(json["DATECHANGE"].map((x) => Cancellation.fromJson(x))),
    //     cancellation: List<Cancellation>.from(json["CANCELLATION"].map((x) => Cancellation.fromJson(x))),
    //     seatChargeable: List<dynamic>.from(json["SEAT_CHARGEABLE"].map((x) => x)),
    // );

    Map<String, dynamic> toJson() => {
        "NO_SHOW": List<dynamic>.from(noShow.map((x) => x)),
        "DATECHANGE": List<dynamic>.from(datechange.map((x) => x.toJson())),
        "CANCELLATION": List<dynamic>.from(cancellation.map((x) => x.toJson())),
        "SEAT_CHARGEABLE": List<dynamic>.from(seatChargeable.map((x) => x)),
    };
}

class Cancellation {
 double additionalFee;
  String policyInfo;
  Fr fcs;
  String st;
  String et;

  Cancellation({
    this.additionalFee,
    this.policyInfo,
    this.fcs,
    this.st,
    this.et,
  });

  // factory Cancellation.fromJson(Map<String, dynamic> json) => Cancellation(
  //       additionalFee: json["additionalFee"],
  //       policyInfo: json["policyInfo"],
  //       fcs: Fr.fromJson(json["fcs"]),
  //       st: json["st"],
  //       et: json["et"],
  //     );
factory Cancellation.fromJson(Map<String, dynamic> json) {
  return Cancellation(
    additionalFee: json["additionalFee"]?.toDouble() ?? 0.0,
    policyInfo: json["policyInfo"]?.toString() ?? '',
    fcs: json["fcs"] != null ? Fr.fromJson(json["fcs"]) : null,
    st: json["st"]?.toString() ?? '',
    et: json["et"]?.toString() ?? '',
  );
}


  Map<String, dynamic> toJson() => {
        "additionalFee": additionalFee,
        "policyInfo": policyInfo,
        "fcs": fcs.toJson(),
        "st": st,
        "et": et,
      };
}

class Fd {
  Adult adult;

  Fd({
    this.adult,
  });

  factory Fd.fromJson(Map<String, dynamic> json) => Fd(
        adult: Adult.fromJson(json["ADULT"]),
      );

  Map<String, dynamic> toJson() => {
        "ADULT": adult.toJson(),
      };
}

class Adult {
  FC fC;
  AfC afC;
  int sR;
  BI bI;
  int rT;
  String cc;
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
        afC: AfC.fromJson(json["afC"]),
        sR: json["sR"],
        bI: BI.fromJson(json["bI"]),
        rT: json["rT"],
        cc: json["cc"],
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
        "cc": cc,
        "cB": cB,
        "fB": fB,
        "mI": mI,
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
