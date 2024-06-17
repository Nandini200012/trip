// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:trip/screens/flightbooking%20page/city_selection_widget.dart';
import 'package:trip/screens/flightbooking%20page/flight_booking%20widgets.dart';
import '../api_services/location_list_api.dart';
import 'flightbooking page/ismulticityformpage.dart';
import 'flightbooking page/isonewayformpage.dart';
import 'flightbooking page/isreturnform.dart';

class FlightBooking extends StatefulWidget {
  List<LocationData> locationList1;
  FlightBooking({Key key, this.locationList1}) : super(key: key);

  @override
  _FlightBookingState createState() => _FlightBookingState();
}

class _FlightBookingState extends State<FlightBooking>
    with TickerProviderStateMixin {
  String selectedRadioButton = '';
  bool isLoading = true;
  bool isoneway = false;
  bool isreturn = false;
  bool ismulticity = false;
  bool isShow3 = false;
  bool isShow4 = false;
  bool isShow5 = false;
  int formDataIndices = 0;
  void handleRadioValueChanged(
      String value, bool oneWay, bool multiCity, bool roundTrip) {
    setState(() {
      selectedRadioButton = value;
      isoneway = oneWay;
      ismulticity = multiCity;
      isreturn = roundTrip;
    });
  }

  Widget buildRadio(String value, bool oneWay, bool multiCity, bool roundTrip) {
    return Radio(
      value: value,
      groupValue: selectedRadioButton,
      onChanged: (value) =>
          handleRadioValueChanged(value, oneWay, multiCity, roundTrip),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });
    formDataIndices = 0;
    // selectedRadioButton ='One Way';
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor = Colors.white;
    Color borderColor = Colors.blue;

    return Scaffold(
      backgroundColor: Color(0xFF0d2b4d),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 40),
        backgroundColor: Colors.white,
        title: Text(
          'Flight',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      // width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 30, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                buildRadio('One Way', true, false, false),
                                Text('One Way'),
                                buildRadio('Round Trip', false, false, true),
                                Text('Round Trip'),
                                buildRadio('Multi City', false, true, false),
                                Text('Multi City'),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: isoneway,
                            child: Container(
                              height: 300,
                              
                               child:
                              //  Column(
                              //   children: [
                                   IntrinsicHeight(
                                    child: formDataWidgetOneway(),
                                  ),
                              //   ],
                              // ),
                            ),
                          ),
                          Visibility(
                            visible: isreturn,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  IntrinsicHeight(
                                    child: formDataWidgetReturn(
                                        isShow: true,
                                        isReturn: isreturn ? true : false,
                                        index: 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: ismulticity,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  IntrinsicHeight(
                                    child: formDataWidgetMulticity(
                                        isShow: true,
                                        isReturn: isreturn ? true : false,
                                        index: 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

                          // Center(
                          //     child: Text(
                          //         'Book International and Domestic Flights')),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Visibility(
                          //   child: Container(
                          //     // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          //     // padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          //     decoration: BoxDecoration(
                          //       border: Border.all(color: Colors.grey),
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //     child: Column(
                          //       children: [
                          //         IntrinsicHeight(
                          //           child: formDataWidget(
                          //               isShow: true,
                          //               isReturn: isreturn ? true : false,
                          //               index: 0),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // Visibility(
                          //   visible: ismulticity,
                          //   child: SizedBox(
                          //     height: 20,
                          //   ),
                          // ),

                          // Visibility(
                          //   visible: ismulticity,
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(color: Colors.grey),
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //     // child: Column(
                          //     //   children: [
                          //     //     IntrinsicHeight(
                          //     //       child: formDataWidget(
                          //     //         isShow: false,
                          //     //         isReturn: isreturn ? true : false,
                          //     //         index: 1,
                          //     //       ),
                          //     //     ),
                          //     //   ],
                          //     // ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // // 3
                          // Visibility(
                          //   visible: isShow3,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.end,
                          //     children: [
                          //       Container(
                          //         decoration: BoxDecoration(
                          //           border: Border.all(color: Colors.grey),
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //         child: IntrinsicHeight(
                          //           child: formDataWidget(
                          //             isShow: false,
                          //             isReturn: isreturn ? true : false,
                          //             index: 2,
                          //           ),
                          //         ),
                          //       ),
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.end,
                          //         children: [
                          //           IconButton(
                          //               onPressed: () {
                          //                 setState(() {
                          //                   if (formDataIndices >= 1) {
                          //                     isShow3 = false;
                          //                     formDataIndices -= 1;
                          //                   }
                          //                   print("delete");
                          //                   print("isShow3: $isShow3");
                          //                 });
                          //               },
                          //               icon: Icon(
                          //                 Icons.delete,
                          //                 size: 20,
                          //                 color: Colors.grey,
                          //               )),
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Visibility(
                          //   visible: isShow3,
                          //   child: SizedBox(
                          //     height: 10,
                          //   ),
                          // ),
                          // // 4
                          // Visibility(
                          //   visible: isShow4,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Container(
                          //         decoration: BoxDecoration(
                          //           border: Border.all(color: Colors.grey),
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //         child:
                          //             // Column(
                          //             // children: [
                          //             IntrinsicHeight(
                          //           child: formDataWidget(
                          //             isShow: false,
                          //             index: 2,
                          //             isReturn: isreturn ? true : false,
                          //           ),
                          //         ),

                          //         //   ],
                          //         // ),
                          //       ),
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.end,
                          //         children: [
                          //           IconButton(
                          //               onPressed: () {
                          //                 setState(() {
                          //                   if (formDataIndices >= 1) {
                          //                     isShow4 = false;
                          //                     formDataIndices -= 1;
                          //                   }
                          //                   print("delete");
                          //                   print("isShow4: $isShow4");
                          //                 });
                          //               },
                          //               icon: Icon(
                          //                 Icons.delete,
                          //                 size: 20,
                          //                 color: Colors.grey,
                          //               ))
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Visibility(
                          //   visible: isShow4,
                          //   child: SizedBox(
                          //     height: 10,
                          //   ),
                          // ),

                          // Visibility(
                          //   visible: ismulticity,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                          //       ElevatedButton(
                          //         onPressed: () {
                          //           setState(() {
                          //             // formDataIndices = formDataIndices + 1;
                          //             if (formDataIndices <= 2) {
                          //               formDataIndices += 1;
                          //               if (formDataIndices == 1) {
                          //                 isShow3 = true;
                          //               } else if (formDataIndices == 2) {
                          //                 isShow4 = true;
                          //               }
                          //             }

                          //             print("add");
                          //             print("isShow3: $isShow3");
                          //             // buttonColor = Colors.red;
                          //           });
                          //         },
                          //         child: Text("Add New City"),
                          //         style: ElevatedButton.styleFrom(
                          //           primary: buttonColor,
                          //           onPrimary:
                          //               Color.fromARGB(255, 16, 180, 234),
                          //           side: BorderSide(color: borderColor),
                          //         ),
                          //       ),
                                // IconButton(
                                //     onPressed: () {
                                //       setState(() {
                                //         if (formDataIndices >= 1) {
                                //           if (formDataIndices == 1) {
                                //             isShow3 = false;
                                //           } else if (formDataIndices == 2) {
                                //           isShow4 = true;
                                //         }else if (formDataIndices == 3) {
                                //           isShow5 = true;
                                //         }
                                //           formDataIndices -= 1;
                                //         }
                                //         print("delete");
                                //         print("isShow3: $isShow3");
                                //       });
                                //     },
                                //     icon: Icon(
                                //       Icons.delete,
                                //       color: Colors.grey,
                                //     ))
                          //     ],
                          //   ),
                          // ),

                        //  Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //      ElevatedButton(
                        //       onPressed: () {},
                        //       child: Container(
                        //         child: Text('Search'),
                        //       ))
                        //   ],
                        //  )
                      