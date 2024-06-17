import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/api_services/bus%20apis/print_ticket_api.dart';
import 'package:trip/api_services/payment_api/cancellation_api.dart';
import 'package:trip/common/print_funtions.dart';
import 'package:trip/constants/fonts.dart';
import 'package:trip/login_variables/login_Variables.dart';
import 'package:trip/screens/Tickets/busTicketpage.dart';
import 'package:trip/screens/Tickets/flightTicket.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import 'package:trip/screens/mytrip_screen/widgets/nulldetails.dart';
import '../../api_services/activity/get_activity_details.dart';
import '../../api_services/bus apis/confirm_booking_api.dart';
import '../../api_services/bus apis/store_tid/get_tid_data.dart';
import '../../api_services/bus apis/store_tid/post_tid_data.dart';
import '../../api_services/flight/Booking Retrieve/booking_details.dart';
import '../../api_services/flight/flightcancellation_api.dart';
import '../../api_services/flight_retrieve_ticket/flight_retrieve.dart';
import '../../api_services/holiday_packages/get_packages_byid_api.dart';
import '../../api_services/my_trip_apis/activity_type_api.dart';
import '../../api_services/my_trip_apis/bus_type_api.dart';
import '../../api_services/my_trip_apis/flight_type_api.dart';
import '../../api_services/my_trip_apis/holiday_type_api.dart';
import '../../api_services/payment_api/cancelled_payments_api.dart';
import '../../api_services/payment_api/completed_payment_api.dart';
import '../../models/flight_ticketmodel.dart';
import '../../models/flighttypemodel.dart';
import '../constant.dart';
import '../header.dart';

List<PackageOption> packagelist;
PackageOption packageac;

class MyTripPage extends StatefulWidget {
  const MyTripPage({key});

  @override
  State<MyTripPage> createState() => _MyTripPageState();
}

Color ContainerClr = Colors.greenAccent;
int value;
// List<SuccessPaymentData> successdata = [];
List<SuccessPaymentData> cancelleddata = [];
List<SuccessPaymentData> upcomingdata = [];
List<SuccessPaymentData> Activitysuccessdata = [];
List<flightData> flightSuccessData = [];
List<SuccessPaymentData> BusSuccessData = [];
List<SuccessPaymentData> BusConstsntData = [];
List<SuccessPaymentData> HolidaySuccessData = [];

// cancellation
List<SuccessPaymentData> ActivityCancelleddata = [];
List<SuccessPaymentData> flightCancelledData = [];
List<SuccessPaymentData> BusCancelledData = [];
List<SuccessPaymentData> HolidayCancelledData = [];

bool showActivities = true;
bool showFlights = false;
bool showBus = false;
bool showholiday = false;
// cancellation
bool showCancelledActivities = true;
bool showCancelledFlights = false;
bool showCancelledBus = false;
bool showCancelledholiday = false;
// activity
String jsondetails;
List<Datum> _activityData;

Datum activitydatum;
// holiday
List<Details> holidaypackageDetails;
// Define a map to store blockkey-tin pairs
Map<String, String> blockkeyTinMap = {};
// flights
List<FlightTicketobj> flightdatas = [];
String orderId;
TextEditingController flightRemarkcontroller=TextEditingController();
class _MyTripPageState extends State<MyTripPage> {
  @override
  void initState() {
    super.initState();
    getFlightpayments();
    getbuspayments();
    getActivitypayments();
    getHolidaypayments();
    getCancelledPayments(user_id);
    log('BlockKey-TIN Map: $blockkeyTinMap');
    log("userid:$user_id");
  }

  getCancelledPayments(id) async {
    String res = await cancelledPaymentAPI(id);
    if (res != 'failed') {
      print("res=not failed");
      SuccessPayments obj = SuccessPayments.fromJson(jsonDecode(res));
      List<SuccessPaymentData> data = obj.data;
      setState(() {
        cancelleddata = data;
      });
    }
    // printWhite("cancelleddata:${cancelleddata.length}");
    if (cancelleddata.isNotEmpty) {
      for (var data in cancelleddata) {
        if (data.userType == 'Activities') {
          setState(() {
            ActivityCancelleddata.add(data);
          });
        } else if (data.userType == 'holiday') {
          setState(() {
            HolidayCancelledData.add(data);
          });
        } else if (data.userType == 'bus') {
          setState(() {
            BusCancelledData.add(data);
          });
        } else if (data.userType == 'flight') {
          setState(() {
            flightCancelledData.add(data);
          });
        }
      }
    }
    printWhite("Cancelled data:${cancelleddata.length}");
    printWhite("Activity Cancelled data:${ActivityCancelleddata.length}");
    printWhite("Bus Cancelled data:${BusCancelledData.length}");
    printWhite("Holiday Cancelled data:${HolidayCancelledData.length}");
    printWhite("Flight Cancelled data:${flightCancelledData.length}");
  }

  getFlightpayments() async {
    if (user_id != null) {
      String res = await CompletedpaymentFlightAPI(user_id);
      if (res != 'failed') {
        Flighttype obj = Flighttype.fromJson(jsonDecode(res));
        List<flightData> data = obj.data;
        setState(() {
          flightSuccessData = data;
        });
        printred("FlightObj:${flightSuccessData.length}");
        Set<FlightTicketobj> uniqueFlights = {};
        if (flightSuccessData.isNotEmpty) {
          for (int i = 0; i < flightSuccessData.length; i++) {
            flightData flight = flightSuccessData[i];
            setState(() {
              orderId = flight.orderId;
            });
            if (flight.bookingId != null) {
              String res =
                  await FlightTciketApi(flight.bookingId, flight.orderId);
              Flightticket obj = Flightticket.fromJson(jsonDecode(res));
              // uniqueFlights.add(obj);
              printWhite("ticket: $obj");
              printWhite("ticket: $res");
            }
          }
        }
        setState(() {
          flightdatas = uniqueFlights.toList();
        });
      }
    }
  }

  Future<void> getbuspayments() async {
    if (user_id == null) return;

    try {
      // Fetch completed bus payments for the user
      String res = await CompletedpaymentBusAPI(user_id);

      if (res != 'failed') {
        // Parse the response into SuccessPayments object
        SuccessPayments obj = SuccessPayments.fromJson(jsonDecode(res));
        List<SuccessPaymentData> data = obj.data;

        // Update state with fetched data
        setState(() {
          BusSuccessData = data;
        });

        // Log the length of fetched data
        printred("BusObj: ${BusSuccessData.length}");

        // Process each bus payment data
        for (SuccessPaymentData bus in BusSuccessData) {
          await processBusPayment(bus);
        }
      } else {
        print("Failed to fetch completed bus payments");
      }
    } catch (e) {
      print('Error fetching bus payments: $e');
    }
  }

