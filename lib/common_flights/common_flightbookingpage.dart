import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip/api_services/payment_api/payment_api.dart';
import 'package:trip/common/print_funtions.dart';
import 'package:trip/login_variables/login_Variables.dart';
import 'package:trip/screens/bus/bus_tripdetail.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api_services/fare_rule_api.dart/farerule_review.dart';
import '../api_services/flight/Booking Retrieve/booking_details.dart';
import '../api_services/flight/booking_apis/Confirm Booking_Immediate_Multi Pax With Passport_api.dart';
import '../api_services/flight_amendments/get_amendments_api.dart';
import '../api_services/promo_codes_api/show-promocodes_api.dart';
import '../api_services/revalidate apis/one way/revalidate_domestic_onewat_api.dart';
import '../models/flight_model.dart';
import '../screens/Drawer.dart';
import '../screens/flights/widgets/travellerform.dart';
import '../screens/header.dart';
import '../screens/mytrip_screen/mytrip_page.dart';
import 'booking_page_widgets/widgets_booking.dart';

class CommonflightBookingPage extends StatefulWidget {
  final List<Flight> flightmodel;
  int travellerCount;
  List<String> fromcity, tocity;
  CommonflightBookingPage(
      {this.flightmodel, this.travellerCount, this.fromcity, this.tocity});

  @override
  State<CommonflightBookingPage> createState() =>
      _CommonflightBookingPageState();
}

String booking_id = "";
String total_fare = "";
List<String> fligtPriceIDS = [];
String _totalsurcharges = null;
String _totalbasefare = null;
int totaladult, totalchild, totalinfant = 0;
Map<String, TextEditingController> controllers = {};
bool gstappl = false;
bool igm = false;
// timer
bool _isTimerFinished = false;

class _CommonflightBookingPageState extends State<CommonflightBookingPage> {
  // form
// adult
  List<TextEditingController> adultFirstNameControllers = [];
  List<TextEditingController> adultLastNameControllers = [];
  List<TextEditingController> adultMobileControllers = [];
  List<TextEditingController> adultEmailControllers = [];
  List<TextEditingController> adultPassportNumberController = [];
  List<TextEditingController> adultPassportNationalityController = [];
  List<TextEditingController> adultExpiryDateController = [];
  List<TextEditingController> adultDateofBirthController = [];
  List<TextEditingController> adultPassportIssuedDateController = [];
  List<TextEditingController> adultAddressController = [];
// child
  List<TextEditingController> childFirstNameControllers = [];
  List<TextEditingController> childLastNameControllers = [];
  List<TextEditingController> childMobileControllers = [];
  List<TextEditingController> childEmailControllers = [];
  List<TextEditingController> childPassportNumberController = [];
  List<TextEditingController> childPassportNationalityController = [];
  List<TextEditingController> childExpiryDateController = [];
  List<TextEditingController> childDateofBirthController = [];
  List<TextEditingController> childPassportIssuedDateController = [];
  List<TextEditingController> childAddressController = [];
// infant
  List<TextEditingController> infantFirstNameControllers = [];
  List<TextEditingController> infantLastNameControllers = [];
  List<TextEditingController> infantMobileControllers = [];
  List<TextEditingController> infantEmailControllers = [];
  List<TextEditingController> infantPassportNumberController = [];
  List<TextEditingController> infantPassportNationalityController = [];
  List<TextEditingController> infantExpiryDateController = [];
  List<TextEditingController> infantDateofBirthController = [];
  List<TextEditingController> infantPassportIssuedDateController = [];
  List<TextEditingController> infantAddressController = [];

  @override
  void initState() {
    super.initState();
    getflightLists();
    _initializeControllers();
    getrevalidateDomesticOnewayAPI();
    getshowPromoCodesAPI();
    _isTimerFinished = false;
    _startTimer();
  }

  void _startTimer() {
    Timer(Duration(seconds: 2), () {
      setState(() {
        _isTimerFinished = true;
      });
    });
  }

  void _initializeControllers() {
    for (int i = 0; i < (widget.flightmodel.first.adult ?? 0); i++) {
      adultFirstNameControllers.add(TextEditingController());
      adultLastNameControllers.add(TextEditingController());
      adultMobileControllers.add(TextEditingController());
      adultEmailControllers.add(TextEditingController());
      adultPassportNumberController.add(TextEditingController());
      adultPassportNationalityController.add(TextEditingController());
      adultExpiryDateController.add(TextEditingController());
      adultDateofBirthController.add(TextEditingController());
      adultPassportIssuedDateController.add(TextEditingController());
      adultAddressController.add(TextEditingController());
    }
    if (widget.flightmodel.first.child != null) {
      for (int j = 0; j < (widget.flightmodel.first.child ?? 0); j++) {
        childFirstNameControllers.add(TextEditingController());
        childLastNameControllers.add(TextEditingController());
        childMobileControllers.add(TextEditingController());
        childEmailControllers.add(TextEditingController());
        childPassportNumberController.add(TextEditingController());
        childPassportNationalityController.add(TextEditingController());
        childExpiryDateController.add(TextEditingController());
        childDateofBirthController.add(TextEditingController());
        childPassportIssuedDateController.add(TextEditingController());
        childAddressController.add(TextEditingController());
      }
    }
    if (widget.flightmodel.first.infant != null) {
      for (int k = 0; k < (widget.flightmodel.first.infant ?? 0); k++) {
        infantFirstNameControllers.add(TextEditingController());
        infantLastNameControllers.add(TextEditingController());
        infantMobileControllers.add(TextEditingController());
        infantEmailControllers.add(TextEditingController());
        infantPassportNumberController.add(TextEditingController());
        infantPassportNationalityController.add(TextEditingController());
        infantExpiryDateController.add(TextEditingController());
        infantDateofBirthController.add(TextEditingController());
        infantPassportIssuedDateController.add(TextEditingController());
        infantAddressController.add(TextEditingController());
      }
    }
  }

  @override
  void dispose() {
    for (var controller in adultFirstNameControllers) {
      controller.dispose();
    }
    for (var controller in adultLastNameControllers) {
      controller.dispose();
    }
    for (var controller in adultMobileControllers) {
      controller.dispose();
    }
    for (var controller in adultEmailControllers) {
      controller.dispose();
    }
    for (var controller in childFirstNameControllers) {
      controller.dispose();
    }
    for (var controller in childLastNameControllers) {
      controller.dispose();
    }
    for (var controller in childMobileControllers) {
      controller.dispose();
    }
    for (var controller in childEmailControllers) {
      controller.dispose();
    }
    for (var controller in infantFirstNameControllers) {
      controller.dispose();
    }
    for (var controller in infantLastNameControllers) {
      controller.dispose();
    }
    for (var controller in infantMobileControllers) {
      controller.dispose();
    }
    for (var controller in infantEmailControllers) {
      controller.dispose();
    }

    Efirstname_controller.dispose();
    Elastname_controller.dispose();
    // addressController.dispose();
    super.dispose();
  }

  void _collectDataAndSubmit() {
    List<Map<String, String>> collectedData = [];

    for (int i = 0; i < adultFirstNameControllers.length; i++) {
      collectedData.add({
        'firstName': adultFirstNameControllers[i].text,
        'lastName': adultLastNameControllers[i].text,
        'mobile': adultMobileControllers[i].text,
        'email': adultEmailControllers[i].text,
      });
    }

    for (int j = 0; j < childFirstNameControllers.length; j++) {
      collectedData.add({
        'firstName': childFirstNameControllers[j].text,
        'lastName': childLastNameControllers[j].text,
        'mobile': childMobileControllers[j].text,
        'email': childEmailControllers[j].text,
      });
    }

    for (int k = 0; k < infantFirstNameControllers.length; k++) {
      collectedData.add({
        'firstName': infantFirstNameControllers[k].text,
        'lastName': infantLastNameControllers[k].text,
        'mobile': infantMobileControllers[k].text,
        'email': infantEmailControllers[k].text,
      });
    }

    print("Collected data: ${collectedData.length}");

    // Collect emergency contact data
    // Map<String, String> emergencyContactData = {
    //   'firstName': Efirstname_controller.text,
    //   'lastName': Elastname_controller.text,
    //   'address': addressController.text,
    // };

    // Send collectedData and emergencyContactData to your API
    // Example:
    // final response = await http.post(
    //   Uri.parse('https://your-api-url.com/endpoint'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     'travellerData': collectedData,
    //     'emergencyContact': emergencyContactData,
    //   }),
    // );
  }
  // }

  final TextEditingController _controller = TextEditingController();
  // Emergency info
  TextEditingController emergencyMobileController = TextEditingController();
  TextEditingController emergencyEmailController = TextEditingController();
  TextEditingController Efirstname_controller = TextEditingController();
  TextEditingController Elastname_controller = TextEditingController();
  TextEditingController Emobile_controller = TextEditingController();
  TextEditingController Eemail_controller = TextEditingController();
  // Gst controllers
  TextEditingController GSTnamecontroller = TextEditingController();
  TextEditingController GSTnocontroller = TextEditingController();
  TextEditingController GSTmobilecontroller = TextEditingController();
  TextEditingController GSTemailcontroller = TextEditingController();
  TextEditingController GSTaddresscontroller = TextEditingController();

  List<CodeData> promocodes;
  double amount;
  double arft;
  double arf;
  double cancel_fee;
  bool isShowBasefare = false;
  bool _isSelectedradio = false;
  bool isShowSurcharges = false;
  Color maleContainerColor = Colors.white;
  Color femaleContainerColor = Colors.white;
  List<String> indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  String selectedState;

