import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/models/flight_model.dart';
import 'package:trip/screens/constant.dart';
import 'package:trip/screens/flights/return/return_widgets/return_widgest.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import '../../api_services/location_list_api.dart';
import '../../api_services/search apis/multi_way/Domestic_multiway_searchapi.dart';
import '../../common_flights/common_flightbookingpage.dart';
import '../Drawer.dart';
import '../flight_model/multicity_route_model.dart';
import '../flightss_/widgets/search_container.dart';
import '../header.dart';

class multiCityInternational extends StatefulWidget {
  ComboMultiFlightData multicity;
  List<LocationData> locationList1;
  String cabin_class;
  String adult;
  String child;
  String infant;
  multiCityInternational(
      {key,
      this.adult,
      this.cabin_class,
      this.child,
      this.infant,
      this.multicity,
      this.locationList1});

  @override
  State<multiCityInternational> createState() => _multiCityInternationalState();
}

double _selectedPrice = 1000; // Example initial value for price filter
bool _filterApplied = false; // Flag to track if any filter is applied
List<String> _selectedAirlines = []; // Store selected airlines
double _selectedDuration = 0; // Initial value for duration filter
Map<String, String> uniqueairlineMap = {};
Map<String, String> uniqueFlights(ComboMultiFlightData multicity) {
  List<Combo> cmb = multicity.tripInfos.combo;
  Map<String, String> airlineMap = {};

  for (Combo flight in cmb) {
    for (Segment seg in flight.segments) {
      String airlineName = seg.flightDetails.airlineInfo.name;
      String airlineCode = seg.flightDetails.airlineInfo.code;

      // Check if airline name already exists in the map before adding
      if (!airlineMap.containsKey(airlineName)) {
        airlineMap[airlineName] = airlineCode;
      }
    }
  }

  return airlineMap;
}

class _multiCityInternationalState extends State<multiCityInternational> {
  @override
  void initState() {
    super.initState();
    uniqueairlineMap = uniqueFlights(widget.multicity);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 232, 251),
      //  Color(0xFF0d2b4d),
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
              travellerCount: int.parse(widget.adult) +
                  int.parse(widget.child) +
                  int.parse(widget.infant),
              adult: widget.adult,
              child: widget.child,
              infant: widget.infant,
              cabin_class: widget.cabin_class,
               fromcity: multiRoutes[0].fromcity,
              tocity: multiRoutes[0].tocity,
              fromcode: multiRoutes[0].fromCode,
              tocode: multiRoutes[0].toCode,
              date: multiRoutes[0].date,
              //  multiflights:widget.flights,
              type: 'Multicity',
               domorInter:'international'
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                _buildGradientContainer(screenWidth),
                (_buildFlightDetails(context, screenHeight, screenWidth,
                    widget.multicity.tripInfos.combo)),

