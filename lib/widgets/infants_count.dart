import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trip/common/print_funtions.dart';
import 'package:trip/screens/flightbooking%20page/ismulticityformpage.dart';

import '../api_services/location_list_api.dart';
import '../api_services/search apis/return/Domestic_return_search_api.dart';
import '../api_services/search apis/return/international_return_search_api.dart';
import '../models/flight_model.dart';
import '../models/return_d_model.dart';
import '../screens/flights/return_international_page.dart';
import '../screens/return_searchlist.dart';
import '../screens/searchlist.dart';

class InfantsCount extends StatefulWidget {
  final Function(int) onNumberSelected;

  InfantsCount(this.onNumberSelected);
  // const InfantsCount({key});

  @override
  State<InfantsCount> createState() => _InfantsCountState();
}

class _InfantsCountState extends State<InfantsCount> {
  int selectedNumberInfant = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 590,
      height: 40,
      child: Row(
        children: [
          // Card(
          //   elevation: 4,
          //   child: Container(
          //     width: 34.0,
          //     height: 38,
          //     // height: 40,
          //     margin: EdgeInsets.all(2.0),
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(4.0),
          //     ),
          //     child: Center(
          //       child: Text(
          //         '<1',
          //         style: TextStyle(
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                int number = index;
                print('num - $number');
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedNumberInfant = number;
                      widget.onNumberSelected(selectedNumberInfant);
                    });
                  },
                  child: Card(
                    elevation: 4,
                    child: Container(
                      width: 40.0,
                      // height: 40,
                      margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        color: selectedNumberInfant == number
                            ? Colors.blue // Change to your desired color
                            : Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Text(
                          number > 6 ? '>6' : number.toString(),
                          style: TextStyle(
                            color: selectedNumberInfant == number
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ----> domestic and international return
void getReturnSearchApi(
  List<LocationData> locationList11,
  bool isDomestic,
  int travellerCount,
  String from,
  String to,
  String cabinClass,
  String adult,
  String child,
  String infant,
  String fromCode,
  String toCode,
  String date1,
  String date2,
  BuildContext context,
) async {
  // Validation checks
  if (locationList11 == null || locationList11.isEmpty) {
    showErrorDialog(context, "Error", "Location list cannot be empty.");
    return;
  }

  if (travellerCount <= 0) {
    showErrorDialog(context, "Error", "Traveller count must be greater than zero.");
    return;
  }

  if ([from, to, cabinClass, adult, child, infant, fromCode, toCode, date1, date2].contains(null) || 
      [from, to, cabinClass, adult, child, infant, fromCode, toCode, date1, date2].contains('')) {
    showErrorDialog(context, "Error", "All fields must be filled out.");
    return;
  }

  if (!_isValidDate(date1) || !_isValidDate(date2)) {
    showErrorDialog(context, "Error", "Invalid date format. Please use YYYY-MM-DD.");
    return;
  }

  if (!_isDate2GreaterThanOrEqualDate1(date1, date2)) {
    showErrorDialog(context, "Error", "Return date must be greater than or equal to departure date.");
    return;
  }

  log("tofunction 1: $toCode");
  print(isDomestic
      ? "getDomesticReturnSearchApi()"
      : "getInternationalReturnSearchApi()");

  String _adult = adult;
  String _infant = infant;
  String _child = child;

  // Call the appropriate API based on the country
  String res;
  try {
    if (isDomestic) {
      res = await Domestic_returnsearchapi(
          cabinClass, adult, child, infant, fromCode, toCode, date1, date2);
    } else {
      res = await International_returnsearchapi(
          cabinClass, adult, child, infant, fromCode, toCode, date1, date2);
    }

    // Decode the response body from JSON
    Map<String, dynamic> data = json.decode(res);

    // Handle the API response
    handleApiResponse(
      data,
      context,
      travellerCount,
      from,
      to,
      date1,
      date2,
      fromCode,
      toCode,
      adult,
      child,
      infant,
      cabinClass,
      locationList11,
    );
  } catch (error) {
    showErrorDialog(context, "Error", "An error occurred: ${error.toString()}");
  }
}

bool _isValidDate(String date) {
  try {
    final parsedDate = DateTime.parse(date);
    return parsedDate != null;
  } catch (e) {
    return false;
  }
}

bool _isDate2GreaterThanOrEqualDate1(String date1, String date2) {
  try {
    final parsedDate1 = DateTime.parse(date1);
    final parsedDate2 = DateTime.parse(date2);
    return parsedDate2.isAtSameMomentAs(parsedDate1) || parsedDate2.isAfter(parsedDate1);
  } catch (e) {
    return false;
  }
}

void handleApiResponse(
  Map<String, dynamic> data,
  BuildContext context,
  int travellerCount,
  String from,
  String to,
  String date1,
  String date2,
  String fromCode,
  String toCode,
  String adult,
  String child,
  String infant,
  String cabin_class,
  List<LocationData> locationList11,
) {
  if (data == null || data['status'] == null || data['status']['httpStatus'] != 200) {
    // Display error message if status code is not 200 or data is null
    showErrorDialog(context, "Error", data['status'] != null ? data['status']['message'] : "Failed to fetch flight data");
    return;
  }

  if (data['searchResult'] == null || data['searchResult']['tripInfos'] == null) {
    showErrorDialog(context, "No Flights", "No flights available for the selected criteria.");
    return;
  }

  List<Flight> airIndiaFlightsReturn = [];
  List<Flight> airIndiaFlightsOnward = [];

  // Extract trip information from the API response
  if (data['searchResult']['tripInfos']['RETURN'] != null) {
    airIndiaFlightsReturn = extractFlights(data['searchResult']['tripInfos']['RETURN']);
  }

  if (data['searchResult']['tripInfos']['ONWARD'] != null) {
    airIndiaFlightsOnward = extractFlights(data['searchResult']['tripInfos']['ONWARD']);
  }

  else if (data['searchResult']['tripInfos']['ONWARD'] == null&& data['searchResult']['tripInfos']['RETURN']== null) {
    showErrorDialog(context, "No Flights", "No flights available for the selected criteria.");
    return;
  }

  // Navigate to search result page with extracted flight data
  navigateToSearchResultPage(
    context,
    airIndiaFlightsReturn,
    airIndiaFlightsOnward,
    travellerCount,
    from,
    to,
    date1,
    date2,
    fromCode,
    toCode,
    adult,
    child,
    infant,
    cabin_class,
    locationList11,
  );
}

List<Flight> extractFlights(List<dynamic> tripInfoData) {
  List<Flight> flights = [];

  for (dynamic tripInfo in tripInfoData) {
    List<dynamic> totalPriceList = tripInfo['totalPriceList'];

    for (dynamic priceData in totalPriceList) {
      double priceDouble = priceData['fd']['ADULT']['fC']['TF'];
      double pricebf_double = priceData['fd']['ADULT']['fC']['BF'];
      double pricetaf_double = priceData['fd']['ADULT']['fC']['TAF'];
      String checkingbaggage = priceData['fd']['ADULT']['bI']['iB'];
      String cabinbaggage = priceData['fd']['ADULT']['bI']['cB'];
      String travellerclass = priceData['fd']['ADULT']['cc'];

      String price = priceDouble.toString();
      String basefare = pricebf_double.toString();
      String surcharges = pricetaf_double.toString();
      String Price_id = priceData['id'];

      for (dynamic segment in tripInfo['sI']) {
        String airlineCode = segment['fD']['aI']['code'];
        String airlineName = segment['fD']['aI']['name'];
        int duration = segment['duration'];
        int stops = segment['stops'];
        String departureTime = segment['dt'];
        String arrivalTime = segment['at'];
        // ----------
        String arrivalcity = segment['aa']['city'];
        String departurecity = segment['da']['city'];
        String departurecountry = segment['da']['country'];
        String arrivalcountry = segment['aa']['country'];
        String arrivalterminal = segment['aa']['terminal'];
        String departureterminal = segment['da']['terminal'];
        String arrivalcode = segment['aa']["code"];
        String departurecode = segment['da']["code"];
        String arrivalairport = segment['aa']["name"];
        String departureairport = segment['da']["name"];
        Flight flight = Flight(
          airlineCode: airlineCode,
          airlineName: airlineName,
          duration: duration,
          stops: stops,
          departureTime: departureTime,
          arrivalTime: arrivalTime,
          price: price,
          pricceID: Price_id,
          travellerClass: travellerclass,
          checkingBaggage: checkingbaggage,
          cabinBaggage: cabinbaggage,
          baseFare: basefare,
          surCharges: surcharges,
          // ------
          arrivalCity: arrivalcity,
          departureCity: departurecity,
          arrivalTerminal: arrivalterminal,
          departureTerminal: departureterminal,
          departureCountry: departurecountry,
          arrivalCountry: arrivalcountry,

          arrivalairport: arrivalairport,
          departureairport: departureairport,
          from_code: departurecode,
          to_code: arrivalcode,
          // adult: _adult,
          // child: _child,
          // infant: _infant,
        );

        flights.add(flight);
      }
    }
  }

  return flights;
}

void showErrorDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

void navigateToSearchResultPage(
  BuildContext context,
  List<Flight> flightsReturn,
  List<Flight> flightsOnward,
  int travellerCount,
  String fromCity,
  String toCity,
  String date1,
  String date2,
  String frmcode,
  String tocde,
  String adult,
  String child,
  String infant,
  String cabin_class,
  List<LocationData> locationList11,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ReturnSearchListPage(
        flightmodelReturn: flightsReturn,
        flightmodelOnward: flightsOnward,
        travellerCount: travellerCount,
        fromCity: fromCity,
        toCity: toCity,
        date1: date1,
        date2: date2,
        locationList1: locationList11,
        fromcode: frmcode,
        tocode: tocde,
        adult: adult,
        child: child,
        infant: infant,
        cabin_class: cabin_class,
      ),
    ),
  );
}
// --------------------->

// international return
Future<void> getInternationalReturnSearch(
  List<LocationData> locationList11,
  int travellerCount,
  String from,
  String to,
  String cabinClass,
  String adult,
  String child,
  String infant,
  String fromCode,
  String toCode,
  String date1,
  String date2,
  BuildContext context,
) async {
  print("getInternationalReturnSearch()");

  // Validation checks
  if (cabinClass == null || fromCode == null || toCode == null) {
    showErrorDialog(context, "Error", "Cabin class, from code, and to code cannot be null.");
    return;
  }

  if (!_isValidDate(date1) || !_isValidDate(date2)) {
    showErrorDialog(context, "Error", "Invalid date format. Please use YYYY-MM-DD.");
    return;
  }

  if (!_isDate2GreaterThanOrEqualDate1(date1, date2)) {
    showErrorDialog(context, "Error", "Return date must be greater than or equal to departure date.");
    return;
  }

  try {
    String res = await International_returnsearchapi(
      cabinClass, adult, child, infant, fromCode, toCode, date1, date2);
    print("API response: $res");

    // Decode the response body from JSON
    Map<String, dynamic> data = json.decode(res);

    if (data != null) {
      // Check if the status is valid
      if (data.containsKey('status') &&
          data['status'] != null &&
          data['status']['httpStatus'] != null) {
        if (data['status']['httpStatus'] != 200) {
          showErrorDialog(
            context,
            data['errors']['message'] ?? 'Error',
            data['errors']['details'] ?? 'Something went wrong.',
          );
          return;
        }
      } else {
        showErrorDialog(context, "Error", "Invalid status structure or missing data.");
        return;
      }

      // Check if tripInfos and COMBO are available
      if (data.containsKey('searchResult') &&
          data['searchResult'] != null &&
          data['searchResult'].containsKey('tripInfos') &&
          data['searchResult']['tripInfos'] != null &&
          data['searchResult']['tripInfos'].containsKey('COMBO') &&
          data['searchResult']['tripInfos']['COMBO'] != null) {
        var comboList = data['searchResult'];
        print("combo $comboList");

        // Create ComboFlightData from the combo list
        ComboFlightData comboFlightData = ComboFlightData.fromJson(data['searchResult']);

        print("searchResult ${comboFlightData.tripInfos.combo.length}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => returnInternationalPage(
              result: comboFlightData,
              travellerCount: travellerCount,
              fromCity: from,
              toCity: to,
              date1: date1,
              date2: date2,
              locationList1: locationList11,
              fromCode: fromCode,
              toCode: toCode,
              adult: adult,
              child: child,
              infant: infant,
              cabinClass: cabinClass,
            ),
          ),
        );
      } else {
        showErrorDialog(context, "No Flights", "No flights available for the selected criteria.");
      }
    } else {
      showErrorDialog(context, "Error", "Received null response from API.");
    }
  } catch (e) {
    showErrorDialog(context, "Error", "An error occurred while processing the request: $e");
  }
}

