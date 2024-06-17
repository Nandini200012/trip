import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trip/common_flights/common_flightbookingpage.dart';
import 'package:trip/models/flight_model.dart';
import '../api_services/location_list_api.dart';
import '../common/print_funtions.dart';
import 'Drawer.dart';
import 'constant.dart';
import 'flight_searchlist/widgets/priceslider.dart';
import 'flightss_/widgets/search_container.dart';
import 'header.dart';

class ReturnSearchListPage extends StatefulWidget {
  List<Flight> flightmodelReturn;
  List<Flight> flightmodelOnward;
  String domOrinter;
  int travellerCount;
  String fromCity, toCity;
  String date1, date2;
  List<LocationData> locationList1;
  String fromcode, tocode, cabin_class, adult, child, infant;
  ReturnSearchListPage(
      {Key key,
      this.domOrinter,
      this.fromcode,
      this.tocode,
      this.cabin_class,
      this.adult,
      this.child,
      this.infant,
      this.locationList1,
      this.flightmodelReturn,
      this.flightmodelOnward,
      this.travellerCount,
      this.fromCity,
      this.toCity,
      this.date1,
      this.date2})
      : super(key: key);

  @override
  State<ReturnSearchListPage> createState() => _ReturnSearchListPageState();
}

class _ReturnSearchListPageState extends State<ReturnSearchListPage> {
  Set<String> uniqueAirlineNames = {};
  Set<String> uniqueAirlineCodes = {};
  String selectedAirline;
  // price filter
  double minOnwardPrice = 0;
  double maxOnwardPrice = 0;
  double onwardSelectedPrice = 0;
  double minReturnPrice = 0;
  double maxReturnPrice = 0;
  double returnSelectedPrice = 0;
  double _selectedPrice = 24300;
  // filter
  bool isreturnShownonstop = false;
  bool isonwardShownonstop = false;
  String selectedLabel = 'cheapest first';

  int selectedIndex_deptimeOnward;
  int selectedIndex_arrtimeOnward;
  int depTimeOnward;
  int arrTimeOnward;

  int selectedIndex_deptimeReturn;
  int selectedIndex_arrtimeReturn;
  int depTimeReturn;
  int arrTimeReturn;
  int selectedonwardIndexlist;
  int selectedreturnIndexlist;
  int selectedIndex_deptime = -1;
  int selectedIndex_arrtime = -1;
  // bool isShownonstop = true;
  int depTime;
  int arrTime;
  bool showDetail = false;
  var selecteddetailindex;
  var list = ['Non stop', '1 Stop'];
  List<int> selectedIndices_onward = [];
  List<int> selectedIndices_return = []; // List to store selected indices
  bool isInnerCircleSelected = false;
  List<bool> isSelected;
  bool detailsPrinted = false;
  List<Flight> selectedFlights = [];
// overlay
  Flight onwardflight, returnflight;
  String dep1, dep2, ret1, ret2;
  String dep_flight = 'Spicejet';
  String ret_flight = 'Spicejet';
  String dep_price, ret_price;
  String dep_image, ret_image;
  @override
  void initState() {
    super.initState();
    log("total ret: ${widget.flightmodelReturn[0].arrivalCountry}");
    log("total on: ${widget.flightmodelOnward.length.toString()}");
    selectedFlights = List.filled(2, null);
    uniqueAirlineNames = widget.flightmodelReturn.fold<Set<String>>(<String>{},
        (uniqueNames, flight) => uniqueNames..add(flight.airlineName));
    uniqueAirlineCodes = widget.flightmodelReturn.fold<Set<String>>(<String>{},
        (uniqueNames, flight) => uniqueNames..add(flight.airlineCode));
    selectedLabel = 'cheapest first';
    selectedAirline = null;
    _selectedPrice = 24300;
    isreturnShownonstop = true;
    isonwardShownonstop = true;
    getflights();
    maxminPrice();
    printred("to ${widget.tocode}");
  }

  void maxminPrice() {
    List<Flight> _onwardflights = widget.flightmodelOnward;
    List<Flight> _returnflights = widget.flightmodelReturn;

    if (_onwardflights.isEmpty && _returnflights.isEmpty) {
      print("No flights available.");
      return;
    }

    double _maxOnwardPrice = double.negativeInfinity;
    double _minOnwardPrice = double.infinity;
    double _maxReturnPrice = double.negativeInfinity;
    double _minReturnPrice = double.infinity;

    for (var flight in _onwardflights) {
      double price = double.parse(flight.price);
      if (price > _maxOnwardPrice) {
        _maxOnwardPrice = price;
      }
      if (price < _minOnwardPrice) {
        _minOnwardPrice = price;
      }
    }

    for (var flight in _returnflights) {
      double price = double.parse(flight.price);
      if (price > _maxReturnPrice) {
        _maxReturnPrice = price;
      }
      if (price < _minReturnPrice) {
        _minReturnPrice = price;
      }
    }

    print("Max onward price: $_maxOnwardPrice");
    print("Min onward price: $_minOnwardPrice");
    print("Max return price: $_maxReturnPrice");
    print("Min return price: $_minReturnPrice");
    setState(() {
      minOnwardPrice = _minOnwardPrice - 1000;
      maxOnwardPrice = _maxOnwardPrice + 1000;
      onwardSelectedPrice = _maxOnwardPrice;
      minReturnPrice = _minReturnPrice - 1000;
      maxReturnPrice = _maxReturnPrice + 1000;
      returnSelectedPrice = _maxReturnPrice;
    });
  }

  void _updateSelectedPrice(double value, String journeyType) {
    setState(() {
      if (journeyType == 'onward') {
        onwardSelectedPrice = value;
      } else {
        returnSelectedPrice = value;
      }
      _buildFlightList(
          selectedLabel,
          journeyType == 'onward'
              ? widget.flightmodelOnward
              : widget.flightmodelReturn,
          journeyType);
    });
  }