                // if (ret_image != null && dep_image != null)
                //   _buildOverlayCOntainer(screenHeight, screenWidth)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientContainer(double width) {
    return Container(
      height: 250, // Adjust the height as needed
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
            Color.fromARGB(255, 3, 54, 81),
            Color.fromARGB(255, 2, 97, 148),
          ],
        ),
      ),
    );
  }

  Widget _buildFilter(BuildContext context, double screenHeight,
      double screenWidth, List<Combo> combo) {
    return Column(
      children: [
        kheight30,
        kheight30,
        kheight30,
        kheight30,
        kheight30,
        Card(
          elevation: 5.0,
          child: Container(
            width: screenWidth * 0.2,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
                    child: Text(
                      "Airlines",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: uniqueairlineMap.length,
                    itemBuilder: (context, index) {
                      String airlineName =
                          uniqueairlineMap.keys.toList()[index];
                      String airlineCode =
                          uniqueairlineMap.values.toList()[index];
                      final isChecked = _selectedAirlines.contains(airlineName);

                      return CheckboxListTile(
                        title: Text(airlineName),
                        subtitle: Text(
                            airlineCode), // Optionally display airline code
                        value: isChecked,
                        onChanged: (bool newValue) {
                          setState(() {
                            if (newValue) {
                              if (!_selectedAirlines.contains(airlineName)) {
                                _selectedAirlines.add(airlineName);
                              }
                            } else {
                              _selectedAirlines.remove(airlineName);
                            }
                            _filterApplied = true;
                            _applyFilters();
                          });
                        },
                      );
                    },
                  ),
                  Slider(
                    min: 0,
                    max: 24,
                    divisions: 24,
                    value: _selectedDuration,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDuration = newValue;
                        _filterApplied = true;
                        _applyFilters();
                      });
                    },
                  ),
                  Slider(
                    min: 0,
                    max: 24,
                    divisions: 24,
                    value: _selectedDuration,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDuration = newValue;
                        _filterApplied = true;
                        _applyFilters();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _applyFilters() {
    List<Combo> filteredCombo = widget.multicity.tripInfos.combo.where((combo) {
      return combo.segments.any((segment) =>
          _selectedAirlines.contains(segment.flightDetails.airlineInfo.name));
    }).toList();

    setState(() {});
  }

  Widget _buildFlightDetails(BuildContext context, double screenHeight,
      double screenWidth, List<Combo> combo) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFilter(context, screenHeight, screenWidth, combo),
        kwidth30,
        Container(
          width: screenWidth * 0.55,
          child: Column(
            children: [
              kheight30,
              kheight30,
              kheight30,
              kheight30,
              for (var trip in combo)
                _buildTripDetailsCard(screenHeight, screenWidth, trip),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTripDetailsCard(double sheight, double swidth, Combo combo) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalPriceInfo(combo.totalPriceList, combo, sheight, swidth),
            Divider(),
            // Display flight segments
            for (int i = 0; i < combo.segments.length; i++)
              _buildFlightSegmentTile(sheight, swidth, combo.segments[i], i),
            // for (var segment in combo.segments) _buildFlightSegmentTile(segment),
            SizedBox(height: 10),
            // Display total price information
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 12, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     child: Text("View Flight Details",
                  //         style: GoogleFonts.rajdhani(
                  //             color: Colors.blue,
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 13)),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFlightSegmentTile(
      double sheight, double swidth, Segment segment, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: sheight * 0.1,
        width: swidth * 0.5,
        // color: Colors.red,
        child: Column(
          children: [
            Row(
              children: [
                kwidth5,
                Text(
                  "Trip ${index + 1}",
                  style: GoogleFonts.rajdhani(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.grey),
                ),
                kwidth30,
                Text(
                  "${segment.departureAirport.city} to ${segment.arrivalAirport.city} | ${formatDate(segment.departureTime)}",
                  style: GoogleFonts.rajdhani(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        // color: Colors.blue,
                        child: Image.asset(
                          'images/AirlinesLogo/${segment.flightDetails.airlineInfo.code}.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      kwidth5,
                      Text(
                        "${segment.flightDetails.airlineInfo.name}",
                        style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  kwidth30,
                  kwidth10,
                  Column(
                    children: [
                      Text(
                        "${extractTime(segment.departureTime)}",
                        style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "${segment.departureAirport.city}",
                        style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  kwidth10,
                  Column(
                    children: [
                      Text(
                        "${convertMinutesToHoursAndMinutes(int.parse(segment.duration))}",
                        style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      kheight3,
                      Visibility(
                        visible: (segment.stops == 0 || segment.stops == "0")
                            ? true
                            : false,
                        child: Container(
                          height: 2,
                          width: 155,
                          color: Colors.grey,
                        ),
                      ),
                      Visibility(
                        visible: (segment.stops == 0 || segment.stops == "0")
                            ? false
                            : true,
                        child: Row(
                          children: [
                            Container(
                              height: 2,
                              width: 80,
                              color: Colors.grey,
                            ),
                            Container(
                              height: 10,
                              width: 10,
                              color: Colors.grey[300],
                            ),
                            Container(
                              height: 2,
                              width: 80,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      // Text(
                      //   "${((segment.stops))}",
                      //   style: GoogleFonts.rajdhani(
                      //     fontWeight: FontWeight.w600,
                      //     fontSize: 13,
                      //   ),
                      // ),
                      (segment.stops == 0 || segment.stops == '0')
                          ? Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "Non stop",
                                style: GoogleFonts.rajdhani(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.blue[400]),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                " ${(segment.stops)} stop ${(segment.so)}",
                                style: GoogleFonts.rajdhani(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.blue[400]),
                              ),
                            )
                    ],
                  ),
                  kwidth10,
                  Column(
                    children: [
                      Text(
                        "${extractTime(segment.arrivalTime)}",
                        style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "${segment.arrivalAirport.city}",
                        style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  // Text('${segment.departureTime} - ${segment.arrivalTime}')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
//   return ListTile(
//     leading: Text("Trip ${index+1}"),
//     // leading: Icon(Icons.flight),
//     title: Text(
//         '${segment.departureAirport.name} to ${segment.arrivalAirport.name}'),
//     subtitle: Text('${segment.departureTime} - ${segment.arrivalTime}'),
//     trailing: Text(
//         '${segment.flightDetails.airlineInfo.name} ${segment.flightDetails.flightNumber}'),
//   );
// }

  Widget _buildTotalPriceInfo(List<TotalPriceList> totalPriceList, Combo _combo,
      double sHeight, double sWidth) {
    // Calculate total price from the list of TotalPriceList objects
    double totalPrice = totalPriceList.fold(
        0.0,
        (previousValue, element) =>
            previousValue +
            double.parse(element.fareDetails.fareComponents.totalFare));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Multiple Airlines",
                style: GoogleFonts.rajdhani(
                    fontWeight: FontWeight.w500, fontSize: 14),
              ),
              kheight3,
              Row(
                children: [
                  for (int i = 0; i < _combo.segments.length; i++)
                    Text(
                      "${_combo.segments[i].flightDetails.airlineInfo.name} ,",
                      style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  kwidth3,
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          " Duration ${(totalDuration(_combo))} ",
                          style: GoogleFonts.rajdhani(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '₹ $totalPrice',
                style: GoogleFonts.rajdhani(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ), // Assuming the currency is USD
              Text(
                'per adult',
                style: GoogleFonts.rajdhani(
                    fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                List<Flight> selectedFlights = comboToFlights(
                    _combo,
                    widget.adult,
                    widget.child,
                    widget.infant,
                    widget.cabin_class);
                List<String> fromcitylist = [];
                List<String> tocitylist = [];

                for (Segment segment in _combo.segments) {
                  fromcitylist.add(segment.departureAirport.city);
                  tocitylist.add(segment.arrivalAirport.city);
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommonflightBookingPage(
                              flightmodel: selectedFlights,
                              fromcity: fromcitylist,
                              tocity: tocitylist,
                              
                              travellerCount: (int.parse(widget.adult)+int.parse(widget.child)+int.parse(widget.infant)),
                            )));
              },
              child: Container(
                height: sHeight * 0.035,
                width: sWidth * 0.075,
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    border: Border.all(width: 0.4, color: Colors.blue),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Book Now",
                    style: GoogleFonts.rajdhani(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
          ),
          kwidth30
        ],
      ),
    );
  }

  String totalDuration(Combo combo) {
    double totalMinutes = 0.0;

    for (int i = 0; i < combo.segments.length; i++) {
      totalMinutes += double.parse(combo.segments[i].duration);
    }

    int hours = totalMinutes ~/ 60;
    int minutes = (totalMinutes % 60).toInt();

    return '${hours} h ${minutes} m';
  }
}
// ------------->>
// _buildFilter(BuildContext context, double screenHeight, double screenWidth,
//     List<Combo> combo) {
//   return Column(
//     children: [
//       kheight30,
//       kheight30,
//       kheight30,
//       kheight30,
//       kheight30,
//       Card(
//         elevation: 5.0,
//         child: Container(
//           width: screenWidth * 0.2,
//           // height: screenHeight * 0.5,
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
//                 child: Text(
//                   "Airlines",
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: 4,
//                 itemBuilder: (context, index) {
//                   List<String> airlineList = ["ghk", "dfgd", "fdghj", "fdghk"];
//                   final airlineName = airlineList[index];
//                   final isChecked = true;
//                   // selectedAirlines.contains(airlineName);

//                   return Padding(
//                     padding: const EdgeInsets.all(3.0),
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 3.0, bottom: 3),
//                       child: Row(
//                         children: [
//                           SizedBox(width: 12),
//                           Container(
//                             height: 25,
//                             width: 25,
//                             child: Image.asset('images/AirlinesLogo/Z7.png'),
//                           ),
//                           SizedBox(width: 12),
//                           Text(airlineName),
//                           Spacer(),
//                           Checkbox(
//                             value: isChecked,
//                             onChanged: (bool newValue) {
//                               // setState(() {
//                               //   _toggleAirlineFilter(
//                               //       airlineName, _selectedIndex);
//                               // });
//                             },
//                           ),
//                           SizedBox(width: 8),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "Price",
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               kheight10,
//               PriceSlider(
//                 minPrice: 22,
//                 maxPrice: 2002222,
//                 initialValue: 1000,
//                 onChanged: (value) {
//                   // setState(() {
//                   // _selectedPrice = value;
//                   // // filteredFlights =
//                   // _applyFilters(widget.flights, _selectedPrice + 1000,
//                   //     _selectedIndex);
//                   // });
//                 },
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Selected Price: \${_selectedPrice.toStringAsFixed(2)}',
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.grey.shade700),
//               ),
//               kheight10,
//               SizedBox(height: 10),
//               Text(
//                 "Duration",
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               kheight10,
//               PriceSlider(
//                 minPrice: 22,
//                 maxPrice: 2002222,
//                 initialValue: 1000,
//                 onChanged: (value) {
//                   // setState(() {
//                   // _selectedPrice = value;
//                   // // filteredFlights =
//                   // _applyFilters(widget.flights, _selectedPrice + 1000,
//                   //     _selectedIndex);
//                   // });
//                 },
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Selected Price: \${_selectedPrice.toStringAsFixed(2)}',
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.grey.shade700),
//               ),
//               kheight10,
//                Text(
//                 "Layover Duration",
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               kheight10,
//               PriceSlider(
//                 minPrice: 22,
//                 maxPrice: 2002222,
//                 initialValue: 1000,
//                 onChanged: (value) {
//                   // setState(() {
//                   // _selectedPrice = value;
//                   // // filteredFlights =
//                   // _applyFilters(widget.flights, _selectedPrice + 1000,
//                   //     _selectedIndex);
//                   // });
//                 },
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Selected Price: \${_selectedPrice.toStringAsFixed(2)}',
//                 style: TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.grey.shade700),
//               ),
//               kheight10,
//               SizedBox(
//                 width: screenWidth * 0.2,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: 2,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           // _buildSegment("Departure From New Delhi",
//                           // screenWidth, screenHeight),
//                           // SizedBox(height: 10),
//                           // _buildSegment(
//                           //     "Arrival at Mumbai",     screenWidth, screenHeight),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ),
//     ],
//   );
// }