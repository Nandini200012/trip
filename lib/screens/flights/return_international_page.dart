import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/common/print_funtions.dart';
import 'package:trip/constants/fonts.dart';
import 'package:trip/models/flight_model.dart';
import 'package:trip/screens/bus/bus_availableTrips.dart';
import 'package:trip/screens/flights/return/return_widgets/return_widgest.dart';
import 'package:trip/screens/flights/widgets/flight_details_widget.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import '../../api_services/location_list_api.dart';
import '../../api_services/search apis/return/international_return_search_api.dart';
import '../../common_flights/common_flightbookingpage.dart';
import '../Drawer.dart';
import '../constant.dart';
import '../flight_searchlist/widgets/priceslider.dart';
import '../flightss_/widgets/search_container.dart';
import '../header.dart';

class returnInternationalPage extends StatefulWidget {
  // final List<Flight> flightModelReturn;
  // final List<Flight> flightModelOnward;
  ComboFlightData result;
  final int travellerCount;
  final String fromCity;
  final String toCity;
  final String date1;
  final String date2;
  final List<LocationData> locationList1;
  final String fromCode;
  final String toCode;
  final String adult;
  final String child;
  final String infant;
  final String cabinClass;
  returnInternationalPage(
      {this.result,
      //   this.flightModelReturn,
      // this.flightModelOnward,
      this.travellerCount,
      this.fromCity,
      this.toCity,
      this.date1,
      this.date2,
      this.locationList1,
      this.fromCode,
      this.toCode,
      this.adult,
      this.child,
      this.infant,
      this.cabinClass});

  @override
  State<returnInternationalPage> createState() =>
      _returnInternationalPageState();
}

double _maxRoundTripPrice;
double _minRoundTripPrice;
double _maxDeparturePricee;
double _minDeparturePrice;
double _maxArrivalPrice;
double _minArrivalPrice;
double _selectedRoundPrice;
double _selectedDeparturePrice;
double _selectedArrivalPrice;
// filter
List<Combo> retcombofilteredList = [];
int onwardStopIndex = null;
String onwardNonstop = null;
String returnNonstop = null;
// onward
int selectedOnwardDepindex = null;
int selectedOnwardRetindex = null;
// return
int selectedReturnDepindex = null;
int selectedReturnRetindex = null;
// airline filter
int selectedIndex;
String selectedAirline = null;

class _returnInternationalPageState extends State<returnInternationalPage> {
  @override
  void initState() {
    super.initState();
    selectedLabel = 'cheapest first';
    flightList.clear();
    retcombofilteredList = widget.result.tripInfos.combo;
    getUniqueFlights(widget.result);
    getMaxAndMinPrices(widget.result);
  }

  void handleTap(int index) {
    printWhite("handle funcrtion");
    setState(() {
      selectedIndex = index;
    });
    printWhite("selected index $selectedIndex");
  }

