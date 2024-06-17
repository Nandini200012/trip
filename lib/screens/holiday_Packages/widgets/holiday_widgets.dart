import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/common/print_funtions.dart';

import 'package:trip/constants/fonts.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';

import '../../../api_services/holiday_packages/get_packages_byid_api.dart';

cancelationContainer(double swidth, double sheight, Details packageDetails) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Cancellation Policy & Payment Terms", style: R23w600),
      kheight3,
      Text("We keep it transparent, crystal clear!",
          style: GoogleFonts.rajdhani(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic)),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Container(
              height: sheight * 0.09,
              width: swidth * 0.55,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  border: Border.all(color: Colors.grey[700], width: 0.3)),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Containerblue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    height: sheight * 0.09,
                    // width: 250,
                    child: Row(
                      children: [
                        kwidth5,
                        kwidth5,
                        kwidth5,
                        kwidth5,
                        Center(
                            child: Text(
                          "Cancellation received no. of days prior \nto departure",
                          style: R13whi500,
                        )),
                        kwidth5,
                        kwidth5,
                        kwidth5,
                        kwidth5,
                      ],
                    ),
                  ),
                  kwidth10,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                        width: swidth * 0.55 - 270,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                packageDetails.policyTerms.length ?? 0,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 0.0,
                          ),
                          itemCount: packageDetails.policyTerms.length ?? 0,
                          itemBuilder: (context, index) {
                            List<PolicyTerm> policy =
                                packageDetails.policyTerms;
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 18.0, left: 0.5),
                              child: Text(
                                "${policy[index].cancellationFrom} to ${policy[index].cancellationTo}",
                                style: R17w500,
                              ),
                            );
                            // return Container(
                            //   // padding: EdgeInsets.all(10.0),
                            //   // decoration: BoxDecoration(
                            //   //   border: Border.all(color: Colors.grey),
                            //   //   borderRadius: BorderRadius.circular(10.0),
                            //   // ),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         "          D\n ${policy[index].cancellationFrom} to ${policy[index].cancellationTo}",
                            //         style: TextStyle(
                            //             fontSize: 17,
                            //             fontWeight: FontWeight.w500),
                            //       ),
                            //       // Add more Text widgets here for other details if needed
                            //     ],
                            //   ),
                            // );
                          },
                        )

                        // child: ListView.builder(
                        //     shrinkWrap: true,
                        //     itemCount: packageDetails.policyTerms.length ?? 0,
                        //     itemBuilder: (context, index) {
                        //       List<PolicyTerm> policy = packageDetails.policyTerms;
                        //       return Row(
                        //         children: [
                        // Text(
                        //   "    D\n ${policy[index].cancellationFrom} to ${policy[index].cancellationTo}",
                        //   style: R17w500,
                        // ),
                        //         ],
                        //       );
                        //     }),
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [

                        // Text(
                        //   "    D\n 0 to 5",
                        //   style: R17w500,
                        // ),
                        // kwidth5,
                        // kwidth5,
                        // Text(
                        //   "    D\n 0 to 5",
                        //   style: R17w500,
                        // ),
                        // kwidth5,
                        // kwidth5,
                        // Text(
                        //   "    D\n 0 to 5",
                        //   style: R17w500,
                        // ),
                        // kwidth5,
                        // kwidth5,
                        // Text(
                        //   "    D\n 0 to 5",
                        //   style: R17w500,
                        // ),
                        // kwidth5,
                        // kwidth5,
                        // Text(
                        //   "    D\n 0 to 5",
                        //   style: R17w500,
                        // ),
                        // kwidth5,
                        // kwidth5,
                        // Text(
                        //   "    D\n 0 to 5",
                        //   style: R17w500,
                        // ),
                        // kwidth5,
                        // kwidth5,
                        // Text(
                        //   "    D\n 0 to 5",
                        //   style: R17w500,
                        // ),
                        // kwidth5,
                        // kwidth5,
                        // Text(
                        //   "    D\n 0 to 5",
                        //   style: R17w500,
                        // ),
                        // kwidth5,
                        // kwidth5,
                        //   ],
                        // ),
                        ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Container(
                height: sheight * 0.09,
                width: swidth * 0.55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    border: Border.all(color: Colors.grey[700], width: 0.3)),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Containerblue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      height: sheight * 0.09,
                      // width: 250,
                      child: Row(
                        children: [
                          kwidth5,
                          kwidth5,
                          kwidth5,
                          kwidth5,
                          Center(
                              child: Text(
                            "Cancellation fee applicable on Net Tour \nPrice (per person)",
                            style: R13whi500,
                          )),
                          kwidth5,
                          kwidth5,
                          kwidth5,
                        ],
                      ),
                    ),
                    kwidth10,
                    Container(
                        width: swidth * 0.55 - 270,
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  packageDetails.policyTerms.length ?? 0,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0,
                            ),
                            itemCount: packageDetails.policyTerms.length ?? 0,
                            itemBuilder: (context, index) {
                              List<PolicyTerm> policy =
                                  packageDetails.policyTerms;
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 22.0, left: 15, right: 2),
                                child: SizedBox(
                                  width: 50,
                                  child: Text(
                                    "${policy[index].percentage}",
                                    style: R17w500,
                                  ),
                                ),
                              );
                            })
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     Text(
                        //       "100%",
                        //       style: R17w500,
                        //     ),
                        //     kwidth5,
                        //     kwidth5,
                        //     Text(
                        //       "100%",
                        //       style: R17w500,
                        //     ),
                        //     kwidth5,
                        //     kwidth5,
                        //     Text(
                        //       "100%",
                        //       style: R17w500,
                        //     ),
                        //     kwidth5,
                        //     kwidth5,
                        //     Text(
                        //       "100%",
                        //       style: R17w500,
                        //     ),
                        //     kwidth5,
                        //     kwidth5,
                        //     Text(
                        //       "100%",
                        //       style: R17w500,
                        //     ),
                        //     kwidth5,
                        //     kwidth5,
                        //     Text(
                        //       "100%",
                        //       style: R17w500,
                        //     ),
                        //     kwidth5,
                        //     kwidth5,
                        //     Text(
                        //       "100%",
                        //       style: R17w500,
                        //     ),
                        //     kwidth5,
                        //     kwidth5,
                        //     Text(
                        //       "100%",
                        //       style: R17w500,
                        //     ),
                        //     kwidth5,
                        //     kwidth5,
                        //   ],
                        // ),
                        )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      kheight20,
      Text("Payment Terms", style: R15w600),
      kheight10,
      blackpoints(
          packageDetails.paymentTerm ??
              "Guest can pay by Cheque/ Demand Draft/ Debit card / Credit card/ NEFT/ RTGS/ IMPS. For Debit / Credit card payment \nadditional 1.8 % convenience charge will be applicable Cheque / Demand draft should be in favour of Us",
          hide: true),
      kheight10,
      kheight5,
      Text("Remarks", style: R15w600),
      kheight10,
      blackpoints(packageDetails.remarks ??
          "Mumbai - New York// Washington DC - Mumbai"),
      // kheight5,
      // blackpoints(
      //     "We use combination of Airlines like Turkish Airline /Qatar Airways / Emirates / Cathay Pacific etc."),
      // kheight5,
      // blackpoints("A/C coach - Seating capacity depends upon group size"),
      kheight10,
      kheight5,
    ],
  );
}

