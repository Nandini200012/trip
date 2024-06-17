import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trip/api_services/revalidate%20apis/one%20way/revalidate_domestic_onewat_api.dart';
import 'package:trip/common/print_funtions.dart';
import 'package:trip/screens/domestic_Multicity_page.dart';
import 'package:trip/screens/flightbooking%20page/ismulticityformpage.dart';
import 'package:trip/screens/flightss_/search/oneway/oneway_search.dart';
import 'package:trip/screens/flightss_/widgets/search_container_widgets/multicity_searchContainer.dart';
import 'package:trip/screens/flightss_/widgets/search_container_widgets/search_container_dropdown.dart';
import 'package:trip/screens/flightss_/widgets/search_container_widgets/search_container_global_variables.dart';
import 'package:trip/screens/flightss_/widgets/search_container_widgets/traveller_function.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import '../../../api_services/location_list_api.dart';
import '../../../constants/fonts.dart';
import '../../../models/flight_model.dart';
import '../../../widgets/Travel_class.dart';
import '../../../widgets/children_count.dart';
import '../../../widgets/infants_count.dart';
import '../../flight_booking_screen.dart';
import '../../flight_model/multicity_route_model.dart';

Color darkblue = Color.fromARGB(255, 20, 28, 61);
String route = 'one way';
String fromPlace = 'New Delhi, India';
String depDate;
String retDate;
onfromChanged({LocationData fromplace}) {
  return fromPlace.toString();
}

class SearchContainer extends StatefulWidget {
  final double sWidth;
  final double sHeight;
  int travellerCount;
  String fromcity, tocity;
  final List<LocationData> locationList1;
  String domorInter;
  String type;
  String adult;
  String child;
  String infant;
  String cabin_class;
  String date;
  String fromcode;
  String tocode;
  String returndate = null;
  // List<List<Flight>> multiflights;
  SearchContainer(
      {Key key,
      this.domorInter,
      // this.multiflights,
      this.returndate,
      this.date,
      this.sWidth,
      this.sHeight,
      this.locationList1,
      this.travellerCount,
      this.fromcity,
      this.tocity,
      this.type,
      this.adult,
      this.child,
      this.infant,
      this.cabin_class,
      this.fromcode,
      this.tocode})
      : super(key: key);

  @override
  _SearchContainerState createState() => _SearchContainerState();
}

List<LocationData> filteredList = [];
bool textCity2 = true;
String fromData1 = "Delhi";
bool showTextField1 = false;
bool adrsCity2 = false;
String city1 = 'Mumbai';
String address1 = "";
LocationData dropdownvalue1;
String date;
String _fromcode, tocode;
// multicity
// trip2
LocationData dropdownvalue2;
bool showTextField_2 = false;
bool textCity_2 = false;
bool adrsCity_2 = false;
String city2 = '';
String address2 = "";
String fromData2 = "";
String _fromcode2;
// return
bool showreturn = false;
bool isshow = false;
String routeDI;

class _SearchContainerState extends State<SearchContainer> {
  @override
  void initState() {
    super.initState();
    log("frmcity:${widget.fromcity}");
    log("tocity:${widget.tocity}");
    log("frmcode:${widget.fromcode}");
    log("tocode:${widget.tocode}");
    log("adult:${widget.adult}");
    log("type:${widget.type}");
    log("child:${widget.child}");
    log("infant:${widget.infant}");
    log("date:${widget.date}");
    log("retdate:${widget.returndate}");
    log("location:${widget.locationList1.length}");
    log("count:${widget.travellerCount}");
    log("cls:${widget.cabin_class}");
    initializeAll();
    routeDI = widget.domorInter;
    route = widget.type;
    globalcount = widget.travellerCount;
    globalclass = widget.cabin_class;
    globalchild = widget.child ?? "0";
    globaladult = widget.adult;
    globalinfant = widget.infant ?? "0";
    isshow = false;
    log("to:$tocode,${widget.tocode}");
    // getType(widget.type);

    multicityInitialize();
  }

