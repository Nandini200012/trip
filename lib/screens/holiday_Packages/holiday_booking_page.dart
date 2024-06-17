import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/login_variables/login_Variables.dart';
import 'package:trip/screens/holiday_Packages/widgets/bookingpage_widgets1.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import 'package:trip/screens/holiday_Packages/widgets/widgets_holiday.dart';
import '../../api_services/holiday_packages/get_coupons_api.dart';
import '../../api_services/holiday_packages/get_packages_byid_api.dart';
import '../../api_services/holiday_packages/get_reviews.dart';
import '../../api_services/holiday_packages/post_reviews.dart';
import '../../common/print_funtions.dart';
import '../../constants/fonts.dart';
import '../constant.dart';
import '../header.dart';

int _holidayprice;

class HolidayBookingPage extends StatefulWidget {
  String pid;

  HolidayBookingPage({this.pid});

  @override
  State<HolidayBookingPage> createState() => _HolidayBookingPageState();
}

Details packageDetails;
List<CouponCode> Couponcodes;
List<HolidayReviewData> reviewData;
// bool showContents = false;

class _HolidayBookingPageState extends State<HolidayBookingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPackageDetails(widget.pid);
    getCOupons();
    getHolidayreviews(widget.pid);
    // Future.delayed( Duration(seconds: 1), () {
    //   setState(() {
    //     showContents = true;
    //   });
    // });
  }

  getHolidayreviews(id) async {
    String res = await getHolidayreviewsAPI(id);
    if (res != 'failed') {
      HolidayReviews obj = HolidayReviews.fromJson(jsonDecode(res));
      List<HolidayReviewData> data = obj.data;
      setState(() {
        reviewData = data;
      });
    }
    printWhite("review:${reviewData.length}");
  }

  getCOupons() async {
    String res = await holidayoffersAPI();
    if (res != 'failes') {
      Holidaycoupon obj = Holidaycoupon.fromJson(jsonDecode(res));
      List<CouponCode> data = obj.couponCodes;
      setState(() {
        Couponcodes = data;
      });
    }
  }

  getPackageDetails(String pid) async {
    String res = await getHolidayPackagesdetailsAPI(pid);
    if (res != "failed") {
      HolidayPackagedetails obj =
          HolidayPackagedetails.fromJson(jsonDecode(res));
      List<Details> data = obj.packages;

      setState(() {
        packageDetails = data[0];
      });
    }
    printred("List length:${packageDetails.name}");
  }

  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: swidth < 600
          ? AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
              title: Text(
                'Tour',
                style: blackB15,
              ),
            )
          : CustomAppBar(),
      body: packageDetails == null ||
              Couponcodes.length == 0 ||
              reviewData.length == 0 
              
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  box1(swidth, sheight, packageDetails, reviewData,
                      _holidayprice,context),
                  box3(swidth, sheight, Couponcodes, packageDetails,
                      _holidayprice),
                 reviewCOntainer(swidth, sheight, reviewData, context,
                      packageDetails.pId, packageDetails.name)
                ],
              ),
            ),
    );
  }
}


// class ReviewContainer extends StatefulWidget {
//   final double swidth;
//   final double sheight;
//   final List<HolidayReviewData> reviewData;
//   final BuildContext context;
//   final String pid;
//   final String pname;

//   ReviewContainer(this.swidth, this.sheight, this.reviewData, this.context, this.pid, this.pname);

//   @override
//   _ReviewContainerState createState() => _ReviewContainerState();
// }

// class _ReviewContainerState extends State<ReviewContainer> {
//   ScrollController _scrollController = ScrollController();

//   void _scrollLeft() {
//     if (_scrollController.hasClients) {
//       final position = _scrollController.position;
//       final newOffset = (position.pixels - position.viewportDimension).clamp(0.0, position.maxScrollExtent);
//       _scrollController.animateTo(newOffset, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
//     }
//   }