  Future<void> processBusPayment(SuccessPaymentData bus) async {
    try {
      // Check if blockKey is valid
      if (bus.blockKey != null && bus.blockKey != 'null') {
        // Fetch details from API using blockKey
        String res = await getTidAPI(block_key: bus.blockKey);

        if (res != 'failed' && res != 'null') {
          TicketModel obj = TicketModel.fromJson(jsonDecode(res));
          List<TicketData> details = obj.data;

          // Check if blockKey is already initialized
          bool alreadyInitialized =
              details.any((detail) => detail.blockId == bus.blockKey);

          if (!alreadyInitialized) {
            // Confirm booking and post tid to API
            String tin = await ConfirmBookingAPI(bus.blockKey);
            await postTidAPI(
              tid: tin,
              block_id: bus.blockKey,
              orderid: bus.orderId,
              user_id: user_id,
            );
            gettid(bus.blockKey);
            // Future.delayed(0.1 as Duration);
            // String res = await getTidAPI(block_key: bus.blockKey);
            print(" res: after post");
            print("New TID posted for blockKey: ${bus.blockKey}");
          } else {
            print("Already in db blockKey: ${bus.blockKey}");
            // Assuming busTicketAPI returns some details related to the ticket
            String ticketDetails = await busTicketAPI(details[0].tid);
            print("Bus Ticket Details: $ticketDetails");
          }
        } else if (res == 'null') {
          // Confirm booking and post tid to API when response is 'null'
          String tin = await ConfirmBookingAPI(bus.blockKey);
          await postTidAPI(
            tid: tin,
            block_id: bus.blockKey,
            orderid: bus.orderId,
            user_id: user_id,
          );
          gettid(bus.blockKey);
          print("New TID posted for blockKey: ${bus.blockKey}");
        } else {
          print("Failed to fetch TID for blockKey: ${bus.blockKey}");
        }
      } else {
        print("Invalid blockKey for bus ID: ${bus.tid}");
      }
    } catch (e) {
      print(
          'Error processing bus payment data for blockKey: ${bus.blockKey}, Error: $e');
    }
  }

  Future<String> gettid(blockKey) async {
    String res = await getTidAPI(block_key: blockKey);
    print("res: after post : $res");
    return res;
  }

  // getbuspayments() async {
  //   if (user_id != null) {
  //     String res = await CompletedpaymentBusAPI(user_id);
  //     if (res != 'failed') {
  //       SuccessPayments obj = SuccessPayments.fromJson(jsonDecode(res));
  //       List<SuccessPaymentData> data = obj.data;
  //       setState(() {
  //         BusSuccessData = data;
  //       });
  //       printred("BusObj:${BusSuccessData.length}");
  //       if (BusSuccessData.isNotEmpty) {
  //         for (int i = 0; i < BusSuccessData.length; i++) {
  //           print("i:$i");
  //           SuccessPaymentData bus = BusSuccessData[i];

  //           bool alreadyExists =
  //               BusConstsntData.any((element) => element.tid == bus.tid);
  //           if (!alreadyExists) {
  //             // New data found
  //             printWhite(
  //                 'New Data Found: Bus ID: ${bus.tid}, Amount: ${bus.amount},blockkey:${bus.blockKey}');

  //             if (bus.blockKey != null || bus.blockKey != 'null') {
  //               // Call API to handle new data and get tin
  //               String tin = await ConfirmBookingAPI(bus.blockKey);

  //               // Store blockkey-tin pair in the map