needtoKnow(swidth, sheight, Details packageDetails) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Need to Know", style: R23w600),
      kheight3,
      Text("Things to consider before the trip!",
          style: GoogleFonts.rajdhani(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic)),
      //  kheight20,
      //    Text("Weather", style: R15w600),
      kheight10,
      blackpoints(packageDetails.ntkDesc),
      // blackpoints("Warm and sunny in summers, cool in winters"),
      kheight5,
      // blackpoints(
      //     "For detailed Information about weather kindly visit www.accuweather.com"),
      // kheight10,
      // kheight5,
      // Text("Transport", style: R15w600),
      // kheight10,
      // blackpoints("Mumbai - New York// Washington DC - Mumbai"),
      // kheight5,
      // blackpoints(
      //     "We use combination of Airlines like Turkish Airline /Qatar Airways / Emirates / Cathay Pacific etc."),
      // kheight5,
      // blackpoints("A/C coach - Seating capacity depends upon group size"),
      // kheight10,
      // kheight5,
      // Text("Documents Required for Travel", style: R15w600),
      // kheight10,
      // blackpoints("Warm and sunny in summers, cool in winters"),
      // kheight5,
      // blackpoints(
      //     "For detailed Information about weather kindly visit www.accuweather.com"),
      // kheight10,
      kheight5,
    ],
  );
}

