import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/constants/fonts.dart';
import 'package:trip/screens/activities/widgets/form.dart';
import 'package:trip/screens/holiday_Packages/holiday_booking_page.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import 'package:trip/screens/holiday_Packages/widgets/holiday_widgets.dart';

import '../../../api_services/holiday_packages/get_coupons_api.dart';
import '../../../api_services/holiday_packages/get_packages_byid_api.dart';


Pricegrncontainer(
  swidth,
  sheight,
) {
  return Container(
    width: swidth * 0.235,
    height: sheight * 0.45,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(10)),
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
  );
}

box3(double swidth, double sheight, CouponCodes, Details packageDetails,int _holidayprice) {
  return Container(
    width: swidth,
    // height: sheight * 4,
    color: Colors.white,
    child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: swidth * 0.6,
              // height: sheight * 4,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kheight20,
                  Row(
                    children: [
                      Text("Itinerary", style: R23w600),
                      kwidth5,
                      kwidth5,
                      Text("(Day Wise)",
                          style: GoogleFonts.rajdhani(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic)),
                      // Spacer(),
                      // Text("View all days",
                      //     style: GoogleFonts.rajdhani(
                      //         color: Colors.blue,
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.w500,
                      //         decoration: TextDecoration.underline,
                      //         fontStyle: FontStyle.normal)),
                      kwidth5,
                    ],
                  ),
                  kheight10,
                  itenery(packageDetails),
                  kheight30,
                  FlightDetails(packageDetails: packageDetails),
                  kheight30,
                  TourInformation(
                      swidth: swidth,
                      sheight: sheight,
                      packageDetails: packageDetails),
                  kheight30,
                  needtoKnow(swidth, sheight, packageDetails),
                  kheight30,
                  cancelationContainer(swidth, sheight, packageDetails),
                  kheight30,
                  // upgradeContainer(swidth, sheight),
                  kheight10,
                  kheight30,
                ],
              )),
          // kheight30,

          Padding(
            padding: const EdgeInsets.only(left: 28.0, top: 8),
            child: Container(
              width: swidth * 0.2,
              // height: sheight * 2,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              child: _buildpromocodes(swidth, sheight, CouponCodes, _holidayprice),
            ),
          ),
        ]),
  );
}