  void getMaxAndMinPrices(ComboFlightData result) {
    List<Combo> combolist = result.tripInfos.combo;

    // Lists to store total prices for round trip, departure, and arrival
    List<double> totalRoundTripPrices = [];
    List<double> totalDeparturePrices = [];
    List<double> totalArrivalPrices = [];

    for (Combo combo in combolist) {
      double totalRoundTripPrice = 0.0;
      double totalDeparturePrice = 0.0;
      double totalArrivalPrice = 0.0;

      for (TotalPriceList totalList in combo.totalPriceList) {
        totalRoundTripPrice +=
            double.parse(totalList.fareDetails.fareComponents.totalFare);
        if (combo.totalPriceList.indexOf(totalList) == 0) {
          totalDeparturePrice +=
              double.parse(totalList.fareDetails.fareComponents.totalFare);
        } else {
          totalArrivalPrice +=
              double.parse(totalList.fareDetails.fareComponents.totalFare);
        }
      }

      // Add total prices to respective lists
      totalRoundTripPrices.add(totalRoundTripPrice);
      totalDeparturePrices.add(totalDeparturePrice);
      totalArrivalPrices.add(totalArrivalPrice);
    }

    // Calculate maximum and minimum prices for round trip, departure, and arrival
    double maxRoundTripPrice = totalRoundTripPrices.isNotEmpty
        ? totalRoundTripPrices.reduce((a, b) => a > b ? a : b)
        : 0.0;
    double minRoundTripPrice = totalRoundTripPrices.isNotEmpty
        ? totalRoundTripPrices.reduce((a, b) => a < b ? a : b)
        : 0.0;

    double maxDeparturePrice = totalDeparturePrices.isNotEmpty
        ? totalDeparturePrices.reduce((a, b) => a > b ? a : b)
        : 0.0;
    double minDeparturePrice = totalDeparturePrices.isNotEmpty
        ? totalDeparturePrices.reduce((a, b) => a < b ? a : b)
        : 0.0;

    double maxArrivalPrice = totalArrivalPrices.isNotEmpty
        ? totalArrivalPrices.reduce((a, b) => a > b ? a : b)
        : 0.0;
    double minArrivalPrice = totalArrivalPrices.isNotEmpty
        ? totalArrivalPrices.reduce((a, b) => a < b ? a : b)
        : 0.0;

    setState(() {
      _maxRoundTripPrice = maxRoundTripPrice;
      _minRoundTripPrice = minRoundTripPrice;
      _maxDeparturePricee = maxDeparturePrice;
      _minDeparturePrice = minDeparturePrice;
      _maxArrivalPrice = maxArrivalPrice;
      _minArrivalPrice = minArrivalPrice;
      _selectedRoundPrice = maxRoundTripPrice - 1000;
      _selectedDeparturePrice = maxDeparturePrice - 1000;
      _selectedArrivalPrice = maxDeparturePrice - 1000;
    });
    // Print the calculated maximum and minimum prices
    print('Max Round Trip Price: $maxRoundTripPrice');
    print('Min Round Trip Price: $minRoundTripPrice');
    print('Max Departure Price: $maxDeparturePrice');
    print('Min Departure Price: $minDeparturePrice');
    print('Max Arrival Price: $maxArrivalPrice');
    print('Min Arrival Price: $minArrivalPrice');
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

  Widget _buildLabelContainer(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLabel = label;
          filterFunction(
              selectedAirline,
              _selectedRoundPrice,
              onwardNonstop,
              returnNonstop,
              selectedLabel,
              selectedOnwardDepindex,
              selectedReturnDepindex,
              selectedOnwardRetindex,
              selectedReturnRetindex);
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

  List<FlightDetails> flightList = [];
  void getUniqueFlights(ComboFlightData result) {
    Set<String> flightNames = {};
    List<FlightDetails> uniqueFlightList = [];

    List<Combo> combolist = result.tripInfos.combo;

    for (Combo combo in combolist) {
      String flightName = combo.segments[0].flightDetails.airlineInfo.name;
      if (!flightNames.contains(flightName)) {
        flightNames.add(flightName);
        uniqueFlightList.add(combo.segments[0].flightDetails);
      }
    }

    setState(() {
      flightList = uniqueFlightList;
    });
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
              fromcity: widget.fromCity,
              tocity: widget.toCity,
              adult: widget.adult,
              child: widget.child,
              cabin_class: widget.cabinClass,
              type: 'Return',
              travellerCount: widget.travellerCount,
              date: widget.date1,
              fromcode: widget.fromCode,
              tocode: widget.toCode,
              returndate: widget.date2,
              infant: widget.infant,
              domorInter:'international'
            ),

            Stack(
              alignment: Alignment.topCenter,
              children: [
                _buildGradientContainer(screenWidth),
                (_buildFlightDetails(
                    context, screenHeight, screenWidth, retcombofilteredList)),

                // if (ret_image != null && dep_image != null)
                //   _buildOverlayCOntainer(screenHeight, screenWidth)
              ],
            ),
          ],
        ),
      ),
    );
  }

  filterFunction(
      String airline,
      double _selectedRoundPrice,
      String onwardNonstop,
      String returnNonstop,
      String selectedlabel,
      int selectedOnwardDepindex,
      int selectedreturnDepindex,
      int selectedOnwardRetindex,
      int selectedreturnRetindex) {
    List<Combo> filtersobj = widget.result.tripInfos.combo;
    // departure
    if (selectedOnwardDepindex != null) {
      filtersobj = DepartureFilter(
          index: selectedOnwardDepindex,
          filtersobj: filtersobj,
          type: 'onward');
    }
    if (selectedreturnDepindex != null) {
      filtersobj = DepartureFilter(
          index: selectedreturnDepindex,
          filtersobj: filtersobj,
          type: 'return');
    }
    // arrival
    if (selectedOnwardRetindex != null) {
      filtersobj = arrivalFilter(
          index: selectedOnwardRetindex,
          filtersobj: filtersobj,
          type: 'onward');
    }
    if (selectedreturnRetindex != null) {
      filtersobj = arrivalFilter(
          index: selectedreturnRetindex,
          filtersobj: filtersobj,
          type: 'return');
    }
    if (selectedlabel != null) {
      filtersobj = labelsort(label: selectedlabel, filtersobj: filtersobj);
    }
    if (airline != null) {
      filtersobj = airlineFilter(airline: airline, filtersobj: filtersobj);
    }
    if (_selectedRoundPrice != null) {
      filtersobj = priceFilter(
          selectedRoundPrice: _selectedRoundPrice, filtersobj: filtersobj);
    }
    if (onwardNonstop != null) {
      filtersobj = onwardNonstopFilter(
          onwardnonstop: onwardNonstop, filtersobj: filtersobj);
    }
    if (returnNonstop != null) {
      filtersobj = returnNonstopFilter(
          returnnonstop: returnNonstop, filtersobj: filtersobj);
    }

    setState(() {
      retcombofilteredList = filtersobj;
    });
  }

  List<Combo> arrivalFilter({int index, List<Combo> filtersobj, String type}) {
    int i = (type == 'onward') ? 0 : 1;
    int initialTime, endTime;

    // Define the time slots based on the index
    switch (index) {
      case 0:
        initialTime = 0;
        endTime = 6;
        break;
      case 1:
        initialTime = 6;
        endTime = 12;
        break;
      case 2:
        initialTime = 12;
        endTime = 18;
        break;
      case 3:
        initialTime = 18;
        endTime = 24;
        break;
      default:
        initialTime = 0;
        endTime = 24;
        break;
    }

    // Filter the flight segments based on the arrival time
    filtersobj = filtersobj.where((combo) {
      String arrivalTime = combo.segments[i].arrivalTime;
      if (arrivalTime != null && arrivalTime.isNotEmpty) {
        int hour = int.tryParse(arrivalTime.substring(11, 13)) ?? 0;
        return hour >= initialTime && hour < endTime;
      }
      return false;
    }).toList();

    return filtersobj;
  }

  List<Combo> DepartureFilter(
      {int index, List<Combo> filtersobj, String type}) {
    int i = (type == 'onward') ? 0 : 1;
    int initial_time, end_time;

    switch (index) {
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

    filtersobj = filtersobj.where((combo) {
      String departureTime = combo.segments[i].departureTime;
      if (departureTime != null && departureTime.isNotEmpty) {
        int hour = int.tryParse(departureTime.substring(11, 13)) ?? 0;
        return hour >= initial_time && hour < end_time;
      }
      return false;
    }).toList();

    return filtersobj;
  }

  List<Combo> labelsort({String label, List<Combo> filtersobj}) {
    switch (label) {
      case 'cheapest first':
        filtersobj.sort((a, b) {
          double aTotalPrice = double.parse(
              a.totalPriceList[0].fareDetails.fareComponents.totalFare);
          double bTotalPrice = double.parse(
              b.totalPriceList[0].fareDetails.fareComponents.totalFare);
          return aTotalPrice.compareTo(bTotalPrice);
        });
        break;

      case 'Non Stop first':
        filtersobj.sort((a, b) {
          int aStops = int.parse(a.segments[0].stops);
          int bStops = int.parse(b.segments[0].stops);
          return aStops.compareTo(bStops);
        });
        break;

      case 'Early Departure':
        filtersobj.sort((a, b) {
          DateTime aDeparture = DateTime.parse(a.segments[0].departureTime);
          DateTime bDeparture = DateTime.parse(b.segments[0].departureTime);
          return aDeparture.compareTo(bDeparture);
        });
        break;

      case 'Late Departure':
        filtersobj.sort((a, b) {
          DateTime aDeparture = DateTime.parse(a.segments[0].departureTime);
          DateTime bDeparture = DateTime.parse(b.segments[0].departureTime);
          return bDeparture.compareTo(aDeparture);
        });
        break;

      default:
        break;
    }

    return filtersobj;
  }

  List<Combo> returnNonstopFilter(
      {String returnnonstop, List<Combo> filtersobj}) {
    int ret;
    switch (returnnonstop) {
      case "0":
        ret = 0;
        break;
      case "1":
        ret = 1;
        break;
      case "2":
        ret = 2; // Represents more than 1
        break;
    }

    filtersobj = filtersobj.where((combo) {
      for (Segment si in combo.segments) {
        if (int.parse(si.stops) >= ret) {
          return true;
        }
      }
      return false;
    }).toList();

    return filtersobj;
  }

  List<Combo> onwardNonstopFilter(
      {String onwardnonstop, List<Combo> filtersobj}) {
    int onward;
    switch (onwardnonstop) {
      case "0":
        onward = 0;
        break;
      case "1":
        onward = 1;
        break;
      case "2":
        onward = 2; // Represents more than 1
        break;
    }

    filtersobj = filtersobj.where((combo) {
      for (Segment si in combo.segments) {
        if (int.parse(si.stops) >= onward) {
          return true;
        }
      }
      return false;
    }).toList();

    return filtersobj;
  }

  List<Combo> priceFilter({double selectedRoundPrice, List<Combo> filtersobj}) {
    filtersobj = filtersobj.where((combo) {
      for (var price in combo.totalPriceList) {
        if (double.parse(price.fareDetails.fareComponents.totalFare) <=
                selectedRoundPrice &&
            double.parse(price.fareDetails.fareComponents.totalFare) >=
                _minRoundTripPrice) {
          return true;
        }
      }
      return false;
    }).toList();

    return filtersobj;
  }

  List<Combo> airlineFilter({String airline, List<Combo> filtersobj}) {
    filtersobj = filtersobj.where((combo) {
      for (var si in combo.segments) {
        if (si.flightDetails.airlineInfo.name == airline) {
          return true;
        }
      }
      return false;
    }).toList();

    return filtersobj;
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

  Widget _buildFlightDetails(BuildContext context, double screenHeight,
      double screenWidth, List<Combo> combo) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAirlineFilters(screenHeight, screenWidth, combo),
          SizedBox(width: 30),
          _buildFlightsDetails(screenHeight, screenWidth, combo)
        ],
      ),
    );
  }

