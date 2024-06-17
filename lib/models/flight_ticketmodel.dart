// To parse this JSON data, do
//
//     final flightticket = flightticketFromJson(jsonString);

import 'dart:convert';

Flightticket flightticketFromJson(String str) => Flightticket.fromJson(json.decode(str));

String flightticketToJson(Flightticket data) => json.encode(data.toJson());

class Flightticket {
    Order order;
    ItemInfos itemInfos;
    GstInfo gstInfo;
    Status status;

    Flightticket({
        this.order,
        this.itemInfos,
        this.gstInfo,
        this.status,
    });

    factory Flightticket.fromJson(Map<String, dynamic> json) => Flightticket(
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
    GstInfo();

    factory GstInfo.fromJson(Map<String, dynamic> json) => GstInfo(
    );

    Map<String, dynamic> toJson() => {
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
        tripInfos: List<TripInfo>.from(json["tripInfos"].map((x) => TripInfo.fromJson(x))),
        travellerInfos: List<TravellerInfo>.from(json["travellerInfos"].map((x) => TravellerInfo.fromJson(x))),
        totalPriceInfo: TotalPriceInfo.fromJson(json["totalPriceInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "tripInfos": List<dynamic>.from(tripInfos.map((x) => x.toJson())),
        "travellerInfos": List<dynamic>.from(travellerInfos.map((x) => x.toJson())),
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

    factory TotalFareDetail.fromJson(Map<String, dynamic> json) => TotalFareDetail(
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
    double yq;
    double mf;
    double agst;
    double mft;
    double ot;

    Taf({
        this.yq,
        this.mf,
        this.agst,
        this.mft,
        this.ot,
    });

    factory Taf.fromJson(Map<String, dynamic> json) => Taf(
        yq: json["YQ"].toDouble(),
        mf: json["MF"].toDouble(),
        agst: json["AGST"].toDouble(),
        mft: json["MFT"].toDouble(),
        ot: json["OT"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "YQ": yq,
        "MF": mf,
        "AGST": agst,
        "MFT": mft,
        "OT": ot,
    };
}

class FC {
    double nf;
    double tf;
    double bf;
    double cgst;
    double sgst;
    double taf;

    FC({
        this.nf,
        this.tf,
        this.bf,
        this.cgst,
        this.sgst,
        this.taf,
    });

    factory FC.fromJson(Map<String, dynamic> json) => FC(
        nf: json["NF"].toDouble(),
        tf: json["TF"].toDouble(),
        bf: json["BF"].toDouble(),
        cgst: json["CGST"].toDouble(),
        sgst: json["SGST"].toDouble(),
        taf: json["TAF"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "NF": nf,
        "TF": tf,
        "BF": bf,
        "CGST": cgst,
        "SGST": sgst,
        "TAF": taf,
    };
}

class TravellerInfo {
    PnrDetails pnrDetails;
    CheckinStatusMap checkinStatusMap;
    String ti;
    String pt;
    String fN;
    String lN;

    TravellerInfo({
        this.pnrDetails,
        this.checkinStatusMap,
        this.ti,
        this.pt,
        this.fN,
        this.lN,
    });

    factory TravellerInfo.fromJson(Map<String, dynamic> json) => TravellerInfo(
        pnrDetails: PnrDetails.fromJson(json["pnrDetails"]),
        checkinStatusMap: CheckinStatusMap.fromJson(json["checkinStatusMap"]),
        ti: json["ti"],
        pt: json["pt"],
        fN: json["fN"],
        lN: json["lN"],
    );

    Map<String, dynamic> toJson() => {
        "pnrDetails": pnrDetails.toJson(),
        "checkinStatusMap": checkinStatusMap.toJson(),
        "ti": ti,
        "pt": pt,
        "fN": fN,
        "lN": lN,
    };
}

class CheckinStatusMap {
    bool delBom;

    CheckinStatusMap({
        this.delBom,
    });

    factory CheckinStatusMap.fromJson(Map<String, dynamic> json) => CheckinStatusMap(
        delBom: json["DEL-BOM"],
    );

    Map<String, dynamic> toJson() => {
        "DEL-BOM": delBom,
    };
}

class PnrDetails {
    String delBom;

    PnrDetails({
        this.delBom,
    });

    factory PnrDetails.fromJson(Map<String, dynamic> json) => PnrDetails(
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
    bool israa;

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
        this.israa,
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
        israa: json["israa"],
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
        "israa": israa,
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
        amount: json["amount"].toDouble(),
        markup: json["markup"].toDouble(),
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