  initializeAll() {
    if (widget.type.toLowerCase() != 'multicity') {
      setState(() {
        filteredList = widget.locationList1;
        fromData1 = widget.fromcity;
        city1 = widget.tocity;
        date = widget.date;
        _fromcode = widget.fromcode;
        tocode = widget.tocode;
        depDate = widget.date;
        retDate = widget.date ?? null;
        route = widget.type;
      });
    } else {}
  }

  void multicityInitialize() {
    // Print the length of multiRoutes for debugging purposes
    print('MultiRoutes length: ${multiRoutes.length}');

    // Check if the widget type is not "multicity"
    if (widget.type.toLowerCase() != 'multicity') {
      // If multiRoutes is null or empty, initialize it with the provided data
      if (multiRoutes.isEmpty || multiRoutes == null) {
        // Create a new MultiRoute object with the provided data
        routes newRoute = routes(
          date: widget.date,
          fromCode: widget.fromcode,
          toCode: widget.tocode,
          fromcity: widget.fromcity,
          tocity: widget.tocity,
        );

        // Add the new route to the multiRoutes list
        multiRoutes.add(newRoute);
      }
    }
  }

  void initialiseglobalvariables(
      String adult, String child, String infant, String cabinglobalclass) {}
  String route = 'One Way'; // Assuming route is a member variable

