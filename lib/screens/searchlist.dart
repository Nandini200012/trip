import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trip/api_services/revalidate%20apis/one%20way/revalidate_domestic_onewat_api.dart';
import 'package:trip/models/flight_model.dart';
import '../api_services/location_list_api.dart';
import '../common_flights/common_flightbookingpage.dart';
import 'Drawer.dart';
import 'constant.dart';
import 'flight_searchlist/widgets/priceslider.dart';
import 'flightss_/widgets/search_container.dart';
import 'header.dart';

class SearchListPage extends StatefulWidget {
  final List<Flight> flightmodel;
  int travellerCount;
  String domOrinter;
  String fromcity, tocity;
  List<LocationData> locationList1;
  PaxInfo searchinfo;
  String type;
  String adult;
  String child;
  String infant;
  String cabin_class;
  String date;
  String fromcode;
  String tocode;

  SearchListPage(
      {this.date,
      this.domOrinter,
      Key key,
      this.flightmodel,
      this.travellerCount,
      this.fromcity,
      this.tocity,
      this.locationList1,
      this.searchinfo,
      this.type,
      this.adult,
      this.child,
      this.infant,
      this.cabin_class,
      this.fromcode,
      this.tocode})
      : super(key: key);

  @override
  State<SearchListPage> createState() => _SearchListPageState();
}

class _SearchListPageState extends State<SearchListPage> {
  Set<String> uniqueAirlineNames = {};
  Set<String> uniqueAirlineCodes = {};
  String selectedAirline;
  double _selectedPrice = 0;
  int selectedIndexlist;
  int selectedIndex_deptime = -1;
  int selectedIndex_arrtime = -1;
  bool isShownonstop = true;
  int depTime;
  int arrTime;
  bool showDetail = false;
  double minPrice = 2500;
  double maxPrice = 55000;
  var selecteddetailindex;
  var list = ['Non stop', '1 Stop'];

  @override
  void initState() {
    super.initState();

    uniqueAirlineNames = widget.flightmodel.fold<Set<String>>(<String>{},
        (uniqueNames, flight) => uniqueNames..add(flight.airlineName));
    uniqueAirlineCodes = widget.flightmodel.fold<Set<String>>(<String>{},
        (uniqueNames, flight) => uniqueNames..add(flight.airlineCode));
    selectedLabel = 'cheapest first';
    selectedAirline = null;
    _selectedPrice = 24300;
    isShownonstop = true;
    log("{widget.flightmodel.length}");
    log(widget.flightmodel.length.toString());
    getprice(widget.flightmodel);
  }

  getprice(List<Flight> flightmodel) {
    if (flightmodel.isEmpty) {
      setState(() {
        minPrice = 0;
        maxPrice = 0;
        _selectedPrice = 0;
      });
      // Return a map with default values if the list is empty
      return {'minPrice': 0, 'maxPrice': 0};
    }

    double _minPrice = double.parse(flightmodel[0].price);
    double _maxPrice = double.parse(flightmodel[0].price);

    for (var flight in flightmodel) {
      double flightPrice = double.parse(flight.price);
      if (flightPrice < _minPrice) {
        _minPrice = flightPrice;
      }
      if (flightPrice > _maxPrice) {
        _maxPrice = flightPrice;
      }
    }
    log("min: $_minPrice");
    log("Max: $_maxPrice");
    setState(() {
      minPrice = 0;
      // _minPrice-1000;
      maxPrice = _maxPrice + 10000;
      _selectedPrice = _maxPrice;
    });
    // return {'minPrice': minPrice, 'maxPrice': maxPrice};
  }