  get currentwidth => null;

// getflightLists() {
//   List<String> priceIds = [];
//   double totalsurcharge = 0;
//   double totalbasefare = 0;
//   int adult, infant, child;

//   // Check if widget.flightmodel is not null before accessing its length
//   if (widget.flightmodel != null) {
//     int length = widget.flightmodel.length ?? 0;
//     print("length: $length");

//     // Loop through flightmodel only if it's not null
//     for (int i = 0; i < length; i++) {
//       priceIds.add(widget.flightmodel[i].pricceID);
//       totalsurcharge += double.parse(widget.flightmodel[i].surCharges);
//       totalbasefare += double.parse(widget.flightmodel[i].baseFare);
//     }
//   } else {
//     // Handle the case where widget.flightmodel is null
//     print("widget.flightmodel is null");
//     return; // Exit the function early to avoid further processing
//   }

//   setState(() {
//     fligtPriceIDS = priceIds;
//     _totalbasefare = totalbasefare.toString();
//     _totalsurcharges = totalsurcharge.toString();
//   });

//   // Logging priceIds
//   for(int i = 0; i < fligtPriceIDS.length??0; i++) {
//     print("priceid $i: ${fligtPriceIDS[i].toString()}");
//   }
// }

  getflightLists() {
    List<String> priceIds = [];
    double totalsurcharge = 0;
    double totalbasefare = 0;
    int adult, infant, child;

    // Check if widget.flightmodel is not null before accessing its length
    if (widget.flightmodel != null) {
      int length = widget.flightmodel.length ??
          0; // Set length to 0 if flightmodel is null
      print("length: $length");

      // Loop through flightmodel only if it's not null
      for (int i = 0; i < length; i++) {
        // Check if the flight model at index i is not null before accessing its properties
        if (widget.flightmodel[i] != null) {
          priceIds
              .add(widget.flightmodel[i].pricceID); // Access pricceID property
          totalsurcharge += double.parse(widget.flightmodel[i].surCharges);
          totalbasefare += double.parse(widget.flightmodel[i].baseFare);
        }
      }
    } else {
      // Handle the case where widget.flightmodel is null
      print("widget.flightmodel is null");
      return; // Exit the function early to avoid further processing
    }

    setState(() {
      fligtPriceIDS = priceIds;
      _totalbasefare = totalbasefare.toString();
      _totalsurcharges = totalsurcharge.toString();
    });

    // Logging priceIds
    for (int i = 0; i < fligtPriceIDS.length ?? 0; i++) {
      print("priceid $i: ${fligtPriceIDS[i].toString()}");
    }
  }

  Future<void> getrevalidateDomesticOnewayAPI() async {
    // Add a 3-second delay

    printWhite("getrevalidateDomesticOnewayAPI :${fligtPriceIDS}");
    String res = await revalidateDomesticOnewayAPI(fligtPriceIDS);
    Revalidate obj = Revalidate.fromJson(jsonDecode(res));
    revalidateTotalPriceInfo info = obj.totalPriceInfo;

    print("revalidate gstappl: ${obj.conditions.gst.gstappl}");
    print("revalidate igm: ${obj.conditions.gst.igm}");

    // setState(() {
    //   igm = obj.conditions.gst.igm;
    //   gstappl = obj.conditions.gst.gstappl;
    // });

    printWhite("info: ${info.totalFareDetail.afC}");
    printred("revalidateDomesticOnewayAPI: res:$res");
    Map<String, dynamic> decodedResponse = jsonDecode(res);

    String bookingId = decodedResponse['bookingId'];

    if (decodedResponse.containsKey("totalPriceInfo")) {
      Map<String, dynamic> totalPriceInfo = decodedResponse["totalPriceInfo"];
      Map<String, dynamic> totalFareDetail = totalPriceInfo["totalFareDetail"];

      double totalFare = totalFareDetail["fC"]["TF"];

      log('Booking ID: ${bookingId}');
      printred("----------------->");
      printred("Total Fare: $totalFare");
      getfareRuleapi(bookingId);
      // cancellationAmendmentApi(bookingId, "DEL", "BOM");
      setState(() {
        booking_id = bookingId;
        total_fare = totalFare.toString();
      });
      log("booking id: $booking_id");
    } else {
      print("Error: 'totalPriceInfo' not found in response");
    }
  }

  void getfarerulrreviewAPI(String bookingId) async {
    String res = await farerulrreviewAPI(bookingId);
    print("getFarerulrreviewAPI: res:$res");

    Map<String, dynamic> jsonResponse = jsonDecode(res);

    if (jsonResponse.containsKey("fareRule")) {
      Map<String, dynamic> fareRule = jsonResponse["fareRule"];

      if (fareRule.containsKey("DEL-BOM")) {
        Map<String, dynamic> delBomFareRule = fareRule["DEL-BOM"];

        if (delBomFareRule.containsKey("fr")) {
          Map<String, dynamic> fr = delBomFareRule["fr"];

          if (fr.containsKey("DATECHANGE")) {
            Map<String, dynamic> dateChange = fr["DATECHANGE"];

            if (dateChange.containsKey("DEFAULT")) {
              Map<String, dynamic> defaultDateChange = dateChange["DEFAULT"];

              if (defaultDateChange.containsKey("amount")) {
                setState(() {
                  amount = defaultDateChange["amount"];
                });

                print("Amount: $amount");
              }

              if (defaultDateChange.containsKey("fcs")) {
                Map<String, dynamic> fcs = defaultDateChange["fcs"];

                if (fcs.containsKey("ARFT")) {
                  setState(() {
                    arft = fcs["ARFT"];
                  });

                  print("ARFT: $arft");
                }

                if (fcs.containsKey("ARF")) {
                  setState(() {
                    arf = fcs["ARF"];
                  });

                  print("ARF: $arf");
                }
              }
            }
          }
        }
      }
    }
    setState(() {
      cancel_fee = amount + arft + arf;
    });
  }

  getfareRuleapi(String bookingid) async {
    print("farerule");
    String res = await farerulrreviewAPI(bookingid);
    printWhite("fare res:$res");
  }

  getshowPromoCodesAPI() async {
    String res = await showPromoCodesAPI();
    Map<String, dynamic> decodedResponse = jsonDecode(res);

    PromoCodes promoCodes = PromoCodes.fromJson(decodedResponse);

    List<CodeData> promoCodesData = promoCodes.data;
    setState(() {
      promocodes = promoCodesData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: screenWidth < 600
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 40),
              backgroundColor: Color.fromARGB(255, 1, 21, 101),
              title: Text(
                "Complete your booking",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            )
          : CustomAppBar(),
      drawer: screenWidth < 600 ? drawer() : null,
      backgroundColor: Color.fromARGB(255, 215, 233, 248),
      // appBar: AppBar(
      // title: Text(
      //     "Complete your booking",
      //     style: TextStyle(
      //         fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
      //   ),
      //   elevation: 0.0,
      //   backgroundColor:  Color.fromARGB(255, 1, 21, 101),
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: _isTimerFinished == false
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Stack(
              // alignment: Alignment.,
              children: [
                _buildGradientContainer(screenWidth),
                SizedBox(
                  height: 100,
                ),
                _buildflightandfare(screenWidth, screenHeight)
              ],
            )),
    );
  }

  String formatDuration(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    String formattedDuration = '${hours}h ';
    if (remainingMinutes > 0) {
      formattedDuration += '${remainingMinutes}m';
    }

    return formattedDuration;
  }

  Widget _buildflightandfare(screenWidth, screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: [
        _buildFlightDetails(context, screenHeight, screenWidth),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildfare(screenWidth, screenHeight),
            SizedBox(
              height: 30,
            ),
            // PrromoCodesWidget(promoCodes: promocodes,)
            _buildpromocodes(screenWidth, screenHeight)
          ],
        )
      ],
    );
  }

  Widget _buildfare(screenWidth, screenHeight) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 45,
          ),
          Container(
            // Position the container to the right
            height: 205,
            width: screenWidth * 0.185,
            child: Card(
                // color: Colors.*,
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Fare Summary",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       isShowBasefare = !isShowBasefare;
                      //     });
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         border: Border.all(
                      //             width: 1.0, color: Colors.grey.shade700),
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child: Icon(
                      //       isShowBasefare ? Icons.remove : Icons.add,
                      //       size: 13,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Base Fare',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "₹ $_totalbasefare",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isShowBasefare,
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Adult(s) (1 X ₹ 5,604)',
                          //       style: TextStyle(
                          //           fontSize: 13,
                          //           fontWeight: FontWeight.w500,
                          //           color: Colors.grey),
                          //     ),
                          //     Spacer(),
                          //     Text(
                          //       '₹ 5,604',
                          //       style: TextStyle(
                          //         fontSize: 13,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Adult(s) (1 X ₹ 5,604)',
                          //       style: TextStyle(
                          //           fontSize: 13,
                          //           fontWeight: FontWeight.w500,
                          //           color: Colors.grey),
                          //     ),
                          //     Spacer(),
                          //     Text(
                          //       '₹ 5,604',
                          //       style: TextStyle(
                          //           fontSize: 13,
                          //           fontWeight: FontWeight.w500),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Adult(s) (1 X ₹ 5,604)',
                          //       style: TextStyle(
                          //           fontSize: 13,
                          //           fontWeight: FontWeight.w500,
                          //           color: Colors.grey),
                          //     ),
                          //     Spacer(),
                          //     Text(
                          //       '₹ 5,604',
                          //       style: TextStyle(
                          //         fontSize: 13,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       isShowSurcharges = !isShowSurcharges;
                      //     });
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         border: Border.all(
                      //             width: 1.0, color: Colors.grey.shade700),
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child: Icon(
                      //       isShowBasefare ? Icons.remove : Icons.add,
                      //       size: 13,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Taxes and Surcharges',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '₹ $_totalsurcharges',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isShowSurcharges,
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Airline Taxes and Surcharges',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                              Spacer(),
                              Text(
                                '₹ $_totalsurcharges',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
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
                  Divider(
                    thickness: 1.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '₹ ${(double.parse(_totalbasefare) + double.parse(_totalsurcharges)).toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }

// Function to convert date format
  String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('EEEE, MMM d').format(dateTime);
    return formattedDate;
  }

// Function to convert time format
  String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return formattedTime;
  }

  Widget _buildGradientContainer(double width) {
    return Container(
      height: 200, // Adjust the height as needed
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.2,
          color: Color.fromARGB(255, 1, 20, 99),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Color.fromARGB(255, 2, 5, 31),
            // Color.fromARGB(255, 4, 17, 73),
            // Color.fromARGB(255, 1, 29, 140),
            Color.fromARGB(255, 3, 49, 74),
            Color.fromARGB(255, 2, 97, 148),
          ],
        ),
      ),
    );
  }

  // Widget _buildGradientContainer(double width) {
  //   return Container(
  //     height: 200, // Adjust the height as needed
  //     width: width,
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //         colors: [
  //           Color.fromARGB(255, 1, 21, 101),
  //           Color.fromARGB(255, 0, 20, 102),
  //           Color.fromARGB(255, 0, 23, 115),
  //           Color.fromARGB(255, 22, 35, 177),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  _buildFlightDetails(
      BuildContext context, double screenHeight, double screenWidth) {
    return Container(
      width: screenWidth - 700,
      // height: 1000,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "Complete your booking",
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          _flightDetailsContainer(),
          // SizedBox(
          //   height: 50,
          // ),
          // _buildCancellation(),
          // SizedBox(
          //   height: 0,
          // ),
          // _buildTripsecure(),
          SizedBox(
            height: 0,
          ),
          _buildTravellerDetails(context, screenHeight, screenWidth),
          SizedBox(
            height: 20,
          ),
          // _buildSeatmealsform(),
          SizedBox(
            height: 20,
          ),
          // _buildaddOnform()
          // // _builStateform(),
        ],
      ),
    );
  }