class TourInformation extends StatefulWidget {
  final double swidth;
  final double sheight;
  final Details packageDetails;

  TourInformation({this.swidth, this.sheight, this.packageDetails});

  @override
  _TourInformationState createState() => _TourInformationState();
}

class _TourInformationState extends State<TourInformation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tour Information", style: R23w600),
        SizedBox(height: 5),
        Text("Read this to prepare for your tour in the best way!",
            style: GoogleFonts.rajdhani(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic)),
        SizedBox(height: 20),
        Container(
          width: widget.swidth * 0.55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                child: Container(
                  height: widget.sheight * 0.052,
                  width: widget.swidth * 0.26,
                  decoration: BoxDecoration(
                      color: _selectedIndex == 0
                          ? Color.fromARGB(233, 42, 47, 142)
                          : Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      border: Border.all(color: Colors.grey[700], width: 0.3)),
                  child: Center(
                      child: Text(
                    "Tour Inclusions",
                    style: _selectedIndex == 0 ? R23whi600 : R23blu600,
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                child: Container(
                  height: widget.sheight * 0.052,
                  width: widget.swidth * 0.28,
                  decoration: BoxDecoration(
                      color: _selectedIndex == 1
                          ? Color.fromARGB(233, 42, 47, 142)
                          : Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      border: Border.all(color: Colors.grey[700], width: 0.1)),
                  child: Center(
                      child: Text(
                    "Tour Exclusions",
                    style: _selectedIndex == 1 ? R23whi600 : R23blu600,
                  )),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       _selectedIndex = 2;
              //     });
              //   },
              //   child: Container(
              //     height: widget.sheight * 0.052,
              //     width: widget.swidth * 0.176,
              //     decoration: BoxDecoration(
              //         color: _selectedIndex == 2 ? Color.fromARGB(233, 42, 47, 142) : Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
              //         borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(10),
              //             topRight: Radius.circular(10)),
              //         border: Border.all(color: Colors.grey[700], width: 0.1)),
              //     child: Center(
              //         child: Text(
              //           "Advance Preparations",
              //           style:  _selectedIndex == 2? R23whi600 : R23blu600,
              //         )),
              //   ),
              // )
            ],
          ),
        ),
        Container(
          // height: widget.sheight * 0.5,
          width: widget.swidth * 0.55,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              border: Border.all(color: Colors.grey[700], width: 0.3)),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 10.0, top: 10, bottom: 10, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                points(_selectedIndex == 0
                    ? widget.packageDetails.inclusive
                    : widget.packageDetails.exclusive),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// TourInformation(double swidth, double sheight,Details packageDetails) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text("Tour Information", style: R23w600),
//       kheight5,
//       Text("Read this to prepare for your tour in the best way!",
//           style: GoogleFonts.rajdhani(
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//               fontStyle: FontStyle.italic)),
//       kheight20,
//       Container(
//         width: swidth * 0.55,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               height: sheight * 0.052,
//               width: swidth * 0.176,
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(233, 42, 47, 142),
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10)),
//                   border: Border.all(color: Colors.grey[700], width: 0.3)),
//               child: Center(
//                   child: Text(
//                 "Tour Inclusions",
//                 style: R23whi600,
//               )),
//             ),
//             Container(
//               height: sheight * 0.052,
//               width: swidth * 0.176,
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10)),
//                   border: Border.all(color: Colors.grey[700], width: 0.1)),
//               child: Center(
//                   child: Text(
//                 "Tour Exclusions",
//                 style: R23blu600,
//               )),
//             ),
//             Container(
//               height: sheight * 0.052,
//               width: swidth * 0.176,
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10)),
//                   border: Border.all(color: Colors.grey[700], width: 0.1)),
//               child: Center(
//                   child: Text(
//                 "Advance Preparations",
//                 style: R23blu600,
//               )),
//             )
//           ],
//         ),
//       ),
//       Container(
//         height: sheight * 0.5,
//         width: swidth * 0.55,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(10),
//                 bottomRight: Radius.circular(10)),
//             border: Border.all(color: Colors.grey[700], width: 0.3)),
//         child: Padding(
//           padding:
//               const EdgeInsets.only(right: 10.0, top: 10, bottom: 10, left: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               kheight10, kheight10,
//               points(
//                   packageDetails.inclusive),
//               kheight10,
//               // points(
//               //     "Post Booking, you will be notified through your contact details about all tour related updates"),
//               // kheight10,
//               // points(
//               //     "Post Booking, you will be notified through your contact details about all tour related updates"),
//               // kheight10,
//               // points(
//               //     "Post Booking, you will be notified through your contact details about all tour related updates"),
//               // kheight10,
//               // points(
//               //     "Post Booking, you will be notified through your contact details about all tour related updates"),
//               // kheight10,
//               // points(
//               //     "Post Booking, you will be notified through your contact details about all tour related updates"),
//               // kheight10,
//               // points(
//               //     "Post Booking, you will be notified through your contact details about all tour related updates"),
//               // kheight10,
//               // points(
//               //     "Post Booking, you will be notified through your contact details about all tour related updates"),
//               // kheight10,
//               // points(
//               //     "Post Booking, you will be notified through your contact details about all tour related updates"),
//               // kheight10,
//               // points(
//               //     "Post Booking, you will be notified through your contact details about all tour related updates"),
//               //  kheight10,
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }

blackpoints(String txt, {bool hide}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hide != true || hide == null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 0, right: 15),
            child: Icon(
              Icons.circle,
              size: 8,
              color: Colors.black,
            ),
          ),
        Text(
          txt,
          style: R15w500,
        ),
      ],
    ),
  );
}

points(String txt) {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 0, right: 15),
          child: Icon(
            Icons.circle,
            size: 8,
            color: Colors.green,
          ),
        ),
        Text(
          txt,
          style: R15w500,
        ),
      ],
    ),
  );
}

class FlightDetails extends StatefulWidget {
  Details packageDetails;
  FlightDetails({this.packageDetails});
  @override
  _FlightDetailsState createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  bool showFlightDetails = true;
  bool showAccommodationDetails = false;
  bool showReportingDetails = false;

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tour details", style: R23w600),
        SizedBox(height: 5),
        Text("Best facilities with no added cost.",
            style: GoogleFonts.rajdhani(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic)),
        SizedBox(height: 20),
        Container(
          width: swidth * 0.55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showFlightDetails = true;
                    showAccommodationDetails = false;
                    showReportingDetails = false;
                  });
                  print("Flight: $showFlightDetails");
                },
                child: Container(
                  height: sheight * 0.052,
                  width: swidth * 0.176,
                  decoration: BoxDecoration(
                      color: showFlightDetails
                          ? Color.fromARGB(233, 42, 47, 142)
                          : Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      border: Border.all(color: Colors.grey[700], width: 0.3)),
                  child: Center(
                      child: Text(
                    "Flight Details",
                    style: showFlightDetails ? R23whi600 : R23blu600,
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showAccommodationDetails = true;
                    showReportingDetails = false;
                    showFlightDetails = false;
                  });
                },
                child: Container(
                  height: sheight * 0.052,
                  width: swidth * 0.176,
                  decoration: BoxDecoration(
                      color: showAccommodationDetails
                          ? Color.fromARGB(233, 42, 47, 142)
                          : Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      border: Border.all(color: Colors.grey[700], width: 0.1)),
                  child: Center(
                      child: Text(
                    "Accommodation Details",
                    style: showAccommodationDetails ? R23whi600 : R23blu600,
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showReportingDetails = true;
                    showFlightDetails = false;
                    showAccommodationDetails = false;
                  });
                },
                child: Container(
                  height: sheight * 0.052,
                  width: swidth * 0.176,
                  decoration: BoxDecoration(
                      color: showReportingDetails
                          ? Color.fromARGB(233, 42, 47, 142)
                          : Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      border: Border.all(color: Colors.grey[700], width: 0.1)),
                  child: Center(
                      child: Text(
                    "Reporting & Dropping",
                    style: showReportingDetails ? R23whi600 : R23blu600,
                  )),
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: showFlightDetails,
          child: Container(
            // height: sheight * 0.25,
            width: swidth * 0.55,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                border: Border.all(color: Colors.grey[700], width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 50.0, top: 10, bottom: 10, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 50,
                      child: Text(
                        widget.packageDetails.flightDetails ??
                            "Processing the best for you!",
                        style: R15w500,
                      )),
                  // SizedBox(
                  //     height: 60,
                  //     child: Text(
                  //       "We are in the process of booking the flights for this tour. \nWe will update it here, as we are done.",
                  //       style:
                  //           R15w500,
                  //     )),
                  // SizedBox(
                  //     height: 50,
                  //     child: Text(
                  //         "Post Booking, you will be notified through your contact details about \nall tour related updates",
                  //         style: R15w500,)),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: showAccommodationDetails,
          child: Container(
            // height: sheight * 0.25,
            width: swidth * 0.55,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                border: Border.all(color: Colors.grey[700], width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 50.0, top: 10, bottom: 10, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 50,
                      child: Text(
                        widget.packageDetails.accommodation ??
                            "Processing the best for you!",
                        style: R15w500,
                      )),
                  // SizedBox(
                  //     height: 60,
                  //     child: Text(
                  //       "We are in the process of booking the flights for this tour. \nWe will update it here, as we are done.",
                  //       style:
                  //           R15w500,
                  //     )),
                  // SizedBox(
                  //     height: 50,
                  //     child: Text(
                  //         "Post Booking, you will be notified through your contact details about \nall tour related updates",
                  //         style: R15w500,)),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: showReportingDetails,
          child: Container(
            // height: sheight * 0.25,
            width: swidth * 0.55,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                border: Border.all(color: Colors.grey[700], width: 0.3)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 50.0, top: 10, bottom: 10, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 50,
                      child: Text(
                        widget.packageDetails.reportingDropping ??
                            "Processing the best for you!",
                        style: R15w500,
                      )),
                  // SizedBox(
                  //     height: 60,
                  //     child: Text(
                  //       "We are in the process of booking the flights for this tour. \nWe will update it here, as we are done.",
                  //       style:
                  //           R15w500,
                  //     )),
                  // SizedBox(
                  //     height: 50,
                  //     child: Text(
                  //         "Post Booking, you will be notified through your contact details about \nall tour related updates",
                  //         style: R15w500,)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
            "Note: Flight details are tentative only. The airline, departure, arrival times and routing may change.\nHotel details are tentative only. The hotel or place of accommodation may change.",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal))
      ],
    );
  }
}