  //               setState(() {
  //                 blockkeyTinMap[bus.blockKey] = tin;
  //               });
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }
  // }

  getActivitypayments() async {
    if (user_id != null) {
      String res = await CompletedpaymentActivityAPI(user_id);
      if (res != 'failed') {
        SuccessPayments obj = SuccessPayments.fromJson(jsonDecode(res));
        List<SuccessPaymentData> data = obj.data;
        setState(() {
          Activitysuccessdata = data;
        });

        printred("activitiesObj:${Activitysuccessdata.length}");

        if (Activitysuccessdata.length != 0) {
          for (int i = 0; i < Activitysuccessdata.length; i++) {
            SuccessPaymentData activity = Activitysuccessdata[i];
            if (activity.packageId != null) {
              try {
                activityobj obj =
                    await getActivitiesdetailsAPI(activity.packageId);
                jsondetails = jsonEncode(obj);
                print('Activity Name: ${obj.data[0].packageName}');
                setState(() {
                  _activityData = obj.data;
                  activitydatum = _activityData[0];
                  packagelist = obj.packageOption;
                });
              } catch (e) {
                print('Error fetching activity details: $e');
              }
            }
          }
        }
      }
    }
  }

  getHolidaypayments() async {
    if (user_id.isNotEmpty) {
      String res = await CompletedpaymentHolidayAPI(user_id);
      if (res != 'failed') {
        SuccessPayments obj = SuccessPayments.fromJson(jsonDecode(res));
        List<SuccessPaymentData> data = obj.data;
        setState(() {
          HolidaySuccessData = data;
        });
        //  setHolidaySuccessData(data);
        printred("HolidayObj:${HolidaySuccessData.length}");

        if (data.isNotEmpty) {
          for (var holiday in data) {
            if (holiday.packageId != null) {
              try {
                String packageDetailsResponse =
                    await getHolidayPackagesdetailsAPI(holiday.packageId);
                if (packageDetailsResponse != 'failed') {
                  HolidayPackagedetails packageDetailsObj =
                      HolidayPackagedetails.fromJson(
                          jsonDecode(packageDetailsResponse));
                  List<Details> packageData = packageDetailsObj.packages;
                  Details holidaydata = packageData[0];
                  if (packageData.isNotEmpty) {
                    setState(() {
                      holidaypackageDetails.addAll(packageData);
                    });

                    log("holidaysuccessdata: ${HolidaySuccessData.length}");

                    log("holidaypackagedetails: ${holidaypackageDetails.length}");

                    //  setHolidayPackageDetails(packageData);

                    //                    setHolidaySuccessData: (data) {
                    //       setState(() {
                    //         holidaySuccessData = data;
                    //       });
                    //     },
                    //     setHolidayPackageDetails: (data) {
                    //       setState(() {
                    //         holidayPackageDetails.addAll(data);
                    //       });
                    //     },
                    //   );
                    // }
                  }
                }
              } catch (e) {
                print('Error fetching holiday details: $e');
              }
            }
          }
        }
      }
    }
  }

  // getHolidaypayments() async {
  //   if (user_id != null) {
  //     String res = await CompletedpaymentHolidayAPI(user_id);
  //     if (res != 'failed') {
  //       SuccessPayments obj = SuccessPayments.fromJson(jsonDecode(res));
  //       List<SuccessPaymentData> data = obj.data;
  //       setState(() {
  //         HolidaySuccessData = data;
  //       });
  //       printred("HolidayObj:${HolidaySuccessData.length}");
  //       if (HolidaySuccessData.length != 0) {
  //         for (int i = 0; i < HolidaySuccessData.length; i++) {
  //           SuccessPaymentData activity = HolidaySuccessData[i];
  //           if (activity.packageId != null) {
  //             try {
  //               Details holiday;
  //               HolidayPackagedetails obj =
  //                   HolidayPackagedetails.fromJson(jsonDecode(res));
  //               List<Details> data = obj.packages;

  //               setState(() {
  //                 holiday = data[0];
  //                 holidaypackageDetails.add(holiday);
  //               });
  //             } catch (e) {
  //               print('Error fetching holiday details: $e');
  //             }
  //           }
  //         }
  //       }
  //     }
  //   }
  // }

  // tin:69BTVJHM

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    width: swidth,
                    height: sheight * 0.35,
                    color: ContainerClr,
                  ),
                  // tripsearchContainer(swidth, sheight),
                  tripDetails(swidth, sheight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  tripDetails(double swidth, double sheight) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 152.0),
        child: Container(
          width: swidth * 0.7,
          // height: sheight * 0.5,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Container(
                width: swidth * 0.7,
                height: sheight * 0.16,
                color: Colors.transparent,
                child: Card(
                  elevation: 5.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          kwidth30,
                          kwidth30,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                ContainerClr = Colors.orangeAccent;
                                value = 1;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              // color: Colors.greenAccent,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.cancel,
                                        size: 35,
                                        color: Colors.black,
                                        fill: 1.0,
                                      ),
                                      kwidth5,
                                      Text(
                                        "Cancelled",
                                        style: rajdhani20W7,
                                      )
                                    ],
                                  ),
                                  Visibility(
                                      visible: value == 1 ? true : false,
                                      child: kheight10),
                                  Visibility(
                                    visible: value == 1 ? true : false,
                                    child: Container(
                                      height: 5,
                                      width: 100,
                                      color: Colors.blueAccent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          kwidth30,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                ContainerClr = Colors.grey;
                                value = 2;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              // color: Colors.greenAccent,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.done_all_outlined,
                                        size: 35,
                                        color: Colors.black,
                                        fill: 1.0,
                                      ),
                                      kwidth5,
                                      Text(
                                        "Completed",
                                        style: rajdhani20W7,
                                      )
                                    ],
                                  ),
                                  Visibility(
                                      visible: value == 2 ? true : false,
                                      child: kheight10),
                                  Visibility(
                                    visible: value == 2 ? true : false,
                                    child: Container(
                                      height: 5,
                                      width: 100,
                                      color: Colors.blueAccent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: value == 1 ? true : false,
                  child: Center(
                      child: Container(
                    // height: 180,
                    // width: 150,
                    // color: Colors.green,
                    child: cancelleddata.length != 0
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //  height:sheight,
                              width: swidth * 0.6,
                              color: Colors.white,
                              child: cancelleddata.length != 0
                                  ? Container(
                                      child: Column(
                                        children: [
                                          kheight20,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showActivities = true;
                                                    showFlights = false;
                                                    showBus = false;
                                                    showholiday = false;
                                                  });
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          showActivities == true
                                                              ? Colors.blue
                                                              : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                      child: Text(
                                                    "Activities",
                                                    style: GoogleFonts.rajdhani(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          showActivities == true
                                                              ? Colors.white
                                                              : Colors.black,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showholiday = true;
                                                    showFlights = false;
                                                    showBus = false;
                                                    showActivities = false;
                                                  });
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      color: showholiday == true
                                                          ? Colors.blue
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                      child: Text(
                                                    "Holiday Packages",
                                                    style: GoogleFonts.rajdhani(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: showholiday == true
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showBus = true;
                                                    showFlights = false;
                                                    showholiday = false;
                                                    showActivities = false;
                                                  });
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      color: showBus == true
                                                          ? Colors.blue
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                      child: Text(
                                                    "Bus",
                                                    style: GoogleFonts.rajdhani(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: showBus == true
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showFlights = true;
                                                    showBus = false;
                                                    showholiday = false;
                                                    showActivities = false;
                                                  });
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      color: showFlights == true
                                                          ? Colors.blue
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                      child: Text(
                                                    "Flights",
                                                    style: GoogleFonts.rajdhani(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: showFlights == true
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  )),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                            ],
                                          ),
                                          if (showActivities == true)
                                            CancellationcommonList(swidth,
                                                sheight, ActivityCancelleddata),
                                          // ActivityList(
                                          //     swidth: swidth,
                                          //     sheight: sheight,
                                          //     activityData: _activityData,
                                          //     activitySuccessData:
                                          //         Activitysuccessdata),
                                          if (showholiday == true)
                                            CancellationcommonList(swidth,
                                                sheight, HolidayCancelledData),
                                          // HolidayList(
                                          //     swidth: swidth,
                                          //     sheight: sheight,
                                          //     holidaySuccessData:
                                          //         HolidaySuccessData,
                                          //     holidayPackageDetails:
                                          //         holidaypackageDetails),
                                          if (showBus == true)
                                            CancellationcommonList(swidth,
                                                sheight, BusCancelledData),
                                          // BusList(
                                          //     swidth: swidth,
                                          //     sheight: sheight,
                                          //     BusSuccessData: BusSuccessData,
                                          //     blockkeyTinMap: blockkeyTinMap),
                                          if (showFlights == true)
                                            CancellationcommonList(swidth,
                                                sheight, flightCancelledData),
                                          // flightList(swidth, sheight,
                                          //     flightSuccessData, flightdatas)
                                        ],
                                      ),
                                    )
                                  : details(
                                      swidth,
                                      sheight,
                                      "Looks empty, you've no cancelled bookings.",
                                      "Great! Looks like you’ve no cancelled bookings."),
                            ))
                        : details(
                            swidth,
                            sheight,
                            "Looks empty, you've no cancelled bookings.",
                            "Great! Looks like you’ve no cancelled bookings."),
                  ))),
              Visibility(
                visible: value == 2 ? true : false,
                child: Container(
                  // height: 180,
                  // width: 150,
                  // color: Colors.yellow,
                  child: (1 == 1)
                      ? Container(
                          child: Column(
                            children: [
                              kheight20,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showActivities = true;
                                        showFlights = false;
                                        showBus = false;
                                        showholiday = false;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: showActivities == true
                                              ? Colors.blue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                          child: Text(
                                        "Activities",
                                        style: GoogleFonts.rajdhani(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: showActivities == true
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showholiday = true;
                                        showFlights = false;
                                        showBus = false;
                                        showActivities = false;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: showholiday == true
                                              ? Colors.blue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                          child: Text(
                                        "Holiday Packages",
                                        style: GoogleFonts.rajdhani(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: showholiday == true
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showBus = true;
                                        showFlights = false;
                                        showholiday = false;
                                        showActivities = false;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: showBus == true
                                              ? Colors.blue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                          child: Text(
                                        "Bus",
                                        style: GoogleFonts.rajdhani(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: showBus == true
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showFlights = true;
                                        showBus = false;
                                        showholiday = false;
                                        showActivities = false;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: showFlights == true
                                              ? Colors.blue
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                          child: Text(
                                        "Flights",
                                        style: GoogleFonts.rajdhani(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: showFlights == true
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                ],
                              ),
                              if (showActivities == true)
                                commonList(
                                    swidth, sheight, Activitysuccessdata),
                              // ActivityList(
                              //     swidth: swidth,
                              //     sheight: sheight,
                              //     activityData: _activityData,
                              //     activitySuccessData: Activitysuccessdata),
                              //  ActivityList(swidth, sheight, _activityData,
                              //       Activitysuccessdata),
                              if (showholiday == true)
                                commonList(swidth, sheight, HolidaySuccessData),
                              // HolidayList(
                              //     swidth: swidth,
                              //     sheight: sheight,
                              //     holidaySuccessData: HolidaySuccessData,
                              //     holidayPackageDetails:
                              //         holidaypackageDetails),
                              // HolidayList(swidth, sheight, HolidaySuccessData,
                              //     holidaypackageDetails),
                              if (showBus == true)
                                commonList(swidth, sheight, BusSuccessData),
                              // BusList(
                              //     swidth: swidth,
                              //     sheight: sheight,
                              //     BusSuccessData: BusSuccessData,
                              //     blockkeyTinMap: blockkeyTinMap),
                              if (showFlights == true)
                                fcommonList(swidth, sheight, flightSuccessData),
                              // flightList(swidth, sheight, flightSuccessData,
                              //     flightdatas)
                            ],
                          ),
                        )
                      : details(
                          swidth,
                          sheight,
                          "Looks empty, you've no completed bookings",
                          "Looks like You don’t have any completed trips"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget fcommonList(
    double swidth, double sheight, List<flightData> successdata) {
  return successdata.isEmpty
      ? details(swidth, sheight, "Looks empty, you've no completed bookings",
          "Looks like You don’t have any completed trips")
      : Container(
          width: swidth * 0.6,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: swidth * 0.6,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0 / 1,
                  ),
                  itemCount: successdata.length,
                  itemBuilder: (context, index) {
                    return fbuildListItem(swidth, successdata[index], context);
                  },
                ),
              ),
            ],
          ),
        );
}

Widget commonList(
    double swidth, double sheight, List<SuccessPaymentData> successdata) {
  return successdata.isEmpty
      ? details(swidth, sheight, "Looks empty, you've no completed bookings",
          "Looks like You don’t have any completed trips")
      : Container(
          width: swidth * 0.6,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: swidth * 0.6,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.0 / 1,
                  ),
                  itemCount: successdata.length,
                  itemBuilder: (context, index) {
                    return buildListItem(swidth, successdata[index], context);
                  },
                ),
              ),
            ],
          ),
        );
}

