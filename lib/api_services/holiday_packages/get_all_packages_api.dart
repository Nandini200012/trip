import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trip/common/print_funtions.dart';

Future<String> holidayPackagesAPI() async {
  print("holidayPackagesAPI api");
  var url = Uri.parse(
      'https://gotodestination.in/api/get_holiday_packages.php');

  try {
    final response = await http.get(url);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      print('holidayPackagesAPI res');

      var decodedData = jsonDecode(data);
      // printWhite("Holiday all: $data");
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
  }
}





class HolidayPackageobj {
    String errorCode;
    String errorMessage;
    List<Package> packages;

    HolidayPackageobj({
          this.errorCode,
          this.errorMessage,
          this.packages,
    });

    factory HolidayPackageobj.fromJson(Map<String, dynamic> json) => HolidayPackageobj(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
        "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
    };
}

class Package {
    String pId;
    String category;
    String name;
    String description;
    String photoVideo;
    String fromDate;
    String toDate;
    String inclusive;
    String exclusive;
    String extra;
    String ntkDesc;
    String paymentTerm;
    String remarks;
    String packagePrice;
    String flightDetails;
    String accommodation;
    String reportingDropping;
    List<Itinerary> itinerary;
    List<PolicyTerm> policyTerms;

    Package({
          this.pId,
          this.category,
          this.name,
          this.description,
          this.photoVideo,
          this.fromDate,
          this.toDate,
          this.inclusive,
          this.exclusive,
          this.extra,
          this.ntkDesc,
          this.paymentTerm,
          this.remarks,
          this.packagePrice,
          this.flightDetails,
          this.accommodation,
          this.reportingDropping,
          this.itinerary,
          this.policyTerms,
    });

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        pId: json["p_id"],
        category: json["category"],
        name: json["name"],
        description: json["description"],
        photoVideo: json["photo_video"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        inclusive: json["inclusive"],
        exclusive: json["exclusive"],
        extra: json["extra"],
        ntkDesc: json["ntk_desc"],
        paymentTerm: json["payment_term"],
        remarks: json["remarks"],
        packagePrice: json["package_price"],
        flightDetails: json["flight_details"],
        accommodation: json["accommodation"],
        reportingDropping: json["reporting_dropping"],
        itinerary: List<Itinerary>.from(json["itinerary"].map((x) => Itinerary.fromJson(x))),
        policyTerms: List<PolicyTerm>.from(json["policy_terms"].map((x) => PolicyTerm.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "p_id": pId,
        "category": category,
        "name": name,
        "description": description,
        "photo_video": photoVideo,
        "from_date": fromDate,
        "to_date": toDate,
        "inclusive": inclusive,
        "exclusive": exclusive,
        "extra": extra,
        "ntk_desc": ntkDesc,
        "payment_term": paymentTerm,
        "remarks": remarks,
        "package_price": packagePrice,
        "flight_details": flightDetails,
        "accommodation": accommodation,
        "reporting_dropping": reportingDropping,
        "itinerary": List<dynamic>.from(itinerary.map((x) => x.toJson())),
        "policy_terms": List<dynamic>.from(policyTerms.map((x) => x.toJson())),
    };
}

class Itinerary {
    String packageId;
    String day;
    String location;
    String itineraryDesc;

    Itinerary({
          this.packageId,
          this.day,
          this.location,
          this.itineraryDesc,
    });

    factory Itinerary.fromJson(Map<String, dynamic> json) => Itinerary(
        packageId: json["package_id"],
        day: json["day"],
        location: json["location"],
        itineraryDesc: json["itinerary_desc"],
    );

    Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "day": day,
        "location": location,
        "itinerary_desc": itineraryDesc,
    };
}

class PolicyTerm {
    String packageId;
    String cancellationFrom;
    String cancellationTo;
    String percentage;

    PolicyTerm({
          this.packageId,
          this.cancellationFrom,
          this.cancellationTo,
          this.percentage,
    });

    factory PolicyTerm.fromJson(Map<String, dynamic> json) => PolicyTerm(
        packageId: json["package_id"],
        cancellationFrom: json["cancellation_from"],
        cancellationTo: json["cancellation_to"],
        percentage: json["percentage"],
    );

    Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "cancellation_from": cancellationFrom,
        "cancellation_to": cancellationTo,
        "percentage": percentage,
    };
}