// Flightdetails(double swidth, sheight) {
//   bool showFlightDetails = true;
//   bool showAccomodationDetails = false;
//   bool showReportingDetails = false;
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text("Tour details", style: R23w600),
//       kheight5,
//       Text("Best facilities with no added cost.",
//           style: GoogleFonts.rajdhani(
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//               fontStyle: FontStyle.italic)),
//       kheight20,
//       Container(
//         width: swidth * 0.55,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 showFlightDetails = true;
//                 showAccomodationDetails = false;
//                 showReportingDetails = false;
//                 print("Flight: $showFlightDetails");
//               },
//               child: Container(
//                 height: sheight * 0.052,
//                 width: swidth * 0.176,
//                 decoration: BoxDecoration(
//                     color: showFlightDetails?Color.fromARGB(233, 42, 47, 142):Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         topRight: Radius.circular(10)),
//                     border: Border.all(color: Colors.grey[700], width: 0.3)),
//                 child: Center(
//                     child: Text(
//                   "Flight Details",
//                   style: R23whi600,
//                 )),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 showAccomodationDetails = true;
//                 showReportingDetails = false;
//                 showFlightDetails = false;
//               },
//               child: Container(
//                 height: sheight * 0.052,
//                 width: swidth * 0.176,
//                 decoration: BoxDecoration(
//                     color: showAccomodationDetails?Color.fromARGB(233, 42, 47, 142):Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         topRight: Radius.circular(10)),
//                     border: Border.all(color: Colors.grey[700], width: 0.1)),
//                 child: Center(
//                     child: Text(
//                   "Accomodation Details",
//                   style: R23blu600,
//                 )),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 showReportingDetails = true;
//                 showFlightDetails = false;
//                 showAccomodationDetails = false;
//               },
//               child: Container(
//                 height: sheight * 0.052,
//                 width: swidth * 0.176,
//                 decoration: BoxDecoration(
//                     color: showReportingDetails?Color.fromARGB(233, 42, 47, 142):Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         topRight: Radius.circular(10)),
//                     border: Border.all(color: Colors.grey[700], width: 0.1)),
//                 child: Center(
//                     child: Text(
//                   "Reporting & Dropping",
//                   style: R23blu600,
//                 )),
//               ),
//             )
//           ],
//         ),
//       ),
//       Container(
//         height: sheight * 0.25,
//         width: swidth * 0.55,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(10),
//                 bottomRight: Radius.circular(10)),
//             border: Border.all(color: Colors.grey[700], width: 0.3)),
//         child: Padding(
//           padding:
//               const EdgeInsets.only(right: 50.0, top: 10, bottom: 10, left: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                   height: 50,
//                   child: Text("Processing the best for you!", style: R15w500)),
//               SizedBox(
//                   height: 60,
//                   child: Text(
//                     "We are in the process of booking the flights for this tour. \nWe will update it here, as we are done.",
//                     style: R15w500,
//                   )),
//               SizedBox(
//                   height: 50,
//                   child: Text(
//                       "Post Booking, you will be notified through your contact details about \nall tour related updates",
//                       style: R15w500)),
//             ],
//           ),
//         ),
//       ),
//       kheight10,
//       Text(
//           "Note: Flight details are tentative only. The airline, departure, arrival times and routing may change.\nHotel details are tentative only. The hotel or place of accommodation may change.",
//           style: GoogleFonts.rajdhani(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               fontStyle: FontStyle.normal))
//     ],
//   );
// }