// Widget buildListItem(
//     double swidth, SuccessPaymentData data, BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Container(
//       height: 200,
//       width: 100,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(width: 0.5, color: Colors.grey),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // kheight10,

//             if (data.userType.toLowerCase() == 'flights')
//               buildFlightTicketInfo(data),
//             if (data.userType.toLowerCase() != 'flights' &&
//                 data.userType.toLowerCase() != 'bus')
//               buildBillingInfo(data),
//             if (data.userType.toLowerCase() == 'bus')
//             busgridinfo(data),
//             // Text("data"),
//             // buildBillingInfo(data),

//             kheight5,
//             buildPaymentStatusInfo(data),
//             kheight10,
//             buildActions(data, context),
//           ],
//         ),
//       ),
//     ),
//   );
// }

Widget fbuildListItem(double swidth, flightData data, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 200,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (data.userType.toLowerCase() == 'flights')
              fbuildFlightTicketInfo(data),
            if (data.userType.toLowerCase() != 'flights' &&
                data.userType.toLowerCase() != 'bus')
              // buildBillingInfo(data),
              // if (data.userType.toLowerCase() == 'bus')
              //   FutureBuilder(
              //     future: busgridinfo(data, context),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return CircularProgressIndicator();
              //       } else if (snapshot.hasError) {
              //         return Text('Error: ${snapshot.error}');
              //       } else {
              //         return snapshot.data ?? Text('No data');
              //       }
              //     },
              //   ),
              kheight5,
            if (data.userType.toLowerCase() != 'bus')
              fbuildPaymentStatusInfo(data, context),
            kheight10,
            if (data.userType.toLowerCase() != 'bus')
              fbuildActions(data, context),
          ],
        ),
      ),
    ),
  );
}

Widget buildListItem(
    double swidth, SuccessPaymentData data, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 200,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (data.userType.toLowerCase() == 'flights')
              buildFlightTicketInfo(data),
            if (data.userType.toLowerCase() != 'flights' &&
                data.userType.toLowerCase() != 'bus')
              buildBillingInfo(data),
            if (data.userType.toLowerCase() == 'bus')
              FutureBuilder(
                future: busgridinfo(data, context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return snapshot.data ?? Text('No data');
                  }
                },
              ),
            kheight5,
            if (data.userType.toLowerCase() != 'bus')
              buildPaymentStatusInfo(data),
            kheight10,
            if (data.userType.toLowerCase() != 'bus')
              buildActions(data, context),
          ],
        ),
      ),
    ),
  );
}