  CheckboxListTile buildCheckboxListTile({
    String title,
    bool value,
    Function(bool) onChanged,
  }) {
    return CheckboxListTile(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.w300),
      ),
      value: value,
      onChanged: onChanged,
      checkColor: value
          ? Color.fromARGB(255, 215, 48, 48)
          : Color.fromARGB(255, 18, 1, 1),
      activeColor: Colors.blue,
      enabled: true,
      selectedTileColor: Colors.blue,
      // contentPadding: EdgeInsets.all(2),
    );
  }

  String selectedLabel = 'cheapest first ';
  String title;
  String titleCreator() {
    if (selectedLabel == 'cheapest first') {
      title = "Flights sorted by Lowest fares on this route";
    } else if (selectedLabel == 'Non Stop first') {
      title = "Flights sorted by Fewest Stops";
    } else if (selectedLabel == 'Early Departure') {
      title = "Flights sorted by Early Departure";
    } else if (selectedLabel == 'Late Departure') {
      title = "Flights sorted by Late Departure";
    } else {
      title = "Flights sorted by Lowest fares on this route";
    }
    return title;
  }

  Widget _buildLabelContainer(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLabel = label;
        });
      },
      child: Container(
        height: 50,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selectedLabel == label
              ? Color.fromARGB(255, 158, 201, 237)
              : Color.fromARGB(255, 205, 205, 205).withOpacity(0.5),
          border: Border.all(width: 0.2, color: Colors.grey),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 25,
                width: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      width: 0.2, color: Color.fromARGB(255, 255, 255, 255)),
                  color: selectedLabel == label
                      ? Color.fromARGB(255, 9, 109, 196)
                      : Color.fromARGB(255, 184, 182, 182).withOpacity(0.8),
                ),
                child: Center(
                  child: Icon(
                    labelicon(label),
                    color: Colors.white,
                    fill: 1.0,
                    weight: 5.0,
                    size: 20,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: screenWidth < 600
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 40),
              backgroundColor: Colors.white,
              title: Text(
                'Tour',
                style: blackB15,
              ),
            )
          : CustomAppBar(),
      drawer: screenWidth < 700 ? drawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchContainer(
              sWidth: screenWidth,
              sHeight: screenHeight,
              locationList1: widget.locationList1,
              fromcity: widget.fromcity,
              tocity: widget.tocity,
              adult: widget.adult,
              child: widget.child,
              infant: widget.infant,
              cabin_class: widget.cabin_class,
              type: widget.type,
              travellerCount: widget.travellerCount,
              date: widget.date,
              fromcode: widget.fromcode,
              tocode: widget.tocode,
              returndate: date,
               domorInter:widget.domOrinter,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                _buildGradientContainer(screenWidth),
                (_buildFlightDetails(context, screenHeight, screenWidth)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // SearchContainer(sWidth, sHeight) {
  //   return Container(
  //       height: 120,
  //       width: sWidth,
  //       decoration: BoxDecoration(
  //           color: Color.fromARGB(255, 1, 20, 99),
  //           border: Border.all(
  //             width: 0.1,
  //             color: Color.fromARGB(255, 1, 20, 99),
  //           )),
  //       child: Padding(
  //         padding: EdgeInsets.only(top: 12, bottom: 55,left: 150,right: 320),
  //         child: Container(

  //           color: Color.fromARGB(255, 1, 20, 99),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Container(
  //                 height: 60,
  //               width: sWidth * 0.1,
  //                 decoration: BoxDecoration(
  //                     color: Color.fromARGB(255, 27, 50, 141),
  //                     borderRadius: BorderRadius.circular(12)),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'TRIP TYPE',
  //                       style: rajdhaniblue,
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Text(
  //                       'One Way',
  //                       style: rajdhaniwhite,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(width: 15,),
  //               Container(
  //                 height: 60,
  //                 width: sWidth * 0.1,
  //                 decoration: BoxDecoration(
  //                     color: Color.fromARGB(255, 27, 50, 141),
  //                     borderRadius: BorderRadius.circular(12)),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'FROM',
  //                       style: rajdhaniblue,
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Text(
  //                       'New Delhi,India',
  //                       style: rajdhaniwhite,
  //                     ),
  //                   ],
  //                 ),
  //               ), SizedBox(width: 5,),
  //               Icon(
  //                 Icons.swap_horiz_sharp,
  //                 size: 22,
  //                 color: Color.fromARGB(255, 3, 158, 255),
  //               ), SizedBox(width: 5,),
  //               Container(
  //                 height: 60,
  //                width: sWidth * 0.1,
  //                 decoration: BoxDecoration(
  //                     color: Color.fromARGB(255, 27, 50, 141),
  //                     borderRadius: BorderRadius.circular(12)),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'TO',
  //                       style: rajdhaniblue,
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Text(
  //                       'Mumbai,India',
  //                       style: rajdhaniwhite,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //                SizedBox(width: 15,),
  //               Container(
  //                 height: 60,
  //               width: sWidth * 0.1,
  //                 decoration: BoxDecoration(
  //                     color: Color.fromARGB(255, 27, 50, 141),
  //                     borderRadius: BorderRadius.circular(12)),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'DEPART',
  //                       style: rajdhaniblue,
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Text(
  //                       '01 May 2024',
  //                       style: rajdhaniwhite,
  //                     ),
  //                   ],
  //                 ),
  //               ), SizedBox(width: 15,),
  //               Container(
  //                 height: 60,
  //                 width: sWidth * 0.1,
  //                 decoration: BoxDecoration(
  //                     color: Color.fromARGB(255, 27, 50, 141),
  //                     borderRadius: BorderRadius.circular(12)),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       'PASSENGERS & CLASS',
  //                       style: rajdhaniblue,
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Text(
  //                       '1Adult, Economy',
  //                       style: rajdhaniwhite,
  //                     ),
  //                   ],
  //                 ),
  //               ), SizedBox(width: 15,),
  //               Container(
  //                 height: 40,
  //                 width: sWidth * 0.13,
  //                 decoration: BoxDecoration(
  //                     color: Color.fromARGB(255, 166, 175, 212),
  //                     borderRadius: BorderRadius.circular(30)),
  //                 child: Center(
  //                     child: Text(
  //                   'SEARCH',
  //                   style: TextStyle(
  //                       fontSize: 20,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold),
  //                 )),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ));
  // }

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
            Color.fromARGB(255, 3, 54, 81),
            Color.fromARGB(255, 2, 97, 148),
          ],
        ),
      ),
    );
  }

  // Widget _buildFlightDetails(BuildContext context, double screenHeight) {
  //   // String selectedLabel = 'cheapest';
  //   return Positioned(
  //     left: 10,
  //     top: 60,
  //     child: Container(
  //       height: screenHeight-60, // Adjust the height to fill remaining space
  //       width: MediaQuery.of(context).size.width,
  //       color: Colors.white, // Background color for flight details
  //       child: SingleChildScrollView(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             // _buildAirlineFilters(),
  //             SizedBox(height: 20),
  //             Text(
  //               'Flights from Delhi to Mumbai',
  //               style: TextStyle(
  //                 fontSize: 25,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             _buildLabelRow(),
  //             SizedBox(height: 20),
  //             _buildContent(selectedLabel),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildLabelRow() {
  //   return Container(
  //     height: 100,
  //     width: double.infinity,
  //     color: Colors.white,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         _buildLabelContainer('cheapest first'),
  //         SizedBox(width: 10),
  //         isShownonstop ? _buildLabelContainer('Non Stop first') : Container(),
  //         SizedBox(width: 10),
  //         _buildLabelContainer('Early Departure'),
  //         SizedBox(width: 10),
  //         _buildLabelContainer('Late Departure'),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildFlightDetails(
      BuildContext context, double screenHeight, double screenWidth) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAirlineFilters(),
          SizedBox(width: 20),
          _buildFlightsDetails()
        ],
      ),
    );
  }

  Widget _buildFlightsDetails() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 80,),
          Text(
            'Flights from ${widget.fromcity} to ${widget.tocity}',
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 110,
                  width: 820,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: _buildLabelContainer('cheapest first')),
                            SizedBox(width: 10),
                            if (isShownonstop)
                              Center(
                                  child:
                                      _buildLabelContainer('Non Stop first')),
                            SizedBox(width: 10),
                            Center(
                                child: _buildLabelContainer('Early Departure')),
                            SizedBox(width: 10),
                            Center(
                                child: _buildLabelContainer('Late Departure')),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                        child: Text(
                          titleCreator(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0),
                Container(
                  color: Colors.transparent,
                  // height: screenHeight * 0.8,
                  // width: screenWidth * 0.5,
                  child: _buildContent(selectedLabel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // Widget _buildFlightDetails(context, screenHeight, screenwidth) {
  //   //  String selectedLabel = 'cheapest';
  //   return Container(
  //     //  height: screenHeight*0.,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         _buildAirlineFilters(),
  //         SizedBox(
  //           width: 20,
  //         ),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.max,
  //           children: [
  //             Text(
  //               'Flights from Delhi to Mumbai',
  //               style: TextStyle(
  //                 fontSize: 25,
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             Container(
  //               color: Colors.white,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     height: 100,
  //                     width: 900,
  //                     color: Colors.white,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Center(child: _buildLabelContainer('cheapest first')),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         isShownonstop
  //                             ? Center(
  //                                 child: _buildLabelContainer('Non Stop first'))
  //                             : Container(),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Center(
  //                             child: _buildLabelContainer('Early Departure')),
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //                         Center(child: _buildLabelContainer('Late Departure')),
  //                       ],
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.fromLTRB(20, 2, 0, 2),
  //                     child: Text(
  //                       titleCreator(),
  //                       style: TextStyle(
  //                           fontSize: 15,
  //                           color: Colors.black,
  //                           fontWeight: FontWeight.w700),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 20,
  //                   ),
  //                   Container(
  //                     // height: screenHeight*0.8,
  //                     // width:screenwidth*0.5,
  //                     child: _buildContent(selectedLabel),
  //                   ),
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildContent(
    String selectedLabel,
  ) {
    return _buildFlightList(selectedLabel);
  }

  Widget _buildFlightList(String selectedLabel) {
    List<Flight> filteredFlights;

    print("Function_deptime=$depTime");
    filteredFlights = List.from(widget.flightmodel);
    if (depTime != null) {
      int initial_time, end_time;
      switch (depTime) {
        case 0:
          {
            initial_time = 6;
            end_time = 18;

            break;
          }
        case 1:
          {
            initial_time = 6;
            end_time = 12;
            break;
          }
        case 2:
          {
            initial_time = 12;
            end_time = 18;
            break;
          }
        case 3:
          {
            initial_time = 18;
            end_time = 24;
            break;
          }
        default:
          {
            initial_time = 0;
            end_time = 06;
            break;
          }
      }
      // Filter flights to include only those departing within the specified time range
      filteredFlights = widget.flightmodel
          .where((flight) =>
              flight.departureTime != null &&
              flight.departureTime.isNotEmpty &&
              int.tryParse(flight.departureTime.substring(11, 13)) >=
                  initial_time &&
              int.tryParse(flight.departureTime.substring(11, 13)) < end_time)
          .toList();
    } else {
      // Use all flights if no departure time range is specified
      filteredFlights = List.from(widget.flightmodel);
    }

    if (arrTime != null) {
      int initial_time, end_time;
      switch (arrTime) {
        case 0:
          {
            initial_time = 6;
            end_time = 18;

            break;
          }
        case 1:
          {
            initial_time = 6;
            end_time = 12;
            break;
          }
        case 2:
          {
            initial_time = 12;
            end_time = 18;
            break;
          }
        case 3:
          {
            initial_time = 18;
            end_time = 24;
            break;
          }
        default:
          {
            initial_time = 0;
            end_time = 06;
            break;
          }
      }
      // Filter flights to include only those departing within the specified time range
      filteredFlights = widget.flightmodel
          .where((flight) =>
              flight.arrivalTime != null &&
              flight.arrivalTime.isNotEmpty &&
              int.tryParse(flight.arrivalTime.substring(11, 13)) >=
                  initial_time &&
              int.tryParse(flight.arrivalTime.substring(11, 13)) < end_time)
          .toList();
    }

    if (selectedAirline != null) {
      filteredFlights = filteredFlights
          .where((flight) => flight.airlineName == selectedAirline)
          .toList();
    }

    if (!isShownonstop) {
      // Filter flights to include only those with 1 stop
      filteredFlights =
          filteredFlights.where((flight) => flight.stops == 1).toList();
    }

    switch (selectedLabel) {
      case 'cheapest first':
        filteredFlights = filteredFlights
            .where((flight) =>
                flight.price != null &&
                double.tryParse(flight.price) >= minPrice &&
                double.tryParse(flight.price) <= _selectedPrice)
            .toList();
        break;
      case 'Non Stop first':
        filteredFlights = filteredFlights
            .where((flight) =>
                flight.stops == 0 &&
                flight.price != null &&
                double.tryParse(flight.price) >= minPrice &&
                double.tryParse(flight.price) <= _selectedPrice)
            .toList();
        break;
      case 'Early Departure':
        filteredFlights = filteredFlights
            .where((flight) =>
                flight.price != null &&
                double.tryParse(flight.price) >= minPrice &&
                double.tryParse(flight.price) <= _selectedPrice &&
                flight.departureTime != null &&
                flight.departureTime.isNotEmpty &&
                int.tryParse(flight.departureTime.substring(11, 13)) < 6)
            .toList();
        break;
      case 'Late Departure':
        filteredFlights = filteredFlights
            .where((flight) =>
                flight.price != null &&
                double.tryParse(flight.price) >= minPrice &&
                double.tryParse(flight.price) <= _selectedPrice &&
                flight.departureTime != null &&
                flight.departureTime.isNotEmpty &&
                int.tryParse(flight.departureTime.substring(11, 13)) >= 18)
            .toList();
        break;
      default:
        break;
    }

    filteredFlights.sort((a, b) {
      final doublePriceA = double.tryParse(a.price);
      final doublePriceB = double.tryParse(b.price);
      return doublePriceA != null && doublePriceB != null
          ? doublePriceA.compareTo(doublePriceB)
          : 0;
    });

    // // return Container(
    // //   height: MediaQuery.of(context).size.height,
    // //   width: MediaQuery.of(context).size.width * 0.55,
    // //   color: Color.fromARGB(255, 248, 246, 246),
    // //   child: Column(
    // //     children: List.generate(filteredFlights.length, (index) {
    // //       return buildFlightCard(filteredFlights[index]);
    // //     }),
    // //   ),
    // // );
    return Container(
      // height: MediaQuery.of(context).size.height,
     width: MediaQuery.of(context).size.width * 0.58,
      color: Colors.transparent,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List.generate(filteredFlights.length, (index) {
          return Column(
            children: [
              buildFlightCard(filteredFlights[index], index),
              if (selecteddetailindex == index)
                // Container(
                //   height: 204,
                //   width:MediaQuery.of(context).size.width * 0.53,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       // border: Border.all(width: 1.0, color: Colors.grey),
                //       borderRadius: BorderRadius.circular(5)),
                //       child: Column(
                //         children: [
                //           Container(

                //           ),
                //         ],
                //       ),
                // )
                buildFlightDetails(filteredFlights[selecteddetailindex]),
            ],
          );
        }),
      ),
    );
  }
// working
  // return Container(
  //   height: MediaQuery.of(context).size.height,
  //   width: MediaQuery.of(context).size.width * 0.55,
  //   color: Color.fromARGB(255, 248, 246, 246),
  //   child: ListView.builder(
  //     shrinkWrap: true,
  //     scrollDirection: Axis.vertical,
  //     itemCount: filteredFlights.length,
  //     itemBuilder: (context, index) {
  //       return Column(
  //         children: [
  //           buildFlightCard(filteredFlights[index], index),
  //           if (selecteddetailindex ==
  //               index) // Show flight details only for the selected index
  //             buildFlightDetails(filteredFlights[selecteddetailindex]),
  //         ],
  //       );
  //     },
  //   ),
  // );
  // }

  Widget buildFlightDetails(
    Flight tripInfo,
  ) {
    String departure;
    String arrival;
    departure = tripInfo.departureTime.toString();
    arrival = tripInfo.arrivalTime.toString();
    String dTime = departure.substring(departure.length - 5);
    String aTime = arrival.substring(arrival.length - 5);
    String dDate = departure.substring(0, 10);

    String aDate = arrival.substring(0, 10);
    String duration = _minuteToHour(tripInfo.duration);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 204,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.0, color: Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${tripInfo.departureCity} to ${tripInfo.arrivalCity},${formatDate(dDate)}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/AirlinesLogo/${tripInfo.airlineCode}.png',
                    width: 18,
                  ),
                  SizedBox(width: 10),
                  Text(
                    tripInfo.airlineName,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Text(
                " ${tripInfo.airlineCode}|${tripInfo.flightnumber}",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 50),
                  Column(
                    children: [
                      Text(
                        " Departure",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                      Text(
                        dTime,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        formatDateString(departure),
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      if (tripInfo.departureTerminal != null)
                        Text(
                          tripInfo.departureTerminal,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      Text(
                        " ${tripInfo.departureCity}, ${tripInfo.departureCountry}",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  //  _buildDateTimeColumn('Departure', dTime, dDate),
                  SizedBox(width: 50),
                  Column(
                    children: [
                      Text(
                        duration,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      tripInfo.stops == 0
                          ? Container(
                              height: 2,
                              width: 50,
                              color: Color.fromARGB(255, 91, 248, 101))
                          : Container(
                              height: 3,
                              width: 50,
                              color: Color.fromARGB(255, 244, 194, 85),
                              child: Center(
                                  child: CircleAvatar(
                                radius: 3.5,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                              )),
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      tripInfo.stops == 0
                          ? Text(
                              "Nonstop",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w500),
                            )
                          : Text(
                              "${tripInfo.stops} Stops",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                    ],
                  ),
                  SizedBox(width: 50),
                  Column(
                    children: [
                      Text(
                        "Arrival",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                      Text(
                        aTime,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        formatDateString(arrival),
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      if (tripInfo.arrivalTerminal != null)
                        Text(
                          tripInfo.arrivalTerminal,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      Text(
                        " ${tripInfo.arrivalCity}, ${tripInfo.arrivalCountry}",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                      Text(
                        " ₹${tripInfo.price.toString()}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        "Per adult",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Base Fare :   ${tripInfo.baseFare}",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Text(
                        "SurCharges :   ${tripInfo.surCharges}",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFlightCard(Flight tripInfo, int index) {
    String departure;
    String arrival;
    departure = tripInfo.departureTime.toString();
    arrival = tripInfo.arrivalTime.toString();
    String dTime = departure.substring(departure.length - 5);
    String aTime = arrival.substring(arrival.length - 5);
    String dDate = departure.substring(0, 10);

    String aDate = arrival.substring(0, 10);
    String duration = _minuteToHour(tripInfo.duration);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        // width:950,
        height: 150,
        // height: index == showDetail ? 350 : 150,
        color: Colors.transparent,
        child: Card(
          elevation: 5.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 20),
                    Image.asset(
                        'images/AirlinesLogo/${tripInfo.airlineCode}.png'),
                    SizedBox(width: 10),
                    Text(
                      tripInfo.airlineName,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 50),
                    _buildDateTimeColumn('Departure', dTime, dDate),
                    SizedBox(width: 50),
                    Column(
                      children: [
                        Text(
                          duration,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        tripInfo.stops == 0
                            ? Container(
                                height: 2,
                                width: 50,
                                color: Color.fromARGB(255, 91, 248, 101))
                            : GestureDetector(
                              onTap: () {
                                
                              },
                              child: Column(
                                  children: [
                                    Container(
                                      height: 3,
                                      width: 50,
                                      color: Color.fromARGB(255, 244, 194, 85),
                                      child: Center(
                                          child: CircleAvatar(
                                        radius: 3.5,
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                      )),
                                    ),
                                    Container(
                                      // height: 60,
                                      // width: 170,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Plain change",
                                            style: GoogleFonts.rajdhani(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "Udaipur (UDR)| 21h layover",
                                            style: GoogleFonts.rajdhani(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                        SizedBox(
                          height: 5,
                        ),
                        tripInfo.stops == 0
                            ? Text(
                                "Nonstop",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              )
                            : Text(
                                "${tripInfo.stops} Stops",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              ),
                      ],
                    ),
                    SizedBox(width: 50),
                    _buildDateTimeColumn('Arrival', aTime, aDate),
                    SizedBox(width: 50),
                    Column(
                      children: [
                        Text(
                          " ₹${tripInfo.price.toString()}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          " per adult",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(width: 50),
                    Container(
                      height: 60,
                      width: 95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 35,
                            width: 95,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 18, 97, 235)
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(width: 1.0, color: Colors.blue)),
                            child: Center(
                                child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => flightBookingPage(
                                //               flightmodel: tripInfo,
                                //               fromcity: widget.fromcity,
                                //               tocity: widget.tocity,
                                //               travellerCount:
                                //                   widget.travellerCount,
                                //             )));
                                // experimental
                                List<Flight> flightlist = [];
                                flightlist.add(tripInfo);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CommonflightBookingPage(
                                              flightmodel: flightlist,
                                              fromcity: [widget.fromcity],
                                              tocity: [widget.tocity],
                                              travellerCount:
                                                  widget.travellerCount,
                                            )));
                              },
                              child: Text(
                                "BOOK NOW",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                    fontSize: 13),
                              ),
                            )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selecteddetailindex == index) {
                                    selecteddetailindex =
                                        null; // Deselect if already selected
                                  } else {
                                    selecteddetailindex =
                                        index; // Select if not already selected
                                  }
                                });
                              },
                              child: Text(
                                selecteddetailindex == index
                                    ? "Hide Flight Details" // Show "Hide Flight Details" if selected
                                    : "View Flight Details", // Show "View Flight Details" otherwise
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('EEE, d MMM yy').format(dateTime);
    return formattedDate;
  }

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    String formattedDate = DateFormat('dd MMM').format(dateTime);
    return formattedDate;
  }

  Widget _buildDateTimeColumn(String label, String time, String date) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w300, color: Colors.black),
        ),
        Text(
          time,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          date,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ],
    );
  }

  String _minuteToHour(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return "$hours h $remainingMinutes min";
  }

  IconData labelicon(String label) {
    if (label == 'cheapest first') {
      return Icons.currency_rupee_rounded;
    } else if (label == 'Non Stop first') {
      return Icons.speed_rounded;
    } else if (label == 'Early Departure') {
      return Icons.sunny;
    } else if (label == 'Late Departure') {
      return Icons.mode_night_rounded;
    }
  }

  Widget _buildAirlineFilters() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 00),
      child: Card(
        child: Container(
          // height: 800,
          width: 300,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 15),
                  child: Text(
                    'Airlines',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: uniqueAirlineNames.length,
                  itemBuilder: (context, index) {
                    final airlineName = uniqueAirlineNames.elementAt(index);
                    final airlineCode = uniqueAirlineCodes.elementAt(index);
                    bool isSelected = airlineName == selectedAirline;

                    return InkWell(
                      onDoubleTap: () {
                        setState(() {
                          selectedAirline = null;
                          _buildFlightList(
                            selectedLabel,
                          );
                        });
                      },
                      onTap: () {
                        setState(() {
                          selectedAirline = airlineName;
                          _buildFlightList(
                            selectedLabel,
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              child: Image.asset(
                                'images/AirlinesLogo/${airlineCode}.png',
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              airlineName,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.5,
                                  color: isSelected
                                      ? Color.fromARGB(255, 30, 145, 238)
                                      : Colors.grey,
                                ),
                                shape: BoxShape.rectangle,
                                color: isSelected
                                    ? Color.fromARGB(255, 62, 158, 248)
                                    : Color.fromARGB(255, 249, 247, 247),
                              ),
                              child: isSelected
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 14,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Price',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                PriceSlider(
                  minPrice: minPrice,
                  maxPrice: maxPrice,
                  initialValue: _selectedPrice,
                  onChanged: (value) {
                    setState(() {
                      _selectedPrice = value;
                      _buildFlightList(selectedLabel);
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Selected Price: \$${_selectedPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade700),
                ),
                SizedBox(height: 20),
                Text(
                  "Stops from ${widget.fromcity}",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedIndexlist == index;
                    return GestureDetector(
                      onDoubleTap: () {
                        setState(() {
                          selectedIndexlist = null;
                          isShownonstop = true;
                          // isShownonstop=null;
                          _buildFlightList(selectedLabel);
                        });
                      },
                      onTap: () {
                        setState(() {
                          selectedIndexlist = index;
                          if (selectedIndexlist == 0) {
                            isShownonstop = true;
                            selectedLabel = 'Non Stop first';
                            _buildFlightList(selectedLabel);
                          } else if (selectedIndexlist == 1) {
                            isShownonstop = false;
                          }

                          _buildFlightList(selectedLabel);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(list[index]),
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.5,
                                  color: isSelected
                                      ? Color.fromARGB(255, 30, 145, 238)
                                      : Colors.grey,
                                ),
                                shape: BoxShape.rectangle,
                                color: isSelected
                                    ? Color.fromARGB(255, 62, 158, 248)
                                    : Color.fromARGB(255, 249, 247, 247),
                              ),
                              child: isSelected
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 14,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Departure From ${widget.fromcity}',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    List<IconData> iconList = [
                      Icons.wb_sunny_outlined,
                      Icons.sunny,
                      Icons.sunny,
                      Icons.sunny,
                    ];
                    List<String> title = [
                      'Before 6AM',
                      '6AM - 12PM',
                      '12PM - 6PM',
                      'After 6PM',
                    ];
                    return GestureDetector(
                      onDoubleTap: () {
                        setState(() {
                          selectedIndex_deptime = null;
                          depTime = null;
                          print("depTime:$depTime");
                          _buildFlightList(selectedLabel);
                        });
                      },
                      onTap: () {
                        setState(() {
                          selectedIndex_deptime = index;
                          depTime = selectedIndex_deptime;
                          print("depTime:$depTime");
                          _buildFlightList(selectedLabel);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIndex_deptime == index
                              ? Colors.blue.shade500
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 0.4,
                            color: selectedIndex_deptime == index
                                ? Colors.blue.shade900
                                : Colors.grey,
                          ),
                        ),
                        height: 60,
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              iconList[index],
                              color: selectedIndex_deptime == index
                                  ? Colors.white
                                  : Colors.grey,
                              size: 20,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              title[index],
                              style: TextStyle(
                                fontSize: 8,
                                color: selectedIndex_deptime == index
                                    ? Colors.white
                                    : Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Arrival at ${widget.tocity}',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    List<IconData> iconList = [
                      Icons.wb_sunny_outlined,
                      Icons.sunny,
                      Icons.sunny,
                      Icons.sunny,
                    ];
                    List<String> title = [
                      'Before 6AM',
                      '6AM - 12PM',
                      '12PM - 6PM',
                      'After 6PM',
                    ];
                    return GestureDetector(
                      onDoubleTap: () {
                        setState(() {
                          selectedIndex_arrtime = null;
                          arrTime = null;
                          print("arrTime:$arrTime");
                          _buildFlightList(selectedLabel);
                        });
                      },
                      onTap: () {
                        setState(() {
                          selectedIndex_arrtime = index;
                          arrTime = selectedIndex_arrtime;
                          print("arrTime:$arrTime");
                          _buildFlightList(selectedLabel);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIndex_arrtime == index
                              ? Colors.blue.shade500
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 0.4,
                            color: selectedIndex_arrtime == index
                                ? Colors.blue.shade900
                                : Colors.grey,
                          ),
                        ),
                        height: 60,
                        width: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              iconList[index],
                              color: selectedIndex_arrtime == index
                                  ? Colors.white
                                  : Colors.grey,
                              size: 20,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              title[index],
                              style: TextStyle(
                                fontSize: 8,
                                color: selectedIndex_arrtime == index
                                    ? Colors.white
                                    : Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}













//   Widget _buildFlightList(
//     String selectedLabel,
//   ) {
//     List<dynamic> filteredFlights;
// // int  price= int.parse(filteredFlights)
//     if (selectedAirline != null) {
//       // Filter flights by airline name
//       filteredFlights = widget.flightmodel
//           .where((flight) => flight.airlineName == selectedAirline)
//           .toList();
//       switch (selectedLabel) {
//         case 'cheapest first':
//           filteredFlights = filteredFlights.where((flight) {
//             try {
//               final doublePrice = double.parse(flight.price);
//               return doublePrice >= 5400 && doublePrice <= _selectedPrice;
//             } catch (e) {
//               // Handle parsing errors, such as invalid price formats
//               return false;
//             }
//           }).toList();
//           filteredFlights.sort((a, b) {
//             try {
//               final doublePriceA = double.parse(a.price);
//               final doublePriceB = double.parse(b.price);
//               return doublePriceA.compareTo(doublePriceB);
//             } catch (e) {
//               // Handle parsing errors, such as invalid price formats
//               return 0;
//             }
//           });
//           break;
//         case 'Non Stop first':
//           filteredFlights = filteredFlights
//               .where((flight) =>
//                   flight.stops == 0 &&
//                   flight.price != null &&
//                   double.tryParse(flight.price) >= 5400 &&
//                   double.tryParse(flight.price) <= _selectedPrice)
//               .toList();
//           filteredFlights.sort((a, b) {
//             final doublePriceA = double.tryParse(a.price);
//             final doublePriceB = double.tryParse(b.price);
//             return doublePriceA != null && doublePriceB != null
//                 ? doublePriceA.compareTo(doublePriceB)
//                 : 0;
//           });
//           break;
//         case 'Early Departure':
//           filteredFlights = filteredFlights
//               .where((flight) =>
//                   flight.price != null &&
//                   double.tryParse(flight.price) >= 5400 &&
//                   double.tryParse(flight.price) <= _selectedPrice &&
//                   flight.departureTime != null &&
//                   flight.departureTime.isNotEmpty &&
//                   int.tryParse(flight.departureTime.substring(11, 13)) < 6)
//               .toList();
//           filteredFlights.sort((a, b) {
//             final doublePriceA = double.tryParse(a.price);
//             final doublePriceB = double.tryParse(b.price);
//             return doublePriceA != null && doublePriceB != null
//                 ? doublePriceA.compareTo(doublePriceB)
//                 : 0;
//           });
//           break;
//         case 'Late Departure':
//           filteredFlights = filteredFlights
//               .where((flight) =>
//                   flight.price != null &&
//                   double.tryParse(flight.price) >= 5400 &&
//                   double.tryParse(flight.price) <= _selectedPrice &&
//                   flight.departureTime != null &&
//                   flight.departureTime.isNotEmpty &&
//                   int.tryParse(flight.departureTime.substring(11, 13)) >= 18)
//               .toList();
//           filteredFlights.sort((a, b) {
//             final doublePriceA = double.tryParse(a.price);
//             final doublePriceB = double.tryParse(b.price);
//             return doublePriceA != null && doublePriceB != null
//                 ? doublePriceA.compareTo(doublePriceB)
//                 : 0;
//           });
//           break;

//         default:
//           break;
//       }
//     } else {
//       // Apply label-based sorting
//       filteredFlights = List.from(widget.flightmodel);

//       switch (selectedLabel) {
//         case 'cheapest first':
//           filteredFlights = List.from(widget.flightmodel).where((flight) {
//             try {
//               final doublePrice = double.parse(flight.price);
//               return doublePrice >= 5400 && doublePrice <= _selectedPrice;
//             } catch (e) {
//               // Handle parsing errors, such as invalid price formats
//               return false;
//             }
//           }).toList();
//           filteredFlights.sort((a, b) {
//             try {
//               final doublePriceA = double.parse(a.price);
//               final doublePriceB = double.parse(b.price);
//               return doublePriceA.compareTo(doublePriceB);
//             } catch (e) {
//               // Handle parsing errors, such as invalid price formats
//               return 0;
//             }
//           });
//           break;
//         case 'Non Stop first':
//           filteredFlights = List.from(widget.flightmodel)
//               .where((flight) =>
//                   flight.stops == 0 &&
//                   flight.price != null &&
//                   double.tryParse(flight.price) >= 5400 &&
//                   double.tryParse(flight.price) <= _selectedPrice)
//               .toList();
//           filteredFlights.sort((a, b) {
//             final doublePriceA = double.tryParse(a.price);
//             final doublePriceB = double.tryParse(b.price);
//             return doublePriceA != null && doublePriceB != null
//                 ? doublePriceA.compareTo(doublePriceB)
//                 : 0;
//           });
//           break;
//         case 'Early Departure':
//           filteredFlights = List.from(widget.flightmodel)
//               .where((flight) =>
//                   flight.price != null &&
//                   double.tryParse(flight.price) >= 5400 &&
//                   double.tryParse(flight.price) <= _selectedPrice &&
//                   flight.departureTime != null &&
//                   flight.departureTime.isNotEmpty &&
//                   int.tryParse(flight.departureTime.substring(11, 13)) < 6)
//               .toList();
//           filteredFlights.sort((a, b) {
//             final doublePriceA = double.tryParse(a.price);
//             final doublePriceB = double.tryParse(b.price);
//             return doublePriceA != null && doublePriceB != null
//                 ? doublePriceA.compareTo(doublePriceB)
//                 : 0;
//           });
//           break;
//         case 'Late Departure':
//           filteredFlights = List.from(widget.flightmodel)
//               .where((flight) =>
//                   flight.price != null &&
//                   double.tryParse(flight.price) >= 5400 &&
//                   double.tryParse(flight.price) <= _selectedPrice &&
//                   flight.departureTime != null &&
//                   flight.departureTime.isNotEmpty &&
//                   int.tryParse(flight.departureTime.substring(11, 13)) >= 18)
//               .toList();
//           filteredFlights.sort((a, b) {
//             final doublePriceA = double.tryParse(a.price);
//             final doublePriceB = double.tryParse(b.price);
//             return doublePriceA != null && doublePriceB != null
//                 ? doublePriceA.compareTo(doublePriceB)
//                 : 0;
//           });
//           break;

//         default:
//           break;
//       }
//     }

//     return Container(
//       height: MediaQuery.of(context).size.width * 0.55,
//       width: MediaQuery.of(context).size.width * 0.55,
//       color: Color.fromARGB(255, 248, 246, 246),
//       child: ListView.builder(
//         shrinkWrap: true,
//         scrollDirection: Axis.vertical,
//         itemCount: filteredFlights.length,
//         itemBuilder: (context, index) {
//           return buildFlightCard(filteredFlights[index]);
//         },
//       ),
//     );
//   }






// Widget _buildFlightList(selectedLabell) {
//   List<Flight> filteredFlights = [];
//   if (selectedLabell == 'cheapest first') {
//     setState(() {
//       filteredFlights = widget.flightmodel;
//       filteredFlights.sort((a, b) => a.price.compareTo(b.price));
//     });
//   } else if (selectedLabel == 'Non Stop first') {
//     setState(() {
//       filteredFlights =
//           widget.flightmodel.where((flight) => flight.stops == 0).toList();
//     });
//   } else if (selectedLabel == 'Early Departure') {
//     setState(() {
//       filteredFlights = widget.flightmodel;
//       filteredFlights
//           .sort((a, b) => a.departureTime.compareTo(b.departureTime));
//     });
//   } else if (selectedLabel == 'Late Departure') {
//     setState(() {
//       filteredFlights = widget.flightmodel;
//       filteredFlights
//           .sort((a, b) => b.departureTime.compareTo(a.departureTime));
//     });
//   }
//   return Container(
//     height: MediaQuery.of(context).size.width * 0.55,
//     width: MediaQuery.of(context).size.width * 0.55,
//     color: Color.fromARGB(255, 248, 246, 246),
//     child: ListView.builder(
//       shrinkWrap: true,
//       scrollDirection: Axis.vertical,
//       itemCount: filteredFlights.length,
//       itemBuilder: (context, index) {
//         return buildFlightCard(filteredFlights[index]);
//       },
//     ),
//   );
// }

// Widget _buildFlightList() {
//   // Your buildFlightList implementation goes here
//   return Container();
// }

// Widget _buildFlightDetails() {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'Flights from Delhi to Mumbai',
//         style: TextStyle(
//           fontSize: 25,
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       SizedBox(
//         height: 20,
//       ),
//       Container(
//         color: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 100,
//               width: 900,
//               color: Color.fromARGB(255, 39, 9, 147),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(width: 15,),
//                   Container(
//                     height: 50,
//                     width: 180,
//                  color: Colors.white,
//                   child: Center(child: Text("cheapest")),
//                   ),
//                   SizedBox(width: 15,),
//                    Container(
//                     height: 50,
//                     width: 180,
//                    color: Colors.white,
//                   child: Center(child: Text("Non Stop first")),
//                   ),
//                   SizedBox(width: 15,),
//                    Container(
//                     height: 50,
//                     width: 180,
//                   color: Colors.white,
//                   child: Center(child: Text("Early Departure")),
//                   ),SizedBox(width: 15,),
//                    Container(
//                     height: 50,
//                     width: 180,
//                   color: Colors.white,
//                   child: Center(child: Text("late Departure")),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.width * 0.55,
//               width: MediaQuery.of(context).size.width * 0.55,
//               // decoration: BoxDecoration(
//               // color: Color.fromARGB(237, 12, 178, 26),
//               // ),
//               child: _buildFlightList(),
//             ),
//           ],
//         ),
//       )
//     ],
//   );
// }

// Widget _buildFlightList() {
//   return Container(
//     height: MediaQuery.of(context).size.width * 0.55,
//     width: MediaQuery.of(context).size.width * 0.55,
//     color: Color.fromARGB(255, 245, 245, 245),
//     child: ListView.builder(
//       shrinkWrap: true,
//       scrollDirection: Axis.vertical,
//       itemCount: widget.flightmodel.length,
//       itemBuilder: (context, index) {
//         return buildFlightCard(widget.flightmodel[index]);
//       },
//     ),
//   );
// }
