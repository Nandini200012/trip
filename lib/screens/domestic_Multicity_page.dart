import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import '../api_services/location_list_api.dart';
import '../models/flight_model.dart';
import 'Drawer.dart';
import 'constant.dart';
import 'flight_model/multicity_route_model.dart';
import 'flight_searchlist/widgets/priceslider.dart';
import 'flightss_/widgets/search_container.dart';
import 'header.dart';
import 'multicity_widgets/list_widgets.dart';

class DomesticMultiwaylistpage extends StatefulWidget {
  List<List<Flight>> flights;

  List<LocationData> locationList1;
  String cabin_class;
  String adult;
  String child;
  String infant;
  DomesticMultiwaylistpage(
      {Key key,
      this.flights,
      this.locationList1,
      this.adult,
      this.cabin_class,
      this.child,
      this.infant});

  @override
  _DomesticMultiwaylistpageState createState() =>
      _DomesticMultiwaylistpageState();
}

class _DomesticMultiwaylistpageState extends State<DomesticMultiwaylistpage>
    with SingleTickerProviderStateMixin {
  Set<String> selectedAirlines = {};
  double _selectedPrice;
  List<List<Flight>> filteredFlights = [];
  // int _selectedIndex = 0;
  Map<String, String> filteredAirlineMap = {};

  // Set<String> filteredAirlines = {};
  Set<String> filteredAirlineCodes = {};
  Set<String> departurePlaces = {};
  Set<String> arrivalPlaces = {};
  String selectedDeparturePlace;
  String selectedArrivalPlace;
  double minPrice = double.infinity;
  double maxPrice = 0;
  TabController _tabController;
  String selectedTimeSlot;
  int activeDepartureSlotIndex = -1;
  int activeArrivalSlotIndex = -1;
  List<int> activeDepartureSlotIndices = [];
  List<int> activeArrivalSlotIndices = [];
  Map<int, String> activeDepartureSlots = {};
  Map<int, String> activeArrivalSlots = {};
  // Define state variables

  int _selectedIndex = 0;

  List<List<int>> selectedFlightIndices = [];
Flight picked_route1,
    picked_route2,
    picked_route3,
    picked_route4,
    picked_route5;
// Initially selected tab index
// List<int> selectedFlightIndices = List.filled(filteredFlights.length, -1);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.flights.length, vsync: this);
    findMinMaxPrices(widget.flights);
    getUniqueAirlineMap(widget.flights);
    getUniquePlaces(widget.flights);
    _selectedPrice = maxPrice;
    // _tabController = TabController(length: widget.flights.length, vsync: this);
    selectedFlightIndices = List.generate(widget.flights.length, (index) => []);
    ;

    applyFilters();
     // Initialize selectedFlightIndices with empty lists
    selectedFlightIndices = List.generate(5, (_) => []);

    // Set picked routes initially to null
    picked_route1 = null;
    picked_route2 = null;
    picked_route3 = null;
    picked_route4 = null;
    picked_route5 = null;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void findMinMaxPrices(List<List<Flight>> flights) {
    if (flights.isEmpty) return;

    for (List<Flight> route in flights) {
      for (Flight flight in route) {
        double price = double.parse(flight.price);
        if (price < minPrice) {
          minPrice = price;
        }
        if (price > maxPrice) {
          maxPrice = price;
        }
      }
    }

    setState(() {
      _selectedPrice = maxPrice;
    });

    print('Minimum price: $minPrice');
    print('Maximum price: $maxPrice');
  }

  void getUniqueAirlineMap(List<List<Flight>> flights) {
    Map<String, String> airlineMap = {};

    for (List<Flight> routeList in flights) {
      for (Flight route in routeList) {
        airlineMap[route.airlineCode] = route.airlineName;
      }
    }

    setState(() {
      filteredAirlineMap = airlineMap;
    });
  }

  void getUniquePlaces(List<List<Flight>> flights) {
    Set<String> depPlaces = {};
    Set<String> arrPlaces = {};
    for (List<Flight> routeList in flights) {
      for (Flight route in routeList) {
        depPlaces.add(route.departureCity);
        arrPlaces.add(route.arrivalCity);
      }
    }
    setState(() {
      departurePlaces = depPlaces;
      arrivalPlaces = arrPlaces;
    });
  }

  void sortFlightsByTimeSlot() {
    if (selectedTimeSlot == null) return;

    for (List<Flight> route in filteredFlights) {
      route.sort((a, b) {
        DateTime aTime = DateTime.parse(a.departureTime);
        DateTime bTime = DateTime.parse(b.departureTime);

        if (selectedTimeSlot == "6am - 11am") {
          return aTime.hour.compareTo(bTime.hour);
        } else if (selectedTimeSlot == "11am - 6pm") {
          return aTime.hour.compareTo(bTime.hour);
        } else if (selectedTimeSlot == "6pm - 12am") {
          return aTime.hour.compareTo(bTime.hour);
        } else if (selectedTimeSlot == "12am - 6am") {
          return aTime.hour.compareTo(bTime.hour);
        }
        return 0;
      });
    }
  }

  // List<Widget> _tabScroll() {
  //   return List.generate(widget.flights.length, (index) {
  //     routes _route = multiRoutes[index];
  //     return Tab(
  //       iconMargin: EdgeInsets.all(0),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(width: 0.5, color: Colors.white),
  //           color: _selectedIndex == index ? Colors.blue : Colors.white,
  //         ),
  //         alignment: Alignment.center,
  //         child: Column(
  //           children: [
  //             SizedBox(
  //               width: 350,
  //               child: Center(
  //                 child: Text(
  //                   "${_route.fromcity} → ${_route.tocity}",
  //                   style: GoogleFonts.rajdhani(
  //                     color:
  //                         _selectedIndex == index ? Colors.white : Colors.black,
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Text(
  //               "${formatDate(_route.date)}",
  //               style: GoogleFonts.rajdhani(
  //                 color: _selectedIndex == index ? Colors.white : Colors.black,
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  // }

List<Widget> _tabScroll() {
  return List.generate(widget.flights.length, (index) {
    routes _route = multiRoutes[index];
    return Tab(
      iconMargin: EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.5, color: Colors.white),
          color: _selectedIndex == index ? Colors.blue : Colors.white,
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              width: 350,
              child: Center(
                child: Text(
                  "${_route.fromcity} → ${_route.tocity}",
                  style: GoogleFonts.rajdhani(
                    color: _selectedIndex == index ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Text(
              "${formatDate(_route.date)}",
              style: GoogleFonts.rajdhani(
                color: _selectedIndex == index ? Colors.white : Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  });
}

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('MMMM d, EEEE').format(parsedDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width;
    var sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 232, 251),
      appBar: sWidth < 600
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 40),
              backgroundColor: Colors.white,
              title: Text(
                'Tour',
                style: blackB15,
              ),
            )
          : CustomAppBar(),
      drawer: sWidth < 700 ? drawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchContainer(
              sWidth: sWidth,
              sHeight: sHeight,
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
               domorInter:'domestic'
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                _buildGradientContainer(sWidth),
                _buildFlightDetails(sWidth, sHeight),
              ],
            ),
          ],
        ),
      ),
            bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildBookingContainer(
              sWidth,
              sHeight,
              picked_route1,
              picked_route2,
              picked_route3,
              picked_route4,
              picked_route5,
              widget.adult,
              widget.child,
              widget.infant,
              widget.cabin_class,
              int.parse(widget.adult)+int.parse(widget.child)+int.parse(widget.infant),
              context),
        ],
      ),
    );
  }

  Widget _buildGradientContainer(double width) {
    return Container(
      height: 200,
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

  Widget _buildFlightDetails(double sWidth, double sHeight) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: sWidth * 0.1),
              // Replace _buildFilters with your implementation
              _buildFilters(sWidth, sHeight),
              SizedBox(width: sWidth * 0.024),
              Expanded(
                child: Container(
                  width: sWidth * 0.62,
                  height: sHeight * 0.98, // Adjust height as needed
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        indicatorColor: Colors.transparent,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: _tabScroll(),
                        onTap: (index) {
                          setState(() {
                            _selectedIndex = index;
                            applyFilters();
                          });
                        },
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children:
                              List.generate(widget.flights.length, (index) {
                            return _buildListView(
                                widget.flights[index], sWidth, sHeight, index);
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: sWidth * 0.04),
            ],
          ),
        ],
      ),
    );
  }

