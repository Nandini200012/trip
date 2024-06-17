import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../api_services/bus apis/available_trip_api.dart';
import '../header.dart';
import 'bus_tripdetail.dart';
import 'functions/bus_functions.dart';

class BusTripList extends StatefulWidget {
  List<AvailableTrip> trip;
  BusTripList({key, this.trip});

  @override
  State<BusTripList> createState() => _BusTripListState();
}

final TextStyle black15 = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
List<AvailableTrip> tripList = [];
List<AvailableTrip> filteredList = [];
bool ac = false;
bool nonac = false;
bool seater = false;
bool sleeper = false;
bool pickup6am = false;
bool pickup11am = false;
bool pickup6pm = false;
bool pickup11pm = false;
bool drop6am = false;
bool drop11am = false;
bool drop6pm = false;
bool drop11pm = false;

class _BusTripListState extends State<BusTripList> {
  void initialiseList(List<AvailableTrip> trip) {
    setState(() {
      tripList = trip;
      filteredList = trip;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseList(widget.trip);
  }

  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: sWidth < 600
            ? AppBar(
                iconTheme: const IconThemeData(color: Colors.black, size: 40),
                backgroundColor: Color.fromARGB(255, 1, 21, 101),
                title: Text(
                  "Bus ",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              )
            : CustomAppBar(),
        backgroundColor: Color.fromARGB(255, 221, 238, 252),
        body: SingleChildScrollView(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: 50),  SizedBox(width: 50),
            FilterContainer(sWidth, sHeight),
            SizedBox(width: 50),
            LIstContainer(sHeight, sWidth)
          ],
        )));
  }

  FilterContainer(sWidth, sHeight) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Card(
          elevation: 5.0,
          child: Container(
            color: Colors.white,
            width: sWidth * .18,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filters",
                    style: GoogleFonts.rajdhani(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 104, 104, 104)),
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "AC",
                    style: GoogleFonts.rajdhani(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            ac = !ac;
                            nonac = false;
                          });
                          if (ac) {
                            setState(() {
                              // Filter tripList to only include trips with the "AC" bus type
                              filteredList = tripList
                                  .where((trip) => trip.ac == 'true')
                                  .toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ac ? Colors.blueAccent : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 35,
                          width: 100,
                          child: Center(
                            child: Text(
                              "AC",
                              style: GoogleFonts.rajdhani(
                                fontWeight: FontWeight.w600,
                                color: ac ? Colors.white : Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // print(tripList[0].ac);

                          setState(() {
                            ac = false;
                            nonac = !nonac;
                          });
                          if (nonac) {
                            setState(() {
                              // Filter tripList to only include trips with the "AC" bus type
                              filteredList = tripList
                                  .where((trip) => trip.ac == 'false')
                                  .toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: nonac ? Colors.blueAccent : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 35,
                          width: 100,
                          child: Center(
                            child: Text(
                              "Non-AC",
                              style: GoogleFonts.rajdhani(
                                fontWeight: FontWeight.w600,
                                color: nonac ? Colors.white : Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Seat Type",
                    style: GoogleFonts.rajdhani(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            seater = false;
                            sleeper = !sleeper;
                          });
                          if (sleeper) {
                            setState(() {
                              // Filter tripList to only include trips with the "AC" bus type
                              filteredList = tripList
                                  .where((trip) => trip.sleeper == 'true')
                                  .toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: sleeper ? Colors.blueAccent : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 35,
                          width: 100,
                          child: Center(
                              child: Text(
                            "Sleeper",
                            style: GoogleFonts.rajdhani(
                              fontWeight: FontWeight.w600,
                              color: sleeper ? Colors.white : Colors.black,
                              fontSize: 15,
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sleeper = false;
                            seater = !seater;
                          });
                          if (seater) {
                            setState(() {
                              // Filter tripList to only include trips with the "AC" bus type
                              filteredList = tripList
                                  .where((trip) => trip.seater == 'true')
                                  .toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: seater ? Colors.blueAccent : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 35,
                          width: 100,
                          child: Center(
                              child: Text("Seater",
                                  style: GoogleFonts.rajdhani(
                                    fontWeight: FontWeight.w600,
                                    color: seater ? Colors.white : Colors.black,
                                    fontSize: 15,
                                  ))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   "Pick up Point",
                  //   style: GoogleFonts.rajdhani(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // checkBOX('Metro Pilar'),
                  // checkBOX('Khana Market'),
                  // checkBOX('Tiz Hazari'),
                  // checkBOX('Kharolbhaug'),
                  // checkBOX('Rajiv Chrowk'),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Divider(),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Pick Up Time",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("6 AM to 11 AM");

                          setState(() {
                            pickup6am = !pickup6am;
                            pickup11am = false;
                            pickup6pm = false;
                            pickup11pm = false;
                          });

                          if (pickup6am) {
                            setState(() {
                              filteredList = tripList.where((trip) {
                                int departureMinutes =
                                    int.parse(trip.departureTime);
                                // assuming departureTime is in minutes since midnight

                                // Convert minutes to hours and minutes
                                int hours = departureMinutes ~/ 60;
                                int minutes = departureMinutes % 60;

                                // Define the start and end time in minutes since midnight
                                int startTimeInMinutes = 6 * 60; // 6 AM
                                int endTimeInMinutes = 11 * 60; // 11 AM

                                // Check if the departure time is between 6 AM and 11 AM
                                return departureMinutes >= startTimeInMinutes &&
                                    departureMinutes < endTimeInMinutes;
                              }).toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: pickup6am ? Colors.blue : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 40,
                          width: 100,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "6 AM to 11 AM",
                              style: GoogleFonts.rajdhani(
                                  color:
                                      pickup6am ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("11 AM to 6 PM");

                          setState(() {
                            pickup6am = false;
                            pickup11am = !pickup11am;
                            pickup6pm = false;
                            pickup11pm = false;
                          });

                          if (pickup11am) {
                            setState(() {
                              filteredList = tripList.where((trip) {
                                int departureMinutes = int.parse(trip
                                    .departureTime); // assuming departureTime is in minutes since midnight

                                // Define the start and end time in minutes since midnight
                                int startTimeInMinutes = 11 * 60; // 11 AM
                                int endTimeInMinutes = 18 * 60; // 6 PM

                                // Check if the departure time is between 11 AM and 6 PM
                                return departureMinutes >= startTimeInMinutes &&
                                    departureMinutes < endTimeInMinutes;
                              }).toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: pickup11am ? Colors.blue : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 40,
                          width: 100,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "11 AM to 6 PM",
                              style: GoogleFonts.rajdhani(
                                  color:
                                      pickup11am ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("6 pM to 11 AM");
                          print(tripList[2].departureTime);
                          setState(() {
                            pickup6am = false;
                            pickup11am = false;
                            pickup6pm = !pickup6pm;
                            pickup11pm = false;
                          });
                          if (pickup6pm) {
                            setState(() {
                              filteredList = tripList.where((trip) {
                                int departureMinutes = int.parse(trip
                                    .departureTime); // assuming departureTime is in minutes since midnight

                                // Define the start and end time in minutes since midnight
                                int startTimeInMinutes = 18 * 60; // 6 PM
                                int endTimeInMinutes = 23 * 60; // 11 PM

                                // Check if the departure time is between 11 AM and 6 PM
                                return departureMinutes >= startTimeInMinutes &&
                                    departureMinutes < endTimeInMinutes;
                              }).toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: pickup6pm ? Colors.blue : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 40,
                          width: 100,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "6 PM to 11 PM",
                              style: GoogleFonts.rajdhani(
                                  color:
                                      pickup6pm ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pickup6am = false;
                            pickup11am = false;
                            pickup6pm = false;
                            pickup11pm = !pickup11pm;
                          });

                          if (pickup11pm) {
                            setState(() {
                              filteredList = tripList.where((trip) {
                                int departureMinutes = int.parse(trip
                                    .departureTime); // assuming departureTime is in minutes since midnight

                                // Define the start and end time in minutes since midnight
                                int startTimeInMinutes = 23 * 60; // 11 PM
                                int endTimeInMinutes =
                                    30 * 60; // 6 AM (next day)

                                // Check if the departure time is between 11 PM and 6 AM
                                return (departureMinutes >=
                                            startTimeInMinutes &&
                                        departureMinutes < 24 * 60) ||
                                    (departureMinutes < endTimeInMinutes &&
                                        departureMinutes >= 0);
                              }).toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: pickup11pm ? Colors.blue : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 40,
                          width: 100,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "11 PM to 6 AM",
                              style: GoogleFonts.rajdhani(
                                  color:
                                      pickup11pm ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  // drop

                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Text(
                  //   "Drop Point",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 15,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // checkBOX('Metro Pilar'),
                  // checkBOX('Khana Market'),
                  // checkBOX('Tiz Hazari'),
                  // checkBOX('Kharolbhaug'),
                  // checkBOX('Rajiv Chrowk'),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Divider(),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Drop Time",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            drop6am = !drop6am;
                            drop11am = false;
                            drop6pm = false;
                            drop11pm = false;
                          });
                          if (drop6am) {
                            setState(() {
                              filteredList = tripList.where((trip) {
                                int arrivalMinutes =
                                    int.parse(trip.arrivalTime);
                                // assuming departureTime is in minutes since midnight

                                // Convert minutes to hours and minutes
                                int hours = arrivalMinutes ~/ 60;
                                int minutes = arrivalMinutes % 60;

                                // Define the start and end time in minutes since midnight
                                int startTimeInMinutes = 6 * 60; // 6 AM
                                int endTimeInMinutes = 11 * 60; // 11 AM

                                // Check if the departure time is between 6 AM and 11 AM
                                return arrivalMinutes >= startTimeInMinutes &&
                                    arrivalMinutes < endTimeInMinutes;
                              }).toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: drop6am ? Colors.blue : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 40,
                          width: 100,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "6 AM to 11 AM",
                              style: GoogleFonts.rajdhani(
                                  color: drop6am ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            drop6am = false;
                            drop11am = !drop11am;
                            drop6pm = false;
                            drop11pm = false;
                          });
                          if (drop11am) {
                            setState(() {
                              filteredList = tripList.where((trip) {
                                int arrivalMinutes = int.parse(trip
                                    .arrivalTime); // assuming departureTime is in minutes since midnight

                                // Define the start and end time in minutes since midnight
                                int startTimeInMinutes = 11 * 60; // 11 AM
                                int endTimeInMinutes = 18 * 60; // 6 PM

                                // Check if the departure time is between 11 AM and 6 PM
                                return arrivalMinutes >= startTimeInMinutes &&
                                    arrivalMinutes < endTimeInMinutes;
                              }).toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: drop11am ? Colors.blue : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 40,
                          width: 100,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "11 AM to 6 PM",
                              style: GoogleFonts.rajdhani(
                                  color: drop11am ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            drop6am = false;
                            drop11am = false;
                            drop6pm = !drop6pm;
                            drop11pm = false;
                          });
                          if (drop6pm) {
                            setState(() {
                              filteredList = tripList.where((trip) {
                                int arrivalMinutes = int.parse(trip
                                    .arrivalTime); // assuming departureTime is in minutes since midnight

                                // Define the start and end time in minutes since midnight
                                int startTimeInMinutes = 18 * 60; // 6 PM
                                int endTimeInMinutes = 23 * 60; // 11 PM

                                // Check if the departure time is between 11 AM and 6 PM
                                return arrivalMinutes >= startTimeInMinutes &&
                                    arrivalMinutes < endTimeInMinutes;
                              }).toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: drop6pm ? Colors.blue : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 40,
                          width: 100,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "6 PM to 11 PM",
                              style: GoogleFonts.rajdhani(
                                  color: drop6pm ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            drop6am = false;
                            drop11am = false;
                            drop6pm = false;
                            drop11pm = !drop11pm;
                          });
                          if (drop11pm) {
                            setState(() {
                              filteredList = tripList.where((trip) {
                                int arrivalMinutes = int.parse(trip
                                    .arrivalTime); // assuming arrivalTime is in minutes since midnight

                                // Define the start and end time in minutes since midnight
                                int startTimeInMinutes = 23 * 60; // 11 PM
                                int endTimeInMinutes = 30 *
                                    60; // 6 AM (30 hours to include the next day's 6 AM)

                                // Check if the arrival time is between 11 PM and 6 AM
                                return (arrivalMinutes >= startTimeInMinutes &&
                                        arrivalMinutes < 24 * 60) ||
                                    (arrivalMinutes < endTimeInMinutes &&
                                        arrivalMinutes >= 0);
                              }).toList();
                            });
                          } else {
                            setState(() {
                              filteredList = tripList;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: drop11pm ? Colors.blue : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          height: 40,
                          width: 100,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "11 PM to 6AM",
                              style: GoogleFonts.rajdhani(
                                  color: drop11pm ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  checkBOX(text) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                borderRadius: BorderRadius.circular(5)),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  LIstContainer(sHeight, sWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
          width: sWidth * 0.5,
          // color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Traveller name",
                style: GoogleFonts.rajdhani(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Text(
                "Departure",
                style: GoogleFonts.rajdhani(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Text(
                "Duration",
                style: GoogleFonts.rajdhani(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Text(
                "Arrival",
                style: GoogleFonts.rajdhani(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Text(
                "Price",
                style: GoogleFonts.rajdhani(
                    fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        if (widget.trip.length != 0)
          SizedBox(
            width: sWidth * .59,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: filteredList.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 0,
                );
              },
              itemBuilder: (context, index) {
                final _trip = filteredList[index];
                // log(widget.trip[index].arrivalTime);
                // log(widget.trip[index].id);

                return Padding(
                  padding: const EdgeInsets.only(left: 1, top: 10, bottom: 10),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: sWidth * 0.4,
                      height: sHeight * .13,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // SizedBox(
                          //   width: 50,
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(_trip.travels,
                                  style: GoogleFonts.notoSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: 150,
                                height: 20,
                                child: Text(_trip.busType,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),

                          Row(
                            children: [
                              // Text(
                              convertMinutesToHoursAndTime(
                                  int.parse(_trip.departureTime),
                                  _trip.doj.toString()),
                              // convertToTime("${_trip.departureTime}"),
                              // style: TextStyle(
                              //     fontSize: 18,
                              //     color: Colors.black,
                              //     fontWeight: FontWeight.w700)),
                              SizedBox(
                                width: 5,
                              ),
                              // Text(convertDateString("${_trip.doj}"),
                              //     style: TextStyle(
                              //         fontSize: 13,
                              //         color: Colors.black,
                              //         fontWeight: FontWeight.w500)),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 1.0,
                                width: 25.0,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                _trip.duration,
                                style: black15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 1.0,
                                width: 25.0,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              // SizedBox(
                              // width: 20,
                              // ),
                              // Text(
                              convertMinutesToHoursAndTime(
                                  int.parse(_trip.arrivalTime),
                                  _trip.doj.toString()),
                              // convertToTime("${_trip.arrivalTime}"),
                              // style: TextStyle(
                              //     fontSize: 18,
                              //     color: Colors.black,
                              //     fontWeight: FontWeight.w700)),
                              SizedBox(
                                width: 5,
                              ),
                              // Text(convertDateString("${_trip.doj}"),
                              //     style: TextStyle(
                              //         fontSize: 13,
                              //         color: Colors.black,
                              //         fontWeight: FontWeight.w500)),
                            ],
                          ),

                          SizedBox(
                            width: 20,
                          ),
                          // Spacer(),
                          Text("₹${buildFaresText(_trip.fares)}",
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700)),
                          // SizedBox(
                          // width: 30,
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 150,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    log(_trip.id);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BusTripDetail(
                                                id: _trip.id,
                                                fare:
                                                    buildFaresText(_trip.fares),
                                                total_seats:
                                                    _trip.availableSeats,
                                                bus_type: _trip.busType,
                                                trip: _trip)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    // Change the button's background color
                                    onPrimary: Color.fromARGB(255, 7, 28, 216), // Change the button's text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Adjust border radius here
                                      side: BorderSide(
                                          color: Colors.blue, width: 0.3),
                                    ),
                                  ),
                                  child: Text(
                                    "Select Seats",
                                    style: GoogleFonts.rajdhani(
                                        color: Colors.blue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 05,
                              ),
                              Text("${_trip.availableSeats} Seats Left",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          // SizedBox(
                          // width: 50,
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
      ],
    );
  }

// String convertMinutesToHoursAndMinutes(int minutes) {
  Widget convertMinutesToHoursAndTime(int minutes, String dateString) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    if (hours == 0 && remainingMinutes == 0) {
      return Text(
        "0 hr",
        style: GoogleFonts.rajdhani(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    int totalHours = hours + (remainingMinutes >= 30 ? 1 : 0);

    // Parse the input date in ISO 8601 format
    DateTime date = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('dd MMM');

    if (totalHours < 24) {
      String hour =
          totalHours == 0 ? "12" : (totalHours % 12).toString().padLeft(2, '0');
      String minute = remainingMinutes.toString().padLeft(2, '0');
      String amPm = totalHours < 12 ? 'am' : 'pm';
      String formattedDate = formatter.format(date);
      return Row(
        children: [
          Text(
            "$hour:$minute $amPm",
            style: GoogleFonts.rajdhani(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          Text(
            formattedDate,
            style: GoogleFonts.rajdhani(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else {
      int remainingHours = totalHours % 24;
      String hour = remainingHours == 0
          ? "12"
          : (remainingHours % 12).toString().padLeft(2, '0');
      String minute = remainingMinutes.toString().padLeft(2, '0');
      String amPm = remainingHours < 12 ? 'am' : 'pm';

      // Increment the date if the total hours exceed 24
      if (totalHours >= 24) {
        date = date.add(Duration(days: 1));
      }
      String newDateString = formatter.format(date);

      return Row(
        children: [
          Text(
            "$hour:$minute $amPm",
            style: GoogleFonts.rajdhani(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          if (totalHours > 24)
            Text(
              "+1 day",
              style: GoogleFonts.rajdhani(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          SizedBox(width: 5),
          Text(
            newDateString,
            style: GoogleFonts.rajdhani(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }
  }

  String convertToTimeFormat(int value) {
    if (value < 0 || value > 2400) {
      throw ArgumentError("Value must be between 0 and 2400");
    }

    int hour = value ~/ 100;
    int minute = value % 100;

    String period = (hour >= 12) ? 'PM' : 'AM';

    if (hour > 12) {
      hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }
    String hourStr = hour.toString().padLeft(2, '0');
    String minuteStr = minute.toString().padLeft(2, '0');

    return '$hourStr:$minuteStr $period';
  }

  Widget title(text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
    );
  }

  String convertDateString(String dateString) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(dateString);

    // Extract day and month
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = _getMonthAbbreviation(dateTime.month);

    // Concatenate day and month
    return '$day$month';
  }

  String _getMonthAbbreviation(int month) {
    switch (month) {
      case 1:
        return 'JAN';
      case 2:
        return 'FEB';
      case 3:
        return 'MAR';
      case 4:
        return 'APR';
      case 5:
        return 'MAY';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AUG';
      case 9:
        return 'SEP';
      case 10:
        return 'OCT';
      case 11:
        return 'NOV';
      case 12:
        return 'DEC';
      default:
        return '';
    }
  }

  String convertTime(String timeString) {
    // Split the time string into hours and minutes
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    // Construct the formatted time string
    String formattedTime = '$hours hrs ';

    if (minutes > 0) {
      formattedTime += '$minutes mins';
    } else {
      formattedTime += '00 mins';
    }

    return formattedTime;
  }
}