  @override
  Widget build(BuildContext context) {
    return Container(
      //(showContainer ? 650 : 450)
      height: (route != 'Multicity' ? 150 : (isshow ? 600 : 250)),
      //  width: widget.sWidth + 140,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          width: 0.1,
          color: Colors.black,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 12,
          bottom: 55,
          left: 100,
          right: (route == 'Return' || widget.type == 'Return') ? 20 : 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Visibility(
                  visible: route == 'Multicity' ? true : false,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isshow = !isshow;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: isshow ? Colors.grey : darkblue,
                      child: Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.white,
                      ),
                      radius: 15,
                    ),
                  ),
                ),
                kwidth3,
                routedropdown(
                  sWidth: widget.sWidth * 0.1,
                  title: "Trip Type",
                  Options: [
                    'One Way',
                    'Multicity',
                    'Return',
                  ],
                  option: widget.type,
                  onChanged: onDropdownChanged,
                ),
                SizedBox(width: 15),
                TypeDropdown(
                  sWidth: widget.sWidth * 0.1,
                  title: "Trip Type",
                  options: [
                    'Domestic',
                    'International',
                  ],
                  option: 'Domestic',
                  onChanged: ontypeChanged,
                ),
                // typeDropdown(
                //   sWidth: widget.sWidth * 0.1,
                //   title: "Trip Type",
                //   Options: [
                //     'International',
                //     'Domestic',
                //   ],
                //   option: widget.type,
                //   onChanged: onDropdownChanged,
                // ),
                // locationDropdown
                // _buildContainer('Type', "Domestic", widget.sWidth * 0.1),
                SizedBox(width: 15),
                Visibility(
                    visible: route == 'Multicity' ? true : false,
                    child: MulticitySearchContainer(
                      sheight: widget.sHeight,
                      swidth: widget.sWidth,
                      locationList1: widget.locationList1,
                      // multiflights: widget.multiflights,
                    )),
                Visibility(
                  visible: route != 'Multicity' ? true : false,
                  child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius as needed
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue,
                                        Colors.lightBlueAccent
                                      ], // Define your gradient colors
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors
                                          .transparent, // Make the button transparent
                                      elevation:
                                          0, // Remove the button's elevation
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Same as the container's radius
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        // fromData1=value.name;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Done"),
                                  ),
                                ),
                              ],
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 500,
                                  height: 200,
                                  // padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),

                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showTextField = true;
                                              textCity1 = false;
                                              adrsCity1 = false;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Visibility(
                                                    visible: true,
                                                    // visible: textCity2,
                                                    child: SizedBox(height: 8)),
                                                Expanded(
                                                  child: Visibility(
                                                    visible: true,
                                                    // visible: showTextField,
                                                    child: Positioned(
                                                      top: 0,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(1.0),
                                                        child: DropdownSearch<
                                                            LocationData>(
                                                          // mode: Mode.MENU,
                                                          // showSearchBox: true,
                                                          compareFn: (LocationData
                                                                  item,
                                                              LocationData
                                                                  selectedItem) {
                                                            return item ==
                                                                selectedItem;
                                                          },
                                                          popupProps:
                                                              PopupProps.menu(
                                                            showSearchBox: true,
                                                            showSelectedItems:
                                                                true,
                                                          ),
                                                          dropdownDecoratorProps:
                                                              DropDownDecoratorProps(
                                                            dropdownSearchDecoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Search for a location',
                                                              border:
                                                                  OutlineInputBorder(),
                                                            ),
                                                          ),
                                                          items: widget
                                                              .locationList1,
                                                          // label: 'Location',
                                                          onChanged: (value) {
                                                            setState(() {
                                                              dropdownvalue =
                                                                  value;
                                                              showTextField =
                                                                  false;
                                                              textCity1 = true;
                                                              adrsCity1 = true;
                                                              city = value.city;
                                                              address =
                                                                  value.name;
                                                              fromData1 =
                                                                  value.city;
                                                              _fromcode =
                                                                  value.code;
                                                              // print(
                                                              //     "code: $from_code");
                                                              print(
                                                                  'city - $city');
                                                              print(
                                                                  'address - $address');
                                                            });
                                                          },
                                                          selectedItem:
                                                              dropdownvalue,
                                                          itemAsString:
                                                              (LocationData
                                                                      location) =>
                                                                  location.name,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: true,
                                                    // visible: adrsCity1,
                                                    child: SizedBox(height: 4)),
                                                Visibility(
                                                  visible: true,
                                                  // visible: adrsCity1,
                                                  child: Text(
                                                    address /*'DEL,Indira International Airport'*/,
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // ------------
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: _buildContainer(
                          'From', fromData1, widget.sWidth * 0.1)),
                ),
                Visibility(
                    visible: route != 'Multicity' ? true : false,
                    child: SizedBox(width: 5)),
                Visibility(
                  visible: route != 'Multicity' ? true : false,
                  child: Icon(
                    Icons.swap_horiz_sharp,
                    size: 22,
                    color: Color.fromARGB(255, 3, 158, 255),
                  ),
                ),
                Visibility(
                    visible: route != 'Multicity' ? true : false,
                    child: SizedBox(width: 5)),
                Visibility(
                  visible: route != 'Multicity' ? true : false,
                  child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              actions: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius as needed
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue,
                                        Colors.lightBlueAccent
                                      ], // Define your gradient colors
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors
                                          .transparent, // Make the button transparent
                                      elevation:
                                          0, // Remove the button's elevation
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Same as the container's radius
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        // fromData1=value.name;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Done"),
                                  ),
                                ),
                              ],
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 500,
                                  height: 200,
                                  // padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),

                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showTextField1 = true;
                                              textCity2 = false;
                                              adrsCity2 = false;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Visibility(
                                                    visible: true,
                                                    // visible: textCity2,
                                                    child: SizedBox(height: 8)),
                                                Expanded(
                                                  child: Visibility(
                                                    visible: true,
                                                    // visible: showTextField1,
                                                    child: Positioned(
                                                      top: 0,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        child: DropdownSearch<
                                                            LocationData>(
                                                          compareFn: (LocationData
                                                                  item,
                                                              LocationData
                                                                  selectedItem) {
                                                            return item ==
                                                                selectedItem;
                                                          },
                                                          popupProps:
                                                              PopupProps.menu(
                                                            showSearchBox: true,
                                                            showSelectedItems:
                                                                true,
                                                          ),
                                                          dropdownDecoratorProps:
                                                              DropDownDecoratorProps(
                                                            dropdownSearchDecoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Search for a location',
                                                              border:
                                                                  OutlineInputBorder(),
                                                            ),
                                                          ),
                                                          items: widget
                                                              .locationList1,
                                                          // label: 'Location',
                                                          onChanged: (value) {
                                                            setState(() {
                                                              dropdownvalue1 =
                                                                  value;
                                                              showTextField1 =
                                                                  false;
                                                              textCity2 = true;
                                                              adrsCity1 = true;
                                                              city1 =
                                                                  value.city;
                                                              address1 =
                                                                  value.name;
                                                              tocode =
                                                                  value.code;
                                                              print(
                                                                  "code:$to_code");
                                                              print(
                                                                  'city - $city1');
                                                              print(
                                                                  'address - $address1');
                                                            });
                                                          },
                                                          selectedItem:
                                                              dropdownvalue1,
                                                          itemAsString:
                                                              (LocationData
                                                                      location) =>
                                                                  location.name,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: true,
                                                    // visible: adrsCity2,
                                                    child: SizedBox(height: 4)),
                                                Visibility(
                                                  visible: true,
                                                  // visible: adrsCity2,
                                                  child: Text(
                                                    address1 /*'DEL,Indira International Airport'*/,
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // ------------
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: _buildContainer('TO', city1, widget.sWidth * 0.1)),
                ),
                Visibility(
                    visible: route != 'Multicity' ? true : false,
                    child: SizedBox(width: 15)),
                Visibility(
                    visible: route != 'Multicity' ? true : false,
                    child:
                        DateSelector(widget.sWidth * 0.1, widget.date, false)),
                Visibility(
                  visible: showreturn,
                  child: SizedBox(width: 15),
                ),
                Visibility(
                  visible: showreturn,
                  child: DateSelector(widget.sWidth * 0.1,
                      widget.returndate ?? widget.date, true),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    Travellerfunction(widget.sHeight, widget.sWidth, context,
                        globaladult, globalchild, globalinfant, globalclass);
                  },
                  child: _buildContainer(
                    'PASSENGERS & CLASS',
                    '${globalcount}Passenger, ${globalclass}',
                    widget.sWidth * 0.1,
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    // print("type:$route,from:$fromPlace,to:$city1,date:$date");
                    if (routeDI.toLowerCase() == 'domestic') {
                      if (widget.type.toLowerCase() == "One Way" ||
                          route.toLowerCase() == 'one way') {
                        print("fromplace:$fromData1");
                        print("city1:$city1");
                        print("globalclass:$globalclass");
                        print("_adul:$globaladult");
                        print("globalchild:$globalchild");
                        print("globalinfant:$globalinfant");
                        print("_fromcode:$_fromcode");
                        print("_tocode:$tocode");
                        print("date:$depDate");
                        print("date2:$retDate");
                        print("_cont:$globalcount");

                        searchDomesticOneway1(
                          widget.locationList1,
                          fromData1,
                          city1,
                          globalclass,
                          globaladult,
                          globalchild ?? 0,
                          globalinfant ?? "0",
                          _fromcode,
                          tocode,
                          depDate,
                          globalcount,
                          context,
                        );
                      } else if (widget.type.toLowerCase() == 'return' ||
                          route.toLowerCase() == 'return') {
                        print("fromplace:$fromData1");
                        print("city1:$city1");
                        print("globalclass:$globalclass");
                        print("_adul:$globaladult");
                        print("globalchild:$globalchild");
                        print("globalinfant:$globalinfant");
                        print("_fromcode:$_fromcode");
                        print("_tocode:$tocode");
                        print("date:$depDate");
                        print("date2:$retDate");
                        print("_cont:$globalcount");

                        getReturnSearchApi(
                            widget.locationList1,
                            true,
                            widget.travellerCount,
                            city,
                            city1,
                            globalclass,
                            globaladult,
                            globalchild ?? 0,
                            globalinfant ?? "0",
                            _fromcode,
                            tocode,
                            retDate,
                            depDate,
                            context);
                      } else if (widget.type.toLowerCase() == 'multicity' ||
                          route.toLowerCase() == 'multicity') {
                        print("mul: ${multiRoutes.length}");
                        print(multiRoutes[0].date);
                        print(multiRoutes[1].date);
                        getMulticity(
                          widget.locationList1,
                          globalclass,
                          globaladult,
                          globalchild ?? 0,
                          globalinfant ?? "0",
                          context,
                        );
                      }
                    } else if (routeDI.toLowerCase() == 'international') {
                      if (widget.type.toLowerCase() == "One Way" ||
                          route.toLowerCase() == 'one way') {
                        print("fromplace:$fromData1");
                        print("city1:$city1");
                        print("globalclass:$globalclass");
                        print("_adul:$globaladult");
                        print("globalchild:$globalchild");
                        print("globalinfant:$globalinfant");
                        print("_fromcode:$_fromcode");
                        print("_tocode:$tocode");
                        print("date:$depDate");
                        print("date2:$retDate");
                        print("_cont:$globalcount");

                        getinter1waysearch_api(
                          widget.locationList1,
                          fromData1,
                          city1,
                          globalclass,
                          globaladult,
                          globalchild ?? 0,
                          globalinfant ?? "0",
                          _fromcode,
                          tocode,
                          depDate,
                          globalcount,
                          context,
                        );
                      } else if (widget.type.toLowerCase() == 'return' ||
                          route.toLowerCase() == 'return') {
                        print("fromplace:$fromData1");
                        print("city1:$city1");
                        print("globalclass:$globalclass");
                        print("_adul:$globaladult");
                        print("globalchild:$globalchild");
                        print("globalinfant:$globalinfant");
                        print("_fromcode:$_fromcode");
                        print("_tocode:$tocode");
                        print("date:$depDate");
                        print("date2:$retDate");
                        print("_cont:$globalcount");

                        getInternationalReturnSearch(
                            widget.locationList1,
                            widget.travellerCount,
                            city,
                            city1,
                            globalclass,
                            globaladult,
                            globalchild ?? 0,
                            globalinfant ?? "0",
                            _fromcode,
                            tocode,
                            retDate,
                            depDate,
                            context);
                      } else if (widget.type.toLowerCase() == 'multicity' ||
                          route.toLowerCase() == 'multicity') {
                        print("mul: ${multiRoutes.length}");
                        print(multiRoutes[0].date);
                        print(multiRoutes[1].date);
                        getinternational_multi_searchapi(
                          widget.locationList1,
                          globalclass,
                          globaladult,
                          globalchild ?? 0,
                          globalinfant ?? 0,
                          context,
                        );
                      }
                    }
                  },
                  child: _buildSearchButton(
                    widget.sWidth,
                  ),
                ),
              ],
            ),
            // Visibility(
            //   visible: route == 'Multicity' ? true : false,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 8.0, left: 80.0),
            //     child: Container(
            //       // color: Colors.white,
            //       height: 250,
            //       width: 750,
            //       child: Column(
            //         children: [
            //           Row(
            //             children: [
            //               kwidth10,
            //               kwidth10,
            //               Container(
            //                 height: 50,
            //                 width: 80,
            //                 child: Center(
            //                     child: Text(
            //                   "Trip 2",
            //                   style: GoogleFonts.rajdhani(
            //                     color: Colors.lightBlueAccent,
            //                     fontSize: 15,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 )),
            //               ),
            //               GestureDetector(
            //                 onTap: () {
            //                   showLocationDialog(context, widget.locationList1,
            //                       (LocationData value) {
            //                     setState(() {
            //                       dropdownvalue2 = value;
            //                       showTextField_2 = false;
            //                       textCity_2 = true;
            //                       adrsCity_2 = true;
            //                       city2 = value.city;
            //                       address2 = value.name;
            //                       fromData2 = value.city;
            //                       _fromcode2 = value.code;
            //                       print('city - $city2');
            //                       print('address - $address2');
            //                     });
            //                   });
            //                 },
            //                 child: _buildContainer(
            //                     'From', fromData1, widget.sWidth * 0.1),
            //               ),
            //               kwidth10,
            //               kwidth10,
            //               kwidth10,
            //               kwidth10,
            //               GestureDetector(
            //                 onTap: () {
            //                   showLocationDialog(context, widget.locationList1,
            //                       (LocationData value) {
            //                     setState(() {
            //                       dropdownvalue2 = value;
            //                       showTextField_2 = false;
            //                       textCity_2 = true;
            //                       adrsCity_2 = true;
            //                       city2 = value.city;
            //                       address2 = value.name;
            //                       fromData2 = value.city;
            //                       _fromcode2 = value.code;
            //                       print('city - $city2');
            //                       print('address - $address2');
            //                     });
            //                   });
            //                 },
            //                 child: _buildContainer(
            //                     'To', fromData1, widget.sWidth * 0.1),
            //               ),
            //               kwidth10,
            //               kwidth10,
            //               GestureDetector(
            //                 child: _buildContainer(
            //                     'Trip Date', fromData1, widget.sWidth * 0.1),
            //               ),
            //               kwidth10,
            //               kwidth10,
            //               Container(
            //                 height: 30,
            //                 width: 80,
            //                 decoration: BoxDecoration(
            //                   color: Colors.blue.shade100,
            //                   borderRadius: BorderRadius.circular(10),
            //                 ),
            //                 child: Center(
            //                     child: Text(
            //                   "Done",
            //                   style: GoogleFonts.rajdhani(
            //                     fontSize: 15,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 )),
            //               ),
            //             ],
            //           ),
            //           kheight20,
            //           // Row(
            //           //   children: [
            //           //     kwidth10,
            //           //     kwidth10,
            //           //     Container(
            //           //       height: 50,
            //           //       width: 80,
            //           //       child: Center(
            //           //           child: Text(
            //           //         "Trip 3",
            //           //         style: GoogleFonts.rajdhani(
            //           //           color: Colors.lightBlueAccent,
            //           //           fontSize: 15,
            //           //           fontWeight: FontWeight.bold,
            //           //         ),
            //           //       )),
            //           //     ),
            //           //     GestureDetector(
            //           //       onTap: () {},
            //           //       child: _buildContainer(
            //           //           'From', fromData1, widget.sWidth * 0.1),
            //           //     ),
            //           //     kwidth10,
            //           //     kwidth10,
            //           //     kwidth10,
            //           //     kwidth10,
            //           //     GestureDetector(
            //           //       onTap: () {},
            //           //       child: _buildContainer(
            //           //           'To', fromData1, widget.sWidth * 0.1),
            //           //     ),
            //           //     kwidth10,
            //           //     kwidth10,
            //           //     GestureDetector(
            //           //       onTap: () {},
            //           //       child: _buildContainer(
            //           //           'Trip Date', fromData1, widget.sWidth * 0.1),
            //           //     ),
            //           //     kwidth10,
            //           //     kwidth10,
            //           //     Container(
            //           //       height: 30,
            //           //       width: 80,
            //           //       decoration: BoxDecoration(
            //           //         color: Colors.blue.shade100,
            //           //         borderRadius: BorderRadius.circular(10),
            //           //       ),
            //           //       child: Center(
            //           //           child: Text(
            //           //         "Done",
            //           //         style: GoogleFonts.rajdhani(
            //           //           fontSize: 15,
            //           //           fontWeight: FontWeight.bold,
            //           //         ),
            //           //       )),
            //           //     ),
            //           //   ],
            //           // ),
            //           //  kheight20,
            //           // Row(
            //           //   children: [
            //           //     kwidth10,
            //           //     kwidth10,

            //           //     _buildContainer(
            //           //         'From', fromData1, widget.sWidth * 0.1),
            //           //     kwidth10,
            //           //     kwidth10,
            //           //     kwidth10,
            //           //     kwidth10,
            //           //     _buildContainer(
            //           //         'From', fromData1, widget.sWidth * 0.1),
            //           //     kwidth10,
            //           //     kwidth10,
            //           //     _buildContainer(
            //           //         'From', fromData1, widget.sWidth * 0.1),
            //           //   ],
            //           // ),
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void getType(String type) {
    if (type == 'Return') {
      setState(() {
        showreturn = true;
      });
    }
  }

  void onDropdownloactionChanged(String selectedValue) {
    route = selectedValue;
    if (selectedValue == 'Return') {
      setState(() {
        showreturn = true;
      });
    } else {
      setState(() {
        showreturn = false;
      });
    }
    printWhite("Selected value: $selectedValue");
  }

  void ontypeChanged(String selectedValue) {
    printWhite("Selected type: $selectedValue");
    routeDI = selectedValue.toLowerCase();
  }

  void onDropdownChanged(String selectedValue) {
    route = selectedValue;
    if (selectedValue == 'Return') {
      setState(() {
        showreturn = true;
        route = 'Return';
      });
    } else if (selectedValue == 'One Way') {
      setState(() {
        showreturn = false;
        route = 'One Way';
      });
    } else {
      setState(() {
        route = 'Multicity';
        showreturn = false;
      });
    }
    printWhite("Selected value: $selectedValue");
  }
}