//   void _scrollRight() {
//     if (_scrollController.hasClients) {
//       final position = _scrollController.position;
//       final newOffset = (position.pixels + position.viewportDimension).clamp(0.0, position.maxScrollExtent);
//       _scrollController.animateTo(newOffset, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.swidth,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Color.fromARGB(255, 4, 58, 159),
//             Color.fromARGB(255, 0, 38, 40),
//             Colors.black,
//           ],
//         ),
//       ),
//       child: Column(
//         children: [
//           SizedBox(height: 30),
//           Text(
//             "Tour reviews",
//             style: GoogleFonts.roboto(fontSize: 35, fontWeight: FontWeight.w600, color: Colors.white),
//           ),
//           Text(
//             "What are you waiting for? Chalo Bag Bharo Nikal Pado!",
//             style: GoogleFonts.roboto(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
//           ),
//           SizedBox(height: 30),
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 18.0),
//                 child: CircleAvatar(
//                   backgroundColor: Color.fromARGB(114, 255, 255, 255).withOpacity(0.1),
//                   radius: 25,
//                   child: Center(
//                     child: IconButton(
//                       icon: Icon(Icons.keyboard_arrow_left, size: 35),
//                       onPressed: _scrollLeft,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: widget.swidth * 0.1),
//               Expanded(
//                 child: Container(
//                   color: Colors.transparent,
//                   child: ListView.builder(
//                     controller: _scrollController,
//                     scrollDirection: Axis.horizontal,
//                     shrinkWrap: true,
//                     itemCount: widget.reviewData.length,
//                     itemBuilder: (context, index) {
//                       HolidayReviewData review = widget.reviewData[index];
//                       return Padding(
//                         padding: const EdgeInsets.all(18.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Reviewcontent(
//                             widget.swidth,
//                             widget.sheight,
//                             review.packageName,
//                             review.review,
//                             review.username,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 18.0),
//                 child: CircleAvatar(
//                   backgroundColor: Color.fromARGB(114, 255, 255, 255).withOpacity(0.1),
//                   radius: 25,
//                   child: Center(
//                     child: IconButton(
//                       icon: Icon(Icons.keyboard_arrow_right, size: 35),
//                       onPressed: _scrollRight,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           GestureDetector(
//             onTap: () {
//               showReviewform(widget.context, widget.pid, widget.pname);
//             },
//             child: Container(
//               width: 170,
//               height: 50,
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Color.fromARGB(255, 24, 111, 183),
//                     Color.fromARGB(255, 9, 46, 157),
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.withOpacity(0.2),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Center(
//                 child: Text(
//                   "Write a review",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
reviewCOntainer(swidth, sheight, List<HolidayReviewData> reviewData,
    BuildContext context, pid, pname) {
  return Container(
    width: swidth,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 4, 58, 159),
          Color.fromARGB(255, 0, 38, 40),
          Colors.black
        ],
      ),
    ),
    child: Column(
      children: [
        kheight30,
        Text(
          "Tour reviews",
          style: R35whi600,
        ),
        Text(
          "What are you waiting for? Chalo Bag Bharo Nikal Pado!",
          style: R23whi600,
        ),
        kheight30,
        Row(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 18.0),
            //   child: CircleAvatar(
            //     backgroundColor:
            //         Color.fromARGB(114, 255, 255, 255).withOpacity(0.1),
            //     radius: 25,
            //     child: Center(
            //         child: Icon(
            //       Icons.keyboard_arrow_left,
            //       size: 35,
            //     )),
            //   ),
            // ),
            SizedBox(
              width: swidth * 0.1,
            ),
            Container(
              // height: sheight * 0.45,
              width: swidth * 0.7,
              color: Colors.transparent,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 30.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 3 / 1.5),
                  itemCount: reviewData.length ?? 0,
                  itemBuilder: (context, index) {
                    HolidayReviewData review = reviewData[index];
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                          // height: sheight * 0.35,
                          width: swidth * 0.05,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Reviewcontent(
                              swidth,
                              sheight,
                              review.packageName,
                              review.review,
                              review.username)),
                    );
                  }),
            ),
            // Spacer(),
            // Padding(
            //   padding: const EdgeInsets.only(right: 18.0),
            //   child: CircleAvatar(
            //     backgroundColor:
            //         Color.fromARGB(114, 255, 255, 255).withOpacity(0.1),
            //     radius: 25,
            //     child: Center(
            //         child: Icon(
            //       Icons.keyboard_arrow_right,
            //       size: 35,
            //     )),
            //   ),
            // ),
          ],
        ),
        kheight20,
        GestureDetector(
          onTap: () {
            showReviewform(context, pid, pname);
          },
          child: Container(
            width: 170,
            height: 50,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 24, 111, 183),
                    Color.fromARGB(255, 9, 46, 157)
                  ]),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                "Write a review",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        kheight30,
      ],
    ),
  );
}

showReviewform(BuildContext context, pid, pname) {
  TextEditingController holidaynameController = TextEditingController();
  TextEditingController holidayemailController = TextEditingController();
  TextEditingController holidayreviewController = TextEditingController();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text('Title'),
        content: Container(
          width: 700,
          height: 190,
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: holidaynameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: GoogleFonts.rajdhani(
                              fontSize: 15,
                              fontWeight:
                                  FontWeight.w500), // Change label color
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Change border color
                          ),
                        ),
                        style:
                            TextStyle(color: Colors.black), // Change text color
                      ),
                    ),
                    SizedBox(width: 10), // Use width instead of height
                    Expanded(
                      child: TextField(
                        controller: holidayemailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: GoogleFonts.rajdhani(
                              fontSize: 15,
                              fontWeight:
                                  FontWeight.w500), // Change label color
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Change border color
                          ),
                        ),
                        style:
                            TextStyle(color: Colors.black), // Change text color
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Expanded(
                    child: TextField(
                      controller: holidayreviewController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Review',
                        labelStyle: GoogleFonts.rajdhani(
                            fontSize: 15,
                            fontWeight: FontWeight.w500), // Change label color
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey), // Change border color
                        ),
                      ),
                      style:
                          TextStyle(color: Colors.black), // Change text color
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 85, // Set width
                height: 40, // Set height
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(12)
                // ),
                child: ElevatedButton(
                  onPressed: () {
                    postcommentApi(
                      holidayreviewController.text,
                      pid,
                      holidaynameController.text,
                      pname,
                      holidayemailController.text,
                    );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Set border radius
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: GoogleFonts.rajdhani(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Reviewcontent(swidth, sheight, String location, String review, String name) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          kheight20,
          Text(
            location ?? "USA East Coast",
            style: rajdhani15W6,
          ),
          kheight10,
          Text(
            review ??
                "We travelled East Coast US with Veena World. \nIt was so great great experience. \nOur tour leader Mr Dinesh Bandivdekar such a nice person.",
            style: rajdhani15W500,
          ),
          kheight20,
          Text(
            name ?? "Rita \nTravelled in Apr, 2024",
            style: rajdhani15W500,
            // rajdhani12,
          ),
          kheight10,
        ],
      ),
    ),
  );
}