  getflights() {
    print("onward[0]");

    printContents(widget.flightmodelOnward[0]);
    print("return[0]");

    printContents(widget.flightmodelReturn[0]);
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

  // String selectedLabel = 'cheapest first ';
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

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Custom Bottom Sheet',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 204, 224, 241),
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
                fromcity: widget.fromCity,
                tocity: widget.toCity,
                adult: widget.adult,
                child: widget.child,
                cabin_class: widget.cabin_class,
                type: 'Return',
                travellerCount: widget.travellerCount,
                date: widget.date1,
                fromcode: widget.fromcode,
                tocode: widget.tocode,
                returndate: widget.date2,
                infant: widget.infant,
                 domorInter:widget.domOrinter
              ),
              //  SearchContainer(sWidth: screenWidth,sHeight: screenHeight, locationList1: widget.locationList1),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  // searchContainer(screenWidth, screenHeight,context),
                  _buildGradientContainer(screenWidth),
                  (_buildFlightDetails(context, screenHeight, screenWidth)),

                  // if (ret_image != null && dep_image != null)
                  //   _buildOverlayCOntainer(screenHeight, screenWidth)
                ],
              ),
            ],
          ),
        ),
        bottomSheet: (ret_image != null && dep_image != null)
            ? Container(
                color: Colors.transparent,
                width: screenWidth,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: _buildOverlayCOntainer(screenHeight, screenWidth),
                ),
              )
            : null);
  }

  Widget _buildGradientContainer(double width) {
    return Container(
      height: 150, // Adjust the height as needed
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

  Widget _buildFlightDetails(
      BuildContext context, double screenHeight, double screenWidth) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAirlineFilters(),
          SizedBox(width: 20),
          _buildFlightsDetails(screenHeight, screenWidth)
        ],
      ),
    );
  }

  // Widget _buildFlightsDetails(
  //   screenHeight,
  //   screenWidth,
  // ) {
  //   return Container(
  //     color: Colors.red,
  //     width: screenWidth * 0.3,
  //     child: _buildFlightList(
  //         selectedLabel, widget.flightmodelOnward, "onward"),
  //   );
  // }

  Widget _buildFlightsDetails(
    screenHeight,
    screenWidth,
  ) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flights from ${widget.fromCity} to ${widget.toCity}, and back',
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    placeIndicator("${widget.fromCity} → ${widget.toCity}",
                        convertToDate("${widget.date1}")),
                    Container(
                      //  height:screenHeight,
                      // color: Colors.red,
                      width: screenWidth * 0.3,
                      child: _buildFlightList(
                          selectedLabel, widget.flightmodelOnward, "onward"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    placeIndicator("${widget.toCity} → ${widget.fromCity}",
                        convertToDate("${widget.date2}")),
                    Container(
                      // color: Colors.amber,
                      // height: screenHeight,
                      width: screenWidth * 0.3,
                      child: _buildFlightList(
                          selectedLabel, widget.flightmodelReturn, 'return'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String convertToDate(String dateString) {
    // Parse the input date string into a DateTime object
    DateTime date = DateTime.parse(dateString);

    // Format the date using the desired format
    String formattedDate = DateFormat('EEE, d MMM').format(date);

    return formattedDate;
  }

  Widget _buildOverlayCOntainer(
    screenHeight,
    screenWidth,
  ) {
    return Container(
      height: screenHeight * 0.19,
      width: screenWidth * 0.6,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5.0,
          color: Color.fromARGB(255, 1, 13, 51),
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 13),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        dep_flight != null
                            ? "Departure ・ $dep_flight"
                            : "Departure ・ SpiceJet",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Row(
                        children: [
                          if (dep_image != null)
                            Container(
                              width: 35,
                              height: 35,
                              // color: Colors.blue,
                              child: Image.asset(
                                'images/AirlinesLogo/${dep_image}.png',
                                width: 18,
                              ),
                            ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            (dep1 == null || dep2 == null)
                                ? "20:00 → 22:15"
                                : "$dep1 → $dep2",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Text(
                        "Flight Details",
                        style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 35,
                ),
                Text(
                  dep_price != null ? "₹ ${dep_price}" : "₹ 5,717",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 100,
                  width: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        ret_flight != null
                            ? "Return ・ $ret_flight"
                            : "Return ・ SpiceJet",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: screenHeight * 0.025,
                      ),
                      Row(
                        children: [
                          if (ret_image != null)
                            Container(
                              width: 35,
                              height: 35,
                              // color: Colors.blue,
                              child: Image.asset(
                                'images/AirlinesLogo/${ret_image}.png',
                                width: 18,
                              ),
                            ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            (ret1 == null || ret2 == null)
                                ? "20:00 → 22:15"
                                : "$ret1 → $ret2",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      Text(
                        "Flight Details",
                        style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 35,
                ),
                Text(
                  ret_price != null ? "₹ ${ret_price}" : "₹ 5,717",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (dep_price != null && ret_price != null)
                            ? "₹ ${Totalprice(ret_price, dep_price)}"
                            : "₹ 11,629",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Text(
                      // (dep_price!=null&&ret_price!=null)?"${dep_price+ret_price}":  "₹ 11,629",
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 22,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "per adult",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Fare Details",
                        style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // printWhite("return book");
                    // log("onward:");
                    // printContents(onwardflight);

                    // log("return:");
                    // printContents(returnflight);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ReturnBookingPagee(
                    //               flightmodel: onwardflight,
                    //               flightmodel2: returnflight,
                    //               travellerCount: widget.travellerCount,
                    //               fromcity: widget.fromCity,
                    //               tocity: widget.toCity,
                    //             )));
                    // List<Flight> flightlist = [];
                    // flightlist.add(onwardflight);
                    // flightlist.add(returnflight);
                    log("--onward book--");
                    // printContents(flightlist[0]);
                    log("--return book--");
                    // printContents(flightlist[1]);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => returnFlightBook(
                    //               flightmodel: flightlist,
                    //             )));
                    List<String> fromcitylist = [
                      widget.fromCity,
                      widget.toCity
                    ];
                    List<String> tocitylist = [widget.toCity, widget.fromCity];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommonflightBookingPage(
                                  flightmodel: selectedFlights,
                                  fromcity: fromcitylist,
                                  tocity: tocitylist,
                                  travellerCount: 1,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Container(
                    width: 115,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 155, 207, 249).withOpacity(0.5),
                          Color.fromARGB(255, 52, 153, 236).withOpacity(0.8),
                          Color.fromARGB(255, 2, 125, 225),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String Totalprice(String dep, String ret) {
    double total = double.parse(dep) + double.parse(ret);
    return total
        .toStringAsFixed(2); // Adjust the number of decimal places as needed
  }

  Widget _buildFlightList(
      String selectedLabel, List<Flight> flightmodel, String type) {
    // List<Flight> filteredonwardFlights;
// List<Flight> filteredreturnFlights;
    List<Flight> filteredFlights;

    // Separate state variables for onward and return flights
    // int depTimeOnward;
    // int arrTimeOnward;
    // int depTimeReturn;
    // int arrTimeReturn;
    // printWhite("${depTimeOnward.toString()}");
    // Determine which state variables to use based on the type
    // int depTime = (type == 'onward') ? depTimeOnward : depTimeReturn;
    // int arrTime = (type == 'onward') ? arrTimeOnward : arrTimeReturn;
    if (type == 'onward') {
      if (depTimeOnward != null) {
        int initial_time, end_time;
        // Switch statement to determine time slots based on depTimeOnward
        switch (depTimeOnward) {
          case 0:
            initial_time = 0;
            end_time = 6;
            break;
          case 1:
            initial_time = 6;
            end_time = 12;
            break;
          case 2:
            initial_time = 12;
            end_time = 18;
            break;
          case 3:
            initial_time = 18;
            end_time = 24;
            break;
          default:
            initial_time = 0;
            end_time = 24;
            break;
        }
        filteredFlights = flightmodel
            .where((flight) =>
                flight.departureTime != null &&
                flight.departureTime.isNotEmpty &&
                int.tryParse(flight.departureTime.substring(11, 13)) >=
                    initial_time &&
                int.tryParse(flight.departureTime.substring(11, 13)) < end_time)
            .toList();
      } else {
        filteredFlights = List.from(flightmodel);
      }
    } else if (type == 'return') {
      if (depTimeReturn != null) {
        int initial_time, end_time;
        // Switch statement to determine time slots based on depTimeReturn
        switch (depTimeReturn) {
          case 0:
            initial_time = 0;
            end_time = 6;
            break;
          case 1:
            initial_time = 6;
            end_time = 12;
            break;
          case 2:
            initial_time = 12;
            end_time = 18;
            break;
          case 3:
            initial_time = 18;
            end_time = 24;
            break;
          default:
            initial_time = 0;
            end_time = 24;
            break;
        }
        filteredFlights = flightmodel
            .where((flight) =>
                flight.departureTime != null &&
                flight.departureTime.isNotEmpty &&
                int.tryParse(flight.departureTime.substring(11, 13)) >=
                    initial_time &&
                int.tryParse(flight.departureTime.substring(11, 13)) < end_time)
            .toList();
      } else {
        filteredFlights = List.from(flightmodel);
      }
    }
    if (type == 'onward') {
      if (arrTimeOnward != null) {
        int initial_time, end_time;
        // Switch statement to determine time slots based on arrTimeOnward
        switch (arrTimeOnward) {
          case 0:
            initial_time = 0;
            end_time = 6;
            break;
          case 1:
            initial_time = 6;
            end_time = 12;
            break;
          case 2:
            initial_time = 12;
            end_time = 18;
            break;
          case 3:
            initial_time = 18;
            end_time = 24;
            break;
          default:
            initial_time = 0;
            end_time = 24;
            break;
        }
        filteredFlights = filteredFlights
            .where((flight) =>
                flight.arrivalTime != null &&
                flight.arrivalTime.isNotEmpty &&
                int.tryParse(flight.arrivalTime.substring(11, 13)) >=
                    initial_time &&
                int.tryParse(flight.arrivalTime.substring(11, 13)) < end_time)
            .toList();
      }
    } else if (type == 'return') {
      if (arrTimeReturn != null) {
        int initial_time, end_time;
        // Switch statement to determine time slots based on arrTimeReturn
        switch (arrTimeReturn) {
          case 0:
            initial_time = 0;
            end_time = 6;
            break;
          case 1:
            initial_time = 6;
            end_time = 12;
            break;
          case 2:
            initial_time = 12;
            end_time = 18;
            break;
          case 3:
            initial_time = 18;
            end_time = 24;
            break;
          default:
            initial_time = 0;
            end_time = 24;
            break;
        }
        filteredFlights = filteredFlights
            .where((flight) =>
                flight.arrivalTime != null &&
                flight.arrivalTime.isNotEmpty &&
                int.tryParse(flight.arrivalTime.substring(11, 13)) >=
                    initial_time &&
                int.tryParse(flight.arrivalTime.substring(11, 13)) < end_time)
            .toList();
      }
    }

    // Filter flights by arrival time if specified
    // if (arrTime != null) {
    //   int initial_time, end_time;
    //   switch (arrTime) {
    //     case 0:
    //       initial_time = 0;
    //       end_time = 6;
    //       break;
    //     case 1:
    //       initial_time = 6;
    //       end_time = 12;
    //       break;
    //     case 2:
    //       initial_time = 12;
    //       end_time = 18;
    //       break;
    //     case 3:
    //       initial_time = 18;
    //       end_time = 24;
    //       break;
    //     default:
    //       initial_time = 0;
    //       end_time = 24;
    //       break;
    //   }
    //   filteredFlights = filteredFlights
    //       .where((flight) =>
    //           flight.arrivalTime != null &&
    //           flight.arrivalTime.isNotEmpty &&
    //           int.tryParse(flight.arrivalTime.substring(11, 13)) >=
    //               initial_time &&
    //           int.tryParse(flight.arrivalTime.substring(11, 13)) < end_time)
    //       .toList();
    // }

    // Filter flights by selected airline if specified
    if (selectedAirline != null) {
      filteredFlights = filteredFlights
          .where((flight) => flight.airlineName == selectedAirline)
          .toList();
    }

    // Filter non-stop flights if specified
    // Filter non-stop or stop flights based on the type
    if (type == 'onward') {
      if (isonwardShownonstop) {
        filteredFlights =
            filteredFlights.where((flight) => flight.stops == 0).toList();
      } else {
        filteredFlights =
            filteredFlights.where((flight) => flight.stops == 1).toList();
      }
    } else {
      if (isreturnShownonstop) {
        filteredFlights =
            filteredFlights.where((flight) => flight.stops == 0).toList();
      } else {
        filteredFlights =
            filteredFlights.where((flight) => flight.stops == 1).toList();
      }
    }

    // Filter flights by selected price range
    filteredFlights = filteredFlights
        .where((flight) =>
            flight.price != null &&
            double.tryParse(flight.price) >=
                (type == 'onward' ? minOnwardPrice : minReturnPrice) &&
            double.tryParse(flight.price) <=
                (type == 'onward' ? onwardSelectedPrice : returnSelectedPrice))
        .toList();

    // Additional sorting logic based on selected label
    filteredFlights.sort((a, b) {
      final doublePriceA = double.tryParse(a.price);
      final doublePriceB = double.tryParse(b.price);
      return doublePriceA != null && doublePriceB != null
          ? doublePriceA.compareTo(doublePriceB)
          : 0;
    });

    return Container(
      color: Colors.transparent,
      child: ListView(
        shrinkWrap: true,
        children: List.generate(filteredFlights.length, (index) {
          return Column(
            children: [
              type == 'onward'
                  ? buildFlightCard_onward(filteredFlights[index], index)
                  : buildFlightCard_return(filteredFlights[index], index),
            ],
          );
        }),
      ),
    );
  }

  // Widget _buildContent(String selectedLabel, List<Flight> flightmodel, type) {
  //   return _buildFlightList( selectedLabel, flightmodel, type);
  // }

//   Widget _buildFlightList(
//       String selectedLabel, List<Flight> flightmodel, type) {
//     List<Flight> filteredFlights;

//     print("Function_deptime=$depTime");

//     if (depTime != null) {
//       int initial_time, end_time;
//       switch (depTime) {
//         case 0:
//           {
//             initial_time = 6;
//             end_time = 18;

//             break;
//           }
//         case 1:
//           {
//             initial_time = 6;
//             end_time = 12;
//             break;
//           }
//         case 2:
//           {
//             initial_time = 12;
//             end_time = 18;
//             break;
//           }
//         case 3:
//           {
//             initial_time = 18;
//             end_time = 24;
//             break;
//           }
//         default:
//           {
//             initial_time = 0;
//             end_time = 06;
//             break;
//           }
//       }
//       // Filter flights to include only those departing within the specified time range
//       filteredFlights = flightmodel
//           .where((flight) =>
//               flight.departureTime != null &&
//               flight.departureTime.isNotEmpty &&
//               int.tryParse(flight.departureTime.substring(11, 13)) >=
//                   initial_time &&
//               int.tryParse(flight.departureTime.substring(11, 13)) < end_time)
//           .toList();
//     } else {
//       // Use all flights if no departure time range is specified
//       filteredFlights = List.from(flightmodel);
//     }

//     if (arrTime != null) {
//       int initial_time, end_time;
//       switch (arrTime) {
//         case 0:
//           {
//             initial_time = 6;
//             end_time = 18;

//             break;
//           }
//         case 1:
//           {
//             initial_time = 6;
//             end_time = 12;
//             break;
//           }
//         case 2:
//           {
//             initial_time = 12;
//             end_time = 18;
//             break;
//           }
//         case 3:
//           {
//             initial_time = 18;
//             end_time = 24;
//             break;
//           }
//         default:
//           {
//             initial_time = 0;
//             end_time = 06;
//             break;
//           }
//       }
//       // Filter flights to include only those departing within the specified time range
//       filteredFlights = flightmodel
//           .where((flight) =>
//               flight.arrivalTime != null &&
//               flight.arrivalTime.isNotEmpty &&
//               int.tryParse(flight.arrivalTime.substring(11, 13)) >=
//                   initial_time &&
//               int.tryParse(flight.arrivalTime.substring(11, 13)) < end_time)
//           .toList();
//     }

//     if (selectedAirline != null) {
//       filteredFlights = filteredFlights
//           .where((flight) => flight.airlineName == selectedAirline)
//           .toList();
//     }

//     if (!isonwardShownonstop) {
//       // Filter flights to include only those with 1 stop
//       filteredFlights =
//           filteredFlights.where((flight) => flight.stops == 1).toList();
//     }

//     switch (selectedLabel) {
//       case 'cheapest first':
//         filteredFlights = filteredFlights
//             .where((flight) =>
//                 flight.price != null &&
//                 double.tryParse(flight.price) >= 5400 &&
//                 double.tryParse(flight.price) <= _selectedPrice)
//             .toList();
//         break;
//       case 'Non Stop first':
//         filteredFlights = filteredFlights
//             .where((flight) =>
//                 flight.stops == 0 &&
//                 flight.price != null &&
//                 double.tryParse(flight.price) >= 5400 &&
//                 double.tryParse(flight.price) <= _selectedPrice)
//             .toList();
//         break;
//       case 'Early Departure':
//         filteredFlights = filteredFlights
//             .where((flight) =>
//                 flight.price != null &&
//                 double.tryParse(flight.price) >= 5400 &&
//                 double.tryParse(flight.price) <= _selectedPrice &&
//                 flight.departureTime != null &&
//                 flight.departureTime.isNotEmpty &&
//                 int.tryParse(flight.departureTime.substring(11, 13)) < 6)
//             .toList();
//         break;
//       case 'Late Departure':
//         filteredFlights = filteredFlights
//             .where((flight) =>
//                 flight.price != null &&
//                 double.tryParse(flight.price) >= 5400 &&
//                 double.tryParse(flight.price) <= _selectedPrice &&
//                 flight.departureTime != null &&
//                 flight.departureTime.isNotEmpty &&
//                 int.tryParse(flight.departureTime.substring(11, 13)) >= 18)
//             .toList();
//         break;
//       default:
//         break;
//     }

//     filteredFlights.sort((a, b) {
//       final doublePriceA = double.tryParse(a.price);
//       final doublePriceB = double.tryParse(b.price);
//       return doublePriceA != null && doublePriceB != null
//           ? doublePriceA.compareTo(doublePriceB)
//           : 0;
//     });

//     // return Container(
//     //   height: MediaQuery.of(context).size.height,
//     //   width: MediaQuery.of(context).size.width * 0.55,
//     //   color: Color.fromARGB(255, 248, 246, 246),
//     //   child: Column(
//     //     children: List.generate(filteredFlights.length, (index) {
//     //       return buildFlightCard(filteredFlights[index]);
//     //     }),
//     //   ),
//     // );
//     return Container(
//       color: Colors.transparent,
//       child: ListView(
//         shrinkWrap: true,
//         children: List.generate(filteredFlights.length, (index) {
//           return Column(
//             children: [
//               type == 'onward'
//                   ? Column(
//                       children: [
//                         buildFlightCard_onward(
//                           filteredFlights[index],
//                           index,
//                         ),
//                       ],
//                     )
//                   : buildFlightCard_return(
//                       filteredFlights[index],
//                       index,
//                     ),
//             ],
//           );
//         }),
//       ),
//     );

// // wotking

//     // return Container(
//     //   // height: MediaQuery.of(context).size.height+500,
//     //   //  width: MediaQuery.of(context).size.width * 0.55,
//     //   color: Colors.transparent,
//     //   child: ListView.builder(
//     //     shrinkWrap: true,
//     //     itemCount: filteredFlights.length,
//     //     itemBuilder: (context, index) {
//     //       return Column(
//     //         children: [
//     //           type == 'onward'
//     //               ? Column(
//     //                   children: [
//     //                     buildFlightCard_onward(
//     //                       filteredFlights[index],
//     //                       index,
//     //                     ),
//     //                   ],
//     //                 )
//     //               : buildFlightCard_return(
//     //                   filteredFlights[index],
//     //                   index,
//     //                 )
//     //         ],
//     //       );
//     //     },
//     //   ),
//     // );
//   }

  Widget placeIndicator(routes, date) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 460,
        height: 100,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(routes,
                      style: GoogleFonts.rajdhani(
                          fontSize: 17, fontWeight: FontWeight.w700)),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(date,
                        style: GoogleFonts.rajdhani(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                color: Colors.grey.shade200,
                width: 500,
                height: 40,
                child: Row(children: [
                  SizedBox(
                    width: 80,
                  ),
                  Text("Departure",
                      style: GoogleFonts.rajdhani(
                          fontSize: 13, fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 40,
                  ),
                  Text("Duration",
                      style: GoogleFonts.rajdhani(
                          fontSize: 13, fontWeight: FontWeight.w500)),
                  SizedBox(
                    width: 40,
                  ),
                  Text("Arrival",
                      style: GoogleFonts.rajdhani(
                          fontSize: 13, fontWeight: FontWeight.w500)),
                  Spacer(),
                  Text("Price ↑",
                      style: GoogleFonts.rajdhani(
                          fontSize: 13, fontWeight: FontWeight.w700)),
                  SizedBox(
                    width: 35,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
      padding: const EdgeInsets.all(18.0),
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
                  // CircleAvatar(radius: 30,backgroundColor: Colors.blue,),
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
                " ${tripInfo.airlineCode}|${tripInfo.flightNo}",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.blue,
                    height: 50,
                    width: 50,
                  ),
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

// List<int> selectedIndices = []; // List to store selected indices
// // Flag to check if details are printed

  Widget buildFlightCard_onward(Flight tripInfo, int index) {
    if (tripInfo == null) {
      // Return a placeholder widget or handle the case where tripInfo is null
      return SizedBox(); // Return an empty widget for now
    }
    String departure = tripInfo.departureTime.toString();
    String arrival = tripInfo.arrivalTime.toString();
    String dTime = departure.substring(departure.length - 5);
    String aTime = arrival.substring(arrival.length - 5);
    String dDate = departure.substring(0, 10);
    String aDate = arrival.substring(0, 10);
    String duration = _minuteToHour(tripInfo.duration);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Container(
        width: 500,
        height: 150,
        color: Colors.transparent,
        child: Card(
          elevation: 5.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Row(
                  children: [
                    Image.asset(
                      'images/AirlinesLogo/${tripInfo.airlineCode}.png',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      tripInfo.airlineName,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        if (selectedFlights[0] != null &&
                            selectedFlights[0].airlineCode ==
                                tripInfo.airlineCode) {
                          selectedFlights[0] = null;
                        }
                        // Set the selected flight for onward
                        selectedFlights[0] = tripInfo;

                        log("onward:55");
                        print("selectedFlights $selectedFlights");
                        // print(priceinfo);
                        printContents(selectedFlights[0]);
                        // printContents(tripInfo);
                        setState(() {
                          if (!selectedIndices_onward.contains(index)) {
                            selectedIndices_onward.clear();
                            selectedIndices_onward.add(index);
                            if (!detailsPrinted) {
                              detailsPrinted = true;
                              printFlightDetails_onward(
                                tripInfo,
                              );
                            }
                          }
                        });
                        printFlightDetails_onward(
                          tripInfo,
                        );
                      },
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.grey.shade400,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Color.fromARGB(255, 252, 253, 255),
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor:
                                selectedIndices_onward.contains(index)
                                    ? Color.fromARGB(255, 32, 107, 213)
                                    : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    _buildDateTimeColumn('Departure', dTime, dDate),
                    SizedBox(width: 25),
                    Column(
                      children: [
                        Text(
                          duration,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 5),
                        tripInfo.stops == 0
                            ? Text("Nonstop",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500))
                            : Text("${tripInfo.stops} Stops",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(width: 25),
                    _buildDateTimeColumn('Arrival', aTime, aDate),
                    SizedBox(width: 40),
                    Column(
                      children: [
                        Text(" ₹${tripInfo.price.toString()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text(" per adult",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                      ],
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

  void printFlightDetails_onward(
    Flight tripInfo,
  ) {
    log('onward');
    print('Airline: ${tripInfo.airlineName}');
    print('Departure: ${tripInfo.departureTime}');
    print('Arrival: ${tripInfo.arrivalTime}');
    setState(() {
      dep1 = convertDateTime(tripInfo.departureTime);
      dep2 = convertDateTime(tripInfo.arrivalTime);
      dep_flight = tripInfo.airlineName;
      dep_image = tripInfo.airlineCode;
      dep_price = tripInfo.price;
    });
    print("dep:$dep1,$dep2");
  }

  String convertDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime =
        DateFormat.Hm().format(dateTime); // Format as "HH:mm"
    return formattedTime;
  }

  Widget buildFlightCard_return(Flight tripInfo, int index) {
    if (tripInfo == null) {
      // Return a placeholder widget or handle the case where tripInfo is null
      return SizedBox(); // Return an empty widget for now
    }
    String departure = tripInfo.departureTime.toString();
    String arrival = tripInfo.arrivalTime.toString();
    String dTime = departure.substring(departure.length - 5);
    String aTime = arrival.substring(arrival.length - 5);
    String dDate = departure.substring(0, 10);
    String aDate = arrival.substring(0, 10);
    String duration = _minuteToHour(tripInfo.duration);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Container(
        width: 500,
        height: 150,
        color: Colors.transparent,
        child: Card(
          elevation: 5.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                child: Row(
                  children: [
                    Image.asset(
                      'images/AirlinesLogo/${tripInfo.airlineCode}.png',
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      tripInfo.airlineName,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (selectedFlights[1] != null &&
                            selectedFlights[1].airlineCode ==
                                tripInfo.airlineCode) {
                          selectedFlights[1] = null;
                        }
                        // Set the selected flight for return
                        selectedFlights[1] = tripInfo;

                        print("selectedFlights ret $selectedFlights");
                        log("ret:55");
                        // printContents(tripInfo);
                        setState(() {
                          if (!selectedIndices_return.contains(index)) {
                            selectedIndices_return
                                .clear(); // Clear previous selections
                            selectedIndices_return
                                .add(index); // Add index if not already present
                            if (!detailsPrinted) {
                              detailsPrinted = true; // Set flag to true
                              printFlightDetails_return(
                                  tripInfo); // Print flight details
                            }
                          }
                        });
                        printFlightDetails_return(tripInfo);
                      },
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.grey.shade400,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Color.fromARGB(255, 252, 253, 255),
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor:
                                selectedIndices_return.contains(index)
                                    ? Color.fromARGB(255, 32, 107, 213)
                                    : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    _buildDateTimeColumn('Departure', dTime, dDate),
                    SizedBox(width: 25),
                    Column(
                      children: [
                        Text(
                          duration,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 5),
                        tripInfo.stops == 0
                            ? Text("Nonstop",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500))
                            : Text("${tripInfo.stops} Stops",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(width: 25),
                    _buildDateTimeColumn('Arrival', aTime, aDate),
                    SizedBox(width: 40),
                    Column(
                      children: [
                        Text(" ₹${tripInfo.price.toString()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text(" per adult",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                      ],
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

  void printFlightDetails_return(Flight tripInfo) {
    log('return');
    print('Airline: ${tripInfo.airlineName}');
    print('Departure: ${tripInfo.departureTime}');
    print('Arrival: ${tripInfo.arrivalTime}');
    setState(() {
      ret1 = convertDateTime(tripInfo.departureTime);
      ret2 = convertDateTime(tripInfo.arrivalTime);
      ret_flight = tripInfo.airlineName;
      ret_price = tripInfo.price;
      ret_image = tripInfo.airlineCode;
      // returnflight = tripInfo;
      // printContents(tripInfo);
      // assignFlights(returnflight, tripInfo);
    });
    print("ret: $ret1,$ret2");
    // Add more details as needed
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 58,
        ),
        Card(
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
                    padding: const EdgeInsets.only(bottom: 5),
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
                            _buildFlightList(selectedLabel,
                                widget.flightmodelOnward, 'onward');
                          });
                        },
                        onTap: () {
                          setState(() {
                            selectedAirline = airlineName;
                            _buildFlightList(selectedLabel,
                                widget.flightmodelOnward, 'onward');
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(
                  //     'Price',
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.w700),
                  //   ),
                  // ),
                  // PriceSlider(
                  //   minPrice: 5400,
                  //   maxPrice: 54300,
                  //   initialValue: _selectedPrice,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       _selectedPrice = value;
                  //       _buildFlightList(
                  //           selectedLabel, widget.flightmodelOnward, 'onward');
                  //     });
                  //   },
                  // ),
                  // SizedBox(height: 20),
                  // Text(
                  //   'Selected Price: \$${_selectedPrice.toStringAsFixed(2)}',
                  //   style: TextStyle(
                  //       fontSize: 10,
                  //       fontWeight: FontWeight.w700,
                  //       color: Colors.grey.shade700),
                  // ),
                  SizedBox(height: 20),
                  OnwardJourney(),
                  SizedBox(
                    height: 20,
                  ),
                  returnJourney(),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget OnwardJourney() {
    List<String> list = ['Non Stop', '1 Stop'];

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Onward Journey",
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          Divider(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Onward Price',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          PriceSlider(
            minPrice: minOnwardPrice,
            maxPrice: maxOnwardPrice,
            initialValue: onwardSelectedPrice,
            onChanged: (value) => _updateSelectedPrice(value, 'onward'),
          ),
          SizedBox(height: 20),
          Text(
            'Selected Price: \$${onwardSelectedPrice.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700),
          ),
          SizedBox(height: 20),
          Text(
            "Stops from ${widget.fromCity}",
            style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(0, 0, 0, 1),
                fontWeight: FontWeight.w700),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, onwardindex) {
              bool isonwardSelected = selectedonwardIndexlist == onwardindex;
              return GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    selectedonwardIndexlist = null;
                    isonwardShownonstop = true;
                    // _buildFlightList(
                    //     selectedLabel, widget.flightmodelOnward, 'onward');
                  });
                },
                onTap: () {
                  setState(() {
                    selectedonwardIndexlist = onwardindex;
                    if (selectedonwardIndexlist == 0) {
                      isonwardShownonstop = true;
                      selectedLabel = 'Non Stop first';
                    } else if (selectedonwardIndexlist == 1) {
                      isonwardShownonstop = false;
                    }

                    _buildFlightList(
                        selectedLabel, widget.flightmodelOnward, 'onward');
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(list[onwardindex]),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: isonwardSelected
                                ? Color.fromARGB(255, 30, 145, 238)
                                : Colors.grey,
                          ),
                          shape: BoxShape.rectangle,
                          color: isonwardSelected
                              ? Color.fromARGB(255, 62, 158, 248)
                              : Color.fromARGB(255, 249, 247, 247),
                        ),
                        child: isonwardSelected
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
            'Departure From ${widget.fromCity}',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20),
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
                    selectedIndex_deptimeOnward = null;
                    depTimeOnward = null;
                    _buildFlightList(
                        selectedLabel, widget.flightmodelOnward, 'onward');
                  });
                },
                onTap: () {
                  setState(() {
                    selectedIndex_deptimeOnward = index;
                    depTimeOnward = selectedIndex_deptimeOnward;

                    // Here, you can call the _buildFlightList function with the updated depTimeOnward
                    _buildFlightList(
                        selectedLabel, widget.flightmodelOnward, 'onward');
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIndex_deptimeOnward == index
                        ? Colors.blue.shade500
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.4,
                      color: selectedIndex_deptimeOnward == index
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
                        color: selectedIndex_deptimeOnward == index
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
                          color: selectedIndex_deptimeOnward == index
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
            'Arrival at ${widget.toCity}',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
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
                    selectedIndex_arrtimeOnward = null;
                    arrTimeOnward = null;
                    _buildFlightList(
                        selectedLabel, widget.flightmodelOnward, 'onward');
                  });
                },
                onTap: () {
                  setState(() {
                    selectedIndex_arrtimeOnward = index;
                    arrTimeOnward = selectedIndex_arrtimeOnward;
                    _buildFlightList(
                        selectedLabel, widget.flightmodelOnward, 'onward');
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIndex_arrtimeOnward == index
                        ? Colors.blue.shade500
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.4,
                      color: selectedIndex_arrtimeOnward == index
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
                        color: selectedIndex_arrtimeOnward == index
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
                          color: selectedIndex_arrtimeOnward == index
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
    );
  }

  // Widget OnwardJourney() {
  //   return Container(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Onward Journey",
  //           style: TextStyle(
  //               fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
  //         ),
  //         Divider(),
  //         SizedBox(height: 20),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(
  //             'Onward Price',
  //             style: TextStyle(
  //                 fontSize: 15,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.w700),
  //           ),
  //         ),
  //         PriceSlider(
  //           minPrice: minOnwardPrice,
  //           maxPrice: maxOnwardPrice,
  //           initialValue: onwardSelectedPrice,
  //           onChanged: (value) => _updateSelectedPrice(value, 'onward'),
  //         ),
  //         SizedBox(height: 20),
  //         Text(
  //           'Selected Price: \$${onwardSelectedPrice.toStringAsFixed(2)}',
  //           style: TextStyle(
  //               fontSize: 10,
  //               fontWeight: FontWeight.w700,
  //               color: Colors.grey.shade700),
  //         ),
  //         SizedBox(height: 20),
  //         Text(
  //           "Stops from ${widget.fromCity}",
  //           style: TextStyle(
  //               fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
  //         ),
  //         ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: list.length,
  //           itemBuilder: (context, index) {
  //             bool isSelected = selectedIndexlist == index;
  //             return GestureDetector(
  //               onDoubleTap: () {
  //                 setState(() {
  //                   selectedIndexlist = null;
  //                   isShownonstop = true;
  //                   // isShownonstop=null;
  //                   _buildFlightList(
  //                       selectedLabel, widget.flightmodelOnward, 'onward');
  //                 });
  //               },
  //               onTap: () {
  //                 setState(() {
  //                   selectedIndexlist = index;
  //                   if (selectedIndexlist == 0) {
  //                     isShownonstop = true;
  //                     selectedLabel = 'Non Stop first';
  //                     _buildFlightList(
  //                         selectedLabel, widget.flightmodelOnward, 'onward');
  //                   } else if (selectedIndexlist == 1) {
  //                     isShownonstop = false;
  //                   }

  //                   _buildFlightList(
  //                       selectedLabel, widget.flightmodelOnward, 'onward');
  //                 });
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(list[index]),
  //                     Container(
  //                       width: 18,
  //                       height: 18,
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           width: 1.5,
  //                           color: isSelected
  //                               ? Color.fromARGB(255, 30, 145, 238)
  //                               : Colors.grey,
  //                         ),
  //                         shape: BoxShape.rectangle,
  //                         color: isSelected
  //                             ? Color.fromARGB(255, 62, 158, 248)
  //                             : Color.fromARGB(255, 249, 247, 247),
  //                       ),
  //                       child: isSelected
  //                           ? Icon(
  //                               Icons.done,
  //                               color: Colors.white,
  //                               size: 14,
  //                             )
  //                           : null,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Text(
  //           'Departure From ${widget.fromCity}',
  //           style: TextStyle(
  //               fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
  //         ),

  //         SizedBox(height: 20),
  //         GridView.builder(
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 4,
  //             crossAxisSpacing: 10,
  //             mainAxisSpacing: 10,
  //           ),
  //           itemCount: 4,
  //           shrinkWrap: true,
  //           itemBuilder: (context, index) {
  //             List<IconData> iconList = [
  //               Icons.wb_sunny_outlined,
  //               Icons.sunny,
  //               Icons.sunny,
  //               Icons.sunny,
  //             ];
  //             List<String> title = [
  //               'Before 6AM',
  //               '6AM - 12PM',
  //               '12PM - 6PM',
  //               'After 6PM',
  //             ];
  //             return GestureDetector(
  //               onDoubleTap: () {
  //                 setState(() {
  //                   selectedIndex_deptime = null;
  //                   depTime = null;
  //                   print("depTime:$depTime");
  //                   _buildFlightList(
  //                       selectedLabel, widget.flightmodelOnward, 'onward');
  //                 });
  //               },
  //               onTap: () {
  //                 setState(() {
  //                   selectedIndex_deptime = index;
  //                   depTime = selectedIndex_deptime;
  //                   print("depTime:$depTime");
  //                   _buildFlightList(
  //                       selectedLabel, widget.flightmodelOnward, 'onward');
  //                 });
  //               },
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   color: selectedIndex_deptime == index
  //                       ? Colors.blue.shade500
  //                       : Colors.white,
  //                   borderRadius: BorderRadius.circular(10),
  //                   border: Border.all(
  //                     width: 0.4,
  //                     color: selectedIndex_deptime == index
  //                         ? Colors.blue.shade900
  //                         : Colors.grey,
  //                   ),
  //                 ),
  //                 height: 60,
  //                 width: 60,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Icon(
  //                       iconList[index],
  //                       color: selectedIndex_deptime == index
  //                           ? Colors.white
  //                           : Colors.grey,
  //                       size: 20,
  //                     ),
  //                     SizedBox(
  //                       height: 5,
  //                     ),
  //                     Text(
  //                       title[index],
  //                       style: TextStyle(
  //                         fontSize: 8,
  //                         color: selectedIndex_deptime == index
  //                             ? Colors.white
  //                             : Colors.grey.shade700,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Text(
  //           'Arrival at ${widget.toCity}',
  //           style: TextStyle(
  //               fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         GridView.builder(
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 4,
  //             crossAxisSpacing: 10,
  //             mainAxisSpacing: 10,
  //           ),
  //           itemCount: 4,
  //           shrinkWrap: true,
  //           itemBuilder: (context, index) {
  //             List<IconData> iconList = [
  //               Icons.wb_sunny_outlined,
  //               Icons.sunny,
  //               Icons.sunny,
  //               Icons.sunny,
  //             ];
  //             List<String> title = [
  //               'Before 6AM',
  //               '6AM - 12PM',
  //               '12PM - 6PM',
  //               'After 6PM',
  //             ];
  //             return GestureDetector(
  //               onDoubleTap: () {
  //                 setState(() {
  //                   selectedIndex_arrtime = null;
  //                   arrTime = null;
  //                   print("arrTime:$arrTime");
  //                   _buildFlightList(
  //                       selectedLabel, widget.flightmodelOnward, 'onward');
  //                 });
  //               },
  //               onTap: () {
  //                 setState(() {
  //                   selectedIndex_arrtime = index;
  //                   arrTime = selectedIndex_arrtime;
  //                   print("arrTime:$arrTime");
  //                   _buildFlightList(
  //                       selectedLabel, widget.flightmodelOnward, 'onward');
  //                 });
  //               },
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   color: selectedIndex_arrtime == index
  //                       ? Colors.blue.shade500
  //                       : Colors.white,
  //                   borderRadius: BorderRadius.circular(10),
  //                   border: Border.all(
  //                     width: 0.4,
  //                     color: selectedIndex_arrtime == index
  //                         ? Colors.blue.shade900
  //                         : Colors.grey,
  //                   ),
  //                 ),
  //                 height: 60,
  //                 width: 60,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Icon(
  //                       iconList[index],
  //                       color: selectedIndex_arrtime == index
  //                           ? Colors.white
  //                           : Colors.grey,
  //                       size: 20,
  //                     ),
  //                     SizedBox(
  //                       height: 5,
  //                     ),
  //                     Text(
  //                       title[index],
  //                       style: TextStyle(
  //                         fontSize: 8,
  //                         color: selectedIndex_arrtime == index
  //                             ? Colors.white
  //                             : Colors.grey.shade700,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget returnJourney() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Return Journey",
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Return Price',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          PriceSlider(
            minPrice: minReturnPrice,
            maxPrice: maxReturnPrice,
            initialValue: returnSelectedPrice,
            onChanged: (value) => _updateSelectedPrice(value, 'return'),
          ),
          SizedBox(height: 20),
          Text(
            'Selected Price: ${returnSelectedPrice.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700),
          ),
          SizedBox(height: 20),
          Text(
            "Stops from ${widget.toCity}",
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, returnindex) {
              bool isreturnSelected = selectedreturnIndexlist == returnindex;
              return GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    selectedreturnIndexlist = null;
                    isreturnShownonstop = true;
                    // isShownonstop=null;
                    // _buildFlightList(
                    //     selectedLabel, widget.flightmodelReturn, 'return');
                  });
                },
                onTap: () {
                  setState(() {
                    selectedreturnIndexlist = returnindex;
                    if (selectedreturnIndexlist == 0) {
                      isreturnShownonstop = true;
                      selectedLabel = 'Non Stop first';
                      _buildFlightList(
                          selectedLabel, widget.flightmodelReturn, 'return');
                    } else if (selectedreturnIndexlist == 1) {
                      isreturnShownonstop = false;
                    }

                    _buildFlightList(
                        selectedLabel, widget.flightmodelReturn, 'return');
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(list[returnindex]),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: isreturnSelected
                                ? Color.fromARGB(255, 30, 145, 238)
                                : Colors.grey,
                          ),
                          shape: BoxShape.rectangle,
                          color: isreturnSelected
                              ? Color.fromARGB(255, 62, 158, 248)
                              : Color.fromARGB(255, 249, 247, 247),
                        ),
                        child: isreturnSelected
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
            'Departure From ${widget.toCity}',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
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
                    depTimeReturn = null;
                    // print("depTime:$depTime");
                    _buildFlightList(
                        selectedLabel, widget.flightmodelReturn, 'return');
                  });
                },
                onTap: () {
                  setState(() {
                    selectedIndex_deptime = index;
                    depTimeReturn = selectedIndex_deptime;

                    _buildFlightList(
                        selectedLabel, widget.flightmodelReturn, 'return');
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
            'Arrival at ${widget.fromCity}',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
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
                    arrTimeReturn = null;
                    print("arrTime:$arrTime");
                    _buildFlightList(
                        selectedLabel, widget.flightmodelReturn, 'return');
                  });
                },
                onTap: () {
                  setState(() {
                    selectedIndex_arrtime = index;
                    arrTimeReturn = selectedIndex_arrtime;

                    _buildFlightList(
                        selectedLabel, widget.flightmodelReturn, 'return');
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
    );
  }
}