Future<Widget> busgridinfo(
    SuccessPaymentData data, BuildContext context) async {
  try {
    String res = await getTidAPI(block_key: data.blockKey);
    TicketModel obj = TicketModel.fromJson(jsonDecode(res));
    List<TicketData> details = obj.data;
    var tin = details[0].tid;
    var ticket = await busTicketAPI(tin);
    Tickectobj ticketobj = Tickectobj.fromJson(jsonDecode(ticket));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${ticketobj.travels}",
          style: GoogleFonts.rajdhani(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Text(
          "${details[0].travellerName}",
          style: GoogleFonts.rajdhani(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Text(" ₹${data.amount}"),
        Text(
          "Status: ₹${data.status}",
          style: GoogleFonts.rajdhani(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
        Text(
          "${data.paymentDate}",
          style: GoogleFonts.rajdhani(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Ticket Details'),
                  content: Container(
                    height: 300,
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Traveller Name: ${ticketobj.travels}"),
                        Text("departureCity: ${ticketobj.sourceCity}"),
                        Text("arrivalCity: ${ticketobj.destinationCity}"),
                        Text(
                            "noOfTravellers: ${ticketobj.inventoryItems.passenger.name.length}"),
                        Row(
                          children: [
                            Text("seatNumbers:"),
                            for (int i = 0;
                                i < ticketobj.inventoryItems.seatName.length;
                                i++)
                              Text(" ${ticketobj.inventoryItems.seatName[i]},"),
                          ],
                        ),
                        Text(
                            "cancellation policy: ${ticketobj.cancellationPolicy}"),
                        Text(
                            "cancellation time: ${ticketobj.cancellationCalculationTimestamp}"),
                        Text(
                            "cancellation message: ${ticketobj.cancellationMessage ?? null}"),
                        Text(
                            "partial cancellation : ${ticketobj.partialCancellationAllowed}"),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            height: 32,
            width: 70,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                "View",
                style: GoogleFonts.rajdhani(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  } catch (e) {
    return Text('Error fetching bus details: $e');
  }
}
// busgridinfo(SuccessPaymentData data) async {
//   String res = await getTidAPI(block_key: data.blockKey);
//   TicketModel obj = TicketModel.fromJson(jsonDecode(res));
//   List<TicketData> details = obj.data;
//   return Column(
//     children: [
//       Text("${details[0].travellerName}"),
//       Text("${data.amount}"),
//     ],
//   );
// }

Widget fbuildFlightTicketInfo(flightData data) {
  Future<dynamic> _getflightDetails(String userType, String bookingId) async {
    if (userType.toLowerCase() == 'flights' &&
        bookingId != null &&
        bookingId != "null") {
      return await FlightTciketApi(bookingId, data.orderId);
    } else {
      return null;
    }
  }

  return FutureBuilder<dynamic>(
    future: _getflightDetails(data.userType, data.bookingId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data == 'failed') {
        return getflightdetails(data.bookingId);
      } else {
        var detailData = snapshot.data;
        FlightTicketobj flight =
            FlightTicketobj.fromJson(jsonDecode(detailData));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (flight != null) ...[
              Text(
                "${flight.itemInfos.air.tripInfos[0].sI[0].aa.city}",
                style: GoogleFonts.rajdhani(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        );
      }
    },
  );
}

Widget buildFlightTicketInfo(SuccessPaymentData data) {
  Future<dynamic> _getflightDetails(String userType, String bookingId) async {
    if (userType.toLowerCase() == 'flights' &&
        bookingId != null &&
        bookingId != "null") {
      return await FlightTciketApi(bookingId, data.orderId);
    } else {
      return null;
    }
  }

  return FutureBuilder<dynamic>(
    future: _getflightDetails(data.userType, data.bookingId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data == 'failed') {
        return getflightdetails(data.bookingId);
      } else {
        var detailData = snapshot.data;
        FlightTicketobj flight =
            FlightTicketobj.fromJson(jsonDecode(detailData));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (flight != null) ...[
              Text(
                "${flight.itemInfos.air.tripInfos[0].sI[0].aa.city}",
                style: GoogleFonts.rajdhani(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        );
      }
    },
  );
}

getflightdetails(String bookingId) async {
  if (bookingId != null && orderId != null) {
    String res = await FlightTciketApi(bookingId, orderId);
    FlightTicketobj obj = FlightTicketobj.fromJson(jsonDecode(res));
    print("obj:$obj");
  }
  return Text("Booking Id: $bookingId");
}

Widget buildBillingInfo(SuccessPaymentData data) {
  Future<dynamic> _getDetails(String userType, String packageId) async {
    if (userType.toLowerCase() == 'activities') {
      return await getactivitydata(packageId);
    } else if (userType.toLowerCase() == 'holiday') {
      return await getholidaydata(packageId);
    } else {
      return null;
    }
  }

  return FutureBuilder<dynamic>(
    future: _getDetails(data.userType, data.packageId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData && data.userType.toLowerCase() == 'flight') {
        return GestureDetector(
            onTap: () {
              // Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => FlightTicketPage(ticket: null),
              //         ),
              //       );
            },
            child: Text('flight'));
      } else if (!snapshot.hasData) {
        return Text('No data lfound');
      } else {
        var detailData = snapshot.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (detailData is Datum) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "  ${detailData.packageName}",
                    style: GoogleFonts.rajdhani(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ] else if (detailData is Details) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${detailData.name}",
                    style: GoogleFonts.rajdhani(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Add more holiday-specific details here
                ],
              ),
            ],
          ],
        );
      }
    },
  );
}

// Future<Datum> getactivitydata(String id) async {
//   activityobj obj = await getActivitiesdetailsAPI(id);
//   return obj.data[0];
// }

// Future<Details> getholidaydata(String id) async {
//   holidayobj obj = await getHolidaydetailsAPI(id);
//   return obj.data[0];
// }

Widget fbuildPaymentStatusInfo(flightData data, context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "${data.paymentDate}",
        style: GoogleFonts.rajdhani(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      kheight3,
      Text(
        "Payment Status:${data.status}",
        style: GoogleFonts.rajdhani(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.green,
        ),
      ),
      kheight10,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              if (data.bookingId != null) {
                String res =
                    await FlightTciketApi(data.bookingId, data.orderId);
                Flightticket obj = Flightticket.fromJson(jsonDecode(res));
                // uniqueFlights.add(obj);
                printWhite("ticket id: ${obj.order.bookingId}");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlightTicketPage(ticket: obj),
                  ),
                );
              }
            },
            child: Center(
              child: Container(
                height: 32,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    "View",
                    style: GoogleFonts.rajdhani(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      width: 250,
                        height: 100, // Adjust height as needed
                        child: Column(
                          children: [
                            Text("Cancel Booking?"),
                            kheight20,
                             SizedBox(
                          width: 180,
                          // height: 150,
                          child: TextFormField(
                             controller: flightRemarkcontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Remarks',
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
                        )),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                         flightCancellation_api(data.bookinngId, flightRemarkcontroller);

                          // Close the dialog
                          // if (data.bookingId != null) {
                          //   String res = await FlightTciketApi(
                          //       data.bookingId, data.orderId);
                          //   Flightticket obj =
                          //       Flightticket.fromJson(jsonDecode(res));
                          //   // uniqueFlights.add(obj);
                          //   printWhite("ticket id: ${obj.order.bookingId}");

                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           FlightTicketPage(ticket: obj),
                          //     ),
                          //   );
                          // }
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
            child: Center(
              child: Container(
                  height: 32,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(
                    Icons.delete,
                    size: 20,
                  )),
            ),
          ),
        ],
      ),
      // Add other payment status info text widgets here
    ],
  );
}

Widget buildPaymentStatusInfo(SuccessPaymentData data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "${data.paymentDate}",
        style: GoogleFonts.rajdhani(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      kheight3,
      Text(
        "Payment Status:${data.status}",
        style: GoogleFonts.rajdhani(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.green,
        ),
      ),
      // Add other payment status info text widgets here
    ],
  );
}

Widget fbuildActions(flightData data, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // GestureDetector(
      //   onTap: () {
      //     cancellationfunction(data.tid, data.blockKey, data.bookingId, data.userType);
      //   },
      //   child: buildActionButton("Cancel", Colors.blue),
      // ),
      // Visibility(
      //   visible: (data.userType == 'Activities' || data.userType == 'holiday'),
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: GestureDetector(
      //       onTap: () {
      //         getactivityPackages(data.packageId, "0");
      //         viewFunction(
      //             data.tid, data.packageId, data.userType, context, data);
      //       },
      //       child: buildActionButton("View", Colors.blue),
      //     ),
      //   ),
      // ),
      // Visibility(
      //   visible: (data.userType != 'Activities' && data.userType != 'holiday'),
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: GestureDetector(
      //       onTap: () {
      //         confirmationFunction(data.blockKey, data.bookingId, data.userType, context);
      //       },
      //       child: buildActionButton("Confirm", Colors.blue),
      //     ),
      //   ),
      // ),
    ],
  );
}

Widget buildActions(SuccessPaymentData data, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // GestureDetector(
      //   onTap: () {
      //     cancellationfunction(data.tid, data.blockKey, data.bookingId, data.userType);
      //   },
      //   child: buildActionButton("Cancel", Colors.blue),
      // ),
      Visibility(
        visible: (data.userType == 'Activities' || data.userType == 'holiday'),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              getactivityPackages(data.packageId, "0");
              viewFunction(
                  data.tid, data.packageId, data.userType, context, data);
            },
            child: buildActionButton("View", Colors.blue),
          ),
        ),
      ),
      // Visibility(
      //   visible: (data.userType != 'Activities' && data.userType != 'holiday'),
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: GestureDetector(
      //       onTap: () {
      //         confirmationFunction(data.blockKey, data.bookingId, data.userType, context);
      //       },
      //       child: buildActionButton("Confirm", Colors.blue),
      //     ),
      //   ),
      // ),
    ],
  );
}

