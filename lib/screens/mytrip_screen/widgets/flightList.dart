
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../api_services/flight_retrieve_ticket/flight_retrieve.dart';
import '../../../api_services/payment_api/completed_payment_api.dart';
import '../../holiday_Packages/widgets/constants_holiday.dart';
import 'nulldetails.dart';

Widget flightList(double swidth, double sheight, List<SuccessPaymentData> flightSuccessData, List<FlightTicketobj> flightdatas) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, top: 25, bottom: 25, right: 8),
    child: flightSuccessData.isEmpty
        ? details(swidth, sheight, "Looks empty, you've no upcoming bookings.",
            "When you book a trip, you will see your itinerary here.")
        : Container(
            width: swidth * 0.6,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: flightdatas.length,
                itemBuilder: (context, index) {
                  final flight = flightdatas[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 0.8, color: Colors.grey)),
                      width: 500,
                      height: 200,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            kwidth30,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 25,
                                  child: Image.asset('images/AirlinesLogo/AI.png'),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Air Asia",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(width: 50),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "BLR",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 28,
                                      color: Color.fromARGB(255, 3, 51, 123),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Bangalore",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 1.2,
                                  width: 150.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "4hr,25Mar",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 1.2,
                                  width: 150.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "             Bangalore \n International Airport",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(width: 50),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 30),
                                Icon(
                                  Icons.swap_horiz,
                                  size: 35,
                                  color: Color.fromARGB(255, 3, 51, 123),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "4hr,25Mar",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 1.2,
                                  width: 150.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Economy",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(width: 50),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "HYD",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 28,
                                      color: Color.fromARGB(255, 3, 51, 123),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Hyderabad",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 1.2,
                                  width: 150.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "4hr,26Mar",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 1.2,
                                  width: 150.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "             Hyderabad \n International Airport",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [Colors.blue[400], Colors.blue[800]],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue[200],
                                    blurRadius: 8.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(1.0, 2.0),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            kwidth30,
                          ]),
                    ),
                  );
                }),
          ),
  );
}























// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../api_services/flight_retrieve_ticket/flight_retrieve.dart';
// import '../../../api_services/payment_api/completed_payment_api.dart';
// import '../../holiday_Packages/widgets/constants_holiday.dart';
// import 'nulldetails.dart';



// flightList(swidth, sheight,List<SuccessPaymentData> flightSuccessData,List<FlightTicketobj> flightdatas) {
//   return Padding(
//     padding: const EdgeInsets.only(left: 8.0, top: 25, bottom: 25, right: 8),
//     child: flightSuccessData.length == 0
//         ? details(swidth, sheight, "Looks empty, you've no upcoming bookings.",
//             "When you book a trip, you will see your itinerary here.")
//         :
//      Container(
//         //  height:sheight,
//         width: swidth * 0.6,
//         // color: Colors.amber,
//         child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: flightdatas.length??0,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(width: 0.8, color: Colors.grey)),
//                   width: 500,
//                   height: 200,
//                   child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         kwidth30,
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CircleAvatar(
//                               backgroundColor: Colors.transparent,
//                               radius: 25,
//                               child: Image.asset('images/AirlinesLogo/AI.png'),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               "Air Asia",
//                               style: GoogleFonts.rajdhani(
//                                   fontSize: 15, fontWeight: FontWeight.w600),
//                             ),
                           
//                           ],
//                         ),
//                         SizedBox(
//                           width: 50,
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "BLR",
//                               style: GoogleFonts.rajdhani(
//                                   fontSize: 28,
//                                   color: Color.fromARGB(255, 3, 51, 123),
//                                   fontWeight: FontWeight.w700),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "Banglore",
//                               style: GoogleFonts.rajdhani(
//                                   fontSize: 17, fontWeight: FontWeight.w600),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Container(
//                               height: 1.2,
//                               width: 150.0,
//                               color: Colors.grey,
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "4hr,25Mar",
//                               style: GoogleFonts.rajdhani(
//                                   fontSize: 15, fontWeight: FontWeight.w600),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Container(
//                               height: 1.2,
//                               width: 150.0,
//                               color: Colors.grey,
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "             Banglore \n International Airport",
//                               style: GoogleFonts.rajdhani(
//                                   fontSize: 15, fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           width: 50,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 30,
//                             ),
//                             Icon(
//                               Icons.swap_horiz,
//                               size: 35,
//                               color: Color.fromARGB(255, 3, 51, 123),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "4hr,25Mar",
//                               style: GoogleFonts.rajdhani(
//                                   fontSize: 15, fontWeight: FontWeight.w600),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Container(
//                               height: 1.2,
//                               width: 150.0,
//                               color: Colors.grey,
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "Economy",
//                               style: GoogleFonts.rajdhani(
//                                   fontSize: 17, fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           width: 50,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "HYD",
//                               style: GoogleFonts.rajdhani(
//                                   fontSize: 28,
//                                   color: Color.fromARGB(255, 3, 51, 123),
//                                   fontWeight: FontWeight.w700),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "Hyderabad",
//                               style: GoogleFonts.rajdhani(
//                                   fontSize: 17, fontWeight: FontWeight.w600),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Container(
//                               height: 1.2,
//                               width: 150.0,
//                               color: Colors.grey,
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "4hr,26Mar",
//                               style: GoogleFonts.rajdhani(
//                                   fontSize: 15, fontWeight: FontWeight.w600),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Container(
//                               height: 1.2,
//                               width: 150.0,
//                               color: Colors.grey,
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "             Hyderabad \n International Airport",
//                               style: GoogleFonts.rajdhani(
//                                   fontSize: 15, fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         ),
//                         Spacer(),
//                         Container(
//                           width: 100,
//                           height: 35,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             gradient: LinearGradient(
//                               colors: [Colors.blue[400], Colors.blue[800]],
//                               begin: Alignment.centerLeft,
//                               end: Alignment.centerRight,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.blue[200],
//                                 blurRadius: 8.0,
//                                 spreadRadius: 1.0,
//                                 offset: Offset(
//                                   1.0,
//                                   2.0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           child: GlowingOverscrollIndicator(
//                             color: Colors.blue[
//                                 200], // Change glow color to match shadow color
//                             axisDirection: AxisDirection.right,
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors
//                                     .transparent, // Make button transparent
//                                 shadowColor:
//                                     Colors.transparent, // Remove button shadow
//                               ),
//                               child: Text(
//                                 "Confirm",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         kwidth30,
//                       ]),
//                 ),
//               );
//             })),
//   );
// }














 