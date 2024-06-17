import 'package:flutter/material.dart';

import '../../common_flights/common_flightbookingpage.dart';
import '../../models/flight_model.dart'; // Import your flight model here

Widget buildBookingContainer(
  double sWidth,
  double sHeight,
  Flight picked_route1,
  Flight picked_route2,
  Flight picked_route3,
  Flight picked_route4,
  Flight picked_route5,
  String adult,
  String child,
  String infant,
  String cabinclass,
  int count,
  BuildContext context,
) {
  // Filter out null routes
  List<Flight> routes = [
    picked_route1,
    picked_route2,
    picked_route3,
    picked_route4,
    picked_route5,
  ].where((route) => route != null).toList();

  // Calculate total fare
  double totalFare = calculateTotalFare(routes);

  return Container(
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 2, 2, 65),
      borderRadius: BorderRadius.circular(5),
    ),
    height: sHeight * 0.12,
    width: sWidth - 100,
    child: Row(
      children: [
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: routes.length,
            separatorBuilder: (context, index) => VerticalDivider(
              color: Colors.white,
              indent: 20,
              endIndent: 20,
              thickness: 0.8,
            ),
            itemBuilder: (context, index) {
              Flight route = routes[index];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Container(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          'images/AirlinesLogo/${route.airlineCode}.png',
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${route.from_code} - ${route.to_code}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    '₹ ${route.price}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Trip Cost',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 5),
            Text(
              '₹ $totalFare',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(width: sWidth * 0.015),
        Center(
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(18.0),
            child: GestureDetector(
              onTap: () {
                List<String> fromcitylist = [];
                for (int i = 0; i < routes.length; i++) {
                  String from = routes[i].departureCity;
                  fromcitylist.add(from);
                }
                List<String> tocitylist = [];
                for (int i = 0; i < routes.length; i++) {
                  String to = routes[i].arrivalCity;
                  tocitylist.add(to);
                }
                routes.first.adult = int.parse(adult);
                routes.first.child = int.parse(child);
                routes.first.infant = int.parse(infant);
                // Navigate to booking page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommonflightBookingPage(
                      flightmodel: routes,
                      fromcity: fromcitylist,
                      tocity: tocitylist,
                      travellerCount: count,
                    ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: 85.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0072FF), // Darker blue
                      Color(0xFF00C6FF), // Lighter blue
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  'Book',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: sWidth * 0.01),
      ],
    ),
  );
}

double calculateTotalFare(List<Flight> routes) {
  double total = 0;
  for (Flight route in routes) {
    total += double.parse(route.price);
  }
  return total;
}

// import 'package:flutter/material.dart';

// import '../../common_flights/common_flightbookingpage.dart';
// import '../../models/flight_model.dart';
// import '../flight_model/multicity_route_model.dart';

// Widget buildBookingContainer(
//     double sWidth,
//     double sHeight,
//     Flight picked_route1,
//     Flight picked_route2,
//     Flight picked_route3,
//     Flight picked_route4,
//     Flight picked_route5,
//     BuildContext context) {
//   // Retrieve data for each booking item
//   List<Flight> routes = [
//     picked_route1,
//     picked_route2,
//     picked_route3,
//     picked_route4,
//     picked_route5

//   ].where((route) => route != null).toList();
//   double totalFare = calculateTotalFare(routes);
//   List<Flight> flightlist = [];

//   if (picked_route1 != null) {
//     flightlist.add(picked_route1);
//   }

//   if (picked_route2 != null) {
//     flightlist.add(picked_route2);
//   }

//   if (picked_route3 != null) {
//     flightlist.add(picked_route3);
//   }

//   if (picked_route4 != null) {
//     flightlist.add(picked_route4);
//   }
//   if (picked_route4 != null) {
//     flightlist.add(picked_route4);
//   }
//   return Container(
//     decoration: BoxDecoration(
//       color: Color.fromARGB(255, 2, 2, 65),
//       borderRadius: BorderRadius.circular(5),
//     ),
//     height: sHeight * 0.175,
//     width: sWidth -100,
//     child: Row(
//       children: [
//         Expanded(
//           child: ListView.separated(
//             shrinkWrap: true,
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             scrollDirection: Axis.horizontal,
//             itemCount: routes.length,
//             separatorBuilder: (context, index) => VerticalDivider(
//               color: Colors.white,
//               indent: 20,
//               endIndent: 20,
//               thickness: 0.8,
//             ),
//             itemBuilder: (context, index) {
//               Flight route = routes[index];

//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         width: 20,
//                         height: 20,
//                         child: Image.asset(
//                           'images/AirlinesLogo/${route.airlineCode}.png',
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         '${route.from_code} - ${route.to_code}',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white.withOpacity(0.7),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Text(
//                     '₹ ${route.price}',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   )
//                 ],
//               );
//             },
//           ),
//         ),
//         Spacer(),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Total Trip Cost',
//               style: TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white.withOpacity(0.7),
//               ),
//             ),
//             SizedBox(height: 5),
//             Text(
//               '₹ $totalFare',
//               style: TextStyle(
//                 fontSize: 19,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(width: sWidth * 0.015),
//         Center(
//           child: Material(
//             elevation: 4.0,
//             borderRadius: BorderRadius.circular(18.0),
//             child: GestureDetector(
//               onTap: () {
//                 print("flightlist.length: ${flightlist.length}");
//                 print("flightlist[0]: ${flightlist[0].pricceID}");
//                 print("flightlist.length: ${flightlist[1].pricceID}");
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => CommonflightBookingPage(
//                       flightmodel: flightlist,
//                       fromcity:
//                           ["Delhi"], // Pass the actual value of fromcity
//                       tocity:
//                           ["Mumbai"], // Pass the actual value of tocity
//                       travellerCount: 1,
//                     ),
//                   ),
//                 );
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 height: 50.0,
//                 width: 85.0,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xFF0072FF), // Darker blue
//                       Color(0xFF00C6FF), // Lighter blue
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     stops: [0.0, 1.0],
//                   ),
//                   borderRadius: BorderRadius.circular(18.0),
//                 ),
//                 child: Text(
//                   'Book',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: sWidth * 0.01),
//       ],
//     ),
//   );
// }

// double calculateTotalFare(List<Flight> routes) {
//   double total = 0;
//   for (Flight route in routes) {
//     total += double.parse(route.price);
//   }
//   return total;
// }

String minutetohour(int minutes) {
  int hours = minutes ~/ 60;
  int remainingMinutes = minutes % 60;
  return "$hours h $remainingMinutes min";
}