// Sample _buildFlightsDetails method
  Widget _buildFlightsDetails(
      double screenHeight, double screenWidth, List<Combo> combo) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          // Set the desired width for the container
          width: screenWidth * 0.57,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              // Build header widget
              _buildHeader(screenWidth, screenHeight),
              SizedBox(height: 30),
              // Use Column with List.generate to build the list of combo widgets
              Column(
                children: List.generate(combo.length, (comboIndex) {
                  return _buildComboWidget(
                    screenHeight,
                    screenWidth,
                    combo[comboIndex],
                    comboIndex,
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(double screenWidth, double screenheight) {
    return Container(
      width: screenWidth * 0.9,
      height: screenheight * 0.19,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Flights from ${widget.fromCity} → ${widget.toCity} , and back ",
            style: GoogleFonts.rajdhani(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          kheight10,
          Container(
            height: screenheight * 0.13,
            width: screenWidth * 0.9,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: _buildLabelContainer('cheapest first')),
                      SizedBox(width: 10),
                      // if (isShownonstop)
                      Center(child: _buildLabelContainer('Non Stop first')),
                      SizedBox(width: 10),
                      Center(child: _buildLabelContainer('Early Departure')),
                      SizedBox(width: 10),
                      Center(child: _buildLabelContainer('Late Departure')),
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
          )
        ],
      ),
    );
  }

  Widget _buildComboWidget(
      double screenHeight, double screenWidth, Combo _combo, int comboIndex) {
    return Column(
      children: [
        Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // height: screenHeight * 0.35,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_combo.segments.length == 2)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                'images/AirlinesLogo/${_combo.segments[0].flightDetails.airlineInfo.code}.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            kwidth3,
                            Text(
                              "${_combo.segments[0].flightDetails.airlineInfo.name}  ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Column(
                              children: [
                                // Text(
                                //   "${combo.totalPriceList.length}  ",
                                //   style: TextStyle(
                                //     fontSize: 15,
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                                _combo.totalPriceList.length == 1
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          kheight5,
                                          Text(
                                            "₹ ${_combo.totalPriceList[0].fareDetails.fareComponents.totalFare}  ",
                                            style: GoogleFonts.rajdhani(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "per adult",
                                            style: GoogleFonts.rajdhani(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          kheight5,
                                          Text(
                                            "₹ ${double.parse(_combo.totalPriceList[0].fareDetails.fareComponents.totalFare) + double.parse(_combo.totalPriceList[1].fareDetails.fareComponents.totalFare)}  ",
                                            style: GoogleFonts.rajdhani(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "per adult",
                                            style: GoogleFonts.rajdhani(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )

                                // Text(
                                //   "${combo.totalPriceList[1].fareDetails.fareComponents.totalFare}  ",
                                //   style: TextStyle(
                                //     fontSize: 15,
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
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
                                      widget.cabinClass);
                                  List<String> fromcitylist = [
                                    widget.fromCity,
                                    widget.toCity,
                                  ];
                                  List<String> tocitylist = [
                                    widget.toCity,
                                    widget.fromCity
                                  ];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CommonflightBookingPage(
                                                flightmodel: selectedFlights,
                                                fromcity: fromcitylist,
                                                tocity: tocitylist,
                                                travellerCount: 1,
                                              )));
                                },
                                child: Container(
                                  height: screenHeight * 0.035,
                                  width: screenWidth * 0.075,
                                  decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.2),
                                      border: Border.all(
                                          width: 0.4, color: Colors.blue),
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
                      ),

                    // Text(
                    //   "Total price: \$${combo.totalPriceList.reduce((a, b) => a + b).toStringAsFixed(2)}",
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    Container(
                      height: screenHeight *
                          0.18, // Fixed height for horizontal ListView
                      child: ListView.builder(
                        scrollDirection: Axis
                            .horizontal, // Set scroll direction to horizontal
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _combo.segments.length,
                        itemBuilder: (context, siIndex) {
                          var flight = _combo.segments[siIndex];
                          // var price =
                          //     combo.totalPriceList.length;

                          return Container(
                            width:
                                screenWidth * 0.25, // Fixed width for each item
                            decoration: BoxDecoration(
                              // color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10), // Space between items
                            // child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          siIndex == 0 ? "Departure" : "Return",
                                          style: GoogleFonts.rajdhani(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17)),
                                      kwidth5,
                                      Text(
                                          siIndex == 0
                                              ? "${formatDate(flight.arrivalTime)}"
                                              : "${formatDate(flight.departureTime)}",
                                          style: GoogleFonts.rajdhani(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15)),
                                      kwidth5,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 10,
                                            // color: Colors.grey,
                                          ),
                                          kheight5,
                                        ],
                                      ),
                                      kwidth5,
                                      Text(
                                          siIndex == 0
                                              ? "${flight.flightDetails.airlineInfo.name}"
                                              : "${flight.flightDetails.airlineInfo.name}",
                                          style: GoogleFonts.rajdhani(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15)),
                                    ],
                                  ),
                                ),
                                Container(
                                  // height: screenHeight * 0.2,
                                  width: screenWidth * 0.3,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${extractTime(flight.departureTime)}",
                                                style: GoogleFonts.rajdhani(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            kheight3,
                                            Text(
                                                "${flight.departureAirport.city}",
                                                style: GoogleFonts.rajdhani(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15)),
                                            kheight3,
                                            // Text(" price${price}",
                                            //     style: GoogleFonts.rajdhani(
                                            //         fontWeight: FontWeight.w600,
                                            //         fontSize: 12)),
                                          ],
                                        ),

                                        SizedBox(
                                          width: 200,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${convertMinutesToHoursAndMinutes(int.parse(flight.duration))}",
                                                    style: GoogleFonts.rajdhani(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14)),
                                                (flight.stops) == "0"
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5.0,
                                                                top: 2,
                                                                bottom: 2),
                                                        child: Container(
                                                          height: 2.0,
                                                          width: 50,
                                                          color: Colors.green,
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          height: 2.0,
                                                          width: 5,
                                                          color: Colors.orange,
                                                        ),
                                                      ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6.5),
                                                  child: Text(
                                                      flight.stops == "0"
                                                          ? "Nonstop"
                                                          : "1 Stop",
                                                      style:
                                                          GoogleFonts.rajdhani(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 13)),
                                                ),
                                                (flight.stops) != "0"
                                                    ? Text("${flight.so}",
                                                        style: GoogleFonts
                                                            .rajdhani(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 13))
                                                    : kheight2,
                                              ],
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        //  arrival
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${extractTime(flight.arrivalTime)}",
                                                style: GoogleFonts.rajdhani(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            kheight3,
                                            Text(
                                                "${flight.arrivalAirport.city}",
                                                style: GoogleFonts.rajdhani(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15)),
                                            kheight3,
                                            // Text("${flight.arrivalAirport.countryCode}",
                                            //     style: GoogleFonts.rajdhani(
                                            //         fontWeight: FontWeight.w600,
                                            //         fontSize: 12)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 0, bottom: 5, right: 25),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {},
                    //         child: Container(
                    //           child: Text("View Flight Details",
                    //               style: GoogleFonts.rajdhani(
                    //                   color: Colors.blue,
                    //                   fontWeight: FontWeight.w600,
                    //                   fontSize: 13)),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
        // FlightDetailsScreen(combo: _combo,),
        // (screenHeight, screenWidth)
      ],
    );
  }

  Widget _buildAirlineFilters(
      double sheight, double swidth, List<Combo> combo) {
    return Column(
      children: [
        kheight30,
        kheight30,
        kheight20,
        kheight10,
        _buildAirlineCard(sheight, swidth),
        _buildOnwardJourneyCard(sheight, swidth),
      ],
    );
  }

  Widget _buildAirlineCard(double sheight, double swidth) {
    return Card(
      elevation: 5.0,
      child: Container(
        height: sheight * 0.45,
        width: swidth * 0.2,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            airlineContainer(sheight, swidth, flightList, handleTap),
            // airlineContainer(sheight, swidth, flightList),
            roundtripPriceslider(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnwardJourneyCard(double sheight, double swidth) {
    return Card(
      elevation: 5.0,
      child: Container(
        height: sheight * 1.1,
        width: swidth * 0.2,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJourneyHeader('Onward Journey'),
            _buildGradientDivider(), kheight10,
            _buildJourneyHeader('Stops From ${widget.fromCity}'),
            nonstopContainer("Onward"),
            // _buildJourneyHeader('Onward Journey Duration'),
            _buildDepartureFromHeader(widget.fromCity),
            kheight10,
            SizedBox(
                width: swidth * 0.18,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: _buildDepartureTimeFilters(sheight, swidth, 'onward'),
                )),
            kheight10,
            _buildArrivalHeader(widget.toCity),
            kheight10,
            SizedBox(
              width: swidth * 0.18,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: _buildArrivalTimeFilters(sheight, swidth, 'onward'),
              ),
            ),
            kheight10,
            _buildJourneyHeader('Return Journey'),
            _buildGradientDivider(), kheight10,
            _buildJourneyHeader('Stops From ${widget.toCity}'),
            nonstopContainer("Return"),
            // _buildJourneyHeader('Onward Journey Duration'),
            _buildDepartureFromHeader(widget.toCity),
            kheight10,
            SizedBox(
              width: swidth * 0.18,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: _buildDepartureTimeFilters(sheight, swidth, 'return'),
              ),
            ),
            kheight10,
            _buildArrivalHeader(widget.fromCity),
            kheight10,
            SizedBox(
              width: swidth * 0.18,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: _buildArrivalTimeFilters(sheight, swidth, 'return'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJourneyHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, top: 5, left: 10),
      child: Text(
        title,
        style: GoogleFonts.rajdhani(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildGradientDivider() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, top: 5, left: 10),
      child: Container(
        height: 5,
        width: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.blue.shade300, Colors.blue.shade900],
          ),
        ),
      ),
    );
  }

  Widget _buildDepartureFromHeader(plc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, top: 5, left: 10),
      child: Text(
        'Departure From $plc',
        style: GoogleFonts.rajdhani(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildDepartureTimeFilters(
      double sheight, double swidth, String type) {
    // Determine the selected index based on the type
    int typeselect =
        (type == 'onward') ? selectedOnwardDepindex : selectedReturnDepindex;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 2 / 1.8,
      ),
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        List<IconData> iconList = [
          Icons.wb_sunny_outlined,
          Icons.wb_sunny,
          Icons.wb_sunny,
          Icons.nights_stay,
        ];
        List<String> title = [
          'Before 6AM',
          '6AM - 12PM',
          '12PM - 6PM',
          'After 6PM',
        ];

        bool isSelected = typeselect == index;

        return GestureDetector(
          onDoubleTap: () {
            setState(() {
              if (type == 'onward') {
                selectedOnwardDepindex = null;
              } else {
                selectedReturnDepindex = null;
              }
              filterFunction(
                selectedAirline,
                _selectedRoundPrice,
                onwardNonstop,
                returnNonstop,
                selectedLabel,
                selectedOnwardDepindex,
                selectedReturnDepindex,
                selectedOnwardRetindex,
                selectedReturnRetindex,
              );
            });
          },
          onTap: () {
            setState(() {
              if (type == 'onward') {
                selectedOnwardDepindex = index;
              } else {
                selectedReturnDepindex = index;
              }
              filterFunction(
                selectedAirline,
                _selectedRoundPrice,
                onwardNonstop,
                returnNonstop,
                selectedLabel,
                selectedOnwardDepindex,
                selectedReturnDepindex,
                selectedOnwardRetindex,
                selectedReturnRetindex,
              );
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.shade500 : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 0.4,
                color: isSelected ? Colors.blue.shade900 : Colors.grey,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  color: isSelected ? Colors.white : Colors.grey,
                  size: 17,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  title[index],
                  style: TextStyle(
                    fontSize: 9,
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildArrivalHeader(String plc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, top: 5, left: 10),
      child: Text(
        'Arrival at $plc',
        style: GoogleFonts.rajdhani(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildArrivalTimeFilters(double sheight, double swidth, String type) {
    // Determine the selected index based on the type
    int typeselect =
        (type == 'onward') ? selectedOnwardRetindex : selectedReturnRetindex;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 2 / 1.8,
      ),
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        List<IconData> iconList = [
          Icons.wb_sunny_outlined,
          Icons.wb_sunny,
          Icons.wb_sunny,
          Icons.nights_stay,
        ];
        List<String> title = [
          'Before 6AM',
          '6AM - 12PM',
          '12PM - 6PM',
          'After 6PM',
        ];

        bool isSelected = typeselect == index;

        return GestureDetector(
          onDoubleTap: () {
            setState(() {
              if (type == 'onward') {
                selectedOnwardRetindex = null;
              } else {
                selectedReturnRetindex = null;
              }
              filterFunction(
                selectedAirline,
                _selectedRoundPrice,
                onwardNonstop,
                returnNonstop,
                selectedLabel,
                selectedOnwardDepindex,
                selectedReturnDepindex,
                selectedOnwardRetindex,
                selectedReturnRetindex,
              );
            });
          },
          onTap: () {
            setState(() {
              if (type == 'onward') {
                selectedOnwardRetindex = index;
              } else {
                selectedReturnRetindex = index;
              }
              filterFunction(
                selectedAirline,
                _selectedRoundPrice,
                onwardNonstop,
                returnNonstop,
                selectedLabel,
                selectedOnwardDepindex,
                selectedReturnDepindex,
                selectedOnwardRetindex,
                selectedReturnRetindex,
              );
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.shade500 : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 0.4,
                color: isSelected ? Colors.blue.shade900 : Colors.grey,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  color: isSelected ? Colors.white : Colors.grey,
                  size: 17,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  title[index],
                  style: TextStyle(
                    fontSize: 9,
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget _buildTimeFilterIcon(IconData icon, String label, sheight, swidth) {
  //   return Padding(
  //     padding: const EdgeInsets.all(2.0),
  //     child: Container(
  //       height: sheight * 0.08,
  //       width: swidth * 0.04,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border.all(
  //           width: 0.5,
  //           color: Colors.grey,
  //         ),
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(
  //             icon,
  //             color: Colors.grey,
  //             size: 18,
  //           ),
  //           SizedBox(height: 3),
  //           Text(
  //             label,
  //             style: GoogleFonts.rajdhani(
  //               fontSize: 10,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  nonstopContainer(String type) {
    if (type == "Onward") {
      List<String> list = ['Non Stop', '1 Stop', '1+ Stops'];
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, onwardindex) {
                bool isonwardSelected =
                    (onwardNonstop == onwardindex.toString());
                return GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      onwardNonstop = null;
                      filterFunction(
                          selectedAirline,
                          _selectedRoundPrice,
                          onwardNonstop,
                          returnNonstop,
                          selectedLabel,
                          selectedOnwardDepindex,
                          selectedReturnDepindex,
                          selectedOnwardRetindex,
                          selectedReturnRetindex);
                    });
                  },
                  onTap: () {
                    setState(() {
                      onwardNonstop = onwardindex
                          .toString(); // Set onwardNonstop to the index as a string
                      filterFunction(
                          selectedAirline,
                          _selectedRoundPrice,
                          onwardNonstop,
                          returnNonstop,
                          selectedLabel,
                          selectedOnwardDepindex,
                          selectedReturnDepindex,
                          selectedOnwardRetindex,
                          selectedReturnRetindex);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
          ],
        ),
      );
    } else {
      List<String> list = ['Non Stop', '1 Stop', '1+ Stops'];
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, returnindex) {
                bool isonwardSelected =
                    (onwardNonstop == returnindex.toString());
                return GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      onwardNonstop = null;
                      filterFunction(
                          selectedAirline,
                          _selectedRoundPrice,
                          onwardNonstop,
                          returnNonstop,
                          selectedLabel,
                          selectedOnwardDepindex,
                          selectedReturnDepindex,
                          selectedOnwardRetindex,
                          selectedReturnRetindex);
                    });
                  },
                  onTap: () {
                    setState(() {
                      onwardNonstop = returnindex
                          .toString(); // Set onwardNonstop to the index as a string
                      filterFunction(
                          selectedAirline,
                          _selectedRoundPrice,
                          onwardNonstop,
                          returnNonstop,
                          selectedLabel,
                          selectedOnwardDepindex,
                          selectedReturnDepindex,
                          selectedOnwardRetindex,
                          selectedReturnRetindex);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
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
          ],
        ),
      );
    }
  }

  roundtripPriceslider() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 5, left: 10),
            child: Text(
              'Round-trip Price',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          PriceSlider(
            minPrice: _minRoundTripPrice - 1000,
            maxPrice: _maxRoundTripPrice + 1000,
            initialValue: _selectedRoundPrice,
            onChanged: (value) {
              setState(() {
                _selectedRoundPrice = value;
                filterFunction(
                    selectedAirline,
                    _selectedRoundPrice,
                    onwardNonstop,
                    returnNonstop,
                    selectedLabel,
                    selectedOnwardDepindex,
                    selectedReturnDepindex,
                    selectedOnwardRetindex,
                    selectedReturnRetindex);
                // _buildFlightList(selectedLabel);
              });
            },
          ),
          SizedBox(height: 20),
          Text(
            'Selected Price: \$${_selectedRoundPrice.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700),
          ),
          // SizedBox(height: 20),
          // Text(
          //   "Stops from ${widget.fromCity}",
          //   style: TextStyle(
          //       fontSize: 15,
          //       color: Colors.black,
          //       fontWeight: FontWeight.w700),
          // ),
        ],
      ),
    );
  }

  Widget airlineContainer(double sheight, double swidth,
      List<FlightDetails> flightList, Function(int) onTapCallback) {
    // int selectedIndex;

    return Container(
      color: Colors.white,
      width: swidth * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 15, left: 10),
            child: Text(
              'Airlines',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(flightList.length, (index) {
              FlightDetails flight = flightList[index];
              bool isSelected = (selectedIndex == index) ? true : false;

              return GestureDetector(
                onDoubleTap: () {
                  onTapCallback(null);
                  setState(() {
                    selectedAirline = null;
                  });
                  filterFunction(
                      selectedAirline,
                      _selectedRoundPrice,
                      onwardNonstop,
                      returnNonstop,
                      selectedLabel,
                      selectedOnwardDepindex,
                      selectedReturnDepindex,
                      selectedOnwardRetindex,
                      selectedReturnRetindex);
                },
                onTap: () {
                  onTapCallback(index);
                  // / printWhite("ret int: selected:$selectedIndex index: $index");
                  printWhite(
                      "selected airlines: ${flightList[selectedIndex].airlineInfo.name}");
                  setState(() {
                    selectedAirline =
                        flightList[selectedIndex].airlineInfo.name;
                  });
                  filterFunction(
                      selectedAirline,
                      _selectedRoundPrice,
                      onwardNonstop,
                      returnNonstop,
                      selectedLabel,
                      selectedOnwardDepindex,
                      selectedReturnDepindex,
                      selectedOnwardRetindex,
                      selectedReturnRetindex);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // color: isSelected ? Colors.blue.withOpacity(0.2) : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            child: Image.asset(
                              'images/AirlinesLogo/${flight.airlineInfo.code}.png',
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            flight.airlineInfo.name,
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
                                      size: 15,
                                      color: Colors.white,
                                    )
                                  : null),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
//   Widget airlineContainer(
//       double sheight, double swidth, List<FlightDetails> flightList) {
//     return Container(
//       color: Colors.white,
//       // height: sheight * 0.72,
//       width: swidth * 0.2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 5, top: 15, left: 10),
//             child: Text(
//               'Airlines',
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),

//           Expanded(
//   child: ListView(
//     children: List.generate(flightList.length, (index) {
//       FlightDetails flight = flightList[index];
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           child: Row(
//             children: [
//               SizedBox(
//                 height: 25,
//                 width: 25,
//                 child: Image.asset('images/AirlinesLogo/${flight.airlineInfo.code}.png'),
//               ),
//               SizedBox(width: 5),
//               Text(
//                 flight.airlineInfo.name,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Spacer(),
//               Container(
//                 height: 20,
//                 width: 20,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(3.5),
//                   border: Border.all(width: 0.5, color: Colors.grey),
//                 ),
//                 child: Icon(
//                   Icons.done,
//                   size: 15,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(width: 30),
//             ],
//           ),
//         ),
//       );
//     }),
//   ),
// ),

//         ],
//       ),
//     );
//   }
// }
