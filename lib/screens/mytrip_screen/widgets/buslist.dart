import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../api_services/bus apis/print_ticket_api.dart';
import '../../../api_services/payment_api/completed_payment_api.dart';
import '../../bus/bus_tripdetail.dart';
import '../../bus/functions/bus_functions.dart';
import 'nulldetails.dart';

List<Tickectobj> busTickets = [];

class BusList extends StatelessWidget {
  final double swidth;
  final double sheight;
  final List<SuccessPaymentData> BusSuccessData;
  final Map<String, String> blockkeyTinMap;

  BusList(
      {this.swidth, this.sheight, this.BusSuccessData, this.blockkeyTinMap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: busticktfunction(BusSuccessData),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data'));
        } else {
          return Padding(
            padding:
                const EdgeInsets.only(left: 8.0, top: 25, bottom: 25, right: 8),
            child: busTickets.isEmpty
                ? details(
                    swidth,
                    sheight,
                    "Looks empty, you've no upcoming bookings.",
                    "When you book a trip, you will see your itinerary here.")
                : SizedBox(
                    width: swidth * .59,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: busTickets.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 0,
                        );
                      },
                      itemBuilder: (context, index) {
                        final _trip = busTickets[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 1, top: 15),
                          child: Container(
                            width: swidth * 0.4,
                            height: sheight * .13,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 0.2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10),
                                    Text(_trip.travels,
                                        style: GoogleFonts.notoSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    SizedBox(height: 5),
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
                                SizedBox(width: 10),
                                Row(
                                  children: [
                                    SizedBox(width: 5),
                                    Text("${_trip.destinationCity}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(width: 10),
                                    Text(convertToTime("${_trip.pickupTime}"),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(width: 5),
                                    Text(convertDateString("${_trip.doj}"),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(width: 5),
                                    Container(
                                      height: 1.0,
                                      width: 25.0,
                                      color: Colors.grey,
                                    ),
                                    // SizedBox(width: 5),
                                    // Text(
                                    //   "_trip.duration",
                                    //   style: TextStyle(fontSize: 15),
                                    // ),
                                    // SizedBox(width: 5),
                                    Container(
                                      height: 1.0,
                                      width: 25.0,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 5),
                                    Text(convertToTime("${_trip.dropTime}"),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(width: 5),
                                    Text(convertDateString("${_trip.doj}"),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                             SizedBox(width: 10),
                                    Text("${_trip.sourceCity}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Text("₹${_trip.bookingFee}",
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700)),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 20),
                                    SizedBox(
                                      width: 150,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Navigate to BusTripDetail with necessary parameters
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(255, 224, 90, 67),
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        child: Text("Cancel"),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    // Text(
                                    //     "${_trip.inventoryItems.seatName} Seats Left",
                                    //     style: TextStyle(
                                    //         fontSize: 11,
                                    //         color: Colors.black,
                                    //         fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          );
        }
      },
    );
  }

Future<void> busticktfunction(List<SuccessPaymentData> BusSuccessData) async {
  busTickets.clear();
  Set<Tickectobj> uniqueTickets = {}; // Use a Set to ensure uniqueness

  for (int i = 0; i < BusSuccessData.length; i++) {
    SuccessPaymentData bus = BusSuccessData[i];
    if (bus.blockKey != "null") {
      String tin = blockkeyTinMap[bus.blockKey];
      if (tin != null) {
        String res = await busTicketAPI(tin);
        if (res != 'failed') {
          Tickectobj obj = Tickectobj.fromJson(jsonDecode(res));
          uniqueTickets.add(obj); // Add to Set to ensure uniqueness
        }
      }
    }
  }

  busTickets = uniqueTickets.toList(); // Convert Set back to List
}
}




























// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:trip/common/print_funtions.dart';

// import '../../../api_services/bus apis/print_ticket_api.dart';
// import '../../../api_services/payment_api/completed_payment_api.dart';
// import '../../bus/bus_availableTrips.dart';
// import '../../bus/bus_tripdetail.dart';
// import '../../bus/functions/bus_functions.dart';
// import '../mytrip_page.dart';
// import 'nulldetails.dart';

// List<Tickectobj> busTickets = [];
// BusList(swidth, sheight, List<SuccessPaymentData> BusSuccessData,
//     Map<String, String> blockkeyTinMap) {
//   busticktfunction(BusSuccessData);
//   return Padding(
//       padding: const EdgeInsets.only(left: 8.0, top: 25, bottom: 25, right: 8),
//       child: busTickets.length == 0
//           ? details(
//               swidth,
//               sheight,
//               "Looks empty, you've no upcoming bookings.",
//               "When you book a trip, you will see your itinerary here.")
//           : SizedBox(
//               width: swidth * .59,
//               child: ListView.separated(
//                 shrinkWrap: true,
//                 itemCount: busTickets.length??0,
//                 separatorBuilder: (context, index) {
//                   return SizedBox(
//                     height: 0,
//                   );
//                 },
//                 itemBuilder: (context, index) {
//                   final _trip = busTickets[index];
//                   // log(widget.trip[index].arrivalTime);
//                   // log(widget.trip[index].id);

//                   return Padding(
//                     padding: const EdgeInsets.only(left: 1, top: 15),
//                     child: Container(
//                       width: swidth * 0.4,
//                       height: sheight * .13,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(width: 0.2, color: Colors.grey),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           // SizedBox(
//                           //   width: 50,
//                           // ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text(_trip.travels,
//                                   style: GoogleFonts.notoSans(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w600,
//                                   )),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               SizedBox(
//                                 width: 150,
//                                 height: 20,
//                                 child: Text(_trip.busType,
//                                     style: TextStyle(
//                                         fontSize: 13,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w400)),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),

//                           Row(
//                             children: [
//                               Text(convertToTime("${_trip.pickupTime}"),
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w700)),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Text(convertDateString("${_trip.doj}"),
//                                   style: TextStyle(
//                                       fontSize: 13,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500)),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Container(
//                                 height: 1.0,
//                                 width: 25.0,
//                                 color: Colors.grey,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Text(
//                                 "_trip.duration",
//                                 style: black15,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Container(
//                                 height: 1.0,
//                                 width: 25.0,
//                                 color: Colors.grey,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               // SizedBox(
//                               // width: 20,
//                               // ),
//                               Text(convertToTime("${_trip.dropTime}"),
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w700)),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Text(convertDateString("${_trip.doj}"),
//                                   style: TextStyle(
//                                       fontSize: 13,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500)),
//                             ],
//                           ),

//                           SizedBox(
//                             width: 20,
//                           ),
//                           // Spacer(),
//                           Text("₹${buildFaresText(_trip.bookingFee)}",
//                               style: TextStyle(
//                                   fontSize: 19,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w700)),
//                           // SizedBox(
//                           // width: 30,
//                           // ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               SizedBox(
//                                 width: 150,
//                                 height: 40,
//                                 child: ElevatedButton(
//                                   onPressed: () {
//                                     // log(_trip.id);

//                                     // Navigator.push(
//                                     //     context,
//                                     //     MaterialPageRoute(
//                                     //         builder: (context) => BusTripDetail(
//                                     //             id: _trip.id,
//                                     //             fare:
//                                     //                 buildFaresText(_trip.fares),
//                                     //             total_seats:
//                                     //                 _trip.availableSeats,
//                                     //             bus_type: _trip.busType,
//                                     //             trip: _trip)));
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     primary: Color.fromARGB(255, 224, 90,
//                                         67), // Change the button's background color
//                                     onPrimary: Colors
//                                         .white, // Change the button's text color
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           20.0), // Adjust border radius here
//                                     ),
//                                   ),
//                                   child: Text("Select Seats"),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 05,
//                               ),
//                               Text(
//                                   "${_trip.inventoryItems.seatName} Seats Left",
//                                   style: TextStyle(
//                                       fontSize: 11,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w400)),
//                             ],
//                           ),
//                           // SizedBox(
//                           // width: 50,
//                           // ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ));
// }

// busticktfunction(BusSuccessData) async {
// busTickets.clear();
//   for (int i = 0; i < BusSuccessData.length; i++) {
//     SuccessPaymentData bus = BusSuccessData[i];
//     if (bus.blockKey != "null") {
//       String tin = blockkeyTinMap[bus.blockKey];

//       // Assuming busTicketAPI is a function that requires tin
//       String res = await busTicketAPI(tin);
//       if (res != 'failed' ) {
//         Tickectobj obj = Tickectobj.fromJson(jsonDecode(res));
//         busTickets.add(obj);
//         printWhite("busTickets.length");
//         printred(busTickets.length.toString());
//       }
//     }
//   }
// }