_buildpromocodes(screenWidth, screenHeight, List<CouponCode> CouponCodes,  int _holidayprice) {
  // Define filteredPromoCodes as a state variable
  // List<CouponCode> CouponCodes = [];

  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.8, color: Colors.grey)),
      // height: 500,
      width: screenWidth * 0.1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              height: 50,
              width: screenWidth * 0.17,
              color: Color.fromARGB(255, 60, 70, 126),
              child: Center(
                child: Text(
                  "Holiday Coupons",
                  style: GoogleFonts.rajdhani(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 252, 250, 250),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: CouponCodes.length ?? 0,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                final code = CouponCodes[index].couponCode;
                final discount = CouponCodes[index].discount;
                return GestureDetector(
                  onTap: () {
                    _holidayprice = 0;
                    print("index $index");
                    print("discount: $discount");

                    double _price = double.parse(packageDetails.packagePrice);
                    _holidayprice = _price.round();

                    print("before :$_holidayprice");
                    _showBookDetails(
                      context,
                      discount, _holidayprice
                    );
                  },
                  child: Center(
                    child: Container(
                      height: 100,
                      width: screenWidth * 0.16,
                      color: Colors.grey.shade200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Color.fromARGB(255, 107, 107, 107),
                            child: CircleAvatar(
                              radius: 9,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                code.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Congratulations! Promo Discount \nof $discount% applied successfully.",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "Terms & Conditions apply",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.card_giftcard,
                            size: 23,
                            color: Colors.grey.shade600,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // : CouponCodes.isEmpty
            //     ? Text('Invalid search') // Show invalid search message
            //     : Expanded(
            //         child: ListView.separated(
            //           shrinkWrap: true,
            //           scrollDirection: Axis.vertical,
            //           itemCount: CouponCodes.length ?? 0,
            //           separatorBuilder: (context, index) {
            //             return SizedBox(height: 10);
            //           },
            //           itemBuilder: (context, index) {
            //             final code = CouponCodes[index].couponCode;
            //             final discount = CouponCodes[index].discount;
            //             return Center(
            //               child: Container(
            //                 height: 100,
            //                 width: screenWidth * 0.16,
            //                 color: Colors.grey.shade200,
            //                 child: Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceEvenly,
            //                   children: [
            //                     CircleAvatar(
            //                       radius: 10,
            //                       backgroundColor:
            //                           Color.fromARGB(255, 107, 107, 107),
            //                       child: CircleAvatar(
            //                         radius: 9,
            //                         backgroundColor: Colors.white,
            //                       ),
            //                     ),
            //                     Column(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceEvenly,
            //                       children: [
            //                         Text(
            //                           code.toUpperCase(),
            //                           style: TextStyle(
            //                               fontSize: 15,
            //                               fontWeight: FontWeight.w500),
            //                         ),
            //                         Text(
            //                           "Congratulations! Promo Discount \nof $discount% applied successfully.",
            //                           style: TextStyle(
            //                               fontSize: 10,
            //                               fontWeight: FontWeight.w400),
            //                         ),
            //                         Text(
            //                           "Terms & Conditions apply",
            //                           style: TextStyle(
            //                             fontSize: 10,
            //                             fontWeight: FontWeight.w400,
            //                             color: Colors.blue,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     Icon(
            //                       Icons.card_giftcard,
            //                       size: 23,
            //                       color: Colors.grey.shade600,
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}

upgradeContainer(double swidth, double sheight) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Upgrades Available", style: R23w600),
        kheight3,
        Text("Want luxury? Add luxury at minimum cost!",
            style: GoogleFonts.rajdhani(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic)),
        kheight20,
        Container(
          width: swidth * 0.55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: sheight * 0.052,
                width: swidth * 0.271,
                decoration: BoxDecoration(
                    color: Color.fromARGB(233, 42, 47, 142),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    border: Border.all(color: Colors.grey[700], width: 0.3)),
                child: Center(
                    child: Text(
                  "Flight Upgrade",
                  style: R23whi600,
                )),
              ),
              Container(
                height: sheight * 0.052,
                width: swidth * 0.271,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 163, 165, 245).withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    border: Border.all(color: Colors.grey[700], width: 0.1)),
                child: Center(
                    child: Text(
                  "Prime Seat(s)",
                  style: R23blu600,
                )),
              ),
            ],
          ),
        ),
        Container(
          height: sheight * 0.13,
          width: swidth * 0.55,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              border: Border.all(color: Colors.grey[700], width: 0.3)),
          child: Padding(
            padding: const EdgeInsets.only(
                right: 50.0, top: 20, bottom: 10, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Need to upgrade to business or first class? Please get in touch with our team on 1800 22 7979 for more details.",
                  style: R18w500,
                ),
              ],
            ),
          ),
        ),
        // kheight10,
      ]);
}

void _showBookDetails(BuildContext context, String discount,int  _holidayprice) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Apply Coupon',
          style: GoogleFonts.rajdhani(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Color.fromARGB(255, 4, 27, 101),
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Get a discount of ${discount} ',
                style: GoogleFonts.rajdhani(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 1, 7, 26),
                ),
              ),
              // SizedBox(height: 8),
              // Text('Author: F. Scott Fitzgerald'),
              // SizedBox(height: 8),
              // Text(
              //   'Description: A classic novel set in the Roaring Twenties. It tells the story of the mysterious and wealthy Jay Gatsby and his unrequited love for Daisy Buchanan.',
              // ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: GoogleFonts.rajdhani(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.blueAccent,
              ),
            ),
            onPressed: () {
              double discountedprice = reducePriceByPercentage(
                  double.parse(_holidayprice.toString()),
                  double.parse(discount.replaceAll("%", "")));
              _holidayprice = discountedprice.round();
              print("after :$_holidayprice");

              Navigator.of(context).pop();
              _showappliedDetails(
                context, _holidayprice
              );
            },
          ),
        ],
      );
    },
  );
}

void _showappliedDetails(
  BuildContext context,int _holidayprice
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Coupon Applied🎉',
          style: GoogleFonts.rajdhani(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Color.fromARGB(255, 4, 27, 101),
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'price changed to ₹${(_holidayprice)}',
                style: GoogleFonts.rajdhani(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 1, 7, 26),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: GoogleFonts.rajdhani(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.blueAccent,
              ),
            ),
            onPressed: () {
              // double discountedprice = reducePriceByPercentage(
              //     _holidayprice, double.parse(discount.replaceAll("%", "")));
              // _holidayprice = discountedprice;
              // print("after :$_holidayprice");

              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

double reducePriceByPercentage(
    double originalPrice, double discountPercentage) {
  double discountFactor = (100 - discountPercentage) / 100;
  return originalPrice * discountFactor;
}