// -----> flight details container
  _flightDetailsContainer() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.flightmodel.length ?? 0,
      itemBuilder: (context, index) {
        final flight = widget.flightmodel[index];
        final fromcity = widget.fromcity[index];
        final tocity = widget.tocity[index];
        return Container(
          color: Colors.white,
          height: 380,
          width: 900,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                // height: 400,
                width: 800,
                child: Card(
                  elevation: 5.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${fromcity ?? 'null'} → ${tocity ?? 'null'}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (flight.refund == 0 ||
                                flight.refund == 2 ||
                                flight.refund == null)
                              Container(
                                color: Color.fromARGB(255, 22, 163, 95),
                                child: Text(
                                  "CANCELLATION FEES APPLY",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            if (flight.refund == 1)
                              Container(
                                color: Color.fromARGB(255, 22, 163, 95),
                                child: Text(
                                  "CANCELLATION FEES DOESN'T APPLY",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 2,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                                color: Color.fromARGB(255, 250, 214, 172),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.5),
                                  child: Text(
                                      formatDate(flight.departureTime) ??
                                          'null',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 11, 11, 11))),
                                )),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                                flight.stops == 0
                                    ? 'Nonstop · ${formatDuration(flight.duration)}'
                                    : '1 stop · ${formatDuration(flight.duration)}',
                                style: TextStyle(
                                  fontSize: 15,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "images/AirlinesLogo/${flight.airlineCode}.png",
                              width: 20,
                              height: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("${flight.airlineName ?? 'null'}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 11, 11, 11))),
                            SizedBox(
                              width: 4,
                            ),
                            // Text("QP 1411"),
                            Spacer(),
                            Text("${flight.travellerClass ?? 'null'}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 11, 11, 11)))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        child: Container(
                            height: 200,
                            color: Colors.grey.shade200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(formatTime(flight.departureTime),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 11, 11, 11))),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Icon(
                                        Icons.circle_outlined,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(flight.departureCity ?? "null",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 11, 11, 11))),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Text(
                                          "${flight.departureairport ?? "null"},${flight.departureTerminal ?? "null"}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 11, 11, 11)))
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 59,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '|',
                                          style: TextStyle(fontSize: 8),
                                        ),
                                        Text(
                                          '|',
                                          style: TextStyle(fontSize: 8),
                                        ),
                                        Text(
                                          '|',
                                          style: TextStyle(fontSize: 8),
                                        ),
                                        Text(
                                          '|',
                                          style: TextStyle(fontSize: 8),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      formatDuration(flight.duration),
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    )
                                    // Icon(Icons.swap_vert,size: 23,color: Colors.grey,),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 0, 12, 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(formatTime(flight.arrivalTime),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 11, 11, 11))),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Icon(
                                        Icons.circle_outlined,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(flight.arrivalCity ?? "null",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 11, 11, 11))),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Text(
                                          "${flight.arrivalairport ?? "null"},${flight.arrivalTerminal ?? "null"}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 11, 11, 11)))
                                    ],
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.wallet_travel_outlined,
                                        size: 20,
                                        color: Color.fromARGB(255, 255, 139, 7),
                                        weight: 20.0,
                                        fill: 1.0,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),

                                      Text("Cabin Baggage:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 11, 11, 11))),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Text(
                                          "${flight.cabinBaggage ?? "null"} / Adult"),
                                      // SizedBox(
                                      //   width: 20,
                                      // ),
                                      Spacer(),
                                      Icon(
                                        Icons.luggage_outlined,
                                        size: 25,
                                        color: Color.fromARGB(255, 255, 139, 7),
                                        weight: 20.0,
                                        fill: 1.0,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text("Check-In Baggage:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 11, 11, 11))),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Text(
                                          "${flight.checkingBaggage ?? "null"} / Adult"),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Travellerform(title, label,String prefix) {
  //   // Create unique controller names
  // String firstNameKey = '${prefix}first_name';
  // String lastNameKey = '${prefix}last_name';
  // String mobileKey = '${prefix}mobile';
  // String emailKey = '${prefix}email';

  // // Create controllers and store them in the map
  // controllers[firstNameKey] = TextEditingController();
  // controllers[lastNameKey] = TextEditingController();
  // controllers[mobileKey] = TextEditingController();
  // controllers[emailKey] = TextEditingController();
  //   return Container(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(15.0),
  //           child: Row(
  //             children: [
  //               CircleAvatar(
  //                 radius: 14,
  //                 backgroundColor: Colors.blue.shade200,
  //                 child: Center(
  //                   child: Icon(
  //                     Icons.person_rounded,
  //                     color: Colors.black,
  //                     size: 25,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 3,
  //               ),
  //               Text(
  //                 "$title",
  //                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 5,
  //         ),
  //         Card(
  //           elevation: 2.0,
  //           child: Container(
  //             color: Color.fromARGB(255, 255, 212, 148).withOpacity(0.5),
  //             height: 25,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   "Important:",
  //                   style: TextStyle(fontWeight: FontWeight.w500),
  //                 ),
  //                 Text(
  //                   " Enter name as mentioned on your passport or Government approved IDs.",
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Card(
  //           elevation: 5.0,
  //           child: Padding(
  //             padding: const EdgeInsets.all(12.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   label,
  //                   style: TextStyle(fontWeight: FontWeight.w700),
  //                 ),
  //                 Divider(),
  //                 SizedBox(
  //                   height: 30,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     SizedBox(
  //                       width: 250,
  //                       height: 50,
  //                       child: TextFormField(
  //                         decoration: InputDecoration(
  //                           border: OutlineInputBorder(),
  //                           labelText: 'First Name',
  //                         ),
  //                         validator: (value) {
  //                           if (value == null || value.isEmpty) {
  //                             return 'Please enter some text';
  //                           }
  //                           return null;
  //                         },
  //                       ),
  //                     ),
  //                     // SizedBox(
  //                     //   width: 10,
  //                     // ),
  //                     SizedBox(
  //                       width: 250,
  //                       height: 50,
  //                       child: TextFormField(
  //                         decoration: InputDecoration(
  //                           border: OutlineInputBorder(),
  //                           labelText: 'Last Name',
  //                         ),
  //                         validator: (value) {
  //                           if (value == null || value.isEmpty) {
  //                             return 'Please enter some text';
  //                           }
  //                           return null;
  //                         },
  //                       ),
  //                     ),

  //                     Row(
  //                       children: [
  //                         GestureDetector(
  //                           onTap: () {
  //                             setState(() {
  //                               // Set the color of the tapped container to blue
  //                               // and reset the color of the other container
  //                               maleContainerColor = Colors.blue;
  //                               femaleContainerColor = Colors.white;
  //                             });
  //                           },
  //                           child: Container(
  //                             height: 50,
  //                             width: 125,
  //                             decoration: BoxDecoration(
  //                               border:
  //                                   Border.all(width: 1.0, color: Colors.grey),
  //                               borderRadius: BorderRadius.circular(5),
  //                               color:
  //                                   maleContainerColor, // Set the color dynamically
  //                             ),
  //                             child: Center(
  //                               child: Text("Male",
  //                                   style: TextStyle(
  //                                       color: maleContainerColor == Colors.blue
  //                                           ? Colors.white
  //                                           : Colors.black)),
  //                             ),
  //                           ),
  //                         ),
  //                         GestureDetector(
  //                           onTap: () {
  //                             setState(() {
  //                               // Set the color of the tapped container to blue
  //                               // and reset the color of the other container
  //                               femaleContainerColor = Colors.blue;
  //                               maleContainerColor = Colors.white;
  //                             });
  //                           },
  //                           child: Container(
  //                             height: 50,
  //                             width: 125,
  //                             decoration: BoxDecoration(
  //                               border:
  //                                   Border.all(width: 1.0, color: Colors.grey),
  //                               borderRadius: BorderRadius.circular(5),
  //                               color:
  //                                   femaleContainerColor, // Set the color dynamically
  //                             ),
  //                             child: Center(
  //                                 child: Text(
  //                               "Female",
  //                               style: TextStyle(
  //                                   color: femaleContainerColor == Colors.blue
  //                                       ? Colors.white
  //                                       : Colors.black),
  //                             )),
  //                           ),
  //                         ),
  //                       ],
  //                     ),

  //                     // SizedBox(
  //                     //   width: 10,
  //                     // ),
  //                     // Row(
  //                     //   children: [
  //                     //     Container(
  //                     //       height: 50,
  //                     //       width: 125,
  //                     //       decoration: BoxDecoration(
  //                     //         border: Border.all(width: 1.0, color: Colors.grey),
  //                     //         borderRadius: BorderRadius.circular(5),
  //                     //       ),
  //                     //       child: Center(child: Text("Male")),
  //                     //     ),
  //                     //     Container(
  //                     //       height: 50,
  //                     //       width: 125,
  //                     //       decoration: BoxDecoration(
  //                     //         border: Border.all(width: 1.0, color: Colors.grey),
  //                     //         borderRadius: BorderRadius.circular(5),
  //                     //       ),
  //                     //       child: Center(child: Text("Female")),
  //                     //     )
  //                     //   ],
  //                     // ),
  //                   ],
  //                 ),
  //                 SizedBox(
  //                   height: 30,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'Country Code', // Text added here
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w400,
  //                             fontSize: 14,
  //                           ),
  //                         ),
  //                         SizedBox(
  //                             height:
  //                                 10), // Added spacing between text and CountryCodePicker
  //                         // Row(
  //                         // children: [
  //                         Container(
  //                           width: 250,
  //                           height: 50,
  //                           decoration: BoxDecoration(
  //                               border:
  //                                   Border.all(width: 0.8, color: Colors.grey),
  //                               borderRadius: BorderRadius.circular(5)),
  //                           child: CountryCodePicker(
  //                             flagWidth: 25,
  //                             onChanged: (CountryCode countryCode) {
  //                               // Handle country code change
  //                               print(
  //                                   'New country selected: ${countryCode.name}');
  //                             },
  //                             initialSelection: 'भारत', // Initial country code
  //                             favorite: [
  //                               '+91',
  //                               'भारत'
  //                             ], // Optional: favorite country codes
  //                             showCountryOnly:
  //                                 true, // Display only the country name
  //                             alignLeft:
  //                                 false, // Align the flag and the country code to the left
  //                             textStyle: TextStyle(
  //                                 fontSize:
  //                                     15), // Style for the country code text
  //                           ),
  //                         ),
  //                         // ],
  //                         // ),
  //                       ],
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'Mobile Number', // Text added here
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w400,
  //                             fontSize: 14,
  //                           ),
  //                         ),
  //                         SizedBox(height: 10),
  //                         SizedBox(
  //                           width: 250,
  //                           height: 50,
  //                           child: TextFormField(
  //                             decoration: InputDecoration(
  //                               border: OutlineInputBorder(),
  //                               labelText: 'Mobile Number (optional)',
  //                             ),
  //                             validator: (value) {
  //                               if (value == null || value.isEmpty) {
  //                                 return 'Please enter some text';
  //                               }
  //                               return null;
  //                             },
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'Email', // Text added here
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w400,
  //                             fontSize: 14,
  //                           ),
  //                         ),
  //                         SizedBox(height: 10),
  //                         SizedBox(
  //                           width: 250,
  //                           height: 50,
  //                           child: TextFormField(
  //                             decoration: InputDecoration(
  //                               border: OutlineInputBorder(),
  //                               labelText: 'Email (optional)',
  //                             ),
  //                             validator: (value) {
  //                               if (value == null || value.isEmpty) {
  //                                 return 'Please enter some text';
  //                               }
  //                               return null;
  //                             },
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),

  //                 SizedBox(
  //                   height: 30,
  //                 ),
  //                 Divider(),
  //                 // Text(
  //                 //   "+ ADD NEW $label",
  //                 //   style: TextStyle(
  //                 //       fontSize: 12,
  //                 //       fontWeight: FontWeight.w500,
  //                 // color: Colors.blue),
  //                 // )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
// --------------------------------->

// void _initializeTravellerData() {
//     for (int i = 1; i <= (widget.flightmodel.first.adult ?? 0); i++) {
//       travellerData.add(_createTravellerMap('ADULT', i));
//     }
//     for (int j = 1; j <= (widget.flightmodel.first.child ?? 0); j++) {
//       travellerData.add(_createTravellerMap('CHILD', j));
//     }
//     for (int k = 1; k <= (widget.flightmodel.first.infant ?? 0); k++) {
//       travellerData.add(_createTravellerMap('INFANT', k));
//     }
//   }

//   Map<String, dynamic> _createTravellerMap(String type, int index) {
//     return {
//       'type': type,
//       'index': index,
//       'firstNameController': TextEditingController(),
//       'lastNameController': TextEditingController(),
//       'mobileController': TextEditingController(),
//       'emailController': TextEditingController(),
//       'genderNotifier': ValueNotifier<String>(null),
//     };
//   }

//   @override
//   void dispose() {
  //   for (var data in travellerData) {
  //     data['firstNameController'].dispose();
  //     data['lastNameController'].dispose();
  //     data['mobileController'].dispose();
  //     data['emailController'].dispose();
  //     data['genderNotifier'].dispose();
  //   }
  //   super.dispose();
  // }

  // void _collectDataAndSubmit() {
  //   List<Map<String, String>> collectedData = travellerData.map((data) {
  //     return {
  //       'firstName': data['firstNameController'].text,
  //       'lastName': data['lastNameController'].text,
  //       'mobile': data['mobileController'].text,
  //       'email': data['emailController'].text,
  //       'gender': data['genderNotifier'].value,
  //     };
  //   }).toList();

  //   // Send collectedData to your API
  //   // Example:
  //   // final response = await http.post(
  //   //   Uri.parse('https://your-api-url.com/endpoint'),
  //   //   headers: {'Content-Type': 'application/json'},
  //   //   body: jsonEncode(collectedData),
  //   // );
  // }

  _buildTravellerDetails(
      BuildContext context, double screenHeight, double screenWidth) {
    return SingleChildScrollView(
      child: Container(
        width: 900,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Traveller Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              if (widget.flightmodel.first.adult != null)
                for (int i = 1; i <= widget.flightmodel.first.adult; i++)
                  TravellerForm(
                    title: 'ADULT (12 yrs+)',
                    label: 'ADULT $i',
                    prefix: 'adult_$i',
                    firstNameController: adultFirstNameControllers[i - 1],
                    lastNameController: adultLastNameControllers[i - 1],
                    mobileController: adultMobileControllers[i - 1],
                    emailController: adultEmailControllers[i - 1],
                    PassportNumberController:
                        adultPassportNumberController[i - 1],
                    PassportNationalityController:
                        adultPassportNationalityController[i - 1],
                    ExpiryDateController: adultExpiryDateController[i - 1],
                    DateofBirthController: adultDateofBirthController[i - 1],
                    PassportIssuedDateController:
                        adultPassportIssuedDateController[i - 1],
                    AddressController: adultAddressController[i - 1],
                  ),
              SizedBox(height: 15),
              if (widget.flightmodel.first.child != null)
                for (int j = 1; j <= widget.flightmodel.first.child; j++)
                  TravellerForm(
                    title: 'CHILD (2-12 Yrs)',
                    label: 'CHILD $j',
                    prefix: 'child_$j',
                    firstNameController: childFirstNameControllers[j - 1],
                    lastNameController: childLastNameControllers[j - 1],
                    mobileController: childMobileControllers[j - 1],
                    emailController: childEmailControllers[j - 1],
                    PassportNumberController:
                        childPassportNumberController[j - 1],
                    PassportNationalityController:
                        childPassportNationalityController[j - 1],
                    ExpiryDateController: childExpiryDateController[j - 1],
                    DateofBirthController: childDateofBirthController[j - 1],
                    PassportIssuedDateController:
                        childPassportIssuedDateController[j - 1],
                    AddressController: childAddressController[j - 1],
                  ),
              SizedBox(height: 15),
              if (widget.flightmodel.first.infant != null)
                for (int k = 1; k <= widget.flightmodel.first.infant; k++)
                  TravellerForm(
                    title: 'INFANT (15 days - 2 Yrs)',
                    label: 'INFANT $k',
                    prefix: 'infant_$k',
                    firstNameController: infantFirstNameControllers[k - 1],
                    lastNameController: infantLastNameControllers[k - 1],
                    mobileController: infantMobileControllers[k - 1],
                    emailController: infantEmailControllers[k - 1],
                    PassportNumberController:
                        infantPassportNumberController[k - 1],
                    PassportNationalityController:
                        infantPassportNationalityController[k - 1],
                    ExpiryDateController: infantExpiryDateController[k - 1],
                    DateofBirthController: infantDateofBirthController[k - 1],
                    PassportIssuedDateController:
                        infantPassportIssuedDateController[k - 1],
                    AddressController: infantAddressController[k - 1],
                  ),
              SizedBox(height: 15),
              Divider(),
              Text(
                'Booking details will be sent to',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Country Code',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.8, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: CountryCodePicker(
                          flagWidth: 25,
                          onChanged: (CountryCode countryCode) {
                            // Handle country code change
                            print('New country selected: ${countryCode.code}');
                          },
                          initialSelection: 'भारत', // Initial country code
                          favorite: [
                            '+91',
                            'भारत'
                          ], // Optional: favorite country codes
                          showCountryOnly:
                              true, // Display only the country name
                          alignLeft:
                              true, // Align the flag and the country code to the left
                          textStyle: TextStyle(
                              fontSize: 15), // Style for the country code text
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile Number',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: TextFormField(
                          controller: emergencyMobileController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mobile Number',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: TextFormField(
                          controller: emergencyEmailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 15),
              Text(
                'Emergency Contact Info',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: TextFormField(
                      controller: Efirstname_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: TextFormField(
                      controller: Elastname_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Country Code',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.8, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: CountryCodePicker(
                          flagWidth: 25,
                          onChanged: (CountryCode countryCode) {
                            // Handle country code change
                            print('New country selected: ${countryCode.name}');
                          },
                          initialSelection: 'भारत', // Initial country code
                          favorite: [
                            '+91',
                            'भारत'
                          ], // Optional: favorite country codes
                          showCountryOnly:
                              true, // Display only the country name
                          alignLeft:
                              true, // Align the flag and the country code to the left
                          textStyle: TextStyle(
                              fontSize: 15), // Style for the country code text
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile Number',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: TextFormField(
                          controller: Emobile_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mobile Number',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: TextFormField(
                          controller: Eemail_controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
//               if (gstappl || igm)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
// // --gst
//                     SizedBox(
//                       height: 15,
//                     ),
//                     // Divider(),
//                     Text(
//                       'GST Info',
//                       style:
//                           TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           width: 250,
//                           height: 50,
//                           child: TextFormField(
//                             controller: GSTnocontroller,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'GST Number',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter some text';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         // SizedBox(
//                         //   width: 10,
//                         // ),
//                         SizedBox(
//                           width: 250,
//                           height: 50,
//                           child: TextFormField(
//                             controller: GSTnamecontroller,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Registered Name',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter some text';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           width: 250,
//                           height: 50,
//                           child: TextFormField(
//                             controller: GSTaddresscontroller,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Registered Address',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter some text';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Country Code', // Text added here
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             SizedBox(
//                                 height:
//                                     10), // Added spacing between text and CountryCodePicker
//                             // Row(
//                             // children: [
//                             Container(
//                               width: 250,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                       width: 0.8, color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: CountryCodePicker(
//                                 flagWidth: 25,
//                                 onChanged: (CountryCode countryCode) {
//                                   // Handle country code change
//                                   print(
//                                       'New country selected: ${countryCode.name}');
//                                 },
//                                 initialSelection:
//                                     'भारत', // Initial country code
//                                 favorite: [
//                                   '+91',
//                                   'भारत'
//                                 ], // Optional: favorite country codes
//                                 showCountryOnly:
//                                     true, // Display only the country name
//                                 alignLeft:
//                                     true, // Align the flag and the country code to the left
//                                 textStyle: TextStyle(
//                                     fontSize:
//                                         15), // Style for the country code text
//                               ),
//                             ),
//                             // ],
//                             // ),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Mobile Number', // Text added here
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             SizedBox(
//                               width: 250,
//                               height: 50,
//                               child: TextFormField(
//                                 controller: GSTmobilecontroller,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   labelText: 'Mobile Number',
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter some text';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Email', // Text added here
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             SizedBox(
//                               width: 250,
//                               height: 50,
//                               child: TextFormField(
//                                 controller: GSTemailcontroller,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   labelText: 'Email',
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter some text';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 35,
//                     ),

// // ---gst
//                   ],
//                 ),
              SizedBox(height: 20),
              Divider(),
              Center(
                child: GestureDetector(
                  onTap: () {
         
                    List<Map<String, String>> travelerDetails = [];

                 
                    for (int i = 0; i < widget.flightmodel.first.adult; i++) {
                      travelerDetails.add({
                        "ti": "Mr",
                        "pt": "ADULT",
                        "fN": adultFirstNameControllers[i].text,
                        "lN": adultLastNameControllers[i].text,
                       
                      });
                    }

                    
                    for (int j = 0; j < widget.flightmodel.first.child; j++) {
                      travelerDetails.add({
                        "ti": "Master",
                        "pt": "CHILD",
                        'firstName': childFirstNameControllers[j].text,
                        'lastName': childLastNameControllers[j].text,
                        
                      });
                    }

                  
                    for (int k = 0; k < widget.flightmodel.first.infant; k++) {
                      travelerDetails.add({
                        "ti": "Master",
                        "pt": 'INFANT',
                        "fN": infantFirstNameControllers[k].text,
                        "lN": infantLastNameControllers[k].text,
             
                      });
                    }

                    print("travelerDetail");
                    print(travelerDetails);

                    
                    print(
                        "emergency:${Efirstname_controller.text},${Elastname_controller.text},${Emobile_controller.text},${Eemail_controller.text}");
                    print(
                        "GST:${GSTnocontroller.text} ${GSTnamecontroller.text},${GSTnocontroller.text},${GSTmobilecontroller.text},${GSTemailcontroller.text},${GSTaddresscontroller.text}");
                    printWhite("book:$booking_id");

                    if (booking_id.isNotEmpty && booking_id != null) {
                      Bookingapi(booking_id, total_fare, travelerDetails,context);
                    } else {
                      print("null booking id");
                    }
                    _collectDataAndSubmit();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 110.0,
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
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//   _buildTravellerDetails(
//       BuildContext context, double screenHeight, double screenWidth) {
//     return SingleChildScrollView(
//       child: Container(
//         // height: 2100,
//         width: 900,
//         color: Color.fromARGB(255, 255, 255, 255),
//         child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Traveller Details",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 if (widget.flightmodel.first.adult != null)
//                   for (int i = 1; i <= widget.flightmodel.first.adult; i++)
//                     TravellerForm(
//                       title: 'ADULT (12 yrs+)',
//                       label: 'ADULT $i',
//                       prefix: 'adult_$i',
//                       firstNameController: adultFirstNameControllers[i - 1],
//                       lastNameController: adultLastNameControllers[i - 1],
//                       mobileController: adultMobileControllers[i - 1],
//                       emailController: adultEmailControllers[i - 1],
//                       // genderNotifier: ,
//                     ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 if (widget.flightmodel.first.child != null)
//                   for (int j = 1; j <= widget.flightmodel.first.child; j++)
//                    TravellerForm(
//                       title: 'CHILD (2-12 Yrs)',
//                       label: 'CHILD $j',
//                       prefix: 'child_$j',
//                       // firstNameController: childFirstNameControllers[j],
//                       // lastNameController: childLastNameControllers[j],
//                       // mobileController: childMobileControllers[j],
//                     ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 if (widget.flightmodel.first.infant != null)
//                   for (int k = 1; k <= widget.flightmodel.first.infant; k++)
//                     TravellerForm(
//                       title: 'Infant (15 days - 2 Yrs)',
//                       label: 'Infant $k',
//                       prefix: 'infant_$k',
//                       // firstNameController: infantFirstNameControllers[k],
//                       // lastNameController: infantLastNameControllers[k],
//                       // mobileController: infantMobileControllers[k],
//                     ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Divider(),
//                 Text(
//                   'Booking details will be sent to',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Country Code', // Text added here
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(
//                             height:
//                                 10), // Added spacing between text and CountryCodePicker
//                         // Row(
//                         // children: [
//                         Container(
//                           width: 250,
//                           height: 50,
//                           decoration: BoxDecoration(
//                               border:
//                                   Border.all(width: 0.8, color: Colors.grey),
//                               borderRadius: BorderRadius.circular(5)),
//                           child: CountryCodePicker(
//                             flagWidth: 25,
//                             onChanged: (CountryCode countryCode) {
//                               // Handle country code change
//                               print(
//                                   'New country selected: ${countryCode.code}');
//                             },
//                             initialSelection: 'भारत', // Initial country code
//                             favorite: [
//                               '+91',
//                               'भारत'
//                             ], // Optional: favorite country codes
//                             showCountryOnly:
//                                 true, // Display only the country name
//                             alignLeft:
//                                 true, // Align the flag and the country code to the left
//                             textStyle: TextStyle(
//                                 fontSize:
//                                     15), // Style for the country code text
//                           ),
//                         ),
//                         // ],
//                         // ),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Mobile Number', // Text added here
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         SizedBox(
//                           width: 250,
//                           height: 50,
//                           child: TextFormField(
//                             controller: emergencyMobileController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Mobile Number',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter some text';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Email', // Text added here
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         SizedBox(
//                           width: 250,
//                           height: 50,
//                           child: TextFormField(
//                             controller: emergencyEmailController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Email',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter some text';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Divider(),
// // ------------Emergency contact info
//                 SizedBox(
//                   height: 15,
//                 ),
//                 // Divider(),
//                 Text(
//                   'Emergency Contact Info',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SizedBox(
//                       width: 250,
//                       height: 50,
//                       child: TextFormField(
//                         controller: Efirstname_controller,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'First Name',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter some text';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     // SizedBox(
//                     //   width: 10,
//                     // ),
//                     SizedBox(
//                       width: 250,
//                       height: 50,
//                       child: TextFormField(
//                         controller: Elastname_controller,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Last Name',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter some text';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 250,
//                       height: 50,
//                       child: TextFormField(
//                         // controller: Elastname_controller,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: 'Address',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter some text';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     // Row(
//                     // children: [
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     setState(() {
//                     //       // Set the color of the tapped container to blue
//                     //       // and reset the color of the other container
//                     //       maleContainerColor = Colors.blue;
//                     //       femaleContainerColor = Colors.white;
//                     //     });
//                     //   },
//                     //   child: Container(
//                     //     height: 50,
//                     //     width: 125,
//                     //     decoration: BoxDecoration(
//                     //       border:
//                     //           Border.all(width: 1.0, color: Colors.grey),
//                     //       borderRadius: BorderRadius.circular(5),
//                     //       color:
//                     //           maleContainerColor, // Set the color dynamically
//                     //     ),
//                     //     child: Center(
//                     //       child: Text("Male",
//                     //           style: TextStyle(
//                     //               color: maleContainerColor == Colors.blue
//                     //                   ? Colors.white
//                     //                   : Colors.black)),
//                     //     ),
//                     //   ),
//                     // ),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     setState(() {
//                     //       // Set the color of the tapped container to blue
//                     //       // and reset the color of the other container
//                     //       femaleContainerColor = Colors.blue;
//                     //       maleContainerColor = Colors.white;
//                     //     });
//                     //   },
//                     //   child: Container(
//                     //     height: 50,
//                     //     width: 125,
//                     //     decoration: BoxDecoration(
//                     //       border:
//                     //           Border.all(width: 1.0, color: Colors.grey),
//                     //       borderRadius: BorderRadius.circular(5),
//                     //       color:
//                     //           femaleContainerColor, // Set the color dynamically
//                     //     ),
//                     //     child: Center(
//                     //         child: Text(
//                     //       "Female",
//                     //       style: TextStyle(
//                     //           color: femaleContainerColor == Colors.blue
//                     //               ? Colors.white
//                     //               : Colors.black),
//                     //     )),
//                     //   ),
//                     // ),
//                     // ],
//                     // ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Country Code', // Text added here
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(
//                             height:
//                                 10), // Added spacing between text and CountryCodePicker
//                         // Row(
//                         // children: [
//                         Container(
//                           width: 250,
//                           height: 50,
//                           decoration: BoxDecoration(
//                               border:
//                                   Border.all(width: 0.8, color: Colors.grey),
//                               borderRadius: BorderRadius.circular(5)),
//                           child: CountryCodePicker(
//                             flagWidth: 25,
//                             onChanged: (CountryCode countryCode) {
//                               // Handle country code change
//                               print(
//                                   'New country selected: ${countryCode.name}');
//                             },
//                             initialSelection: 'भारत', // Initial country code
//                             favorite: [
//                               '+91',
//                               'भारत'
//                             ], // Optional: favorite country codes
//                             showCountryOnly:
//                                 true, // Display only the country name
//                             alignLeft:
//                                 true, // Align the flag and the country code to the left
//                             textStyle: TextStyle(
//                                 fontSize:
//                                     15), // Style for the country code text
//                           ),
//                         ),
//                         // ],
//                         // ),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Mobile Number', // Text added here
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         SizedBox(
//                           width: 250,
//                           height: 50,
//                           child: TextFormField(
//                             controller: Emobile_controller,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Mobile Number',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter some text';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Email', // Text added here
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         SizedBox(
//                           width: 250,
//                           height: 50,
//                           child: TextFormField(
//                             controller: Eemail_controller,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Email',
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter some text';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Divider(),

// // ------------
// // ------------gst info

  //  SizedBox(
  //   height: 15,
  // ),
  // // Divider(),
  // Text(
  //   'GST Info',
  //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
  // ),
  // SizedBox(
  //   height: 20,
  // ),
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //   children: [
  //     SizedBox(
  //       width: 250,
  //       height: 50,
  //       child: TextFormField(
  //         controller: GSTnocontroller,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(),
  //           labelText: 'GST Number',
  //         ),
  //         validator: (value) {
  //           if (value == null || value.isEmpty) {
  //             return 'Please enter some text';
  //           }
  //           return null;
  //         },
  //       ),
  //     ),
  //     // SizedBox(
  //     //   width: 10,
  //     // ),
  //     SizedBox(
  //       width: 250,
  //       height: 50,
  //       child: TextFormField(
  //         controller: GSTnamecontroller,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(),
  //           labelText: 'Registered Name',
  //         ),
  //         validator: (value) {
  //           if (value == null || value.isEmpty) {
  //             return 'Please enter some text';
  //           }
  //           return null;
  //         },
  //       ),
  //     ),
  //     SizedBox(
  //       width: 250,
  //       height: 50,
  //       child: TextFormField(
  //         controller: GSTaddresscontroller,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(),
  //           labelText: 'Registered Address',
  //         ),
  //         validator: (value) {
  //           if (value == null || value.isEmpty) {
  //             return 'Please enter some text';
  //           }
  //           return null;
  //         },
  //       ),
  //     ),
  //   ],
  // ),
  // SizedBox(
  //   height: 20,
  // ),
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //   children: [
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Country Code', // Text added here
  //           style: TextStyle(
  //             fontWeight: FontWeight.w400,
  //             fontSize: 14,
  //           ),
  //         ),
  //         SizedBox(
  //             height:
  //                 10), // Added spacing between text and CountryCodePicker
  //         // Row(
  //         // children: [
  //         Container(
  //           width: 250,
  //           height: 50,
  //           decoration: BoxDecoration(
  //               border:
  //                   Border.all(width: 0.8, color: Colors.grey),
  //               borderRadius: BorderRadius.circular(5)),
  //           child: CountryCodePicker(
  //             flagWidth: 25,
  //             onChanged: (CountryCode countryCode) {
  //               // Handle country code change
  //               print(
  //                   'New country selected: ${countryCode.name}');
  //             },
  //             initialSelection: 'भारत', // Initial country code
  //             favorite: [
  //               '+91',
  //               'भारत'
  //             ], // Optional: favorite country codes
  //             showCountryOnly:
  //                 true, // Display only the country name
  //             alignLeft:
  //                 true, // Align the flag and the country code to the left
  //             textStyle: TextStyle(
  //                 fontSize:
  //                     15), // Style for the country code text
  //           ),
  //         ),
  //         // ],
  //         // ),
  //       ],
  //     ),
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Mobile Number', // Text added here
  //           style: TextStyle(
  //             fontWeight: FontWeight.w400,
  //             fontSize: 14,
  //           ),
  //         ),
  //         SizedBox(height: 10),
  //         SizedBox(
  //           width: 250,
  //           height: 50,
  //           child: TextFormField(
  //             controller: GSTmobilecontroller,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: 'Mobile Number',
  //             ),
  //             validator: (value) {
  //               if (value == null || value.isEmpty) {
  //                 return 'Please enter some text';
  //               }
  //               return null;
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Email', // Text added here
  //           style: TextStyle(
  //             fontWeight: FontWeight.w400,
  //             fontSize: 14,
  //           ),
  //         ),
  //         SizedBox(height: 10),
  //         SizedBox(
  //           width: 250,
  //           height: 50,
  //           child: TextFormField(
  //             controller: GSTemailcontroller,
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(),
  //               labelText: 'Email',
  //             ),
  //             validator: (value) {
  //               if (value == null || value.isEmpty) {
  //                 return 'Please enter some text';
  //               }
  //               return null;
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   ],
  // ),
  // SizedBox(
  //   height: 35,
  // ),
  // Divider(),

// // --------------
//                 // _builStateform(),
//                 // Divider(),
//                 Center(
//                   child: Material(
//                     elevation: 4.0, // Set the elevation here
//                     borderRadius: BorderRadius.circular(18.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         print(
//                             "emergency:${Efirstname_controller.text},${Elastname_controller.text},${Emobile_controller.text},${Eemail_controller.text}");
//                         print(
//                             "GST:${GSTnamecontroller.text},${GSTnocontroller.text},${GSTmobilecontroller.text},${GSTemailcontroller.text},${GSTaddresscontroller.text}");
//                         printWhite("book:$booking_id");

//                         if (booking_id.isNotEmpty && booking_id != null) {
//                           Bookingapi(booking_id, total_fare);
//                         } else {
//                           print("null booking id");
//                         }
//                         _collectDataAndSubmit();

//                         //  flight_payment(total_fare, context);
//                         // Uri _uri = Uri.parse('https://boys.org.in/API/payment_api/payment_api/NON_SEAMLESS_KIT/ccavRequestHandler.php?order_id=11&amount=2000&customer_id=11&user_type=userType&billing_name=nandini&billing_address=kerala&billing_city=palakkad&billing_tel=9526751850&billing_email=nandhininatarajan04@gmail.com');

//                         //                   launchUrl(_uri);
//                       },
  // child: Container(
  //   alignment: Alignment.center,
  //   height: 50.0,
  //   width: 110.0,
  //   decoration: BoxDecoration(
  //     gradient: LinearGradient(
  //       colors: [
  //         Color(0xFF0072FF), // Darker blue
  //         Color(0xFF00C6FF), // Lighter blue
  //       ],
  //       begin: Alignment.topCenter,
  //       end: Alignment.bottomCenter,
  //       stops: [0.0, 1.0],
  //     ),
  //     borderRadius: BorderRadius.circular(18.0),
  //   ),
  // child: Text(
  //   'Continue',
  //   style: TextStyle(
  //     color: Colors.white,
  //     fontSize: 18.0,
  //     fontWeight: FontWeight.bold,
  //   ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }

  // _buildCancellation() {
  //   return Container(
  //     // height: 300,
  //     width: 900,
  //     color: Color.fromARGB(255, 255, 255, 255),
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(45, 20, 45, 20),
  //       child: Card(
  //         color: Colors.grey.shade200,
  //         child: Padding(
  //           padding: const EdgeInsets.all(12.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "Cancellation Refund Policy",
  //                 style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //               SizedBox(height: 10),
  //               Text(
  //                 '{widget.flightmodel.from_code}-{widget.flightmodel.to_code}',
  //                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
  //               ),
  //               SizedBox(height: 10),
  //               Text(
  //                 'Cancellation Penalty :',
  //                 style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
  //               ),
  //               SizedBox(height: 10),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   Text(
  //                     '₹ $cancel_fee',
  //                     style:
  //                         TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
  //                   ),
  //                   Text(
  //                     '₹ ${(double.parse(_totalbasefare) + double.parse(_totalsurcharges)).toStringAsFixed(0)}',
  //                     style:
  //                         TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     height: 10,
  //                     width: 600,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(15),
  //                       gradient: LinearGradient(
  //                         colors: [
  //                           Colors.green, // Start color
  //                           Colors.red, // End color
  //                         ],
  //                         begin: Alignment.centerLeft, // Start from the left
  //                         end: Alignment.centerRight, // End at the right
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 70),
  //                 child: Container(
  //                   width: 600,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         'Now',
  //                         style: TextStyle(
  //                             fontSize: 15, fontWeight: FontWeight.w700),
  //                       ),
  //                       // SizedBox(width: 10,),
  //                       Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Text(
  //                             formatDate(widget.flightmodel.departureTime)
  //                                 .substring(formatDate(
  //                                             widget.flightmodel.departureTime)
  //                                         .length -
  //                                     7),
  //                             style: TextStyle(
  //                                 fontSize: 15, fontWeight: FontWeight.w700),
  //                           ),
  //                           Text(
  //                             formatTime(widget.flightmodel
  //                                 .departureTime), // Assuming '20:00' is a placeholder
  //                             style: TextStyle(
  //                                 fontSize: 13, fontWeight: FontWeight.w500),
  //                           ),
  //                         ],
  //                       ),
  //                       //  SizedBox(width: 10,),
  //                       Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Text(
  //                             formatDate(widget.flightmodel.departureTime)
  //                                 .substring(formatDate(
  //                                             widget.flightmodel.departureTime)
  //                                         .length -
  //                                     7),
  //                             style: TextStyle(
  //                                 fontSize: 15, fontWeight: FontWeight.w700),
  //                           ),
  //                           Text(
  //                             formatTime(widget.flightmodel
  //                                 .arrivalTime), // Assuming '20:00' is a placeholder
  //                             style: TextStyle(
  //                                 fontSize: 13, fontWeight: FontWeight.w500),
  //                           ),
  //                         ],
  //                       ),
  //                       // SizedBox(width: 10,),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 10),
  //               Text(
  //                 'Cancel Between (IST) :',
  //                 style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  _builStateform() {
    return Container(
      height: 200,
      width: 900,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Your State",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "(Required for GST purpose on your tax invoice. You can edit this anytime later in your profile section. )",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text("Select a State",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select State',
                ),
                value: selectedState,
                onChanged: (String newValue) {
                  setState(() {
                    selectedState = newValue;
                  });
                },
                items: indianStates.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a state';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _builStateform() {
  //   return Container(
  //     height: 200,
  //     width: 900,
  //     color: Colors.white,
  //     child: Padding(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Text("Your State",
  //                   style:
  //                       TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
  //               SizedBox(
  //                 width: 5,
  //               ),
  //               Text(
  //                 "(Required for GST purpose on your tax invoice. You can edit this anytime later in your profile section. )",
  //                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  //               )
  //             ],
  //           ),
  //           SizedBox(
  //             height: 15,
  //           ),
  //           Text("Select a State",
  //               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
  //           SizedBox(
  //             height: 15,
  //           ),
  //           SizedBox(
  //             width: 250,
  //             height: 50,
  //             child: TextFormField(
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 labelText: 'Kerala',
  //               ),
  //               validator: (value) {
  //                 if (value == null || value.isEmpty) {
  //                   return 'Please enter some text';
  //                 }
  //                 return null;
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // mealsform() {
  //   return
  // Container(
  //     height: 35,
  //     width: 900,
  //     child: Center(child: Text("Seats & Meals",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w800,color: Colors.grey.shade500),)),
  //   );
  // }

  _buildSeatmealsform() {
    return Container(
      height: 45,
      width: 900,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 10, 0, 10),
        child: Row(
          children: [
            Text(
              "Meals",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  _buildaddOnform() {
    return Container(
      height: 45,
      width: 900,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 10, 0, 10),
        child: Row(
          children: [
            Text(
              "Add Ons",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  _buildpromocodes(screenWidth, screenHeight) {
    // Define filteredPromoCodes as a state variable
    List<CodeData> filteredPromoCodes = [];

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Container(
        color: Colors.white,
        height: 800,
        width: screenWidth * 0.18,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: screenWidth * 0.18,
                color: Color.fromARGB(255, 60, 70, 126),
                child: Center(
                  child: Text(
                    "Promo Codes",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 252, 250, 250),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                height: 50,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      // Filter promo codes based on search text
                      filteredPromoCodes = promocodes
                          .where((codeData) => codeData.promoCode
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Promo Code',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              // Display the appropriate list based on filteredPromoCodes
              filteredPromoCodes.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: filteredPromoCodes.length ?? 0,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          final code = filteredPromoCodes[index].promoCode;
                          final discount = filteredPromoCodes[index].discount;
                          return Center(
                            child: GestureDetector(
                              onTap: () {
                                printred(index.toString());
                              },
                              child: Container(
                                height: 100,
                                width: screenWidth * 0.16,
                                color: Colors.grey.shade200,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                          "Congratulations! Promo Discount \nof $discount% applied successfully.",
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
                    )
                  : filteredPromoCodes.isEmpty && _controller.text.isNotEmpty
                      ? Text('Invalid search') // Show invalid search message
                      : Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: promocodes.length ?? 0,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10);
                            },
                            itemBuilder: (context, index) {
                              final code = promocodes[index].promoCode;
                              final discount = promocodes[index].discount;
                              return Center(
                                child: GestureDetector(
                                  onTap: () {
                                    print("promocodes index: $index");

                                    print("Promocode discount :$discount");
                                    showCustomAlertDialog(context, discount);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: screenWidth * 0.16,
                                    color: Colors.grey.shade200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Color.fromARGB(
                                              255, 107, 107, 107),
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
                                              "Congratulations! Promo Discount \nof $discount% applied successfully.",
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
                        ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTripsecure() {
    bool _yesSelected = false;
    bool _noSelected = false;
    return Container(
      height: 530,
      width: 900,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 15,
                    backgroundColor: Color.fromARGB(255, 207, 224, 251),
                    child: Center(
                      child: Icon(
                        Icons.security_rounded,
                        color: Color.fromARGB(255, 15, 70, 124),
                      ),
                    )),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Trip Secure",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 130,
            width: 900,
            color: Color.fromARGB(255, 243, 228, 245),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "₹149",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    Text(
                      "/Traveller (18% GST included)",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 50,
                    width: 750,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final Iconlist = [
                            Icons.call,
                            Icons.flight,
                            Icons.free_cancellation_rounded,
                            Icons.no_luggage,
                            Icons.heart_broken,
                          ];
                          final text1 = [
                            " Support  ",
                            'Up to',
                            'Up to',
                            "Flat",
                            "Flat",
                          ];
                          final text2 = [
                            "24x7",
                            " ₹ 3,000",
                            " ₹ 3,000",
                            " ₹ 2,000",
                            ' ₹ 50,000 '
                          ];
                          final text3 = [
                            "Delayed/lost baggage Assistance",
                            "Missed Flight",
                            "Trip Cancellation",
                            "Delay of Checked in baggage ",
                            "Accidental Death(24 hours)",
                          ];
                          return Container(
                            height: 20,
                            width: 230,
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Iconlist[index],
                                    size: 25,
                                    color: Colors.blueAccent,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(text1[index],
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 141, 143, 143),
                                                  fontWeight: FontWeight.w700)),
                                          Text(text2[index],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 4, 139, 115),
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      Text(text3[index],
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color.fromARGB(
                                                  255, 16, 16, 16),
                                              fontWeight: FontWeight.w700))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Container(
              height: 40,
              width: 800,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(255, 245, 188, 124)
                          .withOpacity(0.5), // Start color
                      Color.fromARGB(255, 141, 198, 245)
                          .withOpacity(0.5), // End color
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Row(
                    children: [
                      Text('Recommended for your travel within India.',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13)),
                    ],
                  ),
                ), // Optional: To fill the container with the gradient
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Radio(
                  value: true,
                  groupValue: _isSelectedradio,
                  onChanged: (bool value) {
                    setState(() {
                      _isSelectedradio = value;
                    });
                  },
                ),
                Text(
                  "Yes ",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                Text(
                  ", Secure my trip.",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Radio(
                  value: false,
                  groupValue: _isSelectedradio,
                  onChanged: (bool value) {
                    setState(() {
                      _isSelectedradio = value;
                    });
                  },
                ),
                Text(
                  "No ",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                Text(
                  ", i will book without Trip Secure.",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       Radio(
          //         value: true,
          //         groupValue: _yesSelected,
          //         onChanged: (bool value) {
          //           setState(() {
          //             _yesSelected = value;
          //             _noSelected = !value;
          //           });
          //         },
          //       ),

          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     children: [
          //       Radio(
          //         value: true,
          //         groupValue: _noSelected,
          //         onChanged: (bool value) {
          //           setState(() {
          //             _noSelected = value;
          //             _yesSelected = !value;
          //           });
          //         },
          //       ),

          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "Preferred by millions of travellers",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
            ),
          ),
          Center(
            child: Container(
              height: 70,
              width: 750,
              child: ListView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 1.0, color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              "\“I'm selfish, impatient and a little insecure. I make mistakes,\n But if you can't handle me at my worst, then you sure as \nhell don't deserve me at my best.\”",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Text(
                  "By selecting the product, I confirm the travellers age is between 6 months and 70 years and agree to the",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                ),
                Text(" T&Cs",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue))
              ],
            ),
          )
        ],
      ),
    );
  }
Future<void> Bookingapi(
  String booking_id,
  String total_fare,
  List<Map<String, String>> travelerDetails,
  BuildContext context, // Add BuildContext as a parameter
) async {
  print("api function");
  try {
    String res = await Confirm_Booking_Passport_api(
      booking_id: booking_id,
      fare: total_fare,
      gstAddress: GSTaddresscontroller.text,
      deliveryContact: emergencyMobileController.text,
      deliveryEmail: emergencyEmailController.text,
      gstEmail: GSTemailcontroller.text,
      gstNumber: GSTnocontroller.text,
      gstMobile: GSTmobilecontroller.text,
      gstName: GSTnamecontroller.text,
      travelerDetails: travelerDetails,
     
    );

    if (res != 'failed') {
      Map<String, dynamic> jsonResponse = jsonDecode(res);

      if (jsonResponse.containsKey('status') && jsonResponse['status']['success'] == true) {
        String fetchedBookingId = jsonResponse['bookingId'];
        print('Booking Successful! Booking ID: $fetchedBookingId');
        bookingRetrieve(fetchedBookingId);
        flight_payment(total_fare, context);

        // Show success alert dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Booking Successful!'),
              content: Text('Booking ID: $fetchedBookingId'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => MyTripPage())
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        String errorMessage = jsonResponse['errors'][0]['message'];
        print('Booking Failed: $errorMessage');

        // Show error alert dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Booking Failed'),
              content: Text(errorMessage),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      print('Booking Failed: Failed to get response from the server');

      // Show server error alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Booking Failed'),
            content: Text('Failed to get response from the server'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    print('Error during booking: $e');

    // Show exception error alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Error during booking: $e'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
}








//   Future<void> Bookingapi(
//     String booking_id,
//     String total_fare,
//     List<Map<String, String>> travelerDetails,
//   ) async {
//     print("api function");
//     try {
//       String res = await Confirm_Booking_Passport_api(
//           booking_id: booking_id,
//           fare: total_fare,
//           gstAddress: GSTaddresscontroller.text,
//           deliveryContact: emergencyMobileController.text,
//           deliveryEmail: emergencyEmailController.text,
//           gstEmail: GSTemailcontroller.text,
//           gstNumber: GSTnocontroller.text,
//           gstMobile: GSTmobilecontroller.text,
//           gstName: GSTnamecontroller.text,
//           travelerDetails: travelerDetails,
//           igm: igm,
//           gstappl: gstappl);
//       if (res != 'failed') {
//         Map<String, dynamic> jsonResponse = jsonDecode(res);
// if (jsonResponse.containsKey('status') &&
//     jsonResponse['status']['success'] == true) {
//   String fetchedBookingId = jsonResponse['bookingId'];
//   print('Booking Successful! Booking ID: $fetchedBookingId');
//   bookingRetrieve(fetchedBookingId);
//   flight_payment(total_fare, context);

//   // Show success alert dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Booking Successful!'),
//         content: Text('Booking ID: $fetchedBookingId'),
//         actions: <Widget>[
//           TextButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Dismiss the dialog
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => MyTripPage()));
//             },
//           ),
//         ],
//       );
//     },
//   );
// } else {
//   String errorMessage = jsonResponse['errors'][0]['message'];
//   print('Booking Failed: $errorMessage');

//   // Show error alert dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Booking Failed'),
//         content: Text(errorMessage),
//         actions: <Widget>[
//           TextButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Dismiss the dialog
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
// } else {
//   print('Booking Failed: Failed to get response from the server');

//   // Show server error alert dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Booking Failed'),
//         content: Text('Failed to get response from the server'),
//         actions: <Widget>[
//           TextButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Dismiss the dialog
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
// } catch (e) {
//   print('Error during booking: $e');

//   // Show exception error alert dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Error'),
//         content: Text('Error during booking: $e'),
//         actions: <Widget>[
//           TextButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Dismiss the dialog
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

       
//       } else {
//         print('Booking Failed: Failed to get response from the server');
//       }
//     } catch (e) {
//       print('Error during booking: $e');
//     }
//   }

 // if (jsonResponse.containsKey('status') &&
        //     jsonResponse['status']['success'] == true) {
        //   String fetchedBookingId = jsonResponse['bookingId'];
        //   print('Booking Successful! Booking ID: $fetchedBookingId');
        //   bookingRetrieve(fetchedBookingId);
        //   flight_payment(total_fare, context);
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => MyTripPage()));
        // } else {
        //   String errorMessage = jsonResponse['errors'][0]['message'];
        //   print('Booking Failed: $errorMessage');
        // }







  // Future<void> Bookingapi(
  //   String booking_id,
  //   String total_fare,
  //   List<Map<String,String>> travelerDetails
  // ) async {
  //   try {
  //     String res = await Confirm_Booking_Passport_api(
  //       booking_id: booking_id,
  //       fare: total_fare,
  //       gstAddress: GSTaddresscontroller.text,
  //       deliveryContact: emergencyMobileController.text,
  //       deliveryEmail: emergencyEmailController.text,
  //       gstEmail: GSTemailcontroller.text,
  //       gstNumber: GSTmobilecontroller.text,
  //       gstMobile: GSTmobilecontroller.text,
  //       gstName: GSTnamecontroller.text,
  //        travelerDetails: travelerDetails
  //     );
  //     if (res != 'failed') {
  //       Map<String, dynamic> jsonResponse = jsonDecode(res);

  //       if (jsonResponse.containsKey('status') &&
  //           jsonResponse['status']['success'] == true) {
  //         String fetchedBookingId = jsonResponse['bookingId'];
  //         print('Booking Successful! Booking ID: $fetchedBookingId');
  //         bookingRetrieve(fetchedBookingId);
  //       } else {
  //         String errorMessage = jsonResponse['errors'][0]['message'];
  //         print('Booking Failed: $errorMessage');
  //       }
  //     } else {
  //       print('Booking Failed: Failed to get response from the server');
  //     }
  //   } catch (e) {
  //     print('Error during booking: $e');
  //   }
  // }

  Future<void> bookingRetrieve(String fetchedBookingId) async {
    String res = await Booking_Retrieve_api(fetchedBookingId);
    if (res != 'failed') {
      print(res);

      Map<String, dynamic> resMap = jsonDecode(res);

      BookingRetrieveobj obj = BookingRetrieveobj.fromJson(resMap);
      print("retrieved: $obj");
    }
  }
}

flight_payment(total_fare, context) {
  Uri _uri = Uri.parse(
      'http://gotodestination.in/api/payment_api/payment/payment_api/NON_SEAMLESS_KIT/ccavRequestHandler.php?block_key=null&booking_id=$booking_id&rpax_pricing=false&package_details="package"&package_id=1&user_id=$user_id&amount=1&customer_id=$user_id&user_type=flight&billing_name=${user_name}&billing_address=${user_address}&billing_city=${user_city}&billing_tel=${user_mobile}&billing_email=${user_email}');

  if (booking_id != null && user_id != null) {
    launchUrl(_uri);
  } else if (booking_id == null) {
    showCustomAboutDialog(context, booking_id, "Booking id");
  } else if (user_id == null) {
    showCustomAboutDialog(context, user_id, "user id");
  }
}

void showCustomAboutDialog(BuildContext context, String value, String val) {
  showAboutDialog(
    context: context,
    // applicationName: 'My App',
    // applicationVersion: '1.0.0',
    applicationIcon: Icon(Icons.info),
    children: [
      value != null ? Text('The $val is $val.') : Text('The $val is: $value'),
    ],
  );
}


// _buildpromocodes(screenWidth, screenHeight) {
//   return Container(
//     color: Colors.white,
//     height: 800,
//     width: screenWidth * 0.18,
//     child: Padding(
//       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//       child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
//         Container(
//           height: 50,
//           width: screenWidth * 0.18,
//           color: Color.fromARGB(255, 60, 70, 126),
//           child: Center(
//             child: Text(
//               "Promo Codes",
//               style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.w800,
//                   color: Color.fromARGB(255, 252, 250, 250)),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         GestureDetector(
//           onTap: (){

//           },
//           child: SizedBox(
//             width: 250,
//             height: 50,
//             child: TextFormField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Enter Promo Code',
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         promocodes.length != 0
//             ? Container(
//                 child: ListView.separated(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     itemCount: promocodes.length,
//                     separatorBuilder: (context, index) {
//                       return SizedBox(
//                         height: 10,
//                       );
//                     },
//                     itemBuilder: (context, index) {
//                       final code = promocodes[index].promoCode;
//                       final discount = promocodes[index].discount;
//                       return Center(
//                         child: Container(
//                           height: 100,
//                           width: screenWidth * 0.16,
//                           color: Colors.grey.shade200,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               CircleAvatar(
//                                 radius: 10,
//                                 backgroundColor:
//                                     Color.fromARGB(255, 107, 107, 107),
//                                 child: CircleAvatar(
//                                   radius: 9,
//                                   backgroundColor: Colors.white,
//                                 ),
//                               ),
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Text(
//                                     code.toUpperCase(),
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   Text(
//                                     "Congratulations! Promo Discount \nof $discount% applied successfully.",
//                                     style: TextStyle(
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                   Text(
//                                     "Terms & Conditions apply",
//                                     style: TextStyle(
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.w400,
//                                         color: Colors.blue),
//                                   ),
//                                 ],
//                               ),
//                               Icon(
//                                 Icons.card_giftcard,
//                                 size: 23,
//                                 color: Colors.grey.shade600,
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//               )
//             : SizedBox()
//       ]),
//     ),
//   );
// }
