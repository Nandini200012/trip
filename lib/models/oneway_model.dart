

import 'dart:convert';

import 'package:flutter/material.dart';

import '../api_services/search apis/one_way/airsearch_domestic_api.dart';
















class onewayobj {
    SearchResult searchResult;
    Status status;

    onewayobj({
          this.searchResult,
          this.status,
    });

    factory onewayobj.fromJson(Map<String, dynamic> json) => onewayobj(
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
        onward: List<Onward>.from(json["ONWARD"].map((x) => Onward.fromJson(x))),
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
        totalPriceList: List<TotalPriceList>.from(json["totalPriceList"].map((x) => TotalPriceList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "sI": List<dynamic>.from(sI.map((x) => x.toJson())),
        "totalPriceList": List<dynamic>.from(totalPriceList.map((x) => x.toJson())),
    };
}

class SI {
    String id;
    FD fD;
    int stops;
    List<dynamic> so;
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
          this.so,
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
        so: List<dynamic>.from(json["so"].map((x) => x)),
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
        "so": List<dynamic>.from(so.map((x) => x)),
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
    Code code;
    Name name;
    Code cityCode;
    City city;
    Country country;
    CountryCode countryCode;
    Terminal terminal;

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
        code: codeValues.map[json["code"]],
        name: nameValues.map[json["name"]],
        cityCode: codeValues.map[json["cityCode"]],
        city: cityValues.map[json["city"]],
        country: countryValues.map[json["country"]],
        countryCode: countryCodeValues.map[json["countryCode"]],
        terminal: terminalValues.map[json["terminal"]],
    );

    Map<String, dynamic> toJson() => {
        "code": codeValues.reverse[code],
        "name": nameValues.reverse[name],
        "cityCode": codeValues.reverse[cityCode],
        "city": cityValues.reverse[city],
        "country": countryValues.reverse[country],
        "countryCode": countryCodeValues.reverse[countryCode],
        "terminal": terminalValues.reverse[terminal],
    };
}

enum City {
    DELHI,
    MUMBAI
}

final cityValues = EnumValues({
    "Delhi": City.DELHI,
    "Mumbai": City.MUMBAI
});

enum Code {
    BOM,
    DEL
}

final codeValues = EnumValues({
    "BOM": Code.BOM,
    "DEL": Code.DEL
});

enum Country {
    INDIA
}

final countryValues = EnumValues({
    "India": Country.INDIA
});

enum CountryCode {
    IN
}

final countryCodeValues = EnumValues({
    "IN": CountryCode.IN
});

enum Name {
    CHHATRAPATI_SHIVAJI,
    DELHI_INDIRA_GANDHI_INTL
}

final nameValues = EnumValues({
    "Chhatrapati Shivaji": Name.CHHATRAPATI_SHIVAJI,
    "Delhi Indira Gandhi Intl": Name.DELHI_INDIRA_GANDHI_INTL
});

enum Terminal {
    TERMINAL_1,
    TERMINAL_1_D,
    TERMINAL_3
}

final terminalValues = EnumValues({
    "Terminal 1": Terminal.TERMINAL_1,
    "Terminal 1D": Terminal.TERMINAL_1_D,
    "Terminal 3": Terminal.TERMINAL_3
});

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
        msri: List<dynamic>.from(json["msri"].map((x) => x)),
        messages: List<dynamic>.from(json["messages"].map((x) => x)),
        tai: Tai.fromJson(json["tai"]),
        icca: json["icca"],
    );

    Map<String, dynamic> toJson() => {
        "fd": fd.toJson(),
        "fareIdentifier": fareIdentifier,
        "id": id,
        "msri": List<dynamic>.from(msri.map((x) => x)),
        "messages": List<dynamic>.from(messages.map((x) => x)),
        "tai": tai.toJson(),
        "icca": icca,
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
    double ot;
     double yq;
    double agst;

    Taf({
          this.ot,
          this.yq,
          this.agst,
    });

    factory Taf.fromJson(Map<String, dynamic> json) => Taf(
        ot: json["OT"],
        yq: json["YQ"],
        agst: json["AGST"],
    );

    Map<String, dynamic> toJson() => {
        "OT": ot,
        "YQ": yq,
        "AGST": agst,
    };
}

class BI {
    IB iB;
    CB cB;

    BI({
          this.iB,
          this.cB,
    });

    factory BI.fromJson(Map<String, dynamic> json) => BI(
        iB: ibValues.map[json["iB"]]  ,
        cB: cbValues.map[json["cB"]]  ,
    );

    Map<String, dynamic> toJson() => {
        "iB": ibValues.reverse[iB],
        "cB": cbValues.reverse[cB],
    };
}

enum CB {
    THE_7_KG
}

final cbValues = EnumValues({
    "7 Kg": CB.THE_7_KG
});

enum IB {
    THE_15_KG
}

final ibValues = EnumValues({
    "15 Kg": IB.THE_15_KG
});

class FC {
    double bf;
     double tf;
     double taf;
     double nf;

    FC({
          this.bf,
          this.tf,
          this.taf,
          this.nf,
    });

    factory FC.fromJson(Map<String, dynamic> json) => FC(
        bf: json["BF"],
        tf: json["TF"],
        taf: json["TAF"],
        nf: json["NF"],
    );

    Map<String, dynamic> toJson() => {
        "BF": bf,
        "TF": tf,
        "TAF": taf,
        "NF": nf,
    };
}

class Tai {
    Map<String, List<Tbi>> tbi;

    Tai({
          this.tbi,
    });

    factory Tai.fromJson(Map<String, dynamic> json) => Tai(
        tbi: Map.from(json["tbi"]).map((k, v) => MapEntry<String, List<Tbi>>(k, List<Tbi>.from(v.map((x) => Tbi.fromJson(x))))),
    );

    Map<String, dynamic> toJson() => {
        "tbi": Map.from(tbi).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
    };
}

class Tbi {
    BI adult;

    Tbi({
          this.adult,
    });

    factory Tbi.fromJson(Map<String, dynamic> json) => Tbi(
        adult: BI.fromJson(json["ADULT"]),
    );

    Map<String, dynamic> toJson() => {
        "ADULT": adult.toJson(),
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
