import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/api_services/activity/save_review.dart';
import 'package:trip/common/print_funtions.dart';
import 'package:trip/constants/fonts.dart';
import 'package:trip/login_variables/login_Variables.dart';
import 'package:trip/screens/activities/activities.dart';
import 'package:trip/screens/footer.dart';
import 'package:trip/screens/header.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api_services/activity/get_activity_details.dart';
import '../../api_services/activity/show_reviewapi.dart';
import '../../api_services/coupons/activity_coupon_api.dart';
import '../Drawer.dart';

int selectedpackage = 0;
int packagePrice = 0;

class ActivitiesBookingScreen extends StatefulWidget {
  String id;
  ActivitiesBookingScreen({key, this.id});

  @override
  State<ActivitiesBookingScreen> createState() =>
      _ActivitiesBookingScreenState();
}

List<ReviewData> reviews = [];

List<String> imageUrls = [];

TextEditingController reviewNameController = TextEditingController();
TextEditingController reviewemailcontroller = TextEditingController();
TextEditingController review_controller = TextEditingController();
int ratings = 0;
bool expand = false;
int selectedIndexpackage;
List<int> selectedIndexes = [];
bool isLoading = true; // Track loading state
Timer _timer; // Timer to control loading duration

class _ActivitiesBookingScreenState extends State<ActivitiesBookingScreen> {
  @override
  void initState() {
    super.initState();
    reviewNameController.clear();
    reviewemailcontroller.clear();
    review_controller.clear();
    isLoading = true;
    selectedIndexes.clear();
    getActivitiesAPI(widget.id);
    reviewapi(widget.id);
    couponApplied(null, selectedIndexes, packagelist);
    selectedIndexpackage = 0;
    selectedIndexes.add(selectedIndexpackage);
    _timer = Timer(Duration(seconds: 5), () {
      // After 2 seconds, change isLoading to false
      setState(() {
        isLoading = false;
      });
    });
    coupons();
  }

