// ignore_for_file: missing_return, unused_local_variable, must_be_immutable

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/api_services/bus%20apis/available_trip_api.dart';
import 'package:trip/api_services/bus%20apis/trip_details_api.dart';
import 'package:trip/common/print_funtions.dart';
import 'package:trip/screens/bus/functions/bus_functions.dart';
import 'package:trip/screens/bus/widgets/bus_trip_detail_widgets.dart';
import 'package:trip/screens/bus/widgets/bustravellerform.dart';
import 'package:trip/screens/bus/widgets/submitButton.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import '../../api_services/bus apis/boardingDetails_api.dart';
import '../../api_services/bus apis/get_bus_fair_api.dart';
import '../activities/widgets/form.dart';
import '../header.dart';

String busFare;
String tripID;

class BusTripDetail extends StatefulWidget {
  String id;
  String fare;
  String total_seats;
  String bus_type;
  AvailableTrip trip;
  BusTripDetail(
      {key, this.id, this.total_seats, this.bus_type, this.trip, this.fare});

  @override
  State<BusTripDetail> createState() => _BusTripDetailState();
}

TripDetailsObj tripdetails;
List<Seat> Seats = [];
Map<int, List<List<Seat>>> seats3D;
// List<List<Seat>> seats2D = [];
double containerWidth, containerHeight;
int total;
Color seatColor;
List<String> selectedSeats = [];
IngPoints boardingPoints;
IngPoints droppingPoints;

class _BusTripDetailState extends State<BusTripDetail> {
  @override
  void initState() {
    super.initState();

    // seats3D.clear;
    // Seats.clear;
    tripdetails = null;
    getTripDetails(widget.id);
    getBoardingDetails(widget.id);
    get_total();
    getfairDetails(widget.id);
    tripID = widget.id;
    busFare = widget.fare;
    log("busFare:$busFare");
    log("id:${widget.id}");
    selectedSeats.clear();
  }

  void get_total() {
    {
      setState(() {
        total = int.parse(widget.total_seats);
      });
    }
  }

  getfairDetails(id) async {
    // String res = await getBusFairAPI(id);
    // printyellow("fair $res");

    // TripDetailsObj tripobj = TripDetailsObj.fromJson(jsonDecode(res));

    // setState(() {
    //   tripdetails = tripobj;
    //   Seats = tripdetails.seats;
    //   seats2D = create2DArray(Seats);
    // });
  }

  getTripDetails(id) async {
    String res = await tripDetailsapi(id);
    TripDetailsObj tripobj = TripDetailsObj.fromJson(jsonDecode(res));

    setState(() {
      tripdetails = tripobj;
      Seats = tripdetails.seats;
      printWhite("seat:$Seats");
      for (var s in Seats) {
        if (s.zIndex == "1") {
          printWhite("zindex:${s.zIndex}");
        }
      }
      seats3D = groupSeatsByZIndex(Seats);
      // seats3D = create3DArray(Seats);
    });
  }

  getBoardingDetails(id) async {
    String res = await boardingDetailsAPI(
      id,
    );
    if (res != "failed") {
      BoardingDetailsobj obj = BoardingDetailsobj.fromJson(jsonDecode(res));
      setState(() {
        boardingPoints = obj.boardingPoints;
        droppingPoints = obj.droppingPoints;
      });
    }
  }