getactivityPackages(String activityId, String pid) async {
  if (activityId != null && pid != null) {
    try {
      activityobj obj = await getActivitiesdetailsAPI(activityId);
      jsondetails = jsonEncode(obj);
      print('Activity Name: ${obj.data[0].packageName}');
      // setState(() {
      // _activityData = obj.data;
      // activitydatum = _activityData[0];
      packagelist = obj.packageOption;
      packageac = packagelist[int.parse(pid)];
      // });
    } catch (e) {
      print('Error fetching activity details: $e');
    }
  }
}

Widget buildActionButton(String label, Color color) {
  return Container(
    width: 80,
    height: 30,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(
        label,
        style: GoogleFonts.rajdhani(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ),
  );
}

void viewFunction(String tid, String pid, String userType, BuildContext context,
    SuccessPaymentData data) async {
  if (userType == 'Activities') {
    if (pid.isEmpty || pid == null || pid == "null") {
      print("invalid pid");
    } else {
      // Fetch the activity details here
      Datum activityData = await getactivitydata(pid);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Activity Details"),
            content: Container(
              height: 180, // Adjust height as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${data.billingName}",
                    style: GoogleFonts.rajdhani(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(height: 3),
                  Text("Order ID: ${packageac.packageId ?? 'N/A'}"),
                  Text("Includes: ${packageac.priceIncludes ?? 'N/A'}"),
                  Text("Package Time: ${packageac.timeDuration ?? 'N/A'}"),
                  Text("Package Age: ${packageac.agePolicy ?? 'N/A'}"),
                  Text("Package Cancel: ${packageac.description ?? 'N/A'}"),
                  Text("Package Amount: ${packageac.price ?? 'N/A'}"),
                  Text("Amount: ${data.amount ?? 'N/A'}"),
                  // Add more details or widgets here if needed
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                            height: 50, // Adjust height as needed
                            child: Text(
                                "Are you sure you want to \ncancel booking?")),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog

                              cancellationfunction(data.tid, data.blockKey,
                                  data.bookingId, data.userType);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Container(
                                        height: 20, // Adjust height as needed
                                        child: Text("Booking Cancelled!")),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Navigate to ActivitiesBookingScreen
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ActivitiesBookingScreen(id: pid),
                  //   ),
                  // );
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  } else if (userType == 'holiday') {
    if (pid.isEmpty || pid == null || pid == "null") {
      print("invalid pid");
    } else {
      String res = await getHolidayPackagesdetailsAPI(pid);

      HolidayPackagedetails obj =
          HolidayPackagedetails.fromJson(jsonDecode(res));
      List<Details> holidaydata = obj.packages;
      // Fetch the activity details here
      // Datum activityData = await getactivitydata(pid);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Activity Details"),
            content: Container(
              height: 180, // Adjust height as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${data.billingName}",
                    style: GoogleFonts.rajdhani(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(height: 3),
                  for (int i = 0; i < holidaydata[0].itinerary.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0), // Add padding between items
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Total days: ${holidaydata[0].itinerary.length ?? 'N/A'}"),
                            Text(
                                "Day: ${holidaydata[0].itinerary[i].day ?? 'N/A'}"),
                            Text(
                                "Description: ${holidaydata[0].itinerary[i].itineraryDesc ?? 'N/A'}"),
                            Text(
                                "Location: ${holidaydata[0].itinerary[i].location ?? 'N/A'}"),
                          ]),
                    ),
                  Text("packagePrice: ${holidaydata[0].packagePrice ?? 'N/A'}"),
                  Text("Amount paid: ${data.amount ?? 'N/A'}"),
                  // Add more details or widgets here if needed
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                            height: 50, // Adjust height as needed
                            child: Text(
                                "Are you sure you want to \ncancel booking?")),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog

                              cancellationfunction(data.tid, data.blockKey,
                                  data.bookingId, data.userType);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Container(
                                        height: 20, // Adjust height as needed
                                        child: Text("Booking Cancelled!")),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Navigate to ActivitiesBookingScreen
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ActivitiesBookingScreen(id: pid),
                  //   ),
                  // );
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

void cancellationfunction(
    String tid, String blockKey, String bookingId, String userType) {
  if (userType == 'Activities' || userType == 'holiday') {
    cancellationAPI(tid);
  } else if (userType == 'bus') {
    cancellationAPI(tid);
    if (blockKey.isEmpty || blockKey == null || blockKey == "null") {
      print("invalid blockkey");
    } else {}
  } else if (userType == 'flight') {
    cancellationAPI(tid);
    if (bookingId.isEmpty || bookingId == null || bookingId == "null") {
      print("invalid bookingId");
    } else {}
  }
}

confirmationFunction(
  String blockKey,
  String bookingId,
  String userType,
  BuildContext context,
) async {
  if (userType == 'bus') {
    if (blockKey == null || blockKey.isEmpty || blockKey == "null") {
      print("Invalid blockkey");
    } else {
      String tin = await ConfirmBookingAPI(blockKey);
      if (tin == null || tin.isEmpty || tin.contains("Error")) {
        print("Invalid tin");
      } else {
        String res = await busTicketAPI(tin);
        if (res != 'failed') {
          Tickectobj obj = Tickectobj.fromJson(jsonDecode(res));
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ticket Confirmed'),
                content: Text('Show all details'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusTicketPage(ticket: obj),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }
  } else {
    if (bookingId == null || bookingId.isEmpty || bookingId == "null") {
      print("Invalid bookingId");
    } else {
      String res = await Booking_Retrieve_api(bookingId);
      printWhite("booking res: $res");
      if (res != 'failed') {
        BookingRetrieveobj obj = BookingRetrieveobj.fromJson(jsonDecode(res));
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ticket Confirmed'),
              content: Text('Show all details'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => FlightTicketPage(ticket: obj),
                    //   ),
                    // );
                    //
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}

cancellationbox(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Ticket Cancelled'),
        // content: Text('show all details'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              // navigate
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

CancellationcommonList(
    double swidth, double sheight, List<SuccessPaymentData> successdata) {
  return (successdata.isEmpty || successdata.length == 0 || successdata == null)
      ? details(swidth, sheight, "Looks empty, you've no cancelled bookings.",
          "Great! Looks like you’ve no cancelled bookings.")
      : Container(
          width: swidth * 0.6,
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              // height: 500,
              width: swidth * 0.6,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of columns in the grid
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    childAspectRatio: 1.0 / 1.5, // Aspect ratio of the items
                  ),
                  itemCount: successdata.length ?? 0,
                  itemBuilder: (context, index) {
                    SuccessPaymentData data = successdata[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 0.5, color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Billing Name:${data.billingName}",
                                style: GoogleFonts.rajdhani(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              kheight3,
                              Text(
                                "Billing address:${data.billingAddress}",
                                style: GoogleFonts.rajdhani(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              kheight3,
                              Text(
                                "Billing city:${data.billingCity}",
                                style: GoogleFonts.rajdhani(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              kheight3,
                              Text(
                                "Billing email:${data.billingEmail}",
                                style: GoogleFonts.rajdhani(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              kheight3,
                              Text(
                                "payment date:${data.paymentDate}",
                                style: GoogleFonts.rajdhani(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "payment Status:${data.status}",
                                style: GoogleFonts.rajdhani(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange),
                              ),
                              kheight3,
                              Text(
                                "amount: ₹${data.amount}",
                                style: GoogleFonts.rajdhani(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              kheight3,
                              Text(
                                "Tracking id: ${data.trakingId}",
                                style: GoogleFonts.rajdhani(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              kheight3,
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     Container(
                              //       width: 60,
                              //       height: 30,
                              //       decoration: BoxDecoration(
                              //         color: Colors.blue,
                              //         borderRadius: BorderRadius.circular(5),
                              //       ),
                              //       child: Center(
                              //           child: Text(
                              //         "Cancel",
                              //         style: GoogleFonts.rajdhani(
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.w700,
                              //             color: Colors.white),
                              //       )),
                              //     ),
                              //     Container(
                              //       width: 80,
                              //       height: 30,
                              //       decoration: BoxDecoration(
                              //         color: Colors.blue,
                              //         borderRadius: BorderRadius.circular(5),
                              //       ),
                              //       child: Center(
                              //           child: Text(
                              //         "Confirm",
                              //         style: GoogleFonts.rajdhani(
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.w700,
                              //             color: Colors.white),
                              //       )),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ]),
        );
}

Future<Datum> getactivitydata(String id) async {
  activityobj obj = await getActivitiesdetailsAPI(id);

  Datum activity = obj.data[0];
  return activity;
}

Future<Details> getholidaydata(String id) async {
  String res = await getHolidayPackagesdetailsAPI(id);
  HolidayPackagedetails obj = HolidayPackagedetails.fromJson(jsonDecode(res));
  Details activity = obj.packages[0];
  return activity;
}

//   getCancelledPayments(id) async {
//     String res = await cancelledPaymentAPI(id);
//     if (res != 'failed') {
//       SuccessPayments obj = SuccessPayments.fromJson(jsonDecode(res));
//       List<SuccessPaymentData> data = obj.data;
//       setState(() {
//         cancelleddata = data;
//       });
//     }
//     printWhite("cancelleddata:${cancelleddata.length}");
//   }

//   Future<void> getSuccessfullPayments(id) async {
//     String flightres = await CompletedpaymentFlightAPI();
//     String activityres = await CompletedpaymentActivityAPI();
//     String busres = await CompletedpaymentBusAPI();
//     String holidayres = await CompletedpaymentHolidayAPI();
//     if (flightres != 'failed') {
//       List<SuccessPaymentData> activitiesObj = [];

//       List<SuccessPaymentData> holidayObj = [];

//       List<SuccessPaymentData> flightObj = [];

//       List<SuccessPaymentData> busObj = [];

//       SuccessPayments flightobj =
//           SuccessPayments.fromJson(jsonDecode(flightres));
//       List<SuccessPaymentData> flitdata = flightobj.data;
//       setState(() {
//         flightObj = flitdata;
//       });
//       SuccessPayments bussobj =
//           SuccessPayments.fromJson(jsonDecode(busres));
//       List<SuccessPaymentData> busdata = bussobj.data;
//       setState(() {
//         busObj = busdata;
//       });
//       SuccessPayments actyobj =
//           SuccessPayments.fromJson(jsonDecode(activityres));
//       List<SuccessPaymentData> actydata = actyobj.data;
//       setState(() {
//         activitiesObj = actydata;
//       });
//       SuccessPayments holdyobj =
//           SuccessPayments.fromJson(jsonDecode(holidayres));
//       List<SuccessPaymentData> holidydata = holdyobj.data;
//       setState(() {
//         holidayObj = holidydata;
//       });

//       for (int i = 0; i < successdata.length; i++) {
//         SuccessPaymentData payment = successdata[i];
//         print("type:${payment.userType}");
//         if (payment.userType == "Activities") {
//           print("yes");

//           activitiesObj.add(payment);
//         } else if (payment.userType == "Holiday_packages") {
//           holidayObj.add(payment);
//         } else if (payment.userType == "flight") {
//           flightObj.add(payment);
//         } else if (payment.userType == "bus") {
//           busObj.add(payment);
//         }
//       }

//       setState(() {
//         Activitysuccessdata = activitiesObj;
//         flightSuccessData = flightObj;
//         BusSuccessData = busObj;
//         HolidaySuccessData = holidayObj;
//       });
//       printWhite("activitiesObj:${activitiesObj.length}");
//       printWhite("HolidayObj:${holidayObj.length}");
//       printWhite("FlightObj:${flightObj.length}");
//       printWhite("BusObj:${busObj.length}");
//       printWhite("success:${successdata.length}");

//       if (Activitysuccessdata.length != 0) {
//         for (int i = 0; i < Activitysuccessdata.length; i++) {
//           SuccessPaymentData activity = Activitysuccessdata[i];
//           if (activity.packageId != null) {
//             try {
//               activityobj obj =
//                   await getActivitiesdetailsAPI(activity.packageId);
//               jsondetails = jsonEncode(obj);
//               print('Activity Name: ${obj.data[0].packageName}');
//               setState(() {
//                 _activityData = obj.data;
//                 activitydatum = _activityData[0];
//                 packagelist = obj.packageOption;
//               });
//             } catch (e) {
//               print('Error fetching activity details: $e');
//             }
//           }
//         }
//       }

//       if (HolidaySuccessData.length != 0) {
//         for (int i = 0; i < HolidaySuccessData.length; i++) {
//           SuccessPaymentData activity = HolidaySuccessData[i];
//           if (activity.packageId != null) {
//             try {
//               HolidayPackagedetails obj =
//                   HolidayPackagedetails.fromJson(jsonDecode(holidayres));
//               List<Details> data = obj.packages;

//               setState(() {
//                 holidaypackageDetails = data[0];
//               });
//             } catch (e) {
//               print('Error fetching holiday details: $e');
//             }
//           }
//         }
//       }

//       if (BusSuccessData.isNotEmpty) {
//         for (int i = 0; i < BusSuccessData.length; i++) {
//           print("i:$i");
//           SuccessPaymentData bus = BusSuccessData[i];

//           bool alreadyExists =
//               BusConstsntData.any((element) => element.tid == bus.tid);
//           if (!alreadyExists) {
//             // New data found
//             printWhite(
//                 'New Data Found: Bus ID: ${bus.tid}, Amount: ${bus.amount},blockkey:${bus.blockKey}');

//             if (bus.blockKey != null || bus.blockKey != 'null') {
//               // Call API to handle new data and get tin
//               String tin = await ConfirmBookingAPI(bus.blockKey);

//               // Store blockkey-tin pair in the map

//               setState(() {
//                 blockkeyTinMap[bus.blockKey] = tin;
//               });
//             }
//           }
//         }
//       }

// // Print the blockkey-tin map
//       print('BlockKey-TIN Map: $blockkeyTinMap');

// // if (bus.blockKey != null) {
//       //   String res = await ConfirmBookingAPI(bus.blockKey);
//       //   if (res != 'failed') {
//       //     String response = await busTicketAPI(res);
//       //   }
//       // }
//       // if (flightSuccessData.length != 0) {
//       //   for (int i = 0; i < flightSuccessData.length; i++) {
//       //     SuccessPaymentData flight = flightSuccessData[i];
//       //     if (flight.bookingId != null) {
//       //       String res = await FlightTciketApi(flight.bookingId);
//       //       FlightTicketobj obj = FlightTicketobj.fromJson(jsonDecode(res));
//       //      flightdatas.add(obj);
//       //     }
//       //   }
//       // }

//     Set<FlightTicketobj> uniqueFlights = {}; // Use a Set to ensure uniqueness

//     if (flightSuccessData.isNotEmpty) {
//       for (int i = 0; i < flightSuccessData.length; i++) {
//         SuccessPaymentData flight = flightSuccessData[i];
//         if (flight.bookingId != null) {
//           String res = await FlightTciketApi(flight.bookingId);
//           FlightTicketobj obj = FlightTicketobj.fromJson(jsonDecode(res));
//           uniqueFlights.add(obj); // Add to Set to ensure uniqueness
//         }
//       }
//     }

//     setState(() {
//       flightdatas = uniqueFlights.toList(); // Convert Set back to List
//     });
//   }
// }