itenery(Details packageDetails) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: packageDetails.itinerary.length,
    itemBuilder: (context, index) {
      List<Itinerary> itineryobj = packageDetails.itinerary;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconRow(
              day: "${itineryobj[index].day}",
              plc: "${itineryobj[index].location}",
              desc: "${itineryobj[index].itineraryDesc}",
              index: index,
              length: packageDetails.itinerary.length,
              last:
                  index != (packageDetails.itinerary.length - 1) ? null : true),
          // Iconrow("Day 1 / 23 Aug, 24", "Washington D.C (1 Nights)"),
          if (index != (packageDetails.itinerary.length - 1))
            Column(children: [
              greyline(),
              greyline(),
              greyline(),
              greyline(),
              greyline(),
            ])
          // Iconrow("Day 1 / 23 Aug, 24", "Washington D.C (1 Nights)"),
          // greyline(),
          // greyline(),
          // greyline(),
          // greyline(),
          // greyline(),
          // Iconrow("Day 1 / 23 Aug, 24", "Washington D.C (1 Nights)"),
          // greyline(),
          // greyline(),
          // greyline(),
          // greyline(),
          // greyline(),
          // Iconrow("Day 1 / 23 Aug, 24", "Washington D.C (1 Nights)"),
          // greyline(),
          // greyline(),
          // greyline(),
          // greyline(),
          // greyline(),
          // Iconrow("Day 1 / 23 Aug, 24", "Washington D.C (1 Nights)"),
          // greyline(),
          // greyline(),
          // greyline(),
          // greyline(),
          // greyline(),
          // Iconrow("Day 1 / 23 Aug, 24", "Washington D.C (1 Nights)"),
          // greyline(),
          // greyline(),
          // greyline(),
          // greyline(),
          // greyline(),
          // Iconrow("Day 1 / 23 Aug, 24", "Washington D.C (1 Nights)",
          //     last: true),
        ],
      );
    },
  );
}

class IconRow extends StatefulWidget {
  final String day;
  final String plc;
  final String desc;
  final int index;
  final int length;
  final bool last;

  const IconRow({
    Key key,
    @required this.day,
    @required this.plc,
    @required this.desc,
    @required this.index,
    @required this.length,
    this.last,
  }) : super(key: key);

  @override
  _IconRowState createState() => _IconRowState();
}

class _IconRowState extends State<IconRow> {
  List<bool> showdesc;