// bool _isValidDate(String date) {
//   try {
//     final parsedDate = DateTime.parse(date);
//     return parsedDate != null;
//   } catch (e) {
//     return false;
//   }
// }

// bool _isDate2GreaterThanOrEqualDate1(String date1, String date2) {
//   try {
//     final parsedDate1 = DateTime.parse(date1);
//     final parsedDate2 = DateTime.parse(date2);
//     return parsedDate2.isAtSameMomentAs(parsedDate1) || parsedDate2.isAfter(parsedDate1);
//   } catch (e) {
//     return false;
//   }
// }

// void showErrorDialog(BuildContext context, String title, String content) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(content),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }











































































































































// /====================>>>
// Define your models here (AirlineInfo, AirportInfo, FlightDetails, etc.)

// Future<void> getInternationalReturnSearch(
//     List<LocationData> locationList11,
//     int travellerCount,
//     String from,
//     String to,
//     String cabinClass,
//     String adult,
//     String child,
//     String infant,
//     String fromCode,
//     String toCode,
//     String date1,
//     String date2,
//     BuildContext context) async {
//   print("getInternationalReturnSearch()");

//   if (cabinClass == null || fromCode == null || toCode == null) {
//     print("null error ");
//     print("datas: $cabinClass, $fromCode, $toCode");
//     return;
//   }

