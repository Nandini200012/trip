

import 'dart:convert';

OneWaymodel oneWaymodelFromJson(String str) => OneWaymodel.fromJson(json.decode(str));

String oneWaymodelToJson(OneWaymodel data) => json.encode(data.toJson());

class OneWaymodel {
    SearchResult searchResult;
    Status status;

    OneWaymodel({
          this.searchResult,
          this.status,
    });

    factory OneWaymodel.fromJson(Map<String, dynamic> json) => OneWaymodel(
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
    List<Aa> so;
    int duration;
    Aa da;
    Aa aa;
    String dt;
    String at;
    bool iand;
    bool isRs;
    int sN;
    int  cT;

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
        so: List<Aa>.from(json["so"].map((x) => Aa.fromJson(x))),
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
        "so": List<dynamic>.from(so.map((x) => x.toJson())),
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
    String  terminal;

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
        afC: AdultAfC.fromJson(json["afC"]),
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
    int ot;
    int yr;
    int agst;

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
    IB iB;
    CB cB;

    BI({
          this.iB,
          this.cB,
    });

    factory BI.fromJson(Map<String, dynamic> json) => BI(
        iB: ibValues.map[json["iB"]] ,
        cB: cbValues.map[json["cB"]] ,
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
    THE_10_KG_01_PIECE_ONLY,
    THE_25_KG_01_PIECE_ONLY
}

final ibValues = EnumValues({
    "10 Kg (01 Piece only)": IB.THE_10_KG_01_PIECE_ONLY,
    "25 Kg (01 Piece only)": IB.THE_25_KG_01_PIECE_ONLY
});

class FC {
    int nf;
    int tf;
    int bf;
    int taf;

    FC({
          this.nf,
          this.tf,
          this.bf,
          this.taf,
    });

    factory FC.fromJson(Map<String, dynamic> json) => FC(
        nf: json["NF"],
        tf: json["TF"],
        bf: json["BF"],
        taf: json["TAF"],
    );

    Map<String, dynamic> toJson() => {
        "NF": nf,
        "TF": tf,
        "BF": bf,
        "TAF": taf,
    };
}

class Infant {
    FC fC;
    InfantAfC afC;
    int sR;
    BI bI;
    int rT;
    String cc;
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
        tbi: Map.from(json["tbi"]).map((k, v) => MapEntry<String, List<Tbi>>(k, List<Tbi>.from(v.map((x) => Tbi.fromJson(x))))),
    );

    Map<String, dynamic> toJson() => {
        "tbi": Map.from(tbi).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
    };
}

class Tbi {
    BI  child;
    BI  infant;
    BI  adult;

    Tbi({
        this.child,
        this.infant,
        this.adult,
    });

    factory Tbi.fromJson(Map<String, dynamic> json) => Tbi(
        child: json["CHILD"] == null  ? null : BI.fromJson(json["CHILD"]),
        infant: json["INFANT"] == null  ? null : BI.fromJson(json["INFANT"]),
        adult: json["ADULT"] == null  ? null : BI.fromJson(json["ADULT"]),
    );

    Map<String, dynamic> toJson() => {
        "CHILD": child .toJson(),
        "INFANT": infant .toJson(),
        "ADULT": adult .toJson(),
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