getData(String filter) {}

Travellertext(String txt1, String txt2) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        txt1,
        style: rajdhani15W6,
      ),
      Text(
        txt2,
        style: GoogleFonts.rajdhani(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 119, 118, 118)),
      ),
      kheight3,
    ],
  );
}

void onFromDropdownChanged(LocationData selectedLocation) {
  print("Selected location: ${selectedLocation.city}");
  // Do something with the selected location here
}

void onToDropdownChanged(LocationData selectedLocation) {
  print("Selected location: ${selectedLocation.city}");
  // Do something with the selected location here
}

class ContainerWidget extends StatefulWidget {
  final String title;
  final double width;
  final TextStyle titleStyle;

  ContainerWidget({
    Key key,
    this.title,
    this.width,
    this.titleStyle,
  }) : super(key: key);

  @override
  _ContainerWidgetState createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: widget.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 20, 28, 61),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            " widget.title",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            fromPlace,
            style: TextStyle(
                color: Colors.white), // Example style, you can customize it
          ),
        ],
      ),
    );
  }

  void updateValue(String newValue) {
    setState(() {
      value = newValue;
    });
  }
}

Widget _buildContainer(String title, String value, double width) {
  return Container(
    // height: 60,
    width: width,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 20, 28, 61),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: rajdhaniblue,
        ),
        SizedBox(height: 10),
        Text(
          value,
          style: rajdhaniwhite,
        ),
        SizedBox(height: 15),
      ],
    ),
  );
}