  String selectedLocation = '';

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
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : CustomAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: Future.delayed(Duration(seconds: 0)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Seats.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Text(
                                "  ${widget.trip.travels}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildSeatsGrid(
                                  sHeight,
                                  sWidth,
                                  Seats,
                                  selectedSeats,
                                  setState,
                                ),

                                Column(
                                  children: [
                                    pickUpContainer(sWidth, sHeight),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2, bottom: 2),
                                      child: Container(
                                        height: 3,
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2, bottom: 5),
                                      child: Container(
                                        height: 3,
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(
                                            Icons.lock_clock,
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          "${widget.trip.duration}",
                                          style: GoogleFonts.rajdhani(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 2),
                                      child: Container(
                                        height: 3,
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2, bottom: 2),
                                      child: Container(
                                        height: 3,
                                        width: 1.0,
                                        color: Colors.grey,
                                      ),
                                    ),

                                    // SizedBox(
                                    // height: 10,
                                    // ),
                                    DropContainer(sWidth, sHeight, tripdetails),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Visibility(
                                      visible: selectedSeats.length != 0
                                          ? true
                                          : false,
                                      child: Container(
                                        color: Colors.grey.shade200,
                                        height: 60,
                                        width: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Selected Seats ",
                                                style: GoogleFonts.rajdhani(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "${selectedSeats.join(', ')}",
                                                style: GoogleFonts.rajdhani(
                                                    fontSize: 16,
                                                    color: Colors.blueGrey,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Visibility(
                                      visible: selectedSeats.length != 0
                                          ? true
                                          : false,
                                      child: Container(
                                        color: Colors.grey.shade200,
                                        height: 60,
                                        width: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Total Fare ",
                                                style: GoogleFonts.rajdhani(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Text(
                                                "₹ ${totalfare(widget.fare)}",
                                                style: GoogleFonts.rajdhani(
                                                    fontSize: 16,
                                                    color: Colors.blueGrey,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // Padding(
                                // padding:
                                //     const EdgeInsets.only(right: 0, left: 1),
                                // child: Container(
                                //   height: 340,
                                //   width: 320,
                                //   color: Colors.grey.shade300,
                                //   //  ),
                                //   //  ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(
                                //         left: 20.0, top: 8.0, bottom: 8.0),
                                //     child: Container(
                                //       width: sWidth * 0.2,
                                //       // height: sHeight * 0.5,
                                //       child: Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.start,
                                //         children: [
                                //           SizedBox(height: 20),
                                //             buildTextRow(
                                //                 "Selected Seats: ",
                                //                 "${selectedSeats.join(', ')}",
                                //                 18,
                                //                 Color.fromARGB(
                                //                     255, 6, 180, 12)),
                                //             SizedBox(height: 10),
                                //             buildTextRow("Total Fare:",
                                //                 " ₹ ${totalfare()}", 15, null),
                                //             SizedBox(height: 10),
                                //             buildTextRow(
                                //                 "Pick up:", "", 15, null),
                                //             SizedBox(height: 3),
                                //             Padding(
                                //               padding: const EdgeInsets.only(
                                //                   left: 30.0, top: 0),
                                //               child: Text(
                                //                 "  ${tripdetails.boardingTimes.city}",
                                //                 style: TextStyle(
                                //                   fontSize: 15,
                                //                   fontWeight: FontWeight.w700,
                                //                 ),
                                //               ),
                                //             ),
                                //             buildTextRow1(
                                //                 value1:
                                //                     "${tripdetails.boardingTimes.location}",
                                //                 value2:
                                //                     "${tripdetails.boardingTimes.address}",
                                //                 value3:
                                //                     "${tripdetails.boardingTimes.landmark}",
                                //                 fontSize: 12,
                                //                 color: null),
                                //             SizedBox(height: 10),
                                //             buildTextRow("Drop:", "", 15, null),
                                //             SizedBox(height: 3),
                                //             Padding(
                                //               padding: const EdgeInsets.only(
                                //                   left: 30.0, top: 3),
                                //               child: Text(
                                //                 "  ${tripdetails.droppingTimes.city}",
                                //                 style: TextStyle(
                                //                   fontSize: 15,
                                //                   fontWeight: FontWeight.w700,
                                //                 ),
                                //               ),
                                //             ),
                                //             buildTextRow1(
                                //                 value1:
                                //                     "${tripdetails.droppingTimes.location}",
                                //                 value2:
                                //                     "${tripdetails.droppingTimes.address} ",
                                //                 value3:
                                //                     "${tripdetails.droppingTimes.landmark}",
                                //                 fontSize: 12,
                                //                 color: null),
                                //             SizedBox(height: 20),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                            ColorCode(sWidth, sHeight),
                            if (selectedSeats.length != 0)
                              // passengerForm(),

                              BusTravellerForm(),
                            SizedBox(
                              height: 30,
                            ),
                            if (passengers.isNotEmpty || passengers != null)
                              BusSubmitButton(
                                  sWidth,
                                  passengers,
                                  tripID,
                                  boardingPoints.id,
                                  droppingPoints.id,
                                  widget.trip.source,
                                  widget.trip.destination,
                                  context),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        )
                      : Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget DropContainer(sWidth, sheight, TripDetailsObj tripdetails) {
    return Container(
      color: Colors.grey.shade200,
      // height: 100,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 8, bottom: 0),
              child: Row(
                children: [
                  Text(
                    "Drop",
                    style: GoogleFonts.rajdhani(
                        fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    convertDateString(widget.trip.doj.toString()), // date
                    style: GoogleFonts.rajdhani(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Text(
                    convertToTime(widget.trip.arrivalTime.toString()) ??
                        "01:00 AM",
                    style: GoogleFonts.rajdhani(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
            Text(
              "  ${droppingPoints.locationName}" ?? "Bangalore",
              style: GoogleFonts.rajdhani(
                  fontSize: 15, fontWeight: FontWeight.w700),
            ),
            Text(
              " ${droppingPoints.address}",
              style: GoogleFonts.rajdhani(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
            kheight2,
            Text(
              " ${droppingPoints.landmark}",
              style: GoogleFonts.rajdhani(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
            kheight2,
            Text(
              " contact no: ${droppingPoints.contactnumber}",
              style: GoogleFonts.rajdhani(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
            kheight2,
          ],
        ),
      ),
    );
  }

  Widget pickUpContainer(swidth, sHeight) {
    return Container(
      color: Colors.grey.shade200,
      // height: 145,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 8, bottom: 0),
              child: Row(
                children: [
                  Text(
                    "Pick Up",
                    style: GoogleFonts.rajdhani(
                        fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    convertDateString(widget.trip.doj.toString()) ??
                        "Fri 3, May",
                    style: GoogleFonts.rajdhani(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Text(
                    convertToTime(widget.trip.departureTime.toString()) ??
                        "06:00 PM",
                    style: GoogleFonts.rajdhani(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
            Text(
              "  ${boardingPoints.locationName}" ?? "Bangalore",
              style: GoogleFonts.rajdhani(
                  fontSize: 15, fontWeight: FontWeight.w700),
            ),
            Text(
              " ${boardingPoints.address}",
              style: GoogleFonts.rajdhani(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
            kheight2,
            Text(
              " ${boardingPoints.landmark}",
              style: GoogleFonts.rajdhani(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
            kheight2,
            Text(
              " contact no: ${boardingPoints.contactnumber}",
              style: GoogleFonts.rajdhani(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
            kheight2,
          ],
        ),
      ),
    );
  }

  Widget ColorCode(sWidth, sHeight) {
    return Padding(
      padding: const EdgeInsets.only(left: 150),
      child: Container(
        height: 100,
        width: 400,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(5)),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Ladies Seat',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 30,
            ),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Occupied Seat',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Map<int, List<List<Seat>>> groupSeatsByZIndex(List<Seat> seats) {
    Map<int, List<List<Seat>>> groupedSeats = {};

    for (Seat seat in seats) {
      int zIndex = int.parse(seat.zIndex);
      int row = int.parse(seat.row);
      int column = int.parse(seat.column);

      if (!groupedSeats.containsKey(zIndex)) {
        groupedSeats[zIndex] = [];
      }

      while (groupedSeats[zIndex].length <= row) {
        groupedSeats[zIndex].add([]);
      }

      while (groupedSeats[zIndex][row].length <= column) {
        groupedSeats[zIndex][row].add(null);
      }

      groupedSeats[zIndex][row][column] = seat;
    }

    return groupedSeats;
  }

  Widget buildSeatsGrid(
    double sHeight,
    double sWidth,
    List<Seat> seats,
    List<String> selectedSeats,
    void Function(void Function()) setState,
  ) {
    Map<int, List<List<Seat>>> seatsByZIndex = groupSeatsByZIndex(seats);

    double containerWidth = sWidth * 0.65;
    double containerHeight = sHeight * 0.8;
    double borderWidth = 10.0;

    return Center(
      child: Container(
        height: containerHeight,
        width: containerWidth,
        // color: Colors.amber,
        child: Column(
          children: [
            ...seatsByZIndex.entries.map((entry) {
              int zIndex = entry.key;
              List<List<Seat>> seatLayer = entry.value;

              double seatWidth = 70;
              // (containerWidth - borderWidth * (seatLayer[0].length - 1)) /
              //     seatLayer[0].length;
              double seatHeight = 120;
              // (containerHeight - borderWidth * (seatLayer.length - 1)) /
              //     seatLayer.length;

              return Column(
                children: [
                  if (zIndex == 0)
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Lower",
                        style: GoogleFonts.rajdhani(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                  if (zIndex == 1)
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0), // Add spacing for lower berth
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Upper",
                            style: GoogleFonts.rajdhani(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  buildSeatLayer(
                    seatLayer,
                    seatWidth,
                    seatHeight,
                    selectedSeats,
                    setState,
                    zIndex,
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildSeatLayer(
    List<List<Seat>> seatLayer,
    double seatWidth,
    double seatHeight,
    List<String> selectedSeats,
    void Function(void Function()) setState,
    int zIndex,
  ) {
    return Column(
      children: seatLayer.map((row) {
        return Row(
          children: row.map((seat) {
            // Skip the driver's seat at [0][0][0]
            if (zIndex == 0 &&
                row.indexOf(seat) == 0 &&
                seatLayer.indexOf(row) == 0) {
              return buildDriverSeat();
            }
            return buildSeat(
              seat,
              seatWidth,
              seatHeight,
              selectedSeats,
              setState,
              // seats2D[rowIndex][columnIndex].length,
              // seats2D[rowIndex][columnIndex].width
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  // Widget buildSeatsGrid(
  //   double sHeight,
  //   double sWidth,
  //   List<Seat> seats,
  //   List<String> selectedSeats,
  //   void Function(void Function()) setState,
  // ) {
  //   Map<int, List<List<Seat>>> seatsByZIndex = groupSeatsByZIndex(seats);

  //   double containerWidth = sWidth * 0.65;
  //   double containerHeight = sHeight * 0.9;
  //   double borderWidth = 1.0;

  //   return Center(
  //     child: Container(
  //       height: containerHeight,
  //       width: containerWidth,
  //       child: Stack(
  //         children: seatsByZIndex.entries.map((entry) {
  //           int zIndex = entry.key;
  //           List<List<Seat>> seatLayer = entry.value;

  //           double seatWidth =
  //               (containerWidth - borderWidth * (seatLayer[0].length - 1)) /
  //                   seatLayer[0].length;
  //           double seatHeight =
  //               (containerHeight - borderWidth * (seatLayer.length - 1)) /
  //                   seatLayer.length;

  //           return Positioned(
  //             top: zIndex *
  //                 (seatHeight +
  //                     borderWidth +
  //                     (zIndex == 1 ? 20 : 0)), // Add spacing for lower berth
  //             left: 0,
  //             right: 0,
  //             child: Column(
  //               children: [
  //                 if (zIndex == 0)
  //                   Padding(
  //                     padding: const EdgeInsets.all(18.0),
  //                     child: Text(
  //                       "Lower",
  //                       style: GoogleFonts.rajdhani(
  //                           fontSize: 15, fontWeight: FontWeight.w700),
  //                     ),
  //                   ),
  //                 if (zIndex == 1)
  //                   Padding(
  //                     padding: const EdgeInsets.all(0.0),
  //                     child: Container(
  //                       width: 150,
  //                       height: 50,
  //                         // color: Colors.red,
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         children: [
  //                           Text(
  //                             "Upper",
  //                             style: GoogleFonts.rajdhani(
  //                                 fontSize: 15, fontWeight: FontWeight.w700),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 buildSeatLayer(
  //                   seatLayer,
  //                   seatWidth,
  //                   seatHeight,
  //                   selectedSeats,
  //                   setState,
  //                   zIndex,
  //                 ),
  //               ],
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildSeatLayer(
  //   List<List<Seat>> seatLayer,
  //   double seatWidth,
  //   double seatHeight,
  //   List<String> selectedSeats,
  //   void Function(void Function()) setState,
  //   int zIndex,
  // ) {
  //   return Column(
  //     children: seatLayer.map((row) {
  //       return Row(
  //         children: row.map((seat) {
  //           // Skip the driver's seat at [0][0][0]
  //           if (zIndex == 0 &&
  //               row.indexOf(seat) == 0 &&
  //               seatLayer.indexOf(row) == 0) {
  //             return buildDriverSeat();
  //           }
  //           return buildSeat(
  //             seat,
  //             seatWidth,
  //             seatHeight,
  //             selectedSeats,
  //             setState,
  //             // seats2D[rowIndex][columnIndex].length,
  //             // seats2D[rowIndex][columnIndex].width
  //           );
  //         }).toList(),
  //       );
  //     }).toList(),
  //   );
  // }
  // Map<int, List<List<Seat>>> groupSeatsByZIndex(List<Seat> seats) {
  //   Map<int, List<List<Seat>>> groupedSeats = {};

  //   for (Seat seat in seats) {
  //     int zIndex = int.parse(seat.zIndex);
  //     int row = int.parse(seat.row);
  //     int column = int.parse(seat.column);

  //     if (!groupedSeats.containsKey(zIndex)) {
  //       groupedSeats[zIndex] = [];
  //     }

  //     while (groupedSeats[zIndex].length <= row) {
  //       groupedSeats[zIndex].add([]);
  //     }

  //     while (groupedSeats[zIndex][row].length <= column) {
  //       groupedSeats[zIndex][row].add(null);
  //     }

  //     groupedSeats[zIndex][row][column] = seat;
  //   }

  //   return groupedSeats;
  // }

  // Widget buildSeatsGrid(
  //   double sHeight,
  //   double sWidth,
  //   List<Seat> seats,
  //   List<String> selectedSeats,
  //   void Function(void Function()) setState,
  // ) {
  //   Map<int, List<List<Seat>>> seatsByZIndex = groupSeatsByZIndex(seats);

  //   double containerWidth = sWidth * 0.65;
  //   double containerHeight = sHeight * 0.9;
  //   double borderWidth = 1.0;

  //   return Center(
  //     child: Container(
  //       height: containerHeight,
  //       width: containerWidth,
  //       child: Stack(
  //         children: seatsByZIndex.entries.map((entry) {
  //           int zIndex = entry.key;
  //           List<List<Seat>> seatLayer = entry.value;

  //           double seatWidth =
  //               (containerWidth - borderWidth * (seatLayer[0].length - 1)) /
  //                   seatLayer[0].length;
  //           double seatHeight =
  //               (containerHeight - borderWidth * (seatLayer.length - 1)) /
  //                   seatLayer.length;

  //           return Positioned(
  //             top: zIndex * (seatHeight + borderWidth),
  //             left: 0,
  //             right: 0,
  //             child: Column(
  //               children: [
  //                 if (zIndex == 0)
  //                   Padding(
  //                     padding: const EdgeInsets.all(18.0),
  //                     child: Text(
  //                       "Upper" ,
  //                       style: GoogleFonts.rajdhani(
  //                           fontSize: 15, fontWeight: FontWeight.w700),
  //                     ),
  //                   ),
  //                 if (zIndex == 1)
  //                   Padding(
  //                     padding: const EdgeInsets.all(18.0),
  //                     child: Text(
  //                        "Lower",
  //                       style: GoogleFonts.rajdhani(
  //                           fontSize: 15, fontWeight: FontWeight.w700),
  //                     ),
  //                   ),
  //                 buildSeatLayer(
  //                   seatLayer,
  //                   seatWidth,
  //                   seatHeight,
  //                   selectedSeats,
  //                   setState,
  //                 ),
  //               ],
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildSeatLayer(
  //   List<List<Seat>> seatLayer,
  //   double seatWidth,
  //   double seatHeight,
  //   List<String> selectedSeats,
  //   void Function(void Function()) setState,
  // ) {
  //   return Column(
  //     children: seatLayer.map((row) {
  //       return Row(
  //         children: row.map((seat) {
  //           return buildSeat(
  //             seat,
  //             seatWidth,
  //             seatHeight,
  //             selectedSeats,
  //             setState,
  //           );
  //           // return Container(
  //           //   width: seatWidth,
  //           //   height: seatHeight,
  //           //   margin: EdgeInsets.all(0.2),
  //           //   color: seat != null && selectedSeats.contains(seat.name)
  //           //       ? Colors.red
  //           //       : Colors.green,
  //           //   child: Center(
  //           //     child: seat != null ? Text(seat.name) : Container(),
  //           //   ),
  //           // );
  //         }).toList(),
  //       );
  //     }).toList(),
  //   );
  // }

  // Widget buildSeatsGrid(
  //   double sHeight,
  //   double sWidth,
  //   // List<List<Seat>> seats2D,
  //   //  List<String> selectedSeats,
  //   //  void Function(void Function()) setState,
  // ) {
  //   double containerWidth = sWidth * 0.65;
  //   double containerHeight = sHeight * 0.5;
  //   double borderWidth = 1.0;

  //   double seatWidth =
  //       (containerWidth - borderWidth * (seats2D[0].length - 1)) /
  //           seats2D[0].length;
  //   double seatHeight =
  //       (containerHeight - borderWidth * (seats2D.length - 1)) / seats2D.length;

  //   return Center(
  //     child: Container(
  //       height: containerHeight,
  //       width: containerWidth,
  //       child: Center(
  //         child: Column(
  //           children: List.generate(
  //             seats2D.length,
  //             (rowIndex) => Center(
  //               child: Row(
  //                 children: List.generate(
  //                   seats2D[rowIndex].length,
  //                   (columnIndex) {
  //                     Seat seat = seats2D[rowIndex][columnIndex];
  //                     if (rowIndex == 0 && columnIndex == 0) {
  //                       return buildDriverSeat();
  //                     } else {
  // return buildSeat(
  //   seat,
  //   seatWidth,
  //   seatHeight,
  //   selectedSeats,
  //   setState,
  //   // seats2D[rowIndex][columnIndex].length,
  //   // seats2D[rowIndex][columnIndex].width
  // );
  //                     }
  //                   },
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildDriverSeat() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Image.asset(
            'images/steering.png',
            scale: 10,
          ),
        ],
      ),
    );
  }

  Widget buildSeat(
    Seat seat,
    double seatWidth,
    double seatHeight,
    List<String> selectedSeats,
    void Function(void Function()) setState,
    // String _seatLength,
    // String _seatWidth
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: seatWidth * 0.7,
          height: seatHeight * 0.5,
          decoration: BoxDecoration(
            border: seat != null
                ? Border.all(width: 5.0, color: Colors.transparent)
                : Border.all(width: 0.0, color: Colors.transparent),
            color: Colors.white,
          ),
          child: Center(
            child: GestureDetector(
              onTap: seat != null
                  ? () => handleSeatTap(seat, selectedSeats, setState)
                  : null,
              child: seat != null &&
                      seat.name != null &&
                      seat.available != null &&
                      seat.length == "1" &&
                      seat.width == "1"
                  // ? seatPick(
                  //     _seatLength,
                  //     _seatWidth,
                  //     seat.name,
                  //     selectedSeats.contains(seat.name)
                  //         ? Colors.green
                  //         : seatcolor(seat),
                  //     seat,
                  //   )
                  ? Seatdesign(
                      seat.name,
                      selectedSeats.contains(seat.name)
                          ? Colors.green
                          : seatcolor(seat),
                    )
                  : (seat != null &&
                          seat.name != null &&
                          seat.available != null &&
                          seat.length == "2" &&
                          seat.width == "1")
                      ? horizontalSeat(
                          seat.name,
                          selectedSeats.contains(seat.name)
                              ? Colors.green
                              : seatcolor(seat),
                        )
                      : (seat != null &&
                              seat.name != null &&
                              seat.available != null &&
                              seat.length == "1" &&
                              seat.width == "2")
                          ? verticalSeat(
                              seat.name,
                              selectedSeats.contains(seat.name)
                                  ? Colors.green
                                  : seatcolor(seat))
                          : null,
            ),
          ),
        ),
      ),
    );
  }

  void handleSeatTap(
    Seat seat,
    List<String> selectedSeats,
    void Function(void Function()) setState,
  ) {
    print("len: ${seat.length}");
    print("width: ${seat.width}");
    print("seat: ${seat.name}");

    if ((selectedSeats.length <= 6||selectedSeats.contains(seat.name)) &&seat.available == "true") {
      setState(() {
        if (selectedSeats.contains(seat.name)) {
          selectedSeats.remove(seat.name);
        } else {
          selectedSeats.add(seat.name);
        }
      });
    } else if (seat.available != "true") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sorry'),
          content: Text('Seat not avilable'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else if(selectedSeats.length >= 6 && !selectedSeats.contains(seat.name)){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Seat Selection Limit Exceeded'),
          content: Text(
              'You can only select up to 7 seats. Please deselect some seats to proceed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
//   Widget buildSeatsGrid(double sHeight, double sWidth) {
//     containerWidth = sWidth * 0.65;
//     containerHeight = sHeight * 0.5;
//     double borderWidth = 1.0;

//     double seatWidth =
//         (containerWidth - borderWidth * (seats2D[0].length - 1)) /
//             seats2D[0].length;
//     double seatHeight =
//         (containerHeight - borderWidth * (seats2D.length - 1)) / seats2D.length;

//     return Center(
//       child: Container(
//         decoration: BoxDecoration(
//             // border: Border.all(width: 0.0, color: Colors.blueGrey.shade400),
//             ),
//         height: containerHeight,
//         width: containerWidth,
//         child: Center(
//           child: Column(
//             children: List.generate(
//               seats2D.length,
//               (rowIndex) => Center(
//                 child: Row(
//                   children: List.generate(
//                     seats2D[rowIndex].length,
//                     (columnIndex) {
//                       Seat seat = seats2D[rowIndex][columnIndex];
//                       if (rowIndex == 0 && columnIndex == 0) {
//                         return Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Row(
//                             children: [
//                               Image.asset(
//                                 'images/steering.png',
//                                 scale: 10,
//                               ),
//                               // Seatdesign("", Colors.grey.shade300)
//                             ],
//                           ),
//                         );
//                       } else {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Center(
//                             child: Container(
//                               width: seatWidth * 0.7,
//                               height: seatHeight * 0.8,
//                               decoration: BoxDecoration(
//                                 border: seat != null
//                                     ? Border.all(
//                                         width: 5.0, color: Colors.transparent)
//                                     : Border.all(
//                                         width: 0.0, color: Colors.transparent),
//                                 color: Colors.white,
//                               ),
//                               child: Center(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: seat != null
//                                         ? Colors.white
//                                         : Colors.white,
//                                   ),
//                                   child: SizedBox(
//                                     child: Center(
//                                         child: seat != null &&
//                                                 seat.name != null &&
//                                                 seat.available != null &&
//                                                 seat.length == seat.width
//                                             ? GestureDetector(
//                                                 onTap: () {
//                                                   print(
//                                                       "Available trip id:${widget.trip.cpId}");
//                                                   print(
//                                                       "boarding point id:${tripdetails.boardingTimes.bpId}");
//                                                   print(
//                                                       "dropping point id:${tripdetails.droppingTimes.bpId}");
//                                                   print(
//                                                       "destination:${widget.trip.destination}");
//                                                   print(
//                                                       "Source :${widget.trip.source}");
//                                                   print("----inventory-----");
//                                                   print(
//                                                       "seat name:${seat.name}");
//                                                   print("fare:${seat.fare}");

//                                                   print(
//                                                       "ladies :${seat.ladiesSeat}");
//                                                   if (selectedSeats.length <=
//                                                       4) {
//                                                     log(seat.name);
//                                                     setState(() {
//                                                       if (selectedSeats
//                                                           .contains(
//                                                               seat.name)) {
//                                                         selectedSeats
//                                                             .remove(seat.name);
//                                                       } else {
//                                                         selectedSeats
//                                                             .add(seat.name);
//                                                       }
//                                                     });
//                                                   } else {
//                                                     showDialog(
//                                                       context: context,
//                                                       builder: (context) =>
//                                                           AlertDialog(
//                                                         title: Text(
//                                                             'Seat Selection Limit Exceeded'),
//                                                         content: Text(
//                                                             'You can only select up to 5 seats. Please deselect some seats to proceed.'),
//                                                         actions: [
//                                                           TextButton(
//                                                             onPressed: () {
//                                                               Navigator.of(
//                                                                       context)
//                                                                   .pop();
//                                                             },
//                                                             child: Text('OK'),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   }
//                                                 },
//                                                 child:

//                                                 Seatdesign(
//                                                   seat.name,
//                                                   selectedSeats
//                                                           .contains(seat.name)
//                                                       ? Colors.green
//                                                       : seatcolor(seat),
//                                                 ),
//                                               )
//                                             : null),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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

// String convertToTime(String data) {
//   if (data.length != 4) {
//     return data;
//   }

//   String hours = data.substring(0, 2);
//   String minutes = data.substring(2);

//   return '$hours:$minutes';
// }
// String convertTime(String timeString) {
//   // Split the time string into hours and minutes
//   List<String> parts = timeString.split(':');
//   int hours = int.parse(parts[0]);
//   int minutes = int.parse(parts[1]);

//   // Construct the formatted time string
//   String formattedTime = '$hours hrs ';

//   if (minutes > 0) {
//     formattedTime += '$minutes mins';
//   } else {
//     formattedTime += '00 mins';
//   }

//   return formattedTime;
// }