//   try {
//     String res = await International_returnsearchapi(
//         cabinClass, adult, child, infant, fromCode, toCode, date1, date2);
//     print("API response: $res");

//     // Decode the response body from JSON
//     Map<String, dynamic> data = json.decode(res);

//     if (data != null) {
//       // Check if the status is valid
//       if (data.containsKey('status') &&
//           data['status'] != null &&
//           data['status']['httpStatus'] != null) {
//         if (data['status']['httpStatus'] != 200) {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text(data['errors']['message'] ?? 'Error'),
//                 content:
//                     Text(data['errors']['details'] ?? 'Something went wrong.'),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text('OK'),
//                   ),
//                 ],
//               );
//             },
//           );
//           return;
//         }
//       } else {
//         print("Invalid status structure or missing data.");
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Error'),
//               content: Text('Invalid status structure or missing data.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//         return;
//       }

//       // Check if tripInfos and COMBO are available
//       if (data.containsKey('searchResult') &&
//           data['searchResult'] != null &&
//           data['searchResult'].containsKey('tripInfos') &&
//           data['searchResult']['tripInfos'] != null &&
//           data['searchResult']['tripInfos'].containsKey('COMBO') &&
//           data['searchResult']['tripInfos']['COMBO'] != null) {
//         var comboList = data['searchResult'];
//         print("combo $comboList");

//         // Convert to List<Combo>
//         // List<Combo> combos =
//         //     comboList.map((combo) => Combo.fromJson(combo)).toList();
//         // print(combos);

//         // Create ComboFlightData from the combo list
//         ComboFlightData comboFlightData =
//             ComboFlightData.fromJson(data['searchResult']);

