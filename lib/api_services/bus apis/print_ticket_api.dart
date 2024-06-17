
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:trip/common/print_funtions.dart';

Future<String> busTicketAPI(String tin) async {
  print("busTicketAPI");
  print("tin:$tin");

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
    var url = Uri.parse('https://api.seatseller.travel/ticket?tin=69BTVJHM');

    final response = await oauthClient.get(
      url,
    );

    if (response != null) {
      String data = response.body;
      printred("Response busTicketAPI: data");
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



class Tickectobj {
    String bookingFee;
    String busType;
    DateTime cancellationCalculationTimestamp;
    String cancellationMessage;
    String cancellationPolicy;
    DateTime dateOfIssue;
    String destinationCity;
    String destinationCityId;
    DateTime doj;
    String dropLocation;
    String dropLocationAddress;
    String dropLocationId;
    String dropLocationLandmark;
    String dropTime;
    String firstBoardingPointTime;
    String hasRtcBreakup;
    String hasSpecialTemplate;
    String inventoryId;
    InventoryItems inventoryItems;
    String mTicketEnabled;
    OtherDetails otherDetails;
    String partialCancellationAllowed;
    String pickUpContactNo;
    String pickUpLocationAddress;
    String pickupLocation;
    String pickupLocationId;
    String pickupLocationLandmark;
    String pickupTime;
    String pnr;
    String primeDepartureTime;
    String primoBooking;
    ReschedulingPolicy reschedulingPolicy;
    String serviceCharge;
    DateTime serviceStartTime;
    String sourceCity;
    String sourceCityId;
    String status;
    String tin;
    String travels;
    String vaccinatedBus;
    String vaccinatedStaff;

    Tickectobj({
          this.bookingFee,
          this.busType,
          this.cancellationCalculationTimestamp,
          this.cancellationMessage,
          this.cancellationPolicy,
          this.dateOfIssue,
          this.destinationCity,
          this.destinationCityId,
          this.doj,
          this.dropLocation,
          this.dropLocationAddress,
          this.dropLocationId,
          this.dropLocationLandmark,
          this.dropTime,
          this.firstBoardingPointTime,
          this.hasRtcBreakup,
          this.hasSpecialTemplate,
          this.inventoryId,
          this.inventoryItems,
          this.mTicketEnabled,
          this.otherDetails,
          this.partialCancellationAllowed,
          this.pickUpContactNo,
          this.pickUpLocationAddress,
          this.pickupLocation,
          this.pickupLocationId,
          this.pickupLocationLandmark,
          this.pickupTime,
          this.pnr,
          this.primeDepartureTime,
          this.primoBooking,
          this.reschedulingPolicy,
          this.serviceCharge,
          this.serviceStartTime,
          this.sourceCity,
          this.sourceCityId,
          this.status,
          this.tin,
          this.travels,
          this.vaccinatedBus,
          this.vaccinatedStaff,
    });

    factory Tickectobj.fromJson(Map<String, dynamic> json) => Tickectobj(
        bookingFee: json["bookingFee"],
        busType: json["busType"],
        cancellationCalculationTimestamp: DateTime.parse(json["cancellationCalculationTimestamp"]),
        cancellationMessage: json["cancellationMessage"],
        cancellationPolicy: json["cancellationPolicy"],
        dateOfIssue: DateTime.parse(json["dateOfIssue"]),
        destinationCity: json["destinationCity"],
        destinationCityId: json["destinationCityId"],
        doj: DateTime.parse(json["doj"]),
        dropLocation: json["dropLocation"],
        dropLocationAddress: json["dropLocationAddress"],
        dropLocationId: json["dropLocationId"],
        dropLocationLandmark: json["dropLocationLandmark"],
        dropTime: json["dropTime"],
        firstBoardingPointTime: json["firstBoardingPointTime"],
        hasRtcBreakup: json["hasRTCBreakup"],
        hasSpecialTemplate: json["hasSpecialTemplate"],
        inventoryId: json["inventoryId"],
        inventoryItems: InventoryItems.fromJson(json["inventoryItems"]),
        mTicketEnabled: json["MTicketEnabled"],
        otherDetails: OtherDetails.fromJson(json["otherDetails"]),
        partialCancellationAllowed: json["partialCancellationAllowed"],
        pickUpContactNo: json["pickUpContactNo"],
        pickUpLocationAddress: json["pickUpLocationAddress"],
        pickupLocation: json["pickupLocation"],
        pickupLocationId: json["pickupLocationId"],
        pickupLocationLandmark: json["pickupLocationLandmark"],
        pickupTime: json["pickupTime"],
        pnr: json["pnr"],
        primeDepartureTime: json["primeDepartureTime"],
        primoBooking: json["primoBooking"],
        reschedulingPolicy: ReschedulingPolicy.fromJson(json["reschedulingPolicy"]),
        serviceCharge: json["serviceCharge"],
        serviceStartTime: DateTime.parse(json["serviceStartTime"]),
        sourceCity: json["sourceCity"],
        sourceCityId: json["sourceCityId"],
        status: json["status"],
        tin: json["tin"],
        travels: json["travels"],
        vaccinatedBus: json["vaccinatedBus"],
        vaccinatedStaff: json["vaccinatedStaff"],
    );

    Map<String, dynamic> toJson() => {
        "bookingFee": bookingFee,
        "busType": busType,
        "cancellationCalculationTimestamp": cancellationCalculationTimestamp.toIso8601String(),
        "cancellationMessage": cancellationMessage,
        "cancellationPolicy": cancellationPolicy,
        "dateOfIssue": dateOfIssue.toIso8601String(),
        "destinationCity": destinationCity,
        "destinationCityId": destinationCityId,
        "doj": doj.toIso8601String(),
        "dropLocation": dropLocation,
        "dropLocationAddress": dropLocationAddress,
        "dropLocationId": dropLocationId,
        "dropLocationLandmark": dropLocationLandmark,
        "dropTime": dropTime,
        "firstBoardingPointTime": firstBoardingPointTime,
        "hasRTCBreakup": hasRtcBreakup,
        "hasSpecialTemplate": hasSpecialTemplate,
        "inventoryId": inventoryId,
        "inventoryItems": inventoryItems.toJson(),
        "MTicketEnabled": mTicketEnabled,
        "otherDetails": otherDetails.toJson(),
        "partialCancellationAllowed": partialCancellationAllowed,
        "pickUpContactNo": pickUpContactNo,
        "pickUpLocationAddress": pickUpLocationAddress,
        "pickupLocation": pickupLocation,
        "pickupLocationId": pickupLocationId,
        "pickupLocationLandmark": pickupLocationLandmark,
        "pickupTime": pickupTime,
        "pnr": pnr,
        "primeDepartureTime": primeDepartureTime,
        "primoBooking": primoBooking,
        "reschedulingPolicy": reschedulingPolicy.toJson(),
        "serviceCharge": serviceCharge,
        "serviceStartTime": serviceStartTime.toIso8601String(),
        "sourceCity": sourceCity,
        "sourceCityId": sourceCityId,
        "status": status,
        "tin": tin,
        "travels": travels,
        "vaccinatedBus": vaccinatedBus,
        "vaccinatedStaff": vaccinatedStaff,
    };
}

class InventoryItems {
    String baseFare;
    String fare;
    String ladiesSeat;
    String malesSeat;
    String operatorServiceCharge;
    Passenger passenger;
    String seatName;
    String serviceTax;

    InventoryItems({
          this.baseFare,
          this.fare,
          this.ladiesSeat,
          this.malesSeat,
          this.operatorServiceCharge,
          this.passenger,
          this.seatName,
          this.serviceTax,
    });

    factory InventoryItems.fromJson(Map<String, dynamic> json) => InventoryItems(
        baseFare: json["baseFare"],
        fare: json["fare"],
        ladiesSeat: json["ladiesSeat"],
        malesSeat: json["malesSeat"],
        operatorServiceCharge: json["operatorServiceCharge"],
        passenger: Passenger.fromJson(json["passenger"]),
        seatName: json["seatName"],
        serviceTax: json["serviceTax"],
    );

    Map<String, dynamic> toJson() => {
        "baseFare": baseFare,
        "fare": fare,
        "ladiesSeat": ladiesSeat,
        "malesSeat": malesSeat,
        "operatorServiceCharge": operatorServiceCharge,
        "passenger": passenger.toJson(),
        "seatName": seatName,
        "serviceTax": serviceTax,
    };
}

class Passenger {
    String address;
    String age;
    String email;
    String gender;
    String idNumber;
    String idType;
    String mobile;
    String name;
    String primary;
    String singleLadies;
    String title;

    Passenger({
          this.address,
          this.age,
          this.email,
          this.gender,
          this.idNumber,
          this.idType,
          this.mobile,
          this.name,
          this.primary,
          this.singleLadies,
          this.title,
    });

    factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
        address: json["address"],
        age: json["age"],
        email: json["email"],
        gender: json["gender"],
        idNumber: json["idNumber"],
        idType: json["idType"],
        mobile: json["mobile"],
        name: json["name"],
        primary: json["primary"],
        singleLadies: json["singleLadies"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "age": age,
        "email": email,
        "gender": gender,
        "idNumber": idNumber,
        "idType": idType,
        "mobile": mobile,
        "name": name,
        "primary": primary,
        "singleLadies": singleLadies,
        "title": title,
    };
}

class OtherDetails {
    List<Entry> entry;

    OtherDetails({
          this.entry,
    });

    factory OtherDetails.fromJson(Map<String, dynamic> json) => OtherDetails(
        entry: List<Entry>.from(json["entry"].map((x) => Entry.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "entry": List<dynamic>.from(entry.map((x) => x.toJson())),
    };
}

class Entry {
    String key;
    String value;

    Entry({
          this.key,
          this.value,
    });

    factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        key: json["key"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
    };
}

class ReschedulingPolicy {
    String reschedulingCharge;
    String windowTime;

    ReschedulingPolicy({
          this.reschedulingCharge,
          this.windowTime,
    });

    factory ReschedulingPolicy.fromJson(Map<String, dynamic> json) => ReschedulingPolicy(
        reschedulingCharge: json["reschedulingCharge"],
        windowTime: json["windowTime"],
    );

    Map<String, dynamic> toJson() => {
        "reschedulingCharge": reschedulingCharge,
        "windowTime": windowTime,
    };
}







