import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trip/screens/bus/models/dummy_datas/multicity_domestic_data.dart';
import 'package:trip/screens/bus/widgets/bustravellerform.dart';
import 'package:trip/screens/flight_model/multicity_route_model.dart';

import '../api_services/location_list_api.dart';
import '../api_services/search apis/multi_way/Domestic_multiway_searchapi.dart';
import '../api_services/search apis/multi_way/international_multiway_search_api.dart';
import '../models/flight_model.dart';
import '../models/multi_d_model.dart';
import '../screens/bus/models/dummy_datas/multicity_international_data.dart';
import '../screens/domestic_Multicity_page.dart';
import '../screens/multi_city_international/multiciyt_international_page.dart';

class ChildrensCount extends StatefulWidget {
  final Function(int) onNumberSelected;

  ChildrensCount(this.onNumberSelected);
  // const ChildrensCount({key});

  @override
  State<ChildrensCount> createState() => _ChildrensCountState();
}

class _ChildrensCountState extends State<ChildrensCount> {
  int selectedNumberChild = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 340,
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  int number = index;
                  print('num - $number');
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedNumberChild = number;
                        widget.onNumberSelected(selectedNumberChild);
                      });
                    },
                    child: Card(
                      elevation: 4,
                      child: Container(
                        width: 40.0,
                        // height: 40,
                        margin: EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                          color: selectedNumberChild == number
                              ? Colors.blue // Change to your desired color
                              : Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Center(
                          child: Text(
                            number > 6 ? '>6' : number.toString(),
                            style: TextStyle(
                              color: selectedNumberChild == number
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
            Card(
              elevation: 4,
              child: Container(
                width: 34.0,
                height: 38,
                // height: 40,
                margin: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Text(
                    '>6',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

// new with class
Future<void> getMulticity(
  List<LocationData> locationList1,
  String cabin_class,
  String adult,
  String child,
  String infant,
  BuildContext context,
) async {
  print(multiRoutes.length);
  // Check for null or empty multiRoutes
  if (multiRoutes == null || multiRoutes.isEmpty) {
    showErrorDialog(context, "Error", "No routes selected.");
    return;
  }

  // Check if each route is in ascending order or the same
  if (!_areRoutesInAscendingOrder()) {
    showErrorDialog(
        context, "Error", "Routes must be in ascending order or the same.");
    return;
  }
  try {
    String res = await domestic_multiwaysearchapi(
      cabin_class,
      adult,
      child,
      infant,
      multiRoutes,
    );

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
    if (data['searchResult'] != null &&
        data['searchResult'].toString().isNotEmpty) {
      //  List<List<Flight>> airIndiaFlights = [];
      List<Flight> route1 = [];
      List<Flight> route2 = [];
      List<Flight> route3 = [];
      List<Flight> route4 = [];
      List<Flight> route5 = [];
      print("length:${multiRoutes.length}");
      for (int i = 0; i < multiRoutes.length; i++) {
        print("Loop iteration $i");
        dynamic tripInfoData = data['searchResult']['tripInfos'][i.toString()];
        log("tripinfo");
        // print("tripinfo:${tripInfoData}");

        for (dynamic tripInfo in tripInfoData) {
          List<dynamic> totalPriceList = tripInfo['totalPriceList'];

          for (dynamic priceData in totalPriceList) {
            double pricedouble = priceData['fd']['ADULT']['fC']['TF'];
            String price = pricedouble.toString();

            for (dynamic segment in tripInfo['sI']) {
              double pricedouble = priceData['fd']['ADULT']['fC']['TF'];
              double pricebf_double = priceData['fd']['ADULT']['fC']['BF'];
              double pricetaf_double = priceData['fd']['ADULT']['fC']['TAF'];
              String checkingbaggage = priceData['fd']['ADULT']['bI']['iB'];
              String cabinbaggage = priceData['fd']['ADULT']['bI']['cB'];
              String price = pricedouble.toString();
              String basefare = pricebf_double.toString();
              String surcharges = pricetaf_double.toString();
              // String departure_city = segment['da']['city'];
              // String arrival_city = segment['city'];
              String airlineCode = segment['fD']['aI']['code'];
              String airlineName = segment['fD']['aI']['name'];
              int duration = segment['duration'];
              int stops = segment['stops'];
              String departureTime = segment['dt'];
              String arrivalTime = segment['at'];
              String Price_id = priceData['id'];
              int refund = priceData['rT'];
              bool meal = priceData['mI'];
              String travellerclass = priceData['fd']['ADULT']['cc'];
              // -----------
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
                flightData: tripInfo,
                airlineCode: airlineCode,
                airlineName: airlineName,
                duration: duration,
                stops: stops,
                departureTime: departureTime,
                arrivalTime: arrivalTime,
                price: price,
                // departureCity: departure_city,
                // arrivalCity: arrival_city,
                pricceID: Price_id,
                refund: refund,
                meal: meal,
                travellerClass: travellerclass,
                checkingBaggage: checkingbaggage,
                cabinBaggage: cabinbaggage,
                baseFare: basefare,
                surCharges: surcharges,
                // --------
                arrivalCountry: arrivalcountry,
                departureCountry: departurecountry,
                arrivalCity: arrivalcity,
                departureCity: departurecity,
                arrivalairport: arrivalairport,
                departureairport: departureairport,
                from_code: departurecode,
                to_code: arrivalcode,
                arrivalTerminal: arrivalterminal,
                departureTerminal: departureterminal,
              );

              // Assign flights to route1 or route2 based on the value of i
              if (i == 0) {
                route1.add(flight);
              } else if (i == 1) {
                route2.add(flight);
              } else if (i == 2) {
                route3.add(flight);
              } else if (i == 3) {
                route4.add(flight);
              } else if (i == 4) {
                route5.add(flight);
              }
            }
          }
        }
      }
      print(" route1 : ${route1.length}");
      print(" route2 : ${route2.length}");
      List<List<Flight>> airIndiaFlights = [];
      airIndiaFlights.add(route1);

      airIndiaFlights.add(route2);
      if (multiRoutes.length >= 3) {
        airIndiaFlights.add(route3);
      }
      if (multiRoutes.length >= 4) {
        airIndiaFlights.add(route4);
      }
      if (multiRoutes.length >= 5) {
        airIndiaFlights.add(route5);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DomesticMultiwaylistpage(
            flights: airIndiaFlights,
            locationList1: locationList1,
            cabin_class: cabin_class,
            adult: adult,
            child: child,
            infant: infant,
          ),
        ),
      );
    } else {
      showErrorDialog(context, "Sorry", "No flights Available");
    }
  } catch (e) {
    // Handle any errors that occur during the process
    showErrorDialog(context, "Error", "An error occurred: $e");
  }
}

// international multiway

// Assuming the rest of your imports and necessary class definitions are here

getinternational_multi_searchapi(
  List<LocationData> locationList1,
  String cabin_class,
  String adult,
  String child,
  String infant,
  BuildContext context,
) async {
  print("searchinternational_multiway");
  print(multiRoutes.length);

  // Check for null or empty multiRoutes
  if (multiRoutes == null || multiRoutes.isEmpty) {
    showErrorDialog(context, "Error", "No routes selected.");
    return;
  }

  // Check if each route is in ascending order or the same
  if (!_areRoutesInAscendingOrder()) {
    showErrorDialog(
        context, "Error", "Routes must be in ascending order or the same.");
    return;
  }
  try {
    // dynamic
        String res = await domestic_multiwaysearchapi(
      cabin_class,
      adult,
      child,
      infant,
      multiRoutes,
    );
// static
    // String res = jsonEncode(multicityI);
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

    if (data['searchResult'] != null &&
        data['searchResult'].toString().isNotEmpty) {
      ComboMultiFlightData obj =
          ComboMultiFlightData.fromJson(data['searchResult']);
      print("obj: $obj");
      if (data["status"]["httpStatus"] == 200 && obj != null) {
        List<List<Flight>> airIndiaFlights = [];
        List<Flight> route1 = [];
        List<Flight> route2 = [];
        List<Flight> route3 = [];
        List<Flight> route4 = [];
        List<Flight> route5 = [];
        print("length:${multiRoutes.length}");
        print(" route1 : ${route1.length}");
        print(" route2 : ${route2.length}");
        // List<List<Flight>> airIndiaFlights = [];
        airIndiaFlights.add(route1);

        airIndiaFlights.add(route2);
        if (multiRoutes.length >= 3) {
          airIndiaFlights.add(route3);
        }
        if (multiRoutes.length >= 4) {
          airIndiaFlights.add(route4);
        }
        if (multiRoutes.length >= 5) {
          airIndiaFlights.add(route5);
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => multiCityInternational(
              multicity: obj,
              locationList1: locationList1,
            cabin_class: cabin_class,
            adult: adult,
            child: child,
            infant: infant,
            ),
          ),
        );
      } else {
        showErrorDialog(context, "Sorry", "No flights Available");
      }
    } else {
      showAlert("Error", context);
    }
  } catch (e) {
    // Handle any errors that occur during the process
    showErrorDialog(context, "Error", "An error occurred: $e");
  }
}

bool _areRoutesInAscendingOrder() {
  for (int i = 0; i < multiRoutes.length - 1; i++) {
    DateTime date1 = DateTime.parse(multiRoutes[i].date);
    DateTime date2 = DateTime.parse(multiRoutes[i + 1].date);
    if (date1.isAfter(date2)) {
      return false;
    }
  }
  return true;
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












// getinternational_multi_searchapi(
//   List<LocationData> locationList1,
//   String cabin_class,
//   String adult,
//   String child,
//   String infant,
//   BuildContext context,
// ) async {
//   print("searchinternational_multiway");
//   print(multiRoutes.length);
//   String res = await domestic_multiwaysearchapi(
//     cabin_class,
//     adult,
//     child,
//     infant,
//     multiRoutes,
//   );

//   Map<String, dynamic> data = json.decode(res);

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
//   ComboMultiFlightData obj = ComboMultiFlightData.fromJson(jsonDecode(data['searchResult']));
//   print("obj:$obj");}
  //  List<List<Flight>> airIndiaFlights = [];
  // List<Flight> route1 = [];
  // List<Flight> route2 = [];
  // List<Flight> route3 = [];
  // List<Flight> route4 = [];
  // List<Flight> route5 = [];
  // print("length:${multiRoutes.length}");

  // for (int i = 0; i < multiRoutes.length; i++) {
  //   print("Loop iteration $i");
  //   dynamic tripInfoData = data['searchResult']['tripInfos'][i.toString()];
  //   log("tripinfo");
  // print("tripinfo:${tripInfoData}");

  //   for (dynamic tripInfo in tripInfoData) {
  //     List<dynamic> totalPriceList = tripInfo['totalPriceList'];

  //     for (dynamic priceData in totalPriceList) {
  //       double pricedouble = priceData['fd']['ADULT']['fC']['TF'];
  //       String price = pricedouble.toString();

  //       for (dynamic segment in tripInfo['sI']) {
  //         double pricedouble = priceData['fd']['ADULT']['fC']['TF'];
  //         double pricebf_double = priceData['fd']['ADULT']['fC']['BF'];
  //         double pricetaf_double = priceData['fd']['ADULT']['fC']['TAF'];
  //         String checkingbaggage = priceData['fd']['ADULT']['bI']['iB'];
  //         String cabinbaggage = priceData['fd']['ADULT']['bI']['cB'];
  //         String price = pricedouble.toString();
  //         String basefare = pricebf_double.toString();
  //         String surcharges = pricetaf_double.toString();
  //         // String departure_city = segment['da']['city'];
  //         // String arrival_city = segment['city'];
  //         String airlineCode = segment['fD']['aI']['code'];
  //         String airlineName = segment['fD']['aI']['name'];
  //         int duration = segment['duration'];
  //         int stops = segment['stops'];
  //         String departureTime = segment['dt'];
  //         String arrivalTime = segment['at'];
  //         String Price_id = priceData['id'];
  //         int refund = priceData['rT'];
  //         bool meal = priceData['mI'];
  //         String travellerclass = priceData['fd']['ADULT']['cc'];
  //         // -----------
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
  //           flightData: tripInfo,
  //           airlineCode: airlineCode,
  //           airlineName: airlineName,
  //           duration: duration,
  //           stops: stops,
  //           departureTime: departureTime,
  //           arrivalTime: arrivalTime,
  //           price: price,
  //           // departureCity: departure_city,
  //           // arrivalCity: arrival_city,
  //           pricceID: Price_id,
  //           refund: refund,
  //           meal: meal,
  //           travellerClass: travellerclass,
  //           checkingBaggage: checkingbaggage,
  //           cabinBaggage: cabinbaggage,
  //           baseFare: basefare,
  //           surCharges: surcharges,
  //           // --------
  //           arrivalCountry: arrivalcountry,
  //           departureCountry: departurecountry,
  //           arrivalCity: arrivalcity,
  //           departureCity: departurecity,
  //           arrivalairport: arrivalairport,
  //           departureairport: departureairport,
  //           from_code: departurecode,
  //           to_code: arrivalcode,
  //           arrivalTerminal: arrivalterminal,
  //           departureTerminal: departureterminal,
  //         );

  //         // Assign flights to route1 or route2 based on the value of i
  //         if (i == 0) {
  //           route1.add(flight);
  //         } else if (i == 1) {
  //           route2.add(flight);
  //         } else if (i == 2) {
  //           route3.add(flight);
  //         } else if (i == 3) {
  //           route4.add(flight);
  //         }else if (i == 4) {
  //           route5.add(flight);
  //         }
  //       }
  //     }
  //   }
  // }
  // print(" route1 : ${route1.length}");
  // print(" route2 : ${route2.length}");
  // List<List<Flight>> airIndiaFlights = [];
  // airIndiaFlights.add(route1);

  // airIndiaFlights.add(route2);
  // if (multiRoutes.length >= 3) {
  //   airIndiaFlights.add(route3);
  // }
  // if (multiRoutes.length >= 4) {
  //   airIndiaFlights.add(route4);
  // }
  // if (multiRoutes.length >= 5) {
  //   airIndiaFlights.add(route5);
  // }
  
// }
