import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip/constants/fonts.dart';
import 'package:trip/screens/bus/models/usermodel.dart';
import 'package:trip/screens/holiday_Packages/holiday_booking_page.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api_services/holiday_packages/get_packages_byid_api.dart';
import '../../../api_services/holiday_packages/get_reviews.dart';
import '../../../login_variables/login_Variables.dart';

box1(
    double swidth,
    double sheight,
    Details packageDetails,
    List<HolidayReviewData> reviewdata,
    int _holidayprice,
    BuildContext context) {
  return Container(
    color: Colors.white,
    width: swidth,
    height: sheight - 150,
    child: Container(
      margin: EdgeInsets.only(top: 50, bottom: 30, left: 120, right: 30),
      width: swidth * 0.7,
      color: Color.fromARGB(0, 25, 83, 131),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kheight10,
              kheight5,
              Text(packageDetails.name ?? " USA East Coast", style: R23Bold),
              kheight5,
              Text(
                packageDetails.description ??
                    "Home > World > America > USA East Coast",
                style: rajdhani15W5,
              ),
              kheight10,
              SizedBox(
                width: swidth * 0.6,
                height: sheight * 0.565,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      packageDetails.photoVideo ??
                          "https://wallpaperaccess.com/full/52907.jpg",
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                    )),
              )
            ],
          ),
          Pricebox(swidth, sheight, packageDetails, _holidayprice, context)
        ],
      ),
    ),
  );
}

Pricebox(swidth, sheight, Details packageDetails, _holidayprice,
    BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 30),
    child: Container(
      color: Colors.white,
      height: 720,
      width: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Pricebox1(swidth, sheight, packageDetails, _holidayprice, context),
          kheight20,
          // kheight10,
          // if (reviewData.length != 0)
            // Container(
            //   // height: 200,
            //   width: 370,
            //   color: Colors.grey.shade200,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(
            //             left: 8, right: 8, top: 8, bottom: 3),
            //         child: Row(
            //           children: [
            //             Icon(
            //               Icons.star,
            //               size: 18,
            //               color: Colors.deepOrangeAccent,
            //             ),
            //             kwidth5,
            //             Text(
            //               "5",
            //               style: rajdhani13W5,
            //             ),
            //             SizedBox(
            //               width: 20,
            //             ),
            //             Text(
            //               "2,885 Guests already travelled",
            //               style: rajdhani13W5,
            //             )
            //           ],
            //         ),
            //       ),
            //       Divider(),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 8.0, right: 8),
            //         child: Text(
            //           reviewData[0].review ??
            //               "We travelled East Coast US with Veena World. It was so great great experience. Our tour \nleader Mr Dinesh Bandivdekar such a nice person. \nHe is a caring,",
            //           style: rajdhani13W5,
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Row(
            //           children: [
            //             kwidth5,
            //             Text(
            //               reviewData[0].username ??
            //                   "Deepak \nTravelled Jul 21, 2023",
            //               style: rajdhani13W5,
            //             ),
            //             Spacer(),
            //           ],
            //         ),
            //       ),
            //       kheight5
            //     ],
            //   ),
            // ),
          kheight20,
          Text(
            "Tour Includes",
            style: rajdhani15W6,
          ),
          kheight20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconColumn("HOTEL-1.jpg", "Hotel"),
              IconColumn("MEALS-2.jpg", "Meals"),
              IconColumn("TRANSPORT-3.jpg", "Transport"),
              IconColumn("FLIGHT-4.jpg", "Flight"),
              IconColumn("SIGHTSEEING-5.jpg", "Sight seeing"),
              // IconColumn(Icons.hotel_outlined, "Visa"),
            ],
          ),
          kheight10,
          Container(
            width: swidth * 0.253,
            height: 15,
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                "*Except for joining/leaving, To & fro economy class air is included for all departure city.",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          kheight20,

          Text(
            "Why travel with Us",
            style: rajdhani15W6,
          ),
          kheight10,
          IconRow("Expert tour manager all throughout the tour."),
          kheight10,
          IconRow("All meals included in tour price."),
          kheight10,
          IconRow("Music, fun and games everyday."),
        ],
      ),
    ),
  );
}

IconRow(String txt) {
  return Row(
    children: [
      CircleAvatar(
        radius: 10,
        backgroundColor: Color.fromARGB(255, 255, 253, 253),
        child: Center(
          child: Image.asset(
            'images/holiday/VISA-6.jpg',
            filterQuality: FilterQuality.high,
            fit: BoxFit.contain,
          ),
        ),
      ),
      kwidth10,
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(
          txt,
          style: rajdhani15W5,
        ),
      ),
    ],
  );
}

IconColumn(String icon, String txt) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey.shade200,
        child: Image.asset(
          'images/holiday/$icon',
          filterQuality: FilterQuality.high,
          fit: BoxFit.contain,
        ),
      ),
      kheight10,
      Text(
        txt,
        style: rajdhani13W5,
      ),
    ],
  );
}

Pricebox1(swidth, sheight, Details packageDetails, int _holidayprice,
    BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          Text(
            'SUPER DEAL PRICE',
            style: RGreen15W6,
          ),
          kheight3,
          Row(
            children: [
              Text(
                'Starts From',
                style: rajdhani15W5,
              ),
              kwidth5,
              Text(
                _holidayprice != null
                    ? formatNumberWithCommas(_holidayprice)
                    : (formatNumberWithCommas(
                            int.parse(packageDetails.packagePrice)) ??
                        '₹2,90,000'),
                style: R23Bold,
              ),
            ],
          ),
          // kheight2,
          Text(
            'per person on twin sharing',
            style: rajdhanii12,
          ),
        ],
      ),
      // kwidth10,
      kheight5,
      Column(
        children: [
          GestureDetector(
            onTap: () {
              print("uid:$user_id");
              if (user_id != null && user_id.isNotEmpty) {
                // print("uid:yes  $user_id");
                Uri _uri = Uri.parse(
                    'http://gotodestination.in/api/payment_api/payment/payment_api/NON_SEAMLESS_KIT/ccavRequestHandler.php?block_key=null&booking_id=null&rpax_pricing=false&package_details=${packageDetails.name}&package_id=${packageDetails.pId}&user_id=${user_id}&order_id=${packageDetails.pId}&amount=1&customer_id=${user_id}&user_type=holiday&billing_name=${user_name}&billing_address=kerala&billing_city=palakkad&billing_tel=9526751850&billing_email=nandhininatarajan04@gmail.com');

                launchUrl(_uri);
              } else {
                // print("uid:no  $user_id");
                _showLoginAlert(context);
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, bottom: 10),
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade800],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Book Now",
                  style: rWhiteB18,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

String formatNumberWithCommas(int number) {
  final formatter = NumberFormat("#,###");

  return formatter.format(number);
}

IconText(IconData icon, String txt) {
  return Container(
    child: Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: Color.fromARGB(255, 76, 76, 76),
        ),
        kwidth5,
        Text(
          txt,
          style: rajdhani15W5,
        )
      ],
    ),
  );
}

void _showLoginAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Please Log In"),
        content: Text("You need to be logged in to proceed with the payment."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