Widget _buildListView(
    List<Flight> flights, double sWidth, double sHeight, int tabIndex) {
  // Filter flights based on selected filters
  List<Flight> filteredFlights = flights.where((flight) {
    // Filter by selected airlines
    if (selectedAirlines.isNotEmpty &&
        !selectedAirlines.contains(flight.airlineName)) {
      return false;
    }

    // Filter by price range
    if (double.parse(flight.price) < minPrice || double.parse(flight.price) > maxPrice) {
      return false;
    }

    // Additional filters can be added here (departure and arrival times)

    return true;
  }).toList();

  return ListView.builder(
    itemCount: filteredFlights.length,
    itemBuilder: (context, index) {
      Flight flight = filteredFlights[index];
      String departure = flight.departureTime.toString();
      String arrival = flight.arrivalTime.toString();
      String dTime = departure.substring(departure.length - 5);
      String aTime = arrival.substring(arrival.length - 5);
      String dDate = departure.substring(0, 10);
      String aDate = arrival.substring(0, 10);
      String duration = minutetohour(flight.duration);
      bool isSelected =
          selectedFlightIndices[tabIndex].contains(index); // Check if flight is selected

      return GestureDetector(
        onTap: () {
          setState(() {
            // Toggle selection for this tab's flight
            if (selectedFlightIndices[tabIndex].contains(index)) {
              selectedFlightIndices[tabIndex].remove(index);
            } else {
              selectedFlightIndices[tabIndex].clear();
              selectedFlightIndices[tabIndex].add(index);
            }

            // Update picked routes based on tab index
            switch (tabIndex) {
              case 0:
                picked_route1 = selectedFlightIndices[tabIndex].isEmpty
                    ? null
                    : flights[selectedFlightIndices[tabIndex][0]];
                break;
              case 1:
                picked_route2 = selectedFlightIndices[tabIndex].isEmpty
                    ? null
                    : flights[selectedFlightIndices[tabIndex][0]];
                break;
              case 2:
                picked_route3 = selectedFlightIndices[tabIndex].isEmpty
                    ? null
                    : flights[selectedFlightIndices[tabIndex][0]];
                break;
              case 3:
                picked_route4 = selectedFlightIndices[tabIndex].isEmpty
                    ? null
                    : flights[selectedFlightIndices[tabIndex][0]];
                break;
              case 4:
                picked_route5 = selectedFlightIndices[tabIndex].isEmpty
                    ? null
                    : flights[selectedFlightIndices[tabIndex][0]];
                break;
              default:
                break;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: sWidth * 0.62,
            height: sHeight * 0.16,
            // color: isSelected ? Colors.blue[100] : Colors.white, // Adjust selected color
            child: Card(
              elevation: 5.0,
              color: isSelected ? Colors.blue[100] : Colors.white,
              margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: Image.asset(
                            'images/AirlinesLogo/${flight.airlineCode}.png',
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              return Image.network(
                                'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png',
                                fit: BoxFit.contain,
                              );
                            },
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${flight.airlineName}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    _buildFlightInfo(
                        '${flight.departureCity}', dTime, dDate),
                    _durationInfo(duration, flight.stops),
                    _buildFlightInfo('${flight.arrivalCity}', aTime, aDate),
                    _buildPriceInfo("₹${flight.price}"),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

  // Widget _buildListView(
  //     List<Flight> flights, double sWidth, double sHeight, int tabIndex) {
  //   return ListView.builder(
  //     itemCount: flights.length,
  //     itemBuilder: (context, index) {
  //       Flight flight = flights[index];
  //       String departure = flight.departureTime.toString();
  //       String arrival = flight.arrivalTime.toString();
  //       String dTime = departure.substring(departure.length - 5);
  //       String aTime = arrival.substring(arrival.length - 5);
  //       String dDate = departure.substring(0, 10);
  //       String aDate = arrival.substring(0, 10);
  //       String duration = minutetohour(flight.duration);
  //       bool isSelected = selectedFlightIndices[tabIndex]
  //           .contains(index); // Check if flight is selected

  //       return GestureDetector(
  //       onTap: () {
  //           setState(() {
  //             // Toggle selection for this tab's flight
  //             if (selectedFlightIndices[tabIndex].contains(index)) {
  //               selectedFlightIndices[tabIndex].remove(index);
  //             } else {
  //               selectedFlightIndices[tabIndex].clear();
  //               selectedFlightIndices[tabIndex].add(index);
  //             }

  //             // Print selected indices for debugging
  //             print('Selected indices for tab $tabIndex: ${selectedFlightIndices[tabIndex]}');

  //             // Update picked routes based on tab index
  //             switch (tabIndex) {
  //               case 0:
  //                 picked_route1 = selectedFlightIndices[tabIndex].isEmpty
  //                     ? null
  //                     : flights[selectedFlightIndices[tabIndex][0]];
  //                 break;
  //               case 1:
  //                 picked_route2 = selectedFlightIndices[tabIndex].isEmpty
  //                     ? null
  //                     : flights[selectedFlightIndices[tabIndex][0]];
  //                 break;
  //               case 2:
  //                 picked_route3 = selectedFlightIndices[tabIndex].isEmpty
  //                     ? null
  //                     : flights[selectedFlightIndices[tabIndex][0]];
  //                 break;
  //               case 3:
  //                 picked_route4 = selectedFlightIndices[tabIndex].isEmpty
  //                     ? null
  //                     : flights[selectedFlightIndices[tabIndex][0]];
  //                 break;
  //               case 4:
  //                 picked_route5 = selectedFlightIndices[tabIndex].isEmpty
  //                     ? null
  //                     : flights[selectedFlightIndices[tabIndex][0]];
  //                 break;
  //               default:
  //                 break;
  //             }

  //             // Print picked routes for debugging
  //             print('Picked Route 1: ${picked_route1?.airlineName}');
  //             print('Picked Route 2: ${picked_route2?.airlineName}');
  //             print('Picked Route 3: ${picked_route3?.airlineName}');
  //             print('Picked Route 4: ${picked_route4?.airlineName}');
  //             print('Picked Route 5: ${picked_route5?.airlineName}');
  //           });
  //         },

  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             width: sWidth * 0.62,
  //             height: sHeight * 0.16,
  //             // color: isSelected
  //             //     ? Colors.blue[100]
  //             //     : Colors.white, // Adjust selected color
  //             child: Card(
  //               elevation: 5.0,
  //               color: isSelected ? Colors.blue[100] : Colors.white,
  //               margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Container(
  //                           height: 35,
  //                           width: 35,
  //                           child: Image.asset(
  //                             'images/AirlinesLogo/${flight.airlineCode}.png',
  //                             errorBuilder: (BuildContext context,
  //                                 Object exception, StackTrace stackTrace) {
  //                               return Image.network(
  //                                 'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png',
  //                                 fit: BoxFit.contain,
  //                               );
  //                             },
  //                             fit: BoxFit.contain,
  //                           ),
  //                         ),
  //                         SizedBox(width: 8),
  //                         Text(
  //                           '${flight.airlineName}',
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     _buildFlightInfo('${flight.departureCity}', dTime, dDate),
  //                     _durationInfo(duration, flight.stops),
  //                     _buildFlightInfo('${flight.arrivalCity}', aTime, aDate),
  //                     _buildPriceInfo("₹${flight.price}"),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

// Helper methods like _buildFlightInfo, _durationInfo, _buildPriceInfo, minutetohour go here

Widget _buildFilters(double sWidth, double sHeight) {
  return Column(
    children: [
      SizedBox(
        height: sHeight * 0.07,
      ),
      Container(
        width: sWidth * 0.2,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filters',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 10),

                  // Airlines filter
                  Text(
                    'Airlines',
                    style: GoogleFonts.rajdhani(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Column(
                    children: filteredAirlineMap.keys.map((String airlineCode) {
                      final airlineName = filteredAirlineMap[airlineCode];
                      final isChecked = selectedAirlines.contains(airlineName);

                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (isChecked) {
                              selectedAirlines.remove(airlineName);
                            } else {
                              selectedAirlines.add(airlineName);
                            }
                            applyFilters();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                child: Image.asset(
                                  'images/AirlinesLogo/$airlineCode.png',
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace stackTrace) {
                                    return Image.asset(
                                      'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png',
                                      fit: BoxFit.contain,
                                    );
                                  },
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                airlineName,
                                style: GoogleFonts.rajdhani(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Checkbox(
                                value: isChecked,
                                onChanged: (bool value) {
                                  setState(() {
                                    if (value != null && value) {
                                      selectedAirlines.add(airlineName);
                                    } else {
                                      selectedAirlines.remove(airlineName);
                                    }
                                    applyFilters();
                                  });
                                },
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),

                  // Price filter
                  Text(
                    "Price",
                    style: GoogleFonts.rajdhani(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  kheight10,
                  PriceSlider(
                    minPrice: minPrice,
                    maxPrice: maxPrice,
                    initialValue: _selectedPrice,
                    onChanged: (value) {
                      setState(() {
                        _selectedPrice = value;
                        applyFilters();
                      });
                    },
                  ),
                  kheight5, kheight5,
                  Text(
                    "selected price: ₹${_selectedPrice}",
                    style: GoogleFonts.rajdhani(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Departure time filters for each route
                  for (int i = 0; i < widget.flights.length; i++) ...[
                    Text(
                      ' Departure from ${widget.flights[i][0].departureCity}',
                      style: GoogleFonts.rajdhani(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTimeSlotButton(
                            '6am - 11am',
                            () => filterByDepartureTimeForRoute(i, '6am - 11am'),
                            i,
                            true,
                          ),
                          _buildTimeSlotButton(
                            '11am - 6pm',
                            () => filterByDepartureTimeForRoute(i, '11am - 6pm'),
                            i,
                            true,
                          ),
                          _buildTimeSlotButton(
                            '6pm - 12am',
                            () => filterByDepartureTimeForRoute(i, '6pm - 12am'),
                            i,
                            true,
                          ),
                          _buildTimeSlotButton(
                            '12am - 6am',
                            () => filterByDepartureTimeForRoute(i, '12am - 6am'),
                            i,
                            true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    // Arrival time filters for each route
                    Text(
                      'Arrival at ${widget.flights[i][0].arrivalCity}',
                      style: GoogleFonts.rajdhani(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTimeSlotButton(
                            '6am - 11am',
                            () => filterByArrivalTimeForRoute(i, '6am - 11am'),
                            i,
                            false,
                          ),
                          _buildTimeSlotButton(
                            '11am - 6pm',
                            () => filterByArrivalTimeForRoute(i, '11am - 6pm'),
                            i,
                            false,
                          ),
                          _buildTimeSlotButton(
                            '6pm - 12am',
                            () => filterByArrivalTimeForRoute(i, '6pm - 12am'),
                            i,
                            false,
                          ),
                          _buildTimeSlotButton(
                            '12am - 6am',
                            () => filterByArrivalTimeForRoute(i, '12am - 6am'),
                            i,
                            false,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}


  Widget _buildTimeSlotButton(
      String label, VoidCallback onPressed, int routeIndex, bool isDeparture) {
    bool isActive = isDeparture
        ? activeDepartureSlots[routeIndex] == label
        : activeArrivalSlots[routeIndex] == label;

    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.white,
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: Column(
            children: [
              Icon(Icons.sunny,
                  size: 15, color: isActive ? Colors.white : Colors.grey),
              Text(
                label,
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegment(String title, double sWidth, double sHeight) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeSlot("6am - 11am"),
                _buildTimeSlot("11am - 6pm"),
                _buildTimeSlot("6pm - 12am"),
                _buildTimeSlot("12am - 6am"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String time) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTimeSlot = time;
          applyFilters();
        });
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: selectedTimeSlot == time ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sunny,
                size: 15,
                color: Colors.grey,
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//   void filterByDeparturePlace(String departurePlace) {
//     setState(() {
//       filteredFlights.clear();
//       for (int i = 0; i < widget.flights.length; i++) {
//         List<Flight> filteredRoute = widget.flights[i]
//             .where((flight) => flight.departureCity == departurePlace)
//             .toList();
//         filteredFlights.add(filteredRoute);
//       }
//     });
//   }

//   void filterByArrivalPlace(String arrivalPlace) {
//     setState(() {
//       filteredFlights.clear();
//       for (int i = 0; i < widget.flights.length; i++) {
//         List<Flight> filteredRoute = widget.flights[i]
//             .where((flight) => flight.arrivalCity == arrivalPlace)
//             .toList();
//         filteredFlights.add(filteredRoute);
//       }
//     });
//   }

//   void filterByPrice(double selectedPrice) {
//     setState(() {
//       for (int i = 0; i < filteredFlights.length; i++) {
//         filteredFlights[i] = widget.flights[i]
//             .where((flight) => double.parse(flight.price) <= selectedPrice)
//             .toList();
//       }
//     });
//   }

//   void filterByAirlines(Set<String> selectedAirlines) {
//     setState(() {
//       for (int i = 0; i < filteredFlights.length; i++) {
//         filteredFlights[i] = filteredFlights[i]
//             .where((flight) => selectedAirlines.contains(flight.airlineName))
//             .toList();
//       }
//     });
//   }

//   void filterByArrivalTimeForRoute(int routeIndex, String selectedTimeSlot) {
//     setState(() {
//       filteredFlights[routeIndex] = widget.flights[routeIndex].where((flight) {
//         DateTime flightTime = DateTime.parse(flight.arrivalTime);
//         if (selectedTimeSlot == "6am - 11am") {
//           return flightTime.hour >= 6 && flightTime.hour < 11;
//         } else if (selectedTimeSlot == "11am - 6pm") {
//           return flightTime.hour >= 11 && flightTime.hour < 18;
//         } else if (selectedTimeSlot == "6pm - 12am") {
//           return flightTime.hour >= 18 && flightTime.hour < 24;
//         } else if (selectedTimeSlot == "12am - 6am") {
//           return flightTime.hour >= 0 && flightTime.hour < 6;
//         }
//         return false;
//       }).toList();

//       activeArrivalSlots[routeIndex] = selectedTimeSlot;
//       print("Route: $routeIndex, Arrival Time Slot: $selectedTimeSlot");
//       applyFilters();
//     });
//   }

//   void filterByDepartureTimeForRoute(int routeIndex, String selectedTimeSlot) {
//     setState(() {
//       filteredFlights[routeIndex] = widget.flights[routeIndex].where((flight) {
//         DateTime flightTime = DateTime.parse(flight.departureTime);
//         if (selectedTimeSlot == "6am - 11am") {
//           return flightTime.hour >= 6 && flightTime.hour < 11;
//         } else if (selectedTimeSlot == "11am - 6pm") {
//           return flightTime.hour >= 11 && flightTime.hour < 18;
//         } else if (selectedTimeSlot == "6pm - 12am") {
//           return flightTime.hour >= 18 && flightTime.hour < 24;
//         } else if (selectedTimeSlot == "12am - 6am") {
//           return flightTime.hour >= 0 && flightTime.hour < 6;
//         }
//         return false;
//       }).toList();

//       activeDepartureSlots[routeIndex] = selectedTimeSlot;
//       print("Route: $routeIndex, Departure Time Slot: $selectedTimeSlot");
//       applyFilters();
//     });
//   }

// // void applyFilters() {
// //   // Clear previous filtered flights
// //   filteredFlights.clear();

// //   // Apply filters to the original flights data
// //   for (List<Flight> routeList in widget.flights) {
// //     List<Flight> filteredRoute = routeList.where((flight) {
// //       // Apply airline filter
// //       if (selectedAirlines.isNotEmpty &&
// //           !selectedAirlines.contains(flight.airlineName)) {
// //         return false;
// //       }

// //       // Apply price filter
// //       double price = double.parse(flight.price);
// //       if (price > _selectedPrice) {
// //         return false;
// //       }

// //       // Apply departure and arrival city filters if needed
// //       // Example: Uncomment and adjust as per your requirement
// //       if (selectedDeparturePlace != null &&
// //           flight.departureCity != selectedDeparturePlace) {
// //         return false;
// //       }
// //       if (selectedArrivalPlace != null &&
// //           flight.arrivalCity != selectedArrivalPlace) {
// //         return false;
// //       }

// //       // Apply time slot filters if needed
// //       // Example: Uncomment and adjust as per your requirement
// //       if (selectedTimeSlot != null &&
// //           !flight.departureTime.contains(selectedTimeSlot)) {
// //         return false;
// //       }

// //       return true;
// //     }).toList();

// //     filteredFlights.add(filteredRoute);
// //   }

// //   // Update the UI to reflect filtered flights
// //   setState(() {});
// // }



void filterByDeparturePlace(String departurePlace) {
  setState(() {
    filteredFlights.clear();
    for (int i = 0; i < widget.flights.length; i++) {
      List<Flight> filteredRoute = widget.flights[i]
          .where((flight) => flight.departureCity == departurePlace)
          .toList();
      filteredFlights.add(filteredRoute);
    }
  });
}

void filterByArrivalPlace(String arrivalPlace) {
  setState(() {
    filteredFlights.clear();
    for (int i = 0; i < widget.flights.length; i++) {
      List<Flight> filteredRoute = widget.flights[i]
          .where((flight) => flight.arrivalCity == arrivalPlace)
          .toList();
      filteredFlights.add(filteredRoute);
    }
  });
}

void filterByPrice(double selectedPrice) {
  setState(() {
    for (int i = 0; i < filteredFlights.length; i++) {
      filteredFlights[i] = widget.flights[i]
          .where((flight) => double.parse(flight.price) <= selectedPrice)
          .toList();
    }
  });
}

void filterByAirlines(Set<String> selectedAirlines) {
  setState(() {
    for (int i = 0; i < filteredFlights.length; i++) {
      filteredFlights[i] = filteredFlights[i]
          .where((flight) => selectedAirlines.contains(flight.airlineName))
          .toList();
    }
  });
}

void filterByArrivalTimeForRoute(int routeIndex, String selectedTimeSlot) {
  setState(() {
    filteredFlights[routeIndex] = widget.flights[routeIndex].where((flight) {
      DateTime flightTime = DateTime.parse(flight.arrivalTime);
      if (selectedTimeSlot == "6am - 11am") {
        return flightTime.hour >= 6 && flightTime.hour < 11;
      } else if (selectedTimeSlot == "11am - 6pm") {
        return flightTime.hour >= 11 && flightTime.hour < 18;
      } else if (selectedTimeSlot == "6pm - 12am") {
        return flightTime.hour >= 18 && flightTime.hour < 24;
      } else if (selectedTimeSlot == "12am - 6am") {
        return flightTime.hour >= 0 && flightTime.hour < 6;
      }
      return false;
    }).toList();

    activeArrivalSlots[routeIndex] = selectedTimeSlot;
    applyFilters();
  });
}

void filterByDepartureTimeForRoute(int routeIndex, String selectedTimeSlot) {
  setState(() {
    filteredFlights[routeIndex] = widget.flights[routeIndex].where((flight) {
      DateTime flightTime = DateTime.parse(flight.departureTime);
      if (selectedTimeSlot == "6am - 11am") {
        return flightTime.hour >= 6 && flightTime.hour < 11;
      } else if (selectedTimeSlot == "11am - 6pm") {
        return flightTime.hour >= 11 && flightTime.hour < 18;
      } else if (selectedTimeSlot == "6pm - 12am") {
        return flightTime.hour >= 18 && flightTime.hour < 24;
      } else if (selectedTimeSlot == "12am - 6am") {
        return flightTime.hour >= 0 && flightTime.hour < 6;
      }
      return false;
    }).toList();

    activeDepartureSlots[routeIndex] = selectedTimeSlot;
    applyFilters();
  });
}


void applyFilters() {
  // Reset filteredFlights to original flights
  filteredFlights = widget.flights.map((route) => List<Flight>.from(route)).toList();

  // Apply individual filters
  if (selectedDeparturePlace != null && selectedDeparturePlace.isNotEmpty) {
    filterByDeparturePlace(selectedDeparturePlace);
  }

  if (selectedArrivalPlace != null && selectedArrivalPlace.isNotEmpty) {
    filterByArrivalPlace(selectedArrivalPlace);
  }

  if (selectedAirlines.isNotEmpty) {
    filterByAirlines(selectedAirlines);
  }

  // Sorting is done individually for each route using buttons
  setState(() {
    sortFlightsByTimeSlot();
  });
}





//   void applyFilters() {
//     // Reset filteredFlights to original flights
//     filteredFlights =
//         widget.flights.map((route) => List<Flight>.from(route)).toList();

//     // Apply individual filters
//     filterByPrice(_selectedPrice);

//     if (selectedDeparturePlace != null && selectedDeparturePlace.isNotEmpty) {
//       filterByDeparturePlace(selectedDeparturePlace);
//     }

//     if (selectedArrivalPlace != null && selectedArrivalPlace.isNotEmpty) {
//       filterByArrivalPlace(selectedArrivalPlace);
//     }

//     if (selectedAirlines.isNotEmpty) {
//       filterByAirlines(selectedAirlines);
//     }

//     // Sorting is done individually for each route using buttons
//     setState(() {
//       sortFlightsByTimeSlot();
//     });
//   }
// }

Widget _buildFlightInfo(String title, String time, String date) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
      ),
      Text(
        time,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      Text(
        date,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    ],
  );
}

Widget _buildPriceInfo(String price) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        price,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      Text(
        " per adult",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    ],
  );
}

Widget _durationInfo(String title, stops) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(title),
      Container(
        height: 3.5,
        width: 50,
        color: stops.toString() == '0' ? Colors.green : Colors.orange,
      ),
      stops.toString() == '0'
          ? Text("Nonstop")
          : Text("${stops.toString()} stop")
    ],
  );
}
    }
// ------->>

// Widget _buildFilters(double sWidth, double sHeight) {
//   return Container(
//     width: sWidth * 0.2,
//     child: Card(
//       elevation: 5.0,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
//               child: Text(
//                 "Airlines",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: filteredAirlines.length,
//               itemBuilder: (context, index) {
//                 final airlineName = filteredAirlines.elementAt(index);
//                 final airlineCode = filteredAirlineCodes.elementAt(index);
//                 final isChecked = selectedAirlines.contains(airlineName);

//                 return Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: Row(
//                     children: [
//                       SizedBox(width: 12),
//                       Container(
//                         height: 25,
//                         width: 25,
//                         child: Image.asset(
//                           'images/AirlinesLogo/$airlineCode.png',
//                         ),
//                       ),
//                       SizedBox(width: 12),
//                       Text(airlineName),
//                       Spacer(),
//                       Checkbox(
//                         value: isChecked,
//                         onChanged: (bool value) {
//                           setState(() {
//                             if (value) {
//                               selectedAirlines.add(airlineName);
//                             } else {
//                               selectedAirlines.remove(airlineName);
//                             }
//                             applyFilters();
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//             Divider(),
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
//               child: Text(
//                 "Price",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Row(
//               children: [
//                 SizedBox(width: 12),
//                 Text("Max: ₹${_selectedPrice.toStringAsFixed(0)}"),
//               ],
//             ),
//             SizedBox(height: 10),
//             Slider(
//               min: minPrice,
//               max: maxPrice,
//               value: _selectedPrice,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedPrice = value;
//                   applyFilters();
//                 });
//               },
//             ),
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
//               child: Text(
//                 "Departure Place",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 5),
//             ListView.builder(
//               itemCount: departurePlaces.toList().length,
//               itemBuilder: (context, index) {
//               return Text("fghf");
//             }),
//             DropdownButton<String>(
//               value: selectedDeparturePlace,
//               onChanged: (String newValue) {
//                 setState(() {
//                   selectedDeparturePlace = newValue;
//                   applyFilters();
//                 });
//               },
//               items: departurePlaces
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             _buildSegment("Departure time", sWidth, sHeight),
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
//               child: Text(
//                 "Arrival Place",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 5),
//             DropdownButton<String>(
//               value: selectedArrivalPlace,
//               onChanged: (String newValue) {
//                 setState(() {
//                   selectedArrivalPlace = newValue;
//                   applyFilters();
//                 });
//               },
//               items:
//                   arrivalPlaces.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 20),
//             _buildSegment("Arrival time", sWidth, sHeight),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// ----->>

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:trip/screens/bus/bus_details.dart';
// import 'package:trip/screens/constant.dart';
// import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
// import '../api_services/location_list_api.dart';
// import '../models/flight_model.dart';
// import 'Drawer.dart';
// import 'flight_model/multicity_route_model.dart';
// import 'flight_searchlist/widgets/priceslider.dart';
// import 'flightss_/widgets/search_container.dart';
// import 'header.dart';
// import 'multicity_widgets/list_widgets.dart';

// class DomesticMultiwaylistpage extends StatefulWidget {
//   List<List<Flight>> flights;
// List<LocationData> locationList1;
// String cabin_class;
// String adult;
// String child;
// String infant;
//   DomesticMultiwaylistpage(
//       {Key key,
//       this.flights,
// this.locationList1,
// this.adult,
// this.cabin_class,
// this.child,
// this.infant});

//   @override
//   State<DomesticMultiwaylistpage> createState() =>
//       _DomesticMultiwaylistpageState();
// }

// Set<String> selectedAirlines = Set<String>();

// double _selectedPrice = 24300;
// Flight route1, route2, route3, route4, route5;
// List<Flight> routes1List, routes2List, route3List, route4List, route5List;
// int count;
// int selectedIndex = -1;
// Flight picked_route1,
//     picked_route2,
//     picked_route3,
//     picked_route4,
//     picked_route5;
// String totalfare;
// Set<String> filteredAirlines;
// Set<String> filteredAirlineCodes;
// double minPrice = double.infinity;
// double maxPrice = 0;
// List<List<Flight>> filteredFlights = [];

// class _DomesticMultiwaylistpageState extends State<DomesticMultiwaylistpage>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//     getFlights();
//     selectedIndex = 0;
//     getUniqueAirlineNames(widget.flights);
//     findMinMaxPrices(widget.flights);
//     log(" 44:${widget.locationList1.length.toString()}");
//     filteredFlights = widget.flights;
//     _selectedIndex = 0;
//   }

//   void findMinMaxPrices(List<List<Flight>> flights) {
//     if (flights.isEmpty) {
//       // Handle empty list case
//       return;
//     }

//     // Initialize maxPrice to 0

//     setState(() {
//       for (List<Flight> route in flights) {
//         for (Flight flight in route) {
//           if (double.parse(flight.price) < minPrice) {
//             minPrice = double.parse(
//                 flight.price); // Update minPrice if a smaller price is found
//           }
//           if (double.parse(flight.price) > maxPrice) {
//             maxPrice = double.parse(
//                 flight.price); // Update maxPrice if a larger price is found
//           }
//         }
//       }
//     });

//     // Now you have the minimum and maximum prices
//     print('Minimum price: $minPrice');
//     print('Maximum price: $maxPrice');
//   }

// Set<String> getUniqueAirlineNames(List<List<Flight>> flights) {
//   Set<String> uniqueAirlineNames = {};
//   Set<String> uniqueAirlineCodes = {};
//   for (List<Flight> routeList in flights) {
//     for (Flight route in routeList) {
//       uniqueAirlineNames.add(route.airlineName);
//       uniqueAirlineCodes.add(route.airlineCode);
//     }
//   }
//   setState(() {
//     filteredAirlines = uniqueAirlineNames;
//     filteredAirlineCodes = uniqueAirlineCodes;
//   });
//   return uniqueAirlineNames;
// }

//   int _selectedIndex;

//   void getFlights() {
//     List<Flight> routes1 = [];
//     List<Flight> routes2 = [];
//     List<Flight> routes3 = [];
//     List<Flight> routes4 = [];
//     List<Flight> routes5 = [];
//     setState(() {
//       count = multiRoutes.length;
//     });
//     print("count: $count,");

//     for (int i = 0; i < count; i++) {
//       if (i == 0) {
//         routes1.addAll(widget.flights[i]);
//       } else if (i == 1) {
//         routes2.addAll(widget.flights[i]);
//       } else if (i == 2) {
//         routes3.addAll(widget.flights[i]);
//       } else if (i == 3) {
//         routes4.addAll(widget.flights[i]);
//       } else if (i == 4) {
//         routes5.addAll(widget.flights[i]);
//       }
//     }

//     setState(() {
//       routes1List = routes1;
//       routes2List = routes2;
//       count >= 3 ? route3List = routes3 : route3List = null;
//       count >= 4 ? route4List = routes4 : route4List = null;
//       count >= 5 ? route5List = routes5 : route5List = null;
//       print("routes1List: ${routes1List.length},");
//       print("routes2List: ${routes2List.length},");
//       route1 = routes1.isNotEmpty ? routes1.first : null;
//       route2 = routes2.isNotEmpty ? routes2.first : null;
//       route3 = count >= 3 ? routes3.first : null;
//       route4 = count >= 4 ? routes4.first : null;
//       route5 = count >= 5 ? routes5.first : null;
//       picked_route1 = route1;
//       picked_route2 = route2;
//       picked_route3 = count >= 3 ? route3 : null;
//       picked_route4 = count >= 4 ? route4 : null;
//       picked_route5 = count >= 5 ? route5 : null;
//     });
//     print("route1:${route1.departureCity},${route1.arrivalCity}");
//     print("route2:${route2.departureCity},${route2.arrivalCity}");
//     if (count >= 3) {
//       print("route3:${route3.departureCity},${route3.arrivalCity}");
//     }
//     if (count >= 4) {
//       print("route4:${route4.departureCity},${route4.arrivalCity}");
//     }
//     if (count >= 5) {
//       print("route5:${route5.departureCity},${route5.arrivalCity}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var sWidth = MediaQuery.of(context).size.width;
//     var sHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
// backgroundColor: Color.fromARGB(255, 207, 232, 251),
// appBar: sWidth < 600
//     ? AppBar(
//         iconTheme: const IconThemeData(color: Colors.black, size: 40),
//         backgroundColor: Colors.white,
//         title: Text(
//           'Tour',
//           style: blackB15,
//         ),
//       )
//     : CustomAppBar(),
// drawer: sWidth < 700 ? drawer() : null,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
// SearchContainer(
//   sWidth: sWidth,
//   sHeight: sHeight,
//   locationList1: widget.locationList1,
//   travellerCount: int.parse(widget.adult) +
//       int.parse(widget.child) +
//       int.parse(widget.infant),
//   adult: widget.adult,
//   child: widget.child,
//   infant: widget.infant,
//   cabin_class: widget.cabin_class,
//   fromcity: 'delhi',
//   tocity: "mumbai",
//   fromcode: 'DEL',
//   tocode: "BOM",
//   date:'2024-06-13',
//   //  multiflights:widget.flights,
//   type: 'Multicity',
// ),
// Stack(
//   alignment: Alignment.topCenter,
//   children: [
//     _buildGradientContainer(sWidth),
//     _buildFlightDetails(sWidth, sHeight)
//   ],
// ),
//           ],
//         ),
//       ),
      // bottomSheet: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     buildBookingContainer(
      //         sWidth,
      //         sHeight,
      //         picked_route1,
      //         picked_route2,
      //         picked_route3,
      //         picked_route4,
      //         picked_route5,
      //         context),
      //   ],
      // ),
//     );
//   }

// Widget _buildGradientContainer(double width) {
//   return Container(
//     height: 200, // Adjust the height as needed
//     width: width,
//     decoration: BoxDecoration(
//       border: Border.all(
//         width: 0.2,
//         color: Color.fromARGB(255, 1, 20, 99),
//       ),
//       gradient: LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [
//           Colors.black,
//           Color.fromARGB(255, 2, 5, 31),
//           // Color.fromARGB(255, 4, 17, 73),
//           // Color.fromARGB(255, 1, 29, 140),
//           Color.fromARGB(255, 3, 54, 81),
//           Color.fromARGB(255, 2, 97, 148),
//         ],
//       ),
//     ),
//   );
// }

//   void _applyFilters(List<List<Flight>> flights, double maxPrice, int index) {
//     setState(() {
//       // Clear previous filtered results
//       filteredFlights.clear();

//       // Apply the filter to the specific flight list at the given index
//       List<Flight> filteredRoute = flights[index]
//           .where((flight) => double.parse(flight.price) <= maxPrice)
//           .toList();

//       // Add the filtered flights to the list of filtered flights
//       filteredFlights.add(filteredRoute);
//     });
//   }

//   // _applyFilters(List<List<Flight>> flights, double maxPrice, int index) {
//   //   setState(() {
//   //     for (int i = 0; i < flights[index].length; i++) {
//   //       List<Flight> filteredRoute = route
//   //           .where((flight) => double.parse(flight.price) <= maxPrice)
//   //           .toList();
//   //       filteredFlights.add(filteredRoute);
//   //     }
//   //   });
//   // }

//   void _toggleAirlineFilter(String airlineName, int _selectedindex) {
//     setState(() {
//       if (selectedAirlines.contains(airlineName)) {
//         selectedAirlines.remove(airlineName);
//       } else {
//         selectedAirlines.add(airlineName);
//       }
//     });
//   }

//   Widget _buildFlightDetails(double sWidth, double sHeight) {
//     // double maxPrice = _selectedPrice + 1000; // Adjust the range as needed
//     // filteredFlights =
//     // _applyFilters(widget.flights, maxPrice,
//     // _selectedIndex); // Apply filters based on the selected price

//     return Container(
//       child: Stack(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(width: sWidth * 0.1),
//               _filters(sWidth, sHeight, filteredFlights.length,
//                   filteredAirlines, filteredAirlineCodes, _selectedIndex),
//               SizedBox(width: sWidth * 0.024),
//               Padding(
//                 padding: const EdgeInsets.only(top: 80.0),
//                 child: Container(
//                   width: sWidth * 0.62,
//                   height: sHeight * 8,
//                   color: Colors.transparent,
//                   child: Stack(
//                     children: [
//                       DefaultTabController(
//                         length: filteredFlights.length,
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               child: TabBar(
//                                 indicatorColor: Colors.transparent,
//                                 tabs: _tabScroll(),
//                                 onTap: (index) {
//                                   setState(() {
//                                     _selectedIndex = index;
//                                   });
//                                 },
//                               ),
//                             ),
//                             Expanded(
//                               child: TabBarView(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 children: List.generate(filteredFlights.length,
//                                     (index) {
//                                   return _buildListView(filteredFlights[index],
//                                       (index + 1).toString());
//                                 }),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(width: sWidth * 0.04),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   _filters(
//       double sWidth,
//       double sHeight,
//       int count,
//       Set<String> filteredAirlines,
//       Set<String> filteredairlinecodes,
//       int _selectedIndex) {
//     List<String> airlineList = filteredAirlines.toList();
//     List<String> airlineCode = filteredairlinecodes.toList();

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(width: sWidth * 0.2, height: 150),
//         Container(
//             width: sWidth * 0.2,
//             // color: Colors.white,
//             child: Card(
//               elevation: 5.0,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
//                       child: Text(
//                         "Airlines",
//                         style: TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.bold),
//                       ),
//                     ),
// ListView.builder(
//   shrinkWrap: true,
//   itemCount: airlineList.length,
//   itemBuilder: (context, index) {
//     final airlineName = airlineList[index];
//     final isChecked =
//         selectedAirlines.contains(airlineName);

//     return Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 3.0, bottom: 3),
//         child: Row(
//           children: [
//             SizedBox(width: 12),
//             Container(
//               height: 25,
//               width: 25,
//               child: Image.asset(
//                   'images/AirlinesLogo/${airlineCode[index]}.png'),
//             ),
//             SizedBox(width: 12),
//             Text(airlineName),
//             Spacer(),
//             Checkbox(
//               value: isChecked,
//               onChanged: (bool newValue) {
//                 setState(() {
//                   _toggleAirlineFilter(
//                       airlineName, _selectedIndex);
//                 });
//               },
//             ),
//             SizedBox(width: 8),
//           ],
//         ),
//       ),
//     );
//   },
// ),
// SizedBox(height: 10),
// Text(
//   "Price",
//   style: TextStyle(
//     fontSize: 15,
//     color: Colors.black,
//     fontWeight: FontWeight.w700,
//   ),
// ),
// kheight10,
// PriceSlider(
//   minPrice: minPrice,
//   maxPrice: maxPrice,
//   initialValue: _selectedPrice,
//   onChanged: (value) {
//     setState(() {
//       // _selectedPrice = value;
//       // // filteredFlights =
//       // _applyFilters(widget.flights, _selectedPrice + 1000,
//       //     _selectedIndex);
//     });
//   },
// ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Selected Price: \$${_selectedPrice.toStringAsFixed(2)}',
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.grey.shade700),
//                     ),
//                     kheight10,
//                     SizedBox(
//                       width: sWidth * 0.2,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: count - 1,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               children: [
// _buildSegment("Departure From New Delhi",
//     sWidth, sHeight),
// // SizedBox(height: 10),
// _buildSegment(
//     "Arrival at Mumbai", sWidth, sHeight),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )),
//         // SizedBox(height: 10),
//       ],
//     );
//   }

//   Widget _buildSegment(String title, sWidth, sHeight) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 10),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 15,
//               color: Colors.black,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildTimeSlot(),
//                 _buildTimeSlot(),
//                 _buildTimeSlot(),
//                 _buildTimeSlot(),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildTimeSlot() {
//     return Container(
//       height: 70,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey, width: 0.5),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(2.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.sunny,
//               size: 15,
//               color: Colors.grey,
//             ),
//             Text(
//               "12pm-6pm",
//               style: TextStyle(
//                 fontSize: 9,
//                 fontWeight: FontWeight.bold,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> _tabScroll() {
//     return List.generate(widget.flights.length, (index) {
//       final route1Dep = route1.departureCity;
//       final route1Arr = route1.arrivalCity;
//       final route2Dep = route2.departureCity;
//       final route2Arr = route2.arrivalCity;
//       routes _route = multiRoutes[index];

//       return Tab(
//         iconMargin: EdgeInsets.all(0),
//         child: Container(
//           // height: 350,
//           // width: 350,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(width: 0.5, color: Colors.white),
//             color: _selectedIndex == index ? darkblue: Colors.white,
//           ),
//           alignment: Alignment.center,
//           child: Column(
//             children: [
//               kheight5,
//               SizedBox(
//                 width: 350,
//                 child: Center(
//                   child: Text(
//                     "${_route.fromcity} → ${_route.tocity}",
//                     style: GoogleFonts.rajdhani(
//                       color:
//                           _selectedIndex == index ? Colors.white : Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//               Text(
//                 "${formatDate(_route.date)}",
//                 style: GoogleFonts.rajdhani(
//                   color: _selectedIndex == index ? Colors.white : Colors.black,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   String formatDate(String date) {
//     DateTime parsedDate = DateTime.parse(date);
//     String formattedDate = DateFormat('MMMM d, EEEE').format(parsedDate);
//     return formattedDate;
//   }

//   Widget _buildListView(List<Flight> flightModel, route) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(flightModel.length, (index) {
//         Flight tripInfo = flightModel[index];
//         return _buildFlightCard(tripInfo, index, route);
//       }),
//     );
//   }

//   List<int> selectedIndices = [
//     null,
//     null,
//     null,
//     null
//   ]; // Initialize list for each route

//   Widget _buildFlightCard(Flight tripInfo, int index, String route) {
// String departure = tripInfo.departureTime.toString();
// String arrival = tripInfo.arrivalTime.toString();
// String dTime = departure.substring(departure.length - 5);
// String aTime = arrival.substring(arrival.length - 5);
// String dDate = departure.substring(0, 10);
// String aDate = arrival.substring(0, 10);
// String duration = minutetohour(tripInfo.duration);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             // Update the selected index for the corresponding route
            // if (route == '1') {
            //   selectedIndices[0] = index;
            //   picked_route1 = routes1List[index];
            //   print("${routes1List[index].airlineName}");
            // } else if (route == '2') {
            //   selectedIndices[1] = index;
            //   picked_route2 = routes2List[index];
            //   print("${routes2List[index].airlineName}");
            // } else if (route == '3') {
            //   selectedIndices[2] = index;
            //   picked_route3 = route3List[index];
            //   print("${route3List[index].airlineName}");
            // } else if (route == '4') {
            //   selectedIndices[3] = index;
            //   picked_route4 = route4List[index];
            //   print("${route4List[index].airlineName}");
            // }
//           });
//         },
//         child: Container(
//           width: 900,
//           height: 150,
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//           ),
//           child: Card(
//             color: selectedIndices[int.parse(route) - 1] ==
//                     index // Check if index is selected for this route
//                 ? Color.fromARGB(255, 192, 222, 248)
//                 : Colors.white,
//             elevation: 5.0,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                       child: Image.asset(
//                         'images/AirlinesLogo/${tripInfo.airlineCode}.png',
//                       ),
//                     ),
//                     Text(tripInfo.airlineName),
//                     SizedBox(width: 10),
//                     _buildFlightInfo('Departure', dTime, dDate),
//                     SizedBox(width: 10),
//                     _durationInfo(duration, tripInfo.stops),
//                     SizedBox(width: 10),
//                     _buildFlightInfo('Arrival', aTime, aDate),
//                     SizedBox(width: 10),
//                     _buildPriceInfo("₹${tripInfo.price.toString()}"),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
