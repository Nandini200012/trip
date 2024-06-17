import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trip/common/print_funtions.dart';
import 'package:trip/screens/bus/models/dummy_datas/oneway_domestic_data.dart';
import 'package:trip/screens/oneway/oneway_list.dart';
import 'package:trip/screens/searchlist.dart';

import '../api_services/location_list_api.dart';
import '../api_services/search apis/one_way/airsearch_domestic_api.dart';
import '../api_services/search apis/one_way/international_oneway_searchapi.dart';
import '../models/flight_model.dart';
import '../models/oneway_model.dart';
import '../screens/bus/models/dummy_datas/oneway_international_data.dart';
import '../screens/bus/models/oneway_model_deomestic.dart';

class TravelClass extends StatefulWidget {
  final Function(int) onSelected;

  TravelClass(this.onSelected);
  // const TravelClass({key});

  @override
  State<TravelClass> createState() => _TravelClassState();
}

class _TravelClassState extends State<TravelClass> {
  int selectedclass = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3, // Number of travel class options
        itemBuilder: (BuildContext context, int index) {
          String travelClass;
          switch (index) {
            case 0:
              travelClass = 'Economy';
              break;
            case 1:
              travelClass = 'Premium Economy';
              break;
            case 2:
              travelClass = 'Business';
              break;
            default:
              travelClass = '';
              break;
          }
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedclass = index;
                widget.onSelected(selectedclass);
              });

              // Handle onTap event here
              print('Selected Travel Class: $selectedclass');
            },
            child: Card(
              elevation: 2,
              child: Container(
                margin: EdgeInsets.all(2.0),
                padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                decoration: BoxDecoration(
                  color: index == selectedclass ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Text(
                    travelClass,
                    style: TextStyle(
                      color:
                          index == selectedclass ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// // domestic_oneway

Future<void> searchDomesticOneway1(
  List<LocationData> locationList1,
  String from,
  String to,
  String cabin_class,
  String adult,
  String child,
  String infant,
  String from_code,
  String to_code,
  String date,
  int travellerCount,
  BuildContext context,
) async {
  print("searchDomesticOneway1()");

  int adultCount = int.parse(adult);
  int childCount = int.parse(child);
  int infantCount = int.parse(infant);

  if (cabin_class == null || from_code == null || to_code == null) {
    print("null error ");
    print("datas:$cabin_class,$from_code,$to_code ");
    return;
  }

  try {
    // --dynamic
    String res = await searchDomesticOnewayAPI(
      cabin_class,
      adult,
      child,
      infant,
      from_code,
      to_code,
      date,
    );
// static int
    // String res = jsonEncode(onewayD);
    // Decode the response body from JSON
    Map<String, dynamic> data = json.decode(res);

    // Check if the status code is not 200
    if (data['status']['httpStatus'] != 200) {
      // Display an alert box with the error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(data['errors']['message']),
            content: Text(data['errors']['details']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    if (data['searchResult'] != null &&
        data['searchResult']['tripInfos'] != null &&
        data['searchResult']['tripInfos']['ONWARD'] != null) {
      // -------------------->
      // OneWaymodel _onwayobj = OneWaymodel.fromJson(jsonDecode(res));

      // print("obj: $_onwayobj");
      // print("data:${_onwayobj.searchResult.tripInfos.onward.length}");

      // -------------------->
        dynamic tripInfoData = data['searchResult']['tripInfos']['ONWARD'];
        print('\x1B[32m Success \x1B[0m');
        print('\x1B[33m tripinfo:$tripInfoData \x1B[0m');

        List<Flight> airIndiaFlights = [];

        for (dynamic tripInfo in tripInfoData) {
          List<dynamic> totalPriceList = tripInfo['totalPriceList'];
          if (totalPriceList == null) continue; // Skip if no price list

          for (dynamic priceData in totalPriceList) {
            double pricedouble = priceData['fd']['ADULT']['fC']['TF'];
            double pricebf_double = priceData['fd']['ADULT']['fC']['BF'];
            double pricetaf_double = priceData['fd']['ADULT']['fC']['TAF'];
            String checkingbaggage = priceData['fd']['ADULT']['bI']['iB'];
            String cabinbaggage = priceData['fd']['ADULT']['bI']['cB'];
            String priceID = priceData['id'];
            int refund = priceData['rT'];
            bool meal = priceData['mI'];
            String travellerClass = priceData['fd']['ADULT']['cc'];
            String price = pricedouble.toString();
            String baseFare = pricebf_double.toString();
            String surcharges = pricetaf_double.toString();

            for (dynamic segment in tripInfo['sI']) {
              // if (segment['so'] != null && segment['so'].isNotEmpty) {
              //   String socode = segment['so'][0]["code"];
              //   print("socode $socode");
              //   String soname = segment['so'][0]["name"];
              //    print("soname $soname");
              //   String socityCode = segment['so'][0]["cityCode"];
              //    print("socityCode $socityCode");
              //   String socity = segment['so'][0]["city"];
              //    print("socity $socity");
              //   String socountry = segment['so'][0]["country"];
              //    print("socountry $socountry");
              //   String socountryCode = segment['so'][0]["countryCode"];
              //    print("socountryCode $socountryCode");

              // }
              String flightNumber = segment['fD']['fN'].toString();
              String equipmentType = segment['fD']['eT'].toString();
              // printWhite("flight number: ${flightNumber}, et: ${equipmentType}");

              String airlineCode = segment['fD']['aI']['code'];
              String airlineName = segment['fD']['aI']['name'];
              String airlineNo = segment['fN'];

              int duration = segment['duration'];
              int stops = segment['stops'];
              String departureTime = segment['dt'];
              String arrivalTime = segment['at'];
              String arrivalCity = segment['aa']['city'];
              String departureCity = segment['da']['city'];
              String departureCountry = segment['da']['country'];
              String arrivalCountry = segment['aa']['country'];
              String arrivalTerminal = segment['aa']['terminal'];
              String departureTerminal = segment['da']['terminal'];
              String arrivalAirport = segment['aa']['name'];
              String departureAirport = segment['da']['name'];
              String arrivalCode = segment['aa']['code'];
              String departureCode = segment['da']['code'];

              Flight flight = Flight(
                flightnumber: flightNumber.toString(),
                equipmentType: equipmentType,
                pricceID: priceID,
                flightData: tripInfo,
                airlineCode: airlineCode,
                airlineName: airlineName,
                duration: duration,
                stops: stops,
                departureTime: departureTime,
                arrivalTime: arrivalTime,
                price: price,
                arrivalCity: arrivalCity,
                departureCity: departureCity,
                arrivalTerminal: arrivalTerminal,
                departureTerminal: departureTerminal,
                baseFare: baseFare,
                surCharges: surcharges,
                flightNo: airlineNo,
                departureCountry: departureCountry,
                arrivalCountry: arrivalCountry,
                checkingBaggage: checkingbaggage,
                cabinBaggage: cabinbaggage,
                refund: refund,
                meal: meal,
                travellerClass: travellerClass,
                arrivalairport: arrivalAirport,
                departureairport: departureAirport,
                from_code: departureCode,
                to_code: arrivalCode,
                adult: adultCount,
                child: childCount,
                infant: infantCount,
              );
              airIndiaFlights.add(flight);
            }
          }
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchListPage(
              locationList1: locationList1,
              travellerCount: travellerCount,
              flightmodel: airIndiaFlights,
              fromcity: from,
              tocity: to,
              type: "One Way",
              adult: adult,
              child: child,
              infant: infant,
              cabin_class: cabin_class,
              date: date,
              fromcode: from_code,
              tocode: to_code,
            ),
          ),
        );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sorry!"),
            content: Text("No flights available"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print("Error: $e");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(
              "An error occurred while searching for flights. Please try again."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// Future<void> searchDomesticOneway1(
//   String from,
//   String to,
//   String cabinClass,
//   String adult,
//   String child,
//   String infant,
//   String fromCode,
//   String toCode,
//   String date,
//   int travellerCount,
//   BuildContext context,
// ) async {
//   print("searchDomesticOneway1()");

//   // Validating input parameters
//   if (cabinClass == null || fromCode == null || toCode == null || date == null) {
//     print("Null error ");
//     print("Data: $cabinClass, $fromCode, $toCode ");
//     return;
//   }

//   String res = await searchDomesticOnewayAPI(
//     cabinClass,
//     adult,
//     child,
//     infant,
//     fromCode,
//     toCode,
//     date,
//   );

//   Map<String, dynamic> data = json.decode(res);

//   if (data['status']['httpStatus'] != 200) {
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

//   onewayobj tripInfoData = onewayobj.fromJson(data);
//   SearchResult tripres = tripInfoData.searchResult;

//   print('\x1B[32m Success \x1B[0m');
//   print('\x1B[33m Trip Info: $tripres \x1B[0m');

//    Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (contex) => OneWaysearchList(
//         tripinfos: tripres,

//           ),
//     ),
//   );
// }

// domestic_oneway
// searchDomesticOneway1(
//   List<LocationData> locationList1,
//   String from,
//   String to,
//   String cabin_class,
//   String adult,
//   String child,
//   String infant,
//   String from_code,
//   String to_code,
//   String date,
//   int travellerCount,
//   BuildContext context,
// ) async {
//   print("searchDomesticOneway1()");

//   int adultCount = int.parse(adult);
//   int childCount = int.parse(child);
//   int infantCount = int.parse(infant);

//   if (cabin_class == null || from_code == null || to_code == null) {
//     print("null error ");
//     print("datas:$cabin_class,$from_code,$to_code ");
//     return;
//   }

//   String res = await searchDomesticOnewayAPI(
//     cabin_class,
//     adult,
//     child,
//     infant,
//     from_code,
//     to_code,
//     date,
//   );

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
// if(data['searchResult']!=null){
//   dynamic tripInfoData = data['searchResult']['tripInfos']['ONWARD'];
//   print('\x1B[32m Success \x1B[0m');
//   print('\x1B[33m tripinfo:$tripInfoData \x1B[0m');
//   // print("tripinfo:$tripInfoData");

//   List<Flight> airIndiaFlights = [];

//   for (dynamic tripInfo in tripInfoData) {
//     List<dynamic> totalPriceList = tripInfo['totalPriceList'];
//     // Assuming totalPriceList is an array with multiple elements

//     for (dynamic priceData in totalPriceList) {
//       double pricedouble = priceData['fd']['ADULT']['fC']['TF'];
//       double pricebf_double = priceData['fd']['ADULT']['fC']['BF'];
//       double pricetaf_double = priceData['fd']['ADULT']['fC']['TAF'];
//       String checkingbaggage = priceData['fd']['ADULT']['bI']['iB'];
//       String cabinbaggage = priceData['fd']['ADULT']['bI']['cB'];
//       String Price_id = priceData['id'];
//       int refund = priceData['rT'];
//       bool meal = priceData['mI'];
//       String travellerclass = priceData['fd']['ADULT']['cc'];
//       String price = pricedouble.toString();
//       String basefare = pricebf_double.toString();
//       String surcharges = pricetaf_double.toString();

//       for (dynamic segment in tripInfo['sI']) {
//         String airlineCode = segment['fD']['aI']['code'];
//         String airlineName = segment['fD']['aI']['name'];
//         String airlineNo = segment['fN'];

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
//         String arrivalairport = segment['aa']["name"];
//         String departureairport = segment['da']["name"];
//         String arrivalcode = segment['aa']["code"];
//         String departurecode = segment['da']["code"];

//         Flight flight = Flight(
//             pricceID: Price_id,
//             flightData: tripInfo,
//             airlineCode: airlineCode,
//             airlineName: airlineName,
//             duration: duration,
//             stops: stops,
//             departureTime: departureTime,
//             arrivalTime: arrivalTime,
//             price: price,
//             arrivalCity: arrivalcity,
//             departureCity: departurecity,
//             arrivalTerminal: arrivalterminal,
//             departureTerminal: departureterminal,
//             baseFare: basefare,
//             surCharges: surcharges,
//             flightNo: airlineNo,
//             departureCountry: departurecountry,
//             arrivalCountry: arrivalcountry,
//             checkingBaggage: checkingbaggage,
//             cabinBaggage: cabinbaggage,
//             refund: refund,
//             meal: meal,
//             travellerClass: travellerclass,
//             arrivalairport: arrivalairport,
//             departureairport: departureairport,
//             from_code: departurecode,
//             to_code: arrivalcode,
//             adult: adultCount,
//             child: childCount,
//             infant: infantCount);
//         airIndiaFlights.add(flight);
//       }
//     }
//   }

//   // print('\x1B[31m airIndiaFlights:$airIndiaFlights \x1B[0m');
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (contex) => SearchListPage(
//         locationList1: locationList1,
//         travellerCount: travellerCount,
//         flightmodel: airIndiaFlights,
//         fromcity: from,
//         tocity: to,
//         type: "One Way",
//         adult: adult,
//         child: child,
//         infant: infant,
//         cabin_class: cabin_class,
//         date: date,
//         fromcode: from_code,
//         tocode: to_code,
//       ),
//     ),
//   );
//   }else{
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Sorry!"),
//           content: Text("No flights Available"),
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

// }

// -----------international
Future<void> getinter1waysearch_api(
  List<LocationData> locationList1,
  String from,
  String to,
  String cabin_class,
  String adult,
  String child,
  String infant,
  String from_code,
  String to_code,
  String date,
  int travellerCount,
  BuildContext context,
) async {
  print("searchinternational one_way()");

  int adultCount = int.tryParse(adult) ?? 0;
  int childCount = int.tryParse(child) ?? 0;
  int infantCount = int.tryParse(infant) ?? 0;

  if (cabin_class == null || from_code == null || to_code == null) {
    print("Error: Missing required parameters");
    return;
  }
// dynamic
  // String res = await inter1waysearchapi(
  //   cabin_class,
  //   adult,
  //   child,
  //   infant,
  //   from_code,
  //   to_code,
  //   date,
  // );
// static
  String res = jsonEncode(onewayi);
  Map<String, dynamic> data = json.decode(res);

  if (data['status']['httpStatus'] != 200) {
    // Display an alert box with the error message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data['errors']['message']),
          content: Text(data['errors']['details']),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  dynamic tripInfoData = data['searchResult']['tripInfos']['ONWARD'];
  print('\x1B[32m Success \x1B[0m');
  print('\x1B[33m tripinfo:$tripInfoData \x1B[0m');
  List<Flight> airIndiaFlights = [];

  for (dynamic tripInfo in tripInfoData) {
    List<dynamic> totalPriceList = tripInfo['totalPriceList'];
    // Assuming totalPriceList is an array with multiple elements

    for (dynamic priceData in totalPriceList) {
      double pricedouble = priceData['fd']['ADULT']['fC']['TF'];
      double pricebf_double = priceData['fd']['ADULT']['fC']['BF'];
      double pricetaf_double = priceData['fd']['ADULT']['fC']['TAF'];
      String checkingbaggage = priceData['fd']['ADULT']['bI']['iB'];
      String cabinbaggage = priceData['fd']['ADULT']['bI']['cB'];
      String Price_id = priceData['id'];
      int refund = priceData['rT'];
      bool meal = priceData['mI'];
      String travellerclass = priceData['fd']['ADULT']['cc'];
      String price = pricedouble.toString();
      String basefare = pricebf_double.toString();
      String surcharges = pricetaf_double.toString();

      for (dynamic segment in tripInfo['sI']) {
        String flightNumber = segment['fD']['fN'].toString();
        String equipmentType = segment['fD']['eT'].toString();
        String airlineCode = segment['fD']['aI']['code'];
        String airlineName = segment['fD']['aI']['name'];
        String airlineNo = segment['fN'];

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
        String arrivalairport = segment['aa']["name"];
        String departureairport = segment['da']["name"];
        String arrivalcode = segment['aa']["code"];
        String departurecode = segment['da']["code"];

        Flight flight = Flight(
            flightnumber: flightNumber.toString(),
            equipmentType: equipmentType,
            pricceID: Price_id,
            flightData: tripInfo,
            airlineCode: airlineCode,
            airlineName: airlineName,
            duration: duration,
            stops: stops,
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            price: price,
            arrivalCity: arrivalcity,
            departureCity: departurecity,
            arrivalTerminal: arrivalterminal,
            departureTerminal: departureterminal,
            baseFare: basefare,
            surCharges: surcharges,
            flightNo: airlineNo,
            departureCountry: departurecountry,
            arrivalCountry: arrivalcountry,
            checkingBaggage: checkingbaggage,
            cabinBaggage: cabinbaggage,
            refund: refund,
            meal: meal,
            travellerClass: travellerclass,
            arrivalairport: arrivalairport,
            departureairport: departureairport,
            from_code: departurecode,
            to_code: arrivalcode,
            adult: adultCount,
            child: childCount,
            infant: infantCount);
        airIndiaFlights.add(flight);
      }
    }
  }

  print('\x1B[31m airIndiaFlights:$airIndiaFlights \x1B[0m');
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (contex) => SearchListPage(
        locationList1: locationList1,
        travellerCount: travellerCount,
        flightmodel: airIndiaFlights,
        fromcity: from,
        tocity: to,
        type: "One Way",
        adult: adult,
        child: child,
        infant: infant,
        cabin_class: cabin_class,
        date: date,
        fromcode: from_code,
        tocode: to_code,
      ),
    ),
  );
}
    // List<Flight> airIndiaFlights =
    //     parseFlightData(data, adultCount, childCount, infantCount);

//     print('\x1B[31m airIndiaFlights:$airIndiaFlights \x1B[0m');
//     navigateToSearchListPage(context, locationList1, travellerCount,
//         airIndiaFlights, from, to, adult, child, infant, cabin_class);
//   } catch (e) {
//     print("Error occurred while fetching data: $e");
//     showErrorDialog(context, "Error",
//         "An error occurred while fetching data. Please try again later.");
//   }
// }

// Function to parse flight data from the API response
// List<Flight> parseFlightData(Map<String, dynamic> data, int adultCount,
//     int childCount, int infantCount) {
//   dynamic tripInfoData = data['searchResult']['tripInfos']['ONWARD'];
//   List<Flight> flights = [];

//   for (dynamic tripInfo in tripInfoData) {
//     List<dynamic> totalPriceList = tripInfo['totalPriceList'];

//     for (dynamic priceData in totalPriceList) {
//       Flight flight = createFlight(
//           priceData, tripInfo, adultCount, childCount, infantCount);
//       flights.add(flight);
//     }
//   }

//   return flights;
// }

// // Function to create a Flight object from parsed data
// Flight createFlight(dynamic priceData, dynamic tripInfo, int adultCount,
//     int childCount, int infantCount) {
//   // Your existing implementation for creating Flight objects
// }

// // Function to show error dialog
// void showErrorDialog(BuildContext context, String title, String content) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(content),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }

// // Function to navigate to the search list page
// void navigateToSearchListPage(
//   BuildContext context,
//   List<LocationData> locationList1,
//   int travellerCount,
//   List<Flight> flights,
//   String from,
//   String to,
//   String adult,
//   String child,
//   String infant,
//   String cabin_class,
// ) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => SearchListPage(
//         locationList1: locationList1,
//         travellerCount: travellerCount,
//         flightmodel: flights,
//         fromcity: from,
//         tocity: to,
//         type: "One Way",
//         adult: adult,
//         child: child,
//         infant: infant,
//         cabin_class: cabin_class,
//       ),
//     ),
//   );
// }























// // international one_way
// getinter1waysearch_api(
//  List<LocationData> locationList1,
//   String from,
//   String to,
//   String cabin_class,
//   String adult,
//   String child,
//   String infant,
//   String from_code,
//   String to_code,
//   String date,
//   int travellerCount,
//   BuildContext context,
// ) async {
//   print("searchinternational one_way()");

//   int adultCount = int.parse(adult);
//   int childCount = int.parse(child);
//   int infantCount = int.parse(infant);
//   if (cabin_class == null || from_code == null || to_code == null) {
//     print("null error ");
//     print("datas:$cabin_class,$from_code,$to_code ");
//     return;
//   }

//   String res = await inter1waysearchapi(
//     cabin_class,
//     adult,
//     child,
//     infant,
//     from_code,
//     to_code,
//     date,
//   );

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

//   dynamic tripInfoData = data['searchResult']['tripInfos']['ONWARD'];
//   print("tripinfo:$tripInfoData");

//   List<Flight> airIndiaFlights = [];

//   for (dynamic tripInfo in tripInfoData) {
//     List<dynamic> totalPriceList = tripInfo['totalPriceList'];
//     // Assuming totalPriceList is an array with multiple elements

//     for (dynamic priceData in totalPriceList) {
//        double pricedouble = priceData['fd']['ADULT']['fC']['TF'];
//       double pricebf_double = priceData['fd']['ADULT']['fC']['BF'];
//       double pricetaf_double = priceData['fd']['ADULT']['fC']['TAF'];
//       String checkingbaggage = priceData['fd']['ADULT']['bI']['iB'];
//       String cabinbaggage = priceData['fd']['ADULT']['bI']['cB'];
//       String Price_id = priceData['id'];
//       int refund = priceData['rT'];
//       bool meal = priceData['mI'];
//       String travellerclass = priceData['fd']['ADULT']['cc'];
//       String price = pricedouble.toString();
//       String basefare = pricebf_double.toString();
//       String surcharges = pricetaf_double.toString();

//       for (dynamic segment in tripInfo['sI']) {
//         String airlineCode = segment['fD']['aI']['code'];
//         String airlineName = segment['fD']['aI']['name'];
//         String airlineNo = segment['fN'];

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
//         String arrivalairport = segment['aa']["name"];
//         String departureairport = segment['da']["name"];
//         String arrivalcode = segment['aa']["code"];
//         String departurecode = segment['da']["code"];

//         Flight flight = Flight(
//             pricceID: Price_id,
//             flightData: tripInfo,
//             airlineCode: airlineCode,
//             airlineName: airlineName,
//             duration: duration,
//             stops: stops,
//             departureTime: departureTime,
//             arrivalTime: arrivalTime,
//             price: price,
//             arrivalCity: arrivalcity,
//             departureCity: departurecity,
//             arrivalTerminal: arrivalterminal,
//             departureTerminal: departureterminal,
//             baseFare: basefare,
//             surCharges: surcharges,
//             flightNo: airlineNo,
//             departureCountry: departurecountry,
//             arrivalCountry: arrivalcountry,
//             checkingBaggage: checkingbaggage,
//             cabinBaggage: cabinbaggage,
//             refund: refund,
//             meal: meal,
//             travellerClass: travellerclass,
//             arrivalairport: arrivalairport,
//             departureairport: departureairport,
//             from_code: departurecode,
//             to_code: arrivalcode,
//             adult: adultCount,
//             child: childCount,
//             infant: infantCount);
//         airIndiaFlights.add(flight);
//       }
//     }
//   }
//   print('\x1B[31m airIndiaFlights:$airIndiaFlights \x1B[0m');
//     Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (contex) => SearchListPage(
//         locationList1: locationList1,
//           travellerCount: travellerCount,
//           flightmodel: airIndiaFlights,
//           fromcity: from,
//           tocity: to),
//     ),
//   );
// }