  @override
  void initState() {
    super.initState();
    showdesc = List.filled(widget.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            placeIcon(),
            SizedBox(height: 5),
            for (int i = 0; i < 5; i++) greyline(),
          ],
        ),
        SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.day,
                  style: GoogleFonts.rajdhani(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal)),
              SizedBox(height: 2),
              Text(widget.plc, style: R20w500),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Visibility(
                  visible: showdesc[widget.index],
                  child: Text(widget.desc,
                      style: GoogleFonts.rajdhani(
                          fontSize: 17, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            setState(() {
              showdesc[widget.index] = !showdesc[widget.index];
            });
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 15,
            child: Icon(
              showdesc[widget.index] ? Icons.remove : Icons.add,
              size: 15,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

// Iconrow(String day, String plc, String desc, int index, int length,
//     {bool last}) {
//   List<bool> showdesc = List.filled(length, false);
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       last == true || last != null
//           ? placeIcon()
//           : Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 placeIcon(),
//                 greyline(),
//                 greyline(),
//                 greyline(),
//                 greyline(),
//                 greyline()
//               ],
//             ),
//       kwidth10,
//       kwidth5,
//       Padding(
//         padding: const EdgeInsets.only(left: 5, top: 3),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(day,
//                 style: GoogleFonts.rajdhani(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     fontStyle: FontStyle.normal)),
//             kheight2,
//             Text(
//               plc,
//               style: R20w500,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//               child: Visibility(
//                 visible: showdesc[index],
//                 child: Text(
//                   desc,
//                   style: GoogleFonts.rajdhani(
//                       fontSize: 17, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       Spacer(),
//       GestureDetector(
//         onTap: () {
//           print('showdesc before toggle: $showdesc');
//           showdesc[index] = !showdesc[index];
//           print('showdesc after toggle: $showdesc');
//         },
//         child: CircleAvatar(
//           backgroundColor: Colors.grey.shade300,
//           radius: 15,
//           child: Icon(
//             showdesc[index] ? Icons.remove : Icons.add,
//             size: 15,
//             color: Colors.black,
//           ),
//         ),
//       )
//     ],
//   );
// }

placeIcon() {
  return Padding(
    padding: const EdgeInsets.only(top: 0, bottom: 0),
    child: Icon(
      Icons.place_outlined,
      color: Colors.grey.shade400,
      size: 25,
    ),
  );
}

greyline() {
  return Padding(
    padding: const EdgeInsets.only(top: 0.5, bottom: 0.5, left: 13),
    child: Container(
      height: 5.0,
      width: 0.8,
      color: Colors.grey.shade400,
    ),
  );
}

box2(double swidth, double sheight) {
  return Container(
    width: swidth,
    height: sheight * 0.7,
    color: Colors.transparent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 112.0),
          child: Text(
              "Select departure city, dates & add guest to book your tour",
              style: R23w600),
        ),
        kheight5,
        Padding(
          padding: const EdgeInsets.only(left: 112.0),
          child: Text("As seats fill, prices increase! So book today!",
              style: GoogleFonts.rajdhani(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic)),
        ),
        SizedBox(
          height: 35,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: swidth * 0.6,
            height: sheight * 0.45,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "SELECT DEPARTURE CITY & DATE",
                    style: rajdhani15W6,
                  ),
                  kheight5,
                  Container(
                    height: .5,
                    width: swidth * 0.6,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            width: swidth * 0.235,
            height: sheight * 0.45,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "BOOKING SUMMARY",
                    style: rajdhani15W6,
                  ),
                  kheight5,
                  Container(
                    height: 0.5,
                    width: swidth * 0.6,
                    color: Colors.grey,
                  ),
                  kheight20,
                  bookingdetails(
                    "Dept. city",
                    "Mumbai",
                  ),
                  kheight10,
                  bookingdetails(
                    "Dept. date",
                    "23 Aug 202429 → Aug 2024",
                  ),
                  kheight10,
                  bookingdetails(
                    "Travellers",
                    "0 Adult(s) | 0 Child | 0 Infant",
                  ),
                  kheight10,
                  bookingdetails(
                    "Rooms",
                    "0 Room",
                  ),
                  kheight10,
                  Container(
                    height: 0.5,
                    width: swidth * 0.6,
                    color: Colors.grey,
                  ),
                  kheight5,
                  Row(
                    children: [
                      Text(
                        "Basic Price",
                        style: rajdhani15W6,
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "₹ 2,90,000",
                            style: RGreen25W6,
                          ),
                          kheight3,
                          Text(
                            "per person on twin sharing",
                            style: rajdhani13W5,
                          ),
                        ],
                      ),
                      kheight10,
                    ],
                  ),
                  kheight30,
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, bottom: 10),
                      height: 40,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 187, 221, 37),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text("Add Guest & Room", style: rWhiteB18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ],
    ),
  );
}

bookingdetails(String value, txt) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 70,
        child: Text(
          value,
          style: GoogleFonts.rajdhani(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey[500]),
        ),
      ),
      //  Spacer(),
      kwidth10, kwidth10,
      Text(txt,
          style: GoogleFonts.rajdhani(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700])),
      Spacer(),
    ],
  );
}