Widget _buildSearchButton(sWidth) {
  return Container(
    height: 40,
    width: sWidth * 0.115,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 166, 175, 212),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
      child: Text(
        'SEARCH',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

class DateSelector extends StatefulWidget {
  double sWidth;
  String date;
  bool isreturn;
  DateSelector(this.sWidth, this.date, this.isreturn);
  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  String selectdDate;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.parse(widget.date);

    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
  }
  // DateTime selectedDate = DateTime.parse(formattedDate);
  // DateTime.now();

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: widget.isreturn ? DateTime.now() : DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        print("formatted date: $formattedDate");
      });
      depDate = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        width: widget.sWidth,
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 20, 28, 61),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Trip Date",
              style: rajdhaniblue,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              formattedDate,
              style: rajdhaniwhite,
            ),
          ],
        ),
      ),
    );
  }
}

class returnDateSelector extends StatefulWidget {
  double sWidth;
  String date;
  bool isreturn;
  returnDateSelector(this.sWidth, this.date, this.isreturn);
  @override
  _returnDateSelectorState createState() => _returnDateSelectorState();
}

class _returnDateSelectorState extends State<returnDateSelector> {
  String selectdDate;
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.parse(widget.date);

    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
  }
  // DateTime selectedDate = DateTime.parse(formattedDate);
  // DateTime.now();

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: widget.isreturn ? DateTime.now() : DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        print("formatted date: $formattedDate");
      });
      retDate = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        width: widget.sWidth,
        height: 80,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 20, 28, 61),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Trip Date",
              style: rajdhaniblue,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              formattedDate,
              style: rajdhaniwhite,
            ),
          ],
        ),
      ),
    );
  }
}

// --traveller class

class TravellerSelector {
  final BuildContext context;
  final Offset containerPosition;

  TravellerSelector({
    this.context,
    this.containerPosition,
  });

  void showTravellerCount() {
    TravellerClass traveller = TravellerClass(
      adult: '1',
      Children: null,
      Infants: null,
      Class: 'Economy/Premium Economy',
    );

    // Define the size and position of the overlay container
    final double containerWidth = 490;
    final double containerHeight = 300; // Adjust the height as needed
    final double containerLeft = containerPosition.dx + 740;
    final double containerTop = containerPosition.dy + 70;

    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: containerTop,
        left: containerLeft,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: containerWidth,
            height: containerHeight,
            padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
                  child: Text(
                    'ADULTS(12y +)',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                // Add widgets for selecting adults, children, infants, and travel class
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);
  }
}