  @override
  void dispose() {
    // Dispose the timer to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  File _image;
  int d_total = null;
  String jsondetails;
  List<Datum> _activityData;
  String package_id = "";
  List<PackageOption> packagelist;
  Datum activity;
  bool isformvisible = false;
  getActivitiesAPI(id) async {
    try {
      activityobj obj = await getActivitiesdetailsAPI(id);

      jsondetails = jsonEncode(obj);
      print('Activity Name: ${obj.data[0].packageName}');
      setState(() {
        _activityData = obj.data;

        activity = _activityData[0];
        {
          imageUrls = [
            activity.image1,
            activity.image2,
            activity.image3,
            activity.image4,
          ];
        }
        packagelist = obj.packageOption;
      });
    } catch (e) {
      print('Error fetching activity details: $e');
    }
  }

  reviewapi(id) async {
    String res = await getreviewAPI(id);
    if (res != 'failed') {
      reviewobj obj = reviewobj.fromJson(jsonDecode(res));
      setState(() {
        reviews = obj.data;
        print("reviews:${reviews.length}");
      });
    }
  }

  List<ActivityCouponCode> activityCoupons = [];
  coupons() async {
    String res = await getActivityCouponsAPI();
    Activitycoupons obj = Activitycoupons.fromJson(jsonDecode(res));
    List<ActivityCouponCode> coupons = obj.couponCodes;
    print("coupon_res $coupons");
    setState(() {
      activityCoupons = coupons;
    });
  }

  // Function to calculate discounted total price based on discount percentage
// Function to calculate discounted total price based on discount percentage
  int couponApplied(
      [String discountPercentageStr,
      List<int> selectedIndexes,
      List<PackageOption> packageList]) {
    int total =
        totalPrice(selectedIndexes, packageList); // Calculate total price
    int discountPercentage = total;
    if (discountPercentageStr != null && discountPercentageStr.isNotEmpty) {
      try {
        // Remove any non-numeric characters (like %) and parse the integer
        int discountPercentage =
            int.parse(discountPercentageStr.replaceAll('%', ''));

        double discountAmount =
            (discountPercentage / 100.0) * total; // Calculate discount amount
        int discountedTotal = (total - discountAmount)
            .round(); // Apply discount to total and round off
        setState(() {
          d_total = discountPercentage;
        });
        return discountedTotal;
      } catch (e) {
        setState(() {
          d_total = discountPercentage;
        });
        print('Error parsing discount percentage: $e');
        // Handle parsing error, fallback to total without discount
        return discountPercentage;
      }
    } else {
      setState(() {
        d_total = discountPercentage;
      });
      return discountPercentage; // Return total price without discount if discountPercentage is null or empty
    }
  }

// Function to calculate total price based on selected indexes and package list
// int totalPrice(List<int> selectedIndexes, List<PackageOption> packageList) {
//   int total = 0;
//   for (int index in selectedIndexes) {
//     if (index >= 0 && index < packageList.length) {
//       total += packageList[index].price; // Assuming PackageOption has a price property
//     }
//   }
//   return total;
// }

// Function to calculate total price based on selected indexes and package list
// int totalPrice(List<int> selectedIndexes, List<Package> packageList) {
//   int total = 0;
//   for (int index in selectedIndexes) {
//     if (index >= 0 && index < packageList.length) {
//       total += packageList[index].price; // Assuming Package has a price property
//     }
//   }
//   return total;
// }
  int totalPrice(List<int> selectedIndexes, List<PackageOption> packagelist) {
    int total = 0;
    for (var i in selectedIndexes) {
      total += int.parse(packagelist[i].price);
    }
    print("total: $total");
    return total;
  }

  List<bool> isStarSelected = List.generate(5, (_) => false);

  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 160, 207, 246),
      appBar: sWidth < 600
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 40),
              backgroundColor: Color.fromARGB(255, 1, 21, 101),
              title: Text(
                "Activities",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            )
          : CustomAppBar(),
      drawer: sWidth < 600 ? drawer() : null,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                width: sWidth,
                // height: sHeight,
                color: Color.fromARGB(255, 220, 238, 254),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    child: activity == null && isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                SizedBox(
                                  height: sHeight * 0.05,
                                ),

                                ImageContainer(sWidth, sHeight),
                                SizedBox(
                                  height: sHeight * 0.05,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 80, left: 280),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container1(sWidth, sHeight),
                                      kwidth30,
                                      kwidth10,
                                      kwidth10,
                                      Container(
                                        height: sHeight * 0.15,
                                        width: sWidth * 0.15,
                                        decoration: BoxDecoration(
                                            // color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Card(
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Total Price",
                                                  style: GoogleFonts.rajdhani(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15,
                                                    // color: Colors.blue
                                                  ),
                                                ),
                                                // totalPrice(selectedIndexes, packagelist)
                                                // "INR ${couponApplied(null, selectedIndexes, packageList).toString()}",
                                                // (d_total != null ||
                                                //         d_total != 0)
                                                //     ? Text(
                                                //         "INR ${d_total.toString() ?? 0}",
                                                //         style: GoogleFonts
                                                //             .rajdhani(
                                                //                 fontWeight:
                                                //                     FontWeight
                                                //                         .w700,
                                                //                 fontSize: 30,
                                                //                 color: Colors
                                                //                     .blue),
                                                //       )
                                                Text(
                                                  "INR ${totalPrice(selectedIndexes, packagelist) ?? 0}",
                                                  style: GoogleFonts.rajdhani(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 30,
                                                      color: Colors.blue),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 280),
                                  child: ContainerThree(sWidth, sHeight),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 280),
                                  child: ContainerFOurth(sWidth, sHeight),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 80, left: 280),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      COntaFifth(sWidth, sHeight, setState),
                                      kwidth10,
                                      kwidth10,
                                      kwidth30,
                                      Container(
                                        width: sWidth * 0.2,
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(0, 187, 27, 27),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: _buildpromocodes(
                                          sWidth,
                                          sHeight,
                                          activityCoupons,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 42),
                                    child: reviewContainer(
                                        sWidth, sHeight, widget.id)),
                                Showreviews(sWidth, sHeight),
                                Padding(
                                    padding:
                                        const EdgeInsets.only(top: 0, right: 2),
                                    child: showReviews(sWidth, sHeight)
                                    //  Showreviews(sWidth, sHeight),
                                    ),
                                // Showreviews(sWidth, sHeight),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 42),
                                  child: policyContainer(sWidth, sHeight),
                                ),
                                SizedBox(
                                  height: sHeight * .05,
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      Uri _uri = Uri.parse(
                                          'http://gotodestination.in/api/payment_api/payment/payment_api/NON_SEAMLESS_KIT/ccavRequestHandler.php?block_key=null&booking_id=null&rpax_pricing=falsepackage_details=${activitydata[0].packageName}&package_id=${packagelist[0].packageId}&user_id=${user_id}&order_id=${widget.id}&amount=1&customer_id=${user_id}&user_type=Activities&billing_name=${user_name}&billing_address=kerala&billing_city=palakkad&billing_tel=9526751850&billing_email=nandhininatarajan04@gmail.com');

                                      launchUrl(_uri);
                                    },
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Container(
                                        height: sHeight * .058,
                                        width: sWidth * 0.13,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF0D47A1),
                                              Color(0xFF42A5F5)
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                      255, 177, 182, 186)
                                                  .withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Center(
                                          child: Text(
                                            'Book Now',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: sHeight * .1,
                                ),
                               
                              ])),
              ),
            ),
    );
  }

  Widget reviewContainer(double sWidth, double sHeight, String pid) {
    return Container(
      color: Colors.white,
      width: sWidth * .656,
      // height: sHeight * 0.2,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              orangeline(),
              SizedBox(
                width: 20,
              ),
              Text("Write your review", style: rajdhani20W7),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: sWidth * 0.31,
                child: TextFormField(
                  controller: reviewNameController,
                  decoration: InputDecoration(
                      hintText: 'Enter your Name',
                      border: OutlineInputBorder(),
                      hintStyle: rajdhani12),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                  maxLines: null, // Allow multiline input
                ),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: sWidth * 0.31,
                child: TextFormField(
                  controller: reviewemailcontroller,
                  decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      border: OutlineInputBorder(),
                      hintStyle: rajdhani12),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your Email';
                    }
                    return null;
                  },
                  maxLines: null, // Allow multiline input
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: sWidth * 0.63,
                child: TextFormField(
                  controller: review_controller,
                  decoration: InputDecoration(
                      hintText: 'Enter your review',
                      border: OutlineInputBorder(),
                      hintStyle: rajdhani12),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your review';
                    }
                    return null;
                  },
                  maxLines: null, // Allow multiline input
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: SizedBox(
              height: 30,
              width: 80,
              child: ElevatedButton(
                onPressed: () {
                  if (reviewNameController.text.isNotEmpty &&
                      reviewemailcontroller.text.isNotEmpty &&
                      review_controller.text.isNotEmpty) {
                    _savereview(
                        reviewNameController.text,
                        reviewemailcontroller.text,
                        review_controller.text,
                        pid);
                  } else {
                    print("null");
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: rWhiteB15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  Widget policyContainer(sWidth, sHeight) {
    return Container(
      width: sWidth * .656,
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                orangeline(),
                SizedBox(
                  width: 20,
                ),
                Text("${activity.packageName}Policies", style: rajdhani20W7),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 20, 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: sWidth * .3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text("Confirmation Policy",
                                  style: rajdhani15W6),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle_outlined,
                                  size: 15,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: sWidth * 0.23,
                                  // height: sHeight * 0.09,
                                  child: Text(
                                    activity.confirmationPolicy,
                                    style: rajdhani15W5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 1.2,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: sWidth * .3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text("Cancellation Policy",
                                  style: rajdhani15W6),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle_outlined,
                                  size: 15,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: sWidth * 0.23,
                                  // height: sHeight * 0.09,
                                  child: Text(activity.cancellationPolicy,
                                      style: rajdhani15W5),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildpromocodes(
    screenWidth,
    screenHeight,
    List<ActivityCouponCode> CouponCodes,
  ) {
    return Visibility(
      visible: CouponCodes != null ? true : false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 3,
                  blurRadius: 2,
                  offset: Offset(0, 1),
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
                      "Activity Coupons",
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
                    final String discount = CouponCodes[index].discount;
                    return GestureDetector(
                      onTap: () {
                        alertbox(
                          "Apply Coupon",
                          "Do you want to apply the coupon code $code?",
                          discount,
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
                                backgroundColor:
                                    Color.fromARGB(255, 107, 107, 107),
                                child: CircleAvatar(
                                  radius: 9,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    code.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Congratulations! You have a Promo \nDiscount of $discount ",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
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
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  alertbox(String title, String subtitle, String discount) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("ok"),
              onPressed: () {
                couponApplied(discount, selectedIndexes, packagelist);
                // Add your apply coupon logic here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  alertbox1(
    String title,
    String subtitle,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("ok"),
              onPressed: () {
                // couponApplied(discount, selectedIndexes, packagelist);
                // Add your apply coupon logic here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget COntaFifth(double sWidth, double sHeight, StateSetter setState) {
    return Container(
      // color: Colors.white,
      width: sWidth * .45,
      child: Card(
        elevation: 5.0,
        child: Column(children: [
          SizedBox(height: 10),
          Row(
            children: [
              orangeline(),
              SizedBox(width: 20),
              Text("Select Package", style: rajdhani20W7),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 8),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: packagelist.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 100, right: 100),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedIndexes.contains(index)) {
                          if (selectedIndexes.length > 1) {
                            selectedIndexes.remove(index);
                          } else {
                            alertbox1("Error", "Select at least one package");
                            return;
                          }
                        } else {
                          selectedIndexes.add(index);
                        }
                        for (var i in selectedIndexes) {
                          print("Price: ${packagelist[i].price}");
                        }
                        totalPrice(selectedIndexes, packagelist);
                      });
                    },
                    child: Container(
                      height: sHeight * 0.1,
                      // width: sWidth * .2,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        gradient: selectedIndexes.contains(index)
                            ? LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 75, 121, 180),
                                  Colors.blueAccent[700]
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                        color: selectedIndexes.contains(index)
                            ? null
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // color: selectedIndexes.contains(index)
                      //     ? Colors.blueAccent
                      //     : Colors.white,
                      // borderRadius: BorderRadius.circular(12),
                      // ),
                      child: Row(children: [
                        SizedBox(width: 50),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              packagelist[index].description,
                              style: GoogleFonts.rajdhani(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: selectedIndexes.contains(index)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 13,
                                  color: selectedIndexes.contains(index)
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  packagelist[index].timeDuration,
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndexes.contains(index)
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "AgePolicy:  ",
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndexes.contains(index)
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                                Text(
                                  packagelist[index].agePolicy,
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndexes.contains(index)
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Description:  ",
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndexes.contains(index)
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                                Text(
                                  packagelist[index].description,
                                  style: GoogleFonts.rajdhani(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndexes.contains(index)
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "INR ${packagelist[index].price}",
                              style: GoogleFonts.rajdhani(
                                color: selectedIndexes.contains(index)
                                    ? Colors.white
                                    : Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "Per adult",
                              style: GoogleFonts.rajdhani(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: selectedIndexes.contains(index)
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 50),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
        ]),
      ),
    );
  }
  // Widget COntaFifth(sWidth, sHeight) {
  //   return Container(
  //     color: Colors.white,
  //     width: sWidth * .45,
  //     // height: sHeight * 0.15,
  //     child: Column(children: [
  //       SizedBox(
  //         height: 10,
  //       ),
  //       Row(
  //         children: [
  //           orangeline(),
  //           SizedBox(
  //             width: 20,
  //           ),
  //           Text("Select Package", style: rajdhani20W7),
  //         ],
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 8),
  //         child: ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: packagelist.length ?? 0,
  //           itemBuilder: (context, index) => Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Padding(
  //               padding: const EdgeInsets.only(
  //                   top: 8, bottom: 8, left: 120, right: 120),
  //               child: GestureDetector(
  //                 onTap: () {
  //                   print(index);

  //                   setState(() {
  //                     selectedIndexpackage = index;
  //                   });
  //                   selectedpackage = index;
  //                 },
  //                 child: Container(
  //                   height: sHeight * 0.1,
  //                   width: sWidth * .2,
  //                   decoration: BoxDecoration(
  //                       border: Border.all(width: 1.0, color: Colors.grey),
  //                       color: index == selectedIndexpackage
  //                           ? Colors.blueAccent
  //                           : Colors.white,
  //                       borderRadius: BorderRadius.circular(12)),
  //                   child: Row(children: [
  //                     SizedBox(
  //                       width: 50,
  //                     ),
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Text(packagelist[index].description,
  //                             style: GoogleFonts.rajdhani(
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.w700,
  //                               color: index == selectedIndexpackage
  //                                   ? Colors.white
  //                                   : Colors.black,
  //                             )),
  //                         SizedBox(
  //                           height: 5,
  //                         ),
  //                         Row(
  //                           children: [
  //                             Icon(
  //                               Icons.timer,
  //                               size: 13,
  //                               color: index == selectedIndexpackage
  //                                   ? Colors.white
  //                                   : Colors.grey,
  //                             ),
  //                             SizedBox(
  //                               width: 5,
  //                             ),
  //                             Text(packagelist[index].timeDuration,
  //                                 style: GoogleFonts.rajdhani(
  //                                   fontSize: 13,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: index == selectedIndexpackage
  //                                       ? Colors.white
  //                                       : Colors.grey,
  //                                 ))
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       width: 15,
  //                     ),
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Text("AgePolicy:  ",
  //                                 style: GoogleFonts.rajdhani(
  //                                   fontSize: 13,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: index == selectedIndexpackage
  //                                       ? Colors.white
  //                                       : Colors.grey,
  //                                 )),
  //                             Text(packagelist[index].agePolicy,
  //                                 style: GoogleFonts.rajdhani(
  //                                   fontSize: 13,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: index == selectedIndexpackage
  //                                       ? Colors.white
  //                                       : Colors.grey,
  //                                 )),
  //                           ],
  //                         ),
  //                         Row(
  //                           children: [
  //                             Text("Description:  ",
  //                                 style: GoogleFonts.rajdhani(
  //                                   fontSize: 13,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: index == selectedIndexpackage
  //                                       ? Colors.white
  //                                       : Colors.grey,
  //                                 )),
  //                             Text(packagelist[index].description,
  //                                 style: GoogleFonts.rajdhani(
  //                                   fontSize: 13,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: index == selectedIndexpackage
  //                                       ? Colors.white
  //                                       : Colors.grey,
  //                                 )),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     Spacer(),
  //                     // SizedBox(width: 25,),
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         SizedBox(
  //                           height: 0,
  //                         ),
  //                         Text(
  //                           "INR ${packagelist[index].price}",
  //                           style: GoogleFonts.rajdhani(
  //                               color: index == selectedIndexpackage
  //                                   ? Colors.white
  //                                   : Colors.blue,
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                         SizedBox(
  //                           height: 3,
  //                         ),
  //                         Text("Per adult",
  //                             style: GoogleFonts.rajdhani(
  //                               fontSize: 13,
  //                               fontWeight: FontWeight.bold,
  //                               color: index == selectedIndexpackage
  //                                   ? Colors.white
  //                                   : Colors.grey,
  //                             ))
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       width: 50,
  //                     ),
  //                   ]),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 5,
  //       )
  //     ]),
  //   );
  // }

  Widget orangeline() {
    return Container(
      width: 3.2,
      height: 45,
      color: Colors.blue,
    );
  }

  Widget ContainerFOurth(sWidth, sHeight) {
    return Container(
      // color: Colors.white,
      width: sWidth * .45,
      // height: sHeight * 0.15,
      child: Card(
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                orangeline(),
                SizedBox(
                  width: 20,
                ),
                Text("About the Activity", style: rajdhani20W7)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(activity.packageDesc, style: rajdhani15W5),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget showreviews(sWidth, sHeight) {
    return Container(
      width: sWidth * .45,
      height: sHeight * 0.15,
      color: Colors.white,
    );
  }

  Widget ContainerThree(sWidth, sHeight) {
    return Container(
      // color: Colors.white,
      width: sWidth * .45,
      // height: sHeight * 0.15,
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            // orangeline(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                orangeline(),
                SizedBox(
                  width: 20,
                ),
                Text("Highlights", style: rajdhani20W7)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            highlights('Age Limit:', activity.ageLimit),
            SizedBox(
              height: 10,
            ),
            highlights('Allowed Weight (kg) :', activity.permissionWeight),
            SizedBox(
              height: 10,
            ),
            highlights('Start Time:', activity.startTime),
            SizedBox(
              height: 10,
            ),
            highlights('End Time:', activity.endTime),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget highlights(String title, String subtitle) {
    return Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Icon(
          Icons.circle_outlined,
          size: 15,
          color: Colors.blue,
        ),
        SizedBox(
          width: 10,
        ),
        Text(title, style: rajdhani15W6),
        SizedBox(
          width: 5,
        ),
        Text(subtitle, style: rajdhani15W500)
      ],
    );
  }

  Widget Container_two(sWidth, sHeight) {
    return Container(
      color: Colors.white,
      width: sWidth * .45,
      height: sHeight * 0.15,
      child: Row(
        children: [
          orangeline(),
          SizedBox(
            width: 150,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mobile_screen_share,
                size: 35,
                color: Colors.deepOrangeAccent,
              ),
              Text(
                "Mobile voucher",
                style: GoogleFonts.notoSans(
                    fontSize: 15, fontWeight: FontWeight.w300),
              )
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mobile_screen_share,
                size: 35,
                color: Colors.deepOrangeAccent,
              ),
              Text(
                "Guide",
                style: GoogleFonts.notoSans(
                    fontSize: 15, fontWeight: FontWeight.w300),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget PriceCOntainer(sWidth, sHeight) {
    return Container(
      width: sWidth * .15,
      height: sHeight * 0.15,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Starting from", style: rajdhani15W5),
          SizedBox(
            height: 5,
          ),
          Text(
            "INR 1,599",
            style: GoogleFonts.rajdhani(
                color: Colors.deepOrange,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 5,
          ),
          Text("Per adult", style: rajdhani15W5),
        ],
      ),
    );
  }

  Widget Container1(sWidth, sHeight) {
    return Container(
        width: sWidth * .45,
        height: sHeight * 0.15,
        // color: Colors.white,
        child: Card(
          elevation: 5.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  orangeline(),
                  SizedBox(
                    width: 20,
                  ),
                  Text(activity.packageName, style: rajdhani20W7)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 16, 155, 9),
                        borderRadius: BorderRadius.circular(12)),
                    height: 35,
                    width: 60,
                    child: Center(
                      child: Text("4.7/5", style: rajdhani15Whi6),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.place,
                    size: 20,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    activity.location,
                    style: GoogleFonts.rajdhani(
                        color: Colors.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
        ));
  }

// Widget ImageContainer(double sWidth, double sHeight, ) {
//   return Container(
//     height: sHeight * 0.6,
//     width: sWidth,
//     child: Row(
//       children: [
//         Container(
//           height: sHeight * 0.6,
//           width: sWidth * 0.6,
//           child: buildNetworkImage(activity.image1,
//               'https://media1.thrillophilia.com/filestore/6trqgqb2cft5jrmugtyj95fseq2z_202A8972.jpg?w=auto&h=600'),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 1.5),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   buildNetworkImage(activity.image2,
//                       'https://media1.thrillophilia.com/filestore/mz2tox5p8xi8shf1agkn8wv0aymt_202A9023.jpg?w=auto&h=600'),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 7),
//                     child: buildNetworkImage(activity.image3,
//                         'https://media1.thrillophilia.com/filestore/fg2etmwykacc6dlsnakh9b1qla41_7e5baf004deab35b0bf0c9fdcaf329d5.webp?w=auto&h=600'),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 2, top: 7),
//                 child: Row(
//                   children: [
//                     buildNetworkImage(activity.image4,
//                         'https://media1.thrillophilia.com/filestore/mz2tox5p8xi8shf1agkn8wv0aymt_202A9023.jpg?w=auto&h=600'),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 7),
//                       child: buildNetworkImage(activity.image1,
//                           'https://media1.thrillophilia.com/filestore/fg2etmwykacc6dlsnakh9b1qla41_7e5baf004deab35b0bf0c9fdcaf329d5.webp?w=auto&h=600'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }

// Widget buildNetworkImage(String imageUrl, String fallbackUrl) {
//   return Container(
//     width: 100,
//     height: 100,
//     child: imageUrl != null
//         ? Image.network(
//             imageUrl,
//             fit: BoxFit.cover,
//             filterQuality: FilterQuality.high,
//             errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
//               return Center(
//                 child: Text('Failed to load image'),
//               );
//             },
//           )
//         : Center(
//             child: CircularProgressIndicator(), // Show circular progress indicator if imageUrl is null
//           ),
//   );
// }
  ImageContainer(sWidth, sHeight) {
    return Container(
      height: sHeight * 0.6,
      width: sWidth,
      // color: Color.fromARGB(255, 220, 238, 254),
      child: Row(
        children: [
          Container(
            height: sHeight * 0.6,
            width: sWidth * 0.6,
            // color: Color.fromARGB(255, 220, 238, 254),
            child: Image.network(
              activity.image1 ??
                  'https://media1.thrillophilia.com/filestore/6trqgqb2cft5jrmugtyj95fseq2z_202A8972.jpg?w=auto&h=600',
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 1.5,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: sWidth * 0.19,
                      height: sHeight * 0.3,
                      // color: Colors.amber,
                      child: Image.network(
                        activity.image2 ??
                            'https://media1.thrillophilia.com/filestore/mz2tox5p8xi8shf1agkn8wv0aymt_202A9023.jpg?w=auto&h=600',
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Container(
                        width: sWidth * 0.19,
                        height: sHeight * 0.3,
                        // color: Colors.blue,
                        child: Image.network(
                          activity.image3 ??
                              'https://media1.thrillophilia.com/filestore/fg2etmwykacc6dlsnakh9b1qla41_7e5baf004deab35b0bf0c9fdcaf329d5.webp?w=auto&h=600',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2, top: 7),
                  child: Row(
                    children: [
                      Container(
                        width: sWidth * 0.19,
                        height: sHeight * 0.285,
                        // color: Colors.amber,
                        child: Image.network(
                          activity.image4 ??
                              'https://media1.thrillophilia.com/filestore/mz2tox5p8xi8shf1agkn8wv0aymt_202A9023.jpg?w=auto&h=600',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Container(
                          width: sWidth * 0.19,
                          height: sHeight * 0.285,
                          // color: Colors.blue,
                          child: Image.network(
                            activity.image1 ??
                                'https://media1.thrillophilia.com/filestore/fg2etmwykacc6dlsnakh9b1qla41_7e5baf004deab35b0bf0c9fdcaf329d5.webp?w=auto&h=600',
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget showReviews(double sWidth, double sHeight) {
    return Center(
      child: Container(
        // color: Colors.white,
        width: sWidth * 0.67,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: reviews.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 38, 8),
                child: Container(
                  // color: Colors.white,
                  height: sHeight * .133,
                  width: sWidth * 0.76,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 3),
                            child: Container(
                              // height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade500,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reviews[index].name ?? "LEXI CAMERON",
                                  style: rajdhani15W6),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  reviews[index].review ??
                                      "I adore delving into your insights on traveling the world. Your experiences sound exhilarating!",
                                  style: rajdhani15W5),
                            ],
                          )
                        ],
                      ),
                      VerticalDivider()
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget Showreviews(sWidth, sHeight) {
    return Container(
      width: sWidth * 0.665,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All Reviews (${reviews.length}) ", style: rajdhani20W7),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getGravatarProfilePicture(String email, {double size = 100}) {
    String gravatarUrl = _buildGravatarUrl(email, size);

    return CircleAvatar(
      radius: 32,
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage(gravatarUrl),
    );
  }

  String _buildGravatarUrl(String email, double size) {
    final hash = _generateMd5(email);
    return 'https://www.gravatar.com/avatar/$hash?s=${size.toInt()}';
  }

  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  void _savereview(String text, String text2, String text3, String pid) {
    if (text == null || text2 == null || text3 == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text("All fields are required."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      getsavereview(text, text2, text3, pid);
    }
  }

  Future<void> getsavereview(
      String text, String text2, String text3, String pid) async {
    String res = await saveReviewAPI(text, text2, text3, pid);
    Map<String, dynamic> response = jsonDecode(res);

    String errorMessage = response['error_message'];

    if (errorMessage == "Images are not uploaded ." ||
        errorMessage == "Review Successfully Submitted. ") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Review Successfully Submitted."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else if (user_id == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error!"),
            content: Text("Please login!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error!"),
            content: Text("Please try again!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}

Container buildContainer() {
  return Container(
      height: 400.0,
      width: 400.0,
      child: Image.asset(
        'images/mumbai3.jpg',
        fit: BoxFit.fill,
      ));
}