//         print("searchResult ${comboFlightData.tripInfos.combo.length}");
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => returnInternationalPage(
//               result: comboFlightData,
//               // flightModelReturn: returnFlights,
//               // flightModelOnward: onwardFlights,
//               travellerCount: travellerCount,
//               fromCity: from,
//               toCity: to,
//               date1: date1,
//               date2: date2,
//               locationList1: locationList11,
//               fromCode: fromCode,
//               toCode: toCode,
//               adult: adult,
//               child: child,
//               infant: infant,
//               cabinClass: cabinClass,
//             ),
//           ),
//         );
//         //  Navigator.push(
// //     //   context,
// //     //   MaterialPageRoute(
// //     //     builder: (context) => returnInternationalPage(
// //     //       result:searchResult,
// //     //       // flightModelReturn: returnFlights,
// //     //       // flightModelOnward: onwardFlights,
// //     //       travellerCount: travellerCount,
// //     //       fromCity: from,
// //     //       toCity: to,
// //     //       date1: date1,
// //     //       date2: date2,
// //     //       locationList1: locationList11,
// //     //       fromCode: fromCode,
// //     //       toCode: toCode,
// //     //       adult: adult,
// //     //       child: child,
// //     //       infant: infant,
// //     //       cabinClass: cabinClass,
// //     //     ),
// //     //   ),
// //     // );
//       } else {
//         print("Invalid response structure or missing data in tripInfos/COMBO.");
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Error'),
//               content: Text(
//                   'Invalid response structure or missing data in tripInfos/COMBO.'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } else {
//       print("Received null response from API.");
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Received null response from API.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   } catch (e) {
//     print("Error: $e");
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text('An error occurred while processing the request: $e'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }








































































































































// -------------><
// void getReturnSearchApi(
//   List<LocationData> locationList11,
//   bool isDomestic,
//   int travellerCount,
//   String from,
//   String to,
//   String cabinClass,
//   String adult,
//   String child,
//   String infant,
//   String fromCode,
//   String toCode,
//   String date1,
//   String date2,
//   BuildContext context,
// ) async {
//   log("tofunction 1: $toCode");
//   print(isDomestic
//       ? "getDomesticReturnSearchApi()"
//       : "getInternationalReturnSearchApi()");

//   String _adult = adult;
//   String _infant = infant;
//   String _child = child;

//   if ([cabinClass, fromCode, toCode].contains(null)) {
//     print("Null error: $cabinClass, $fromCode, $toCode");
//     return;
//   }

//   // Call the appropriate API based on the country
//   String res;
//   if (isDomestic) {
//     res = await Domestic_returnsearchapi(
//         cabinClass, adult, child, infant, fromCode, toCode, date1, date2);
//   } else {
//     res = await International_returnsearchapi(
//         cabinClass, adult, child, infant, fromCode, toCode, date1, date2);
//   }

//   // Decode the response body from JSON
//   Map<String, dynamic> data = json.decode(res);

//   // Handle the API response
//   handleApiResponse(
//     data,
//     context,
//     travellerCount,
//     from,
//     to,
//     date1,
//     date2,
//     fromCode,
//     toCode,
//     adult,
//     child,
//     infant,
//     cabinClass,
//     locationList11,
//   );
// }

// void handleApiResponse(
//   Map<String, dynamic> data,
//   BuildContext context,
//   int travellerCount,
//   String from,
//   String to,
//   String date1,
//   String date2,
//   String fromCode,
//   String toCode,
//   String adult,
//   String child,
//   String infant,
//   String cabin_class,
//   List<LocationData> locationList11,
// ) {
//   if (data == null ||
//       data['status'] == null ||
//       data['status']['httpStatus'] != 200) {
//     // Display error message if status code is not 200 or data is null
//     showErrorDialog(context, "Error", "Failed to fetch flight data");
//     return;
//   }

//   List<Flight> airIndiaFlightsReturn = [];
//   List<Flight> airIndiaFlightsOnward = [];

//   // Extract trip information from the API response
//   if (data['searchResult'] != null &&
//       data['searchResult']['tripInfos'] != null) {
//     if (data['searchResult']['tripInfos']['RETURN'] != null) {
//       airIndiaFlightsReturn =
//           extractFlights(data['searchResult']['tripInfos']['RETURN']);
//     }

//     if (data['searchResult']['tripInfos']['ONWARD'] != null) {
//       airIndiaFlightsOnward =
//           extractFlights(data['searchResult']['tripInfos']['ONWARD']);
//     }
//   }

//   // Navigate to search result page with extracted flight data
//   navigateToSearchResultPage(
//     context,
//     airIndiaFlightsReturn,
//     airIndiaFlightsOnward,
//     travellerCount,
//     from,
//     to,
//     date1,
//     date2,
//     fromCode,
//     toCode,
//     adult,
//     child,
//     infant,
//     cabin_class,
//     locationList11,
//   );
// }

// List<Flight> extractFlights(List<dynamic> tripInfoData) {
//   List<Flight> flights = [];

//   for (dynamic tripInfo in tripInfoData) {
//     List<dynamic> totalPriceList = tripInfo['totalPriceList'];

//     for (dynamic priceData in totalPriceList) {
//       double priceDouble = priceData['fd']['ADULT']['fC']['TF'];
//       double pricebf_double = priceData['fd']['ADULT']['fC']['BF'];
//       double pricetaf_double = priceData['fd']['ADULT']['fC']['TAF'];
//       String checkingbaggage = priceData['fd']['ADULT']['bI']['iB'];
//       String cabinbaggage = priceData['fd']['ADULT']['bI']['cB'];
//       String travellerclass = priceData['fd']['ADULT']['cc'];

//       String price = priceDouble.toString();
//       String basefare = pricebf_double.toString();
//       String surcharges = pricetaf_double.toString();
//       String Price_id = priceData['id'];

//       for (dynamic segment in tripInfo['sI']) {
//         String airlineCode = segment['fD']['aI']['code'];
//         String airlineName = segment['fD']['aI']['name'];
//         int duration = segment['duration'];
//         int stops = segment['stops'];
//         String departureTime = segment['dt'];
//         String arrivalTime = segment['at'];
//         // ----------
//         String arrivalcity = segment['aa']['city'];
//         String departurecity = segment['da']['city'];
//         String departurecountry = segment['da']['country'];
//         String arrivalcountry = segment['aa']['country'];
//         String arrivalterminal = segment['aa']['terminal'];
//         String departureterminal = segment['da']['terminal'];
//         String arrivalcode = segment['aa']["code"];
//         String departurecode = segment['da']["code"];
//         String arrivalairport = segment['aa']["name"];
//         String departureairport = segment['da']["name"];
//         Flight flight = Flight(
//           airlineCode: airlineCode,
//           airlineName: airlineName,
//           duration: duration,
//           stops: stops,
//           departureTime: departureTime,
//           arrivalTime: arrivalTime,
//           price: price,
//           pricceID: Price_id,
//           travellerClass: travellerclass,
//           checkingBaggage: checkingbaggage,
//           cabinBaggage: cabinbaggage,
//           baseFare: basefare,
//           surCharges: surcharges,
//           // ------
//           arrivalCity: arrivalcity,
//           departureCity: departurecity,
//           arrivalTerminal: arrivalterminal,
//           departureTerminal: departureterminal,
//           departureCountry: departurecountry,
//           arrivalCountry: arrivalcountry,

//           arrivalairport: arrivalairport,
//           departureairport: departureairport,
//           from_code: departurecode,
//           to_code: arrivalcode,
//           // adult: _adult,
//           // child: _child,
//           // infant: _infant,
//         );

//         flights.add(flight);
//       }
//     }
//   }

//   return flights;
// }

// void showErrorDialog(BuildContext context, String title, String content) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(content),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }

// void navigateToSearchResultPage(
//   BuildContext context,
//   List<Flight> flightsReturn,
//   List<Flight> flightsOnward,
//   int travellerCount,
//   String fromCity,
//   String toCity,
//   String date1,
//   String date2,
//   String frmcode,
//   String tocde,
//   String adult,
//   String child,
//   String infant,
//   String cabin_class,
//   List<LocationData> locationList11,
// ) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => ReturnSearchListPage(
//         flightmodelReturn: flightsReturn,
//         flightmodelOnward: flightsOnward,
//         travellerCount: travellerCount,
//         fromCity: fromCity,
//         toCity: toCity,
//         date1: date1,
//         date2: date2,
//         locationList1: locationList11,
//         // search container
//         // type: "Return",
//         // travellerCount: travellerCount,
//         fromcode: frmcode,
//         tocode: tocde,
//         adult: adult,
//         child: child,
//         infant: infant,
//         cabin_class: cabin_class,
//       ),
//     ),
//   );
// }



































// ----------------> domestic_return

// Future<void> getDomesticReturnSearchApi(
//   int travellerCount,
//   String from,
//   String to,
//   String cabinClass,
//   String adult,
//   String child,
//   String infant,
//   String fromCode,
//   String toCode,
//   String date1,
//   date2,
//   BuildContext context,
// ) async {
//   print("getDomesticReturnSearchApi()");

//   if ([cabinClass, fromCode, toCode].contains(null)) {
//     print("Null error: $cabinClass, $fromCode, $toCode");
//     return;
//   }

//   // Call API and handle response
//   // Example: String response = await callApiMethod(parameters);

//   // Simulated API response
//   Map<String, dynamic> data = {
//     'status': {'httpStatus': 200}, // Simulated success status
//     'searchResult': {
//       'tripInfos': {'RETURN': [], 'ONWARD': []}, // Simulated trip data
//     },
//   };

//   // Handle API response
//   handleApiResponse(data, context, travellerCount, from, to);
// }

// void handleApiResponse(
//   Map<String, dynamic> data,
//   BuildContext context,
//   int travellerCount,
//   String from,
//   String to,
// ) {
//   if (data['status']['httpStatus'] != 200) {
//     // Display error message if status code is not 200
//     showErrorDialog(context, data['errors']['message'], data['errors']['details']);
//     return;
//   }

//   // Extract trip information from the API response
//   List<Flight> airIndiaFlightsReturn = extractFlights(data['searchResult']['tripInfos']['RETURN']);
//   List<Flight> airIndiaFlightsOnward = extractFlights(data['searchResult']['tripInfos']['ONWARD']);

//   // Navigate to search result page with extracted flight data
//   navigateToSearchResultPage(context, airIndiaFlightsReturn, airIndiaFlightsOnward, travellerCount, from, to);
// }

// List<Flight> extractFlights(List<dynamic> tripInfoData) {
//   List<Flight> flights = [];

//   for (dynamic tripInfo in tripInfoData) {
//     List<dynamic> totalPriceList = tripInfo['totalPriceList'];

//     for (dynamic priceData in totalPriceList) {
//       double priceDouble = priceData['fd']['ADULT']['fC']['TF'];
//       String price = priceDouble.toString();

//       for (dynamic segment in tripInfo['sI']) {
//         String airlineCode = segment['fD']['aI']['code'];
//         String airlineName = segment['fD']['aI']['name'];
//         int duration = segment['duration'];
//         int stops = segment['stops'];
//         String departureTime = segment['dt'];
//         String arrivalTime = segment['at'];

//         Flight flight = Flight(
//           airlineCode: airlineCode,
//           airlineName: airlineName,
//           duration: duration,
//           stops: stops,
//           departureTime: departureTime,
//           arrivalTime: arrivalTime,
//           price: price,
//         );

//         flights.add(flight);
//       }
//     }
//   }

//   return flights;
// }

// void showErrorDialog(BuildContext context, String title, String content) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(content),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }

// void navigateToSearchResultPage(
//   BuildContext context,
//   List<Flight> flightsReturn,
//   List<Flight> flightsOnward,
//   int travellerCount,
//   String fromCity,
//   String toCity,
// ) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => ReturnSearchListPage(
//         flightmodelReturn: flightsReturn,
//         flightmodelOnward: flightsOnward,
//         travellerCount: travellerCount,
//         fromCity: fromCity,
//         toCity: toCity,
//       ),
//     ),
//   );
// }

// getdomestic_returnsearchapi(
//     int travellerCount,
//     String from,
//     String to,
//     String cabin_class,
//     String adult,
//     String child,
//     String infant,
//     String from_code,
//     String to_code,
//     String date1,
//     date2,
//     BuildContext context) async {
//   print(" getdomestic_returnsearchapi()");

//   if (cabin_class == null || from_code == null || to_code == null) {
//     print("null error ");
//     print("datas:$cabin_class,$from_code,$to_code ");
//     return;
//   }

//   String res = await Domestic_returnsearchapi(
//       cabin_class, adult, child, infant, from_code, to_code, date1, date2);

//   Map<String, dynamic> data = json.decode(res);

//   // change this if u got api
// // Map<String, dynamic> data = returnd;
//   // Check if the status code is not 200
//   if (data['status']['httpStatus'] != 200) {
//     // Display an alert box with the error message
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(data['errors']['message']),
//           content: Text(data['errors']['details']),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//     return;
//   }

//   dynamic tripInfoData_return = data['searchResult']['tripInfos']['RETURN'];
//   dynamic tripInfoData_onward = data['searchResult']['tripInfos']['ONWARD'];
//   log("tripinfo_onward:$tripInfoData_onward");

//   List<Flight> airIndiaFlights_return = [];
//   List<Flight> airIndiaFlights_onward = [];

// //  return
//   for (dynamic tripInfo in tripInfoData_return) {
//     List<dynamic> totalPriceList = tripInfo['totalPriceList'];

//     for (dynamic priceData in totalPriceList) {
//       double pricedouble = priceData['fd']['ADULT']['fC']['TF'];
//       String price = pricedouble.toString();

//       // log("price:$price");

//       for (dynamic segment in tripInfo['sI']) {
//         String airlineCode = segment['fD']['aI']['code'];
//         String airlineName = segment['fD']['aI']['name'];
//         int duration = segment['duration'];
//         int stops = segment['stops'];
//         String departureTime = segment['dt'];
//         String arrivalTime = segment['at'];

//         Flight flight_return = Flight(
//           ComboFlightData : tripInfo,
//           airlineCode: airlineCode,
//           airlineName: airlineName,
//           duration: duration,
//           stops: stops,
//           departureTime: departureTime,
//           arrivalTime: arrivalTime,
//           price: price,
//         );
//         airIndiaFlights_return.add(flight_return);
//       }
//     }
//   }

// // onward
//   for (dynamic tripInfo in tripInfoData_onward) {
//     List<dynamic> totalPriceList = tripInfo['totalPriceList'];

//     for (dynamic priceData in totalPriceList) {
//       double pricedouble = priceData['fd']['ADULT']['fC']['TF'];
//       String price = pricedouble.toString();

//       // log("price:$price");

//       for (dynamic segment in tripInfo['sI']) {
//         String airlineCode = segment['fD']['aI']['code'];
//         String airlineName = segment['fD']['aI']['name'];
//         int duration = segment['duration'];
//         int stops = segment['stops'];
//         String departureTime = segment['dt'];
//         String arrivalTime = segment['at'];

//         Flight flight_onward = Flight(
//           ComboFlightData : tripInfo,
//           airlineCode: airlineCode,
//           airlineName: airlineName,
//           duration: duration,
//           stops: stops,
//           departureTime: departureTime,
//           arrivalTime: arrivalTime,
//           price: price,
//         );
//         airIndiaFlights_onward.add(flight_onward);
//       }
//     }
//   }

//   Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (contex) => ReturnSearchListPage(
//               flightmodel_return: airIndiaFlights_return,
//               flightmodel_onward: airIndiaFlights_onward,
//               travellerCount: travellerCount,
//               fromcity: from,
//               tocity: to)));
// }

// international return

// Future<void> getInternationalReturnSearch(
//     List<LocationData> locationList11,
//     //  bool isDomestic,
//     int travellerCount,
//     String from,
//     String to,
//     String cabinClass,
//     String adult,
//     String child,
//     String infant,
//     String fromCode,
//     String toCode,
//     String date1,
//     String date2,
//     BuildContext context) async {
//   print("getInternationalReturnSearch()");

//   if (cabinClass == null || fromCode == null || toCode == null) {
//     print("null error ");
//     print("datas: $cabinClass, $fromCode, $toCode");
//     return;
//   }

//   String res = await International_returnsearchapi(
//       cabinClass, adult, child, infant, fromCode, toCode, date1, date2);
//   print("dfghj: $res");
//   // Decode the response body from JSON
//   Map<String, dynamic> data = json.decode(res);

//   // Check if the status code is not 200
//   if (data['status']['httpStatus'] != 200) {
//     // Display an alert box with the error message
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(data['errors']['message']),
//           content: Text(data['errors']['details']),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//     return;
//   }

//   if (res != 'failed') {
//     List<Flight> extractFlights(List<dynamic> tripInfoData) {
//       List<Flight> flights = [];

//       for (dynamic tripInfo in tripInfoData) {
//         List<dynamic> totalPriceList = tripInfo['totalPriceList'];

//         for (dynamic priceData in totalPriceList) {
//           for (dynamic segment in tripInfo['sI']) {
//             String airlineCode = segment['fD']['aI']['code'];
//             String airlineName = segment['fD']['aI']['name'];
//             int duration = segment['duration'];
//             int stops = segment['stops'];
//             String departureTime = segment['dt'];
//             String arrivalTime = segment['at'];
//             // ----------
//             String arrivalcity = segment['aa']['city'];
//             String departurecity = segment['da']['city'];
//             String departurecountry = segment['da']['country'];
//             String arrivalcountry = segment['aa']['country'];
//             String arrivalterminal = segment['aa']['terminal'];
//             String departureterminal = segment['da']['terminal'];
//             String arrivalcode = segment['aa']["code"];
//             String departurecode = segment['da']["code"];
//             String arrivalairport = segment['aa']["name"];
//             String departureairport = segment['da']["name"];

//             print("airline $airlineCode");
//             print("airlinename $airlineName");
//             print("duration $duration");
//             print("stops $stops");
//             print("departure $departureTime");
//             print("arrival time $arrivalTime");
//             print("arrival city $arrivalcity");
//             print("departurecity $departurecity");
//             print("departure country $departurecountry");
//             print("arrival country $arrivalcountry");
//             print("arrival terminal $arrivalterminal");
//             print("depature terminal $departureterminal");
//             print("arrivalcode $arrivalcode");
//             print("departure code $departurecode");
//             print("arrival airport $arrivalairport");
//             print("departure airport $departureairport");
//           }
//         }
//       }
//     }

//     //   InternationalReturnSearchObj obj =
//     //       InternationalReturnSearchObj.fromJson(jsonDecode(res));
//     //   if (obj.status.success) {
//     //     SearchResult searchResult = obj.searchResult;
//     //     Navigator.push(
//     //   context,
//     //   MaterialPageRoute(
//     //     builder: (context) => returnInternationalPage(
//     //       result:searchResult,
//     //       // flightModelReturn: returnFlights,
//     //       // flightModelOnward: onwardFlights,
//     //       travellerCount: travellerCount,
//     //       fromCity: from,
//     //       toCity: to,
//     //       date1: date1,
//     //       date2: date2,
//     //       locationList1: locationList11,
//     //       fromCode: fromCode,
//     //       toCode: toCode,
//     //       adult: adult,
//     //       child: child,
//     //       infant: infant,
//     //       cabinClass: cabinClass,
//     //     ),
//     //   ),
//     // );
//     //   }
//   }

  // dynamic tripInfoData = data['searchResult']['tripInfos']['COMBO'];
  // print("tripInfo: $tripInfoData");

  // List<Flight> onwardFlights = [];
  // List<Flight> returnFlights = [];

  // for (dynamic tripInfo in tripInfoData) {
  //   List<dynamic> totalPriceList = tripInfo['totalPriceList'];

  //   for (dynamic priceData in totalPriceList) {
  //     double priceDouble = priceData['fd']['ADULT']['fC']['TF'];
  //     double priceBaseFareDouble = priceData['fd']['ADULT']['fC']['BF'];
  //     double priceSurchargesDouble = priceData['fd']['ADULT']['fC']['TAF'];
  //     String checkingBaggage = priceData['fd']['ADULT']['bI']['iB'];
  //     String cabinBaggage = priceData['fd']['ADULT']['bI']['cB'];
  //     String travellerClass = priceData['fd']['ADULT']['cc'];
  //     String priceId = priceData['id'];

  //     String price = priceDouble.toString();
  //     String baseFare = priceBaseFareDouble.toString();
  //     String surcharges = priceSurchargesDouble.toString();

  //     for (dynamic segment in tripInfo['sI']) {
  //       String airlineCode = segment['fD']['aI']['code'];
  //       String airlineName = segment['fD']['aI']['name'];
  //       int duration = segment['duration'];
  //       int stops = segment['stops'];
  //       String departureTime = segment['dt'];
  //       String arrivalTime = segment['at'];
  //       String arrivalCity = segment['aa']['city'];
  //       String departureCity = segment['da']['city'];
  //       String departureCountry = segment['da']['country'];
  //       String arrivalCountry = segment['aa']['country'];
  //       String arrivalTerminal = segment['aa']['terminal'];
  //       String departureTerminal = segment['da']['terminal'];
  //       String arrivalCode = segment['aa']['code'];
  //       String departureCode = segment['da']['code'];
  //       String arrivalAirport = segment['aa']['name'];
  //       String departureAirport = segment['da']['name'];

  //       Flight flight = Flight(
  //         airlineCode: airlineCode,
  //         airlineName: airlineName,
  //         duration: duration,
  //         stops: stops,
  //         departureTime: departureTime,
  //         arrivalTime: arrivalTime,
  //         price: price,
  //         pricceID: priceId,
  //         travellerClass: travellerClass,
  //         checkingBaggage: checkingBaggage,
  //         cabinBaggage: cabinBaggage,
  //         baseFare: baseFare,
  //         surCharges: surcharges,
  //         arrivalCity: arrivalCity,
  //         departureCity: departureCity,
  //         arrivalTerminal: arrivalTerminal,
  //         departureTerminal: departureTerminal,
  //         departureCountry: departureCountry,
  //         arrivalCountry: arrivalCountry,
  //         arrivalairport: arrivalAirport,
  //         departureairport: departureAirport,
  //         from_code: departureCode,
  //         to_code: arrivalCode,
  //       );

  //       if (segment['da']['code'] == fromCode && segment['aa']['code'] == toCode) {
  //         onwardFlights.add(flight);
  //       } else if (segment['da']['code'] == toCode && segment['aa']['code'] == fromCode) {
  //         returnFlights.add(flight);
  //       }
  //     }
  //   }
  // }

  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => ReturnSearchListPage(
  //       flightmodelReturn: returnFlights,
  //       flightmodelOnward: onwardFlights,
  //       travellerCount: travellerCount,
  //       fromCity: from,
  //       toCity: to,
  //       date1: date1,
  //       date2: date2,
  //       locationList1: locationList11,
  //       fromcode: fromCode,
  //       tocode: toCode,
  //       adult: adult,
  //       child: child,
  //       infant: infant,
  //       cabin_class: cabinClass,
  //     ),
  //   ),
  // );
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => returnInternationalPage(
  //       flightModelReturn: returnFlights,
  //       flightModelOnward: onwardFlights,
  //       travellerCount: travellerCount,
  //       fromCity: from,
  //       toCity: to,
  //       date1: date1,
  //       date2: date2,
  //       locationList1: locationList11,
  //       fromCode: fromCode,
  //       toCode: toCode,
  //       adult: adult,
  //       child: child,
  //       infant: infant,
  //       cabinClass: cabinClass,
  //     ),
  //   ),
  // );
// }

// ---new--
// Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => returnInternationalPage(
//         flightModelReturn: returnFlights,
//         flightModelOnward: onwardFlights,
//         travellerCount: travellerCount,
//         fromCity: from,
//         toCity: to,
//         date1: date1,
//         date2: date2,
//         locationList1: locationList11,
//         fromCode: fromCode,
//         toCode: toCode,
//         adult: adult,
//         child: child,
//         infant: infant,
//         cabinClass: cabinClass,
//       ),
//     ),
//   );




// // ======yguhklm;,/>gjhbkn
// getinternational_return_search(
//    List<LocationData> locationList11,
//   bool isDomestic,
//   int travellerCount,
//   String from,
//   String to,
//     String cabin_class,
//     String adult,
//     String child,
//     String infant,
//     String from_code,
//     String to_code,
//     String date1,
//      String date2,
//     BuildContext context) async {
//   print(" getinternational_returnsearchapi()");

//   if (cabin_class == null || from_code == null || to_code == null) {
//     print("null error ");
//     print("datas:$cabin_class,$from_code,$to_code ");
//     return;
//   }
//   String res = await International_returnsearchapi(
//       cabin_class, adult, child, infant, from_code, to_code, date1, date2);

// // Decode the response body from JSON
//   Map<String, dynamic> data = json.decode(res);

//   // Check if the status code is not 200
//   if (data['status']['httpStatus'] != 200) {
//     // Display an alert box with the error message
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(data['errors']['message']),
//           content: Text(data['errors']['details']),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//     return;
//   }

//   dynamic tripInfoData = data['searchResult']['tripInfos']['COMBO'];
//   print("tripinfo:$tripInfoData");
// List<Flight> flights = [];

//   for (dynamic tripInfo in tripInfoData) {
//     List<dynamic> totalPriceList = tripInfo['totalPriceList'];

//     for (dynamic priceData in totalPriceList) {
//       double priceDouble = priceData['fd']['ADULT']['fC']['TF'];
//       double pricebf_double = priceData['fd']['ADULT']['fC']['BF'];
//       double pricetaf_double = priceData['fd']['ADULT']['fC']['TAF'];
//       String checkingbaggage = priceData['fd']['ADULT']['bI']['iB'];
//       String cabinbaggage = priceData['fd']['ADULT']['bI']['cB'];
//       String travellerclass = priceData['fd']['ADULT']['cc'];

//       String price = priceDouble.toString();
//       String basefare = pricebf_double.toString();
//       String surcharges = pricetaf_double.toString();
//       String Price_id = priceData['id'];

//       for (dynamic segment in tripInfo['sI']) {
//         String airlineCode = segment['fD']['aI']['code'];
//         String airlineName = segment['fD']['aI']['name'];
//         int duration = segment['duration'];
//         int stops = segment['stops'];
//         String departureTime = segment['dt'];
//         String arrivalTime = segment['at'];
//         // ----------
//         String arrivalcity = segment['aa']['city'];
//         String departurecity = segment['da']['city'];
//         String departurecountry = segment['da']['country'];
//         String arrivalcountry = segment['aa']['country'];
//         String arrivalterminal = segment['aa']['terminal'];
//         String departureterminal = segment['da']['terminal'];
//         String arrivalcode = segment['aa']["code"];
//         String departurecode = segment['da']["code"];
//         String arrivalairport = segment['aa']["name"];
//         String departureairport = segment['da']["name"];
//         Flight flight = Flight(
//           airlineCode: airlineCode,
//           airlineName: airlineName,
//           duration: duration,
//           stops: stops,
//           departureTime: departureTime,
//           arrivalTime: arrivalTime,
//           price: price,
//           pricceID: Price_id,
//           travellerClass: travellerclass,
//           checkingBaggage: checkingbaggage,
//           cabinBaggage: cabinbaggage,
//           baseFare: basefare,
//           surCharges: surcharges,
//           // ------
//           arrivalCity: arrivalcity,
//           departureCity: departurecity,
//           arrivalTerminal: arrivalterminal,
//           departureTerminal: departureterminal,
//           departureCountry: departurecountry,
//           arrivalCountry: arrivalcountry,

//           arrivalairport: arrivalairport,
//           departureairport: departureairport,
//           from_code: departurecode,
//           to_code: arrivalcode,
//           // adult: _adult,
//           // child: _child,
//           // infant: _infant,
//         );

//         flights.add(flight);
//       }
//     }
//   }
  
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => ReturnSearchListPage(
//         flightmodelReturn: flights,
//         flightmodelOnward: flights,
//         travellerCount: travellerCount,
//         fromCity: from,
//         toCity: to,
//         date1: date1,
//         date2: date2,
//         locationList1: locationList11,
//         // search container
//         // type: "Return",
//         // travellerCount: travellerCount,
//         fromcode:from_code ,
//         tocode: to_code,
//         adult: adult,
//         child: child,
//         infant: infant,
//         cabin_class: cabin_class,
        
//       ),
//     ),
//   );
// }
















// ======yguhklm;,/>gjhbkn






// List<Flight> airIndiaFlights = [];

  // for (dynamic tripInfo in tripInfoData) {
  //   List<dynamic> totalPriceList = tripInfo['totalPriceList'];
  //   printWhite("totalPriceList $totalPriceList");
  //   // Assuming totalPriceList is an array with multiple elements

  //   for (dynamic priceData in totalPriceList) {
  //     double pricedouble = priceData['fd']['ADULT']['fC']['TF'];
  //     String price = pricedouble.toString();
  //     // Assuming 'TF' contains the price value

  //     log("price:$price");

  //     for (dynamic segment in tripInfo['so']) {
  //       String airlineCode = segment['fD']['aI']['code'];
  //       String airlineName = segment['fD']['aI']['name'];
  //       int duration = segment['duration'];
  //       int stops = segment['stops'];
  //       String departureTime = segment['dt'];
  //       String arrivalTime = segment['at'];

  //       Flight flight = Flight(
  //         ComboFlightData : tripInfo,
  //         airlineCode: airlineCode,
  //         airlineName: airlineName,
  //         duration: duration,
  //         stops: stops,
  //         departureTime: departureTime,
  //         arrivalTime: arrivalTime,
  //         price: price,
  //       );
  //       airIndiaFlights.add(flight);
  //     }
  //   }
  // }
