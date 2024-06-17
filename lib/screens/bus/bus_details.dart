import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trip/api_services/bus%20apis/get_cities_api.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';

import '../../api_services/bus apis/available_trip_api.dart';
import '../header.dart';
import 'bus_availableTrips.dart';

class BusDetails extends StatefulWidget {
  List<City> city;
  BusDetails({key, this.city});

  @override
  State<BusDetails> createState() => _BusDetailsState();
}

// from
City dropdownvalue;
bool showTextField = false;
bool textCity1 = true;
bool adrsCity1 = true;
String city = "Bangalore";
String state = 'Karnataka';
String from_code='3';
// to
City dropdownvalue1;
bool showTextField1 = false;
bool textCity2 = true;
bool adrsCity2 = true;
String city1 = "Chennai";
String state1 = 'Tamil Nadu';
String to_code='102';
// date
DateTime selectedDate = DateTime.now();
TextEditingController dateController = TextEditingController();
String formatted_date = DateFormat('yyyy-MM-dd').format(selectedDate);
String date;
String day;
String formatDate(DateTime date) {
  return DateFormat('dd MMM yy').format(date);
}

// api
List<AvailableTrip> trip;

class _BusDetailsState extends State<BusDetails> {
  bool showList = false;
  @override
  void initState() {
    super.initState();
    dateController.text = formatDate(DateTime.now());
     day = DateFormat('EEEE').format(DateTime.now());
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        formatted_date = DateFormat('yyyy-MM-dd').format(picked);
        log("formatted:$formatted_date");
        selectedDate = picked;
        day = DateFormat('EEEE').format(picked);
        date = DateFormat('dd MMMM yy').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: sWidth < 600
            ? AppBar(
                iconTheme: const IconThemeData(color: Colors.black, size: 40),
                backgroundColor: Color.fromARGB(255, 1, 21, 101),
                title: Text(
                  "Bus ",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              )
            : CustomAppBar(),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: sHeight * 0.45,
              width: sWidth,
              color: Colors.black,
              child: Opacity(
                opacity: 0.6,
                child: Image.network(
                  'https://images.hdqwalls.com/download/1/airplane-flying-over-beach-shore-sunset-5k-l9.jpg',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 100,
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: sHeight * 0.3,
                  width: sWidth * 0.853,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Container(
                            height:(textCity1==false||textCity2==false)? sHeight * 0.2:sHeight * 0.145,
                            width: sWidth * 0.83,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                // ---from
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
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              child: Text(
                                                'From',
                                                style: GoogleFonts.rajdhani(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                                visible: textCity1,
                                                child: SizedBox(height: 5)),
                                            Visibility(
                                              visible: textCity1,
                                              child: Text(
                                                city,
                                                style: GoogleFonts.rajdhani(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: showTextField,
                                              child: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: DropdownSearch<City>(
                                                  compareFn: (City item,
                                                      City selectedItem) {
                                                    return item == selectedItem;
                                                  },
                                                  popupProps: PopupProps.menu(
                                                    showSearchBox: true,
                                                    showSelectedItems: true,
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
                                                  items: widget.city,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      dropdownvalue = value;
                                                      showTextField = false;
                                                      textCity1 = true;
                                                      adrsCity1 = true;
                                                      city = value.name;
                                                      state = value.state;
                                                      // country1=value.
                                                      from_code = value.id;
                                                      var state_code1 =
                                                          value.stateId;
                                                      print('');
                                                      print(
                                                          'city2 - $city,code - $from_code');
                                                      print(
                                                          'state2 - $state, state id - $state_code1');
                                                    });
                                                  },
                                                  selectedItem: dropdownvalue,
                                                  itemAsString: (City city) =>
                                                      city.name,
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                                visible: adrsCity1,
                                                child: SizedBox(height: 0)),
                                            Visibility(
                                              visible: adrsCity1,
                                              child: Text(
                                                "$state" /*'DEL,Indira International Airport'*/,
                                                style: GoogleFonts.rajdhani(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                                VerticalDivider(),

                                // ----to-----
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
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Text(
                                              'To',
                                              style: GoogleFonts.rajdhani(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                              visible: textCity2,
                                              child: SizedBox(height: 5)),
                                          Visibility(
                                            visible: textCity2,
                                            child: Text(
                                              city1,
                                              style: GoogleFonts.rajdhani(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: showTextField1,
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: DropdownSearch<City>(
                                                compareFn: (City item1,
                                                        City selectedItem1) =>
                                                    item1 == selectedItem1,
                                                popupProps: PopupProps.menu(
                                                    showSearchBox: true,
                                                    showSelectedItems: true),
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
                                                items: widget.city,
                                                onChanged: (value) {
                                                  setState(() {
                                                    dropdownvalue1 = value;
                                                    showTextField1 = false;
                                                    textCity2 = true;
                                                    adrsCity2 = true;
                                                    city1 = value.name;
                                                    state1 = value.state;
                                                    to_code = value.id;
                                                    var state_code =
                                                        value.stateId;
                                                    print('');
                                                    print(
                                                        'city2 - $city1,code - $to_code');
                                                    print(
                                                        'state2 - $state1, state id - $state_code');
                                                  });
                                                },
                                                selectedItem: dropdownvalue1,
                                                itemAsString: (City city1) =>
                                                    city1.name,
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                              visible: adrsCity2,
                                              child: SizedBox(height: 0)),
                                          Visibility(
                                            visible: adrsCity2,
                                            child: Text(
                                              state1 /*'DEL,Indira International Airport'*/,
                                              style: GoogleFonts.rajdhani(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                VerticalDivider(),
                                // --------date
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectDate(context);
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      width: sWidth * 0.19,
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 20),
                                          SizedBox(width: 8),
                                          Text(
                                            'Travel Date',
                                            style: GoogleFonts.rajdhani(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Container(
                                            width: sWidth * 0.17,
                                            height: sHeight * 0.07,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              // border: Border.all(
                                              //     width: 1.0,
                                              //     color: Colors.grey)
                                            ),
                                            child: Row(
                                              children: [
                                                // SizedBox(
                                                //   width: 5,
                                                // ),
                                                // Icon(
                                                //   Icons.calendar_month,
                                                //   color: Colors.grey,
                                                //   size: 20,
                                                // ),
                                                // SizedBox(
                                                //   width: 25,
                                                // ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      date ??
                                                          dateController.text,
                                                      style:
                                                          GoogleFonts.rajdhani(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                    if (day != null)
                                                      Text(
                                                        day ?? '',
                                                        style: GoogleFonts
                                                            .rajdhani(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey,
                                                          fontSize: 15,
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: sHeight * 0.03,
                        ),
                        // Center(
                        //   child: Container(
                        //     width: sWidth * 0.079,
                        //     height: sHeight * 0.0457,
                        //     decoration: BoxDecoration(
                        //         shape: BoxShape.rectangle,
                        //         color: Color.fromARGB(255, 226, 48, 7),
                        //         borderRadius: BorderRadius.circular(15)),
                        //     child: ElevatedButton(
                        //       style: ButtonStyle(
                        //         backgroundColor:
                        //             MaterialStateProperty.all<Color>(Colors.transparent),
                        //         elevation: MaterialStateProperty.all<double>(0),
                        //         shape: MaterialStateProperty.all<OutlinedBorder>(
                        //           RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(45.0),
                        //           ),
                        //         ),
                        //       ),
                        //       onPressed: () {
                        //   if (from_code != null &&
                        //       to_code != null &&
                        //       formatted_date != null) {
                        //     print("from:$from_code");
                        //     print("to:$to_code");
                        //     print("date:$formatted_date");
                        //     getavailable_trip(from_code, to_code, formatted_date);
                        //   } else {
                        //     print("from:$from_code");
                        //     print("to:$to_code");
                        //     print("date:$formatted_date");
                        //     _checkAndProceed();
                        //   }
                        // },
                        //       child: Text(
                        //         "Search",
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 20,
                        //             fontWeight: FontWeight.w500),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ]),
                ),
              ),
            ),
            SearchCOntainer(sWidth, sHeight)
          ],
        ));
  }

  SearchCOntainer(sWidth, sHeight) {
    return Positioned(
      bottom: 75,
      left: 680,
      child: GestureDetector(
        onTap: () {
          if (from_code != null && to_code != null && formatted_date != null) {
            print("from:$from_code");
            print("to:$to_code");
            print("date:$formatted_date");
            getAvailableTrip(from_code, to_code, formatted_date);
          } else {
            print("from:$from_code");
            print("to:$to_code");
            print("date:$formatted_date");
            _checkAndProceed();
          }
        },
        child: Container(
          height: 40,
          width: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blueAccent,
                Colors.lightBlueAccent
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Center(
              child: Text(
            "SEARCH",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          )),
        ),
      ),
    );
  }

void getAvailableTrip(String fromCode, String toCode, String formattedDate) async {
  // Show loading indicator
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(), // Show a circular progress indicator
      );
    },
  );

  String res = await availableTripsAPI(fromCode, toCode, formattedDate);
  Navigator.pop(context); // Close the loading dialog

  if (res != 'failed') {
    Map<String, dynamic> data = json.decode(res);
    if (data['availableTrips'] != null) {
      List<dynamic> tripData = data['availableTrips'];
      List<AvailableTrip> tripObj =
          tripData.map((trip) => AvailableTrip.fromJson(trip)).toList();

      setState(() {
        trip = tripObj;
        log("trip:${trip.length.toString()}");
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusTripList(trip: trip),
        ),
      );
    }
  } else {
    print('Error: Failed to fetch available trips.');
    // Handle error
  }
}

  // void getavailable_trip(
  //     String from_code, String to_code, String formatted_date) async {
  //   String res = await availableTripsAPI(from_code, to_code, formatted_date);
  //   if (res != 'failed') {
  //     Map<String, dynamic> data = json.decode(res);
  //     if (data['availableTrips'] != null) {
  //       List<dynamic> tripData = data['availableTrips'];
  //       List<AvailableTrip> tripObj =
  //           tripData.map((trip) => AvailableTrip.fromJson(trip)).toList();

  //       setState(() {
  //         trip = tripObj;
  //         log("trip:${trip.length.toString()}");
  //       });
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => BusTripList(trip: trip)));
  //     }
  //   } else {
  //     print('Error: Failed to fetch available trips.');
  //   }
  // }

  void _checkAndProceed() {
    if (from_code != null && to_code != null && formatted_date != null) {
      // Proceed with the API call or any other action
      // availableTripsAPI();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill all the fields.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

Widget buildPopupMenuButton(BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (String choice) {
      // Handle dropdown item selection
    },
    itemBuilder: (BuildContext context) {
      return <PopupMenuEntry<String>>[
        buildPopupMenuItem(
          context,
          icon: Icons.person,
          label: 'My Profile',
          onTap: () {},
        ),
        buildPopupMenuItem(
          context,
          icon: Icons.luggage,
          label: 'My Trip',
          onTap: () {},
        ),
        buildPopupMenuItem(
          context,
          icon: Icons.logout,
          label: 'Logout',
          onTap: () {
            // Perform logout action
          },
        ),
      ];
    },
    // child: buildTextContainer("Hi $user_name"),
  );
}

PopupMenuItem<String> buildPopupMenuItem(BuildContext context,
    {IconData icon, String label, VoidCallback onTap}) {
  return PopupMenuItem<String>(
    value: label,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: Colors.grey,
            ),
            SizedBox(width: 5),
            Text(
              label,
              style: GoogleFonts.rajdhani(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildTextContainer(String text) {
  return Text(
    text,
    style: GoogleFonts.rajdhani(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: Colors.blue.shade800,
    ),
  );
}

Widget routeContainer(
    double sHeight, double sWidth, BuildContext context, List<City> city) {
  return Positioned(
    top: 20,
    left: 100,
    child: Container(
      height: sHeight * 0.313,
      width: sWidth * 0.853,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 50, right: 50, top: 70, bottom: 70),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.8, color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showPopupMenu(context, city);
                },
                child: buildGestureContainer(
                    sHeight, sWidth, "From", "Delhi,Delhi", "India", context),
              ),
              VerticalDivider(),
              GestureDetector(
                onTap: () {
                  ToshowPopupMenu(context, city);
                },
                child: buildGestureContainer(sHeight, sWidth, "To",
                    "Mumbai,Maharastra", "India", context),
              ),
              VerticalDivider(),
              buildSearchContainer(
                  sHeight, sWidth, "Travel Date", "9 May'24", "Thursday"),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildSearchContainer(double sHeight, double sWidth, String title,
    String subtitle1, String subtitle2) {
  return GestureDetector(
    onTap: () {
      // Handle gesture tap action
    },
    child: Container(
      height: sHeight * 0.25,
      width: sWidth * 0.15,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.rajdhani(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 5),
            Text(
              subtitle1,
              style: GoogleFonts.rajdhani(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 5),
            Text(
              subtitle2,
              style: GoogleFonts.rajdhani(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildGestureContainer(double sHeight, double sWidth, String title,
    String subtitle1, String subtitle2, BuildContext context) {
  return Container(
    height: sHeight * 0.25,
    width: sWidth * 0.3,
    color: Colors.transparent,
    child: Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.rajdhani(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 5),
          Text(
            subtitle1,
            style: GoogleFonts.rajdhani(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 5),
          Text(
            subtitle2,
            style: GoogleFonts.rajdhani(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    ),
  );
}

void ToshowPopupMenu(BuildContext context, List<City> cities) {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromLTWH(
      650,
      250,
      110, // Adjust width as needed
      110, // Adjust height as needed
    ),
    Offset.zero & overlay.size,
  );

  showMenu<String>(
    context: context,
    position: position,
    items: [
      PopupMenuItem<String>(
        value: 'search',
        child: Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  // Handle search text changes
                },
              ),
            ),
          ],
        ),
      ),
      ...cities.map((city) {
        return PopupMenuItem<String>(
          value: city.name,
          child: Row(
            children: [
              Icon(Icons.location_city),
              SizedBox(width: 8),
              Text(city.name),
            ],
          ),
        );
      }),
    ],
  );
}

void showPopupMenu(BuildContext context, List<City> city) {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  final Offset center = overlay.localToGlobal(overlay.size.center(Offset.zero));

  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromLTWH(
      180,
      250,
      110,
      110,
    ),
    Offset.zero & overlay.size,
  );

  showMenu<String>(
    context: context,
    position: position,
    items: [
      PopupMenuItem<String>(
        value: 'Option 1',
        child: Text('Option 1'),
      ),
      PopupMenuItem<String>(
        value: 'Option 2',
        child: Text('Option 2'),
      ),
      PopupMenuItem<String>(
        value: 'Option 3',
        child: Text('Option 3'),
      ),
    ],
  );
}















// routecontainer(double sHeight, double sWidth) {
//   return Positioned(
//     top: 20,
//     left: 100,
//     child: Container(
//       height: sHeight * 0.313,
//       width: sWidth * 0.853,
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding:
//             const EdgeInsets.only(top: 60.0, left: 30, right: 30, bottom: 60),
//         child: Container(
//           height: sHeight * 0.25,
//           width: sWidth * 0.4,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(width: 0.8, color: Colors.grey)),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
// PopupMenuButton<String>(
//                                   onSelected: (String choice) {
//                                     // Handle dropdown item selection
//                                   },
//                                   itemBuilder: (BuildContext context) {
//                                     return <PopupMenuEntry<String>>[
//                                       PopupMenuItem<String>(
//                                         value: 'My Profile',
//                                         child: GestureDetector(
//                                            onTap: () {
//                                                     Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ProfilePage()));
//                                            },
//                                           child: Container(
//                                               child: Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.person,
//                                                 size: 25,
//                                                 color: Colors.grey,
//                                               ),
//                                               kwidth5,
//                                               Text(
//                                                 'My Profile',
//                                                 style: GoogleFonts.rajdhani(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ],
//                                           )),
//                                         ),
                                       
//                                       ),
//                                       PopupMenuItem<String>(
//                                         value: 'My Trip',
//                                         child: GestureDetector(
//                                           onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       MyTripPage()));
//                                         },
//                                           child: Container(
//                                               child: Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.luggage,
//                                                 size: 25,
//                                                 color: Colors.grey,
//                                               ),
//                                               kwidth5,
//                                               Text(
//                                                 'My Trip',
//                                                 style: GoogleFonts.rajdhani(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ],
//                                           )),
//                                         ),
                                        
//                                       ),
//                                       PopupMenuItem<String>(
//                                         value: 'Logout',
//                                         child: GestureDetector(
//                                            onTap: () {},
//                                           child: Container(
//                                               child: Row(
//                                             children: [
//                                               Icon(
//                                                 Icons.logout,
//                                                 size: 25,
//                                                 color: Colors.grey,
//                                               ),
//                                               kwidth5,
//                                               Text(
//                                                 'Logout',
//                                                 style: GoogleFonts.rajdhani(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ],
//                                           )),
//                                         ),
                                       
//                                       ),
//                                     ];

//                 },
//                 child: Container(
//                     height: sHeight * 0.25,
//                     width: sWidth * 0.3,
//                     color: Colors.transparent,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "From",
//                             style: GoogleFonts.rajdhani(
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey,
//                                 fontSize: 15),
//                           ),
//                           kheight5,
//                           Text(
//                             "Delhi,Delhi",
//                             style: GoogleFonts.rajdhani(
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black,
//                                 fontSize: 22),
//                           ),
//                           kheight5,
//                           Text(
//                             "India",
//                             style: GoogleFonts.rajdhani(
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey,
//                                 fontSize: 15),
//                           ),
//                         ],
//                       ),
//                     )),
//               ),
//               VerticalDivider(),
//               GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   height: sHeight * 0.25,
//                   width: sWidth * 0.3,
//                   color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "To",
//                           style: GoogleFonts.rajdhani(
//                               fontWeight: FontWeight.w500,
//                               color: Colors.grey,
//                               fontSize: 15),
//                         ),
//                         kheight5,
//                         Text(
//                           "Mumbai,Maharastra",
//                           style: GoogleFonts.rajdhani(
//                               fontWeight: FontWeight.w700,
//                               color: Colors.black,
//                               fontSize: 22),
//                         ),
//                         kheight5,
//                         Text(
//                           "India",
//                           style: GoogleFonts.rajdhani(
//                               fontWeight: FontWeight.w500,
//                               color: Colors.grey,
//                               fontSize: 15),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               VerticalDivider(),
//               GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   height: sHeight * 0.25,
//                   width: sWidth * 0.15,
//                  color: Colors.white,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left:16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Travel Date",style: GoogleFonts.rajdhani(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 15),),
//                         kheight5,
//                         Text("9 May'24",style: GoogleFonts.rajdhani(fontWeight: FontWeight.w700,color: Colors.black,fontSize: 22),),
//                         kheight5,
//                         Text("Thursday",style: GoogleFonts.rajdhani(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 15),),
//                       ],
//                     ),),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Expanded(
//     child: TextFormField(
//   decoration: InputDecoration(
//       hintText: "From",
//       prefixIcon: Icon(Icons.airport_shuttle)),
// )),
//       CircleAvatar(
//           backgroundColor: Color.fromARGB(255, 248, 87, 51),
//           child: Icon(
//             Icons.swap_horiz,
//             color: Colors.white,
//           )),
//       Expanded(
//           child: TextFormField(
//         decoration: InputDecoration(
//             hintText: "To",
//             prefixIcon: Icon(Icons.airport_shuttle)),
//       )),
//       VerticalDivider(),
//       Expanded(
//           child: TextFormField(
//         decoration: InputDecoration(
//             hintText: "Date",
//             prefixIcon: Icon(Icons.calendar_month)),
//       )),
//     ],
//   ),
// ),
// SizedBox(
//   height: sHeight * 0.1,
// ),
// Container(
//   width: sWidth * 0.1,
//   height: sHeight * 0.1,
//   decoration: BoxDecoration(
//       shape: BoxShape.rectangle,
//       color: Color.fromARGB(255, 226, 48, 7),
//       borderRadius: BorderRadius.circular(15)),
//   child: ElevatedButton(
//     style: ButtonStyle(
//       backgroundColor:
//           MaterialStateProperty.all<Color>(Colors.transparent),
//       elevation: MaterialStateProperty.all<double>(0),
//       shape: MaterialStateProperty.all<OutlinedBorder>(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(45.0),
//         ),
//       ),
//     ),
//     onPressed: () {
//       // setState(() {
//       //   showList = !showList;
//       // });

//       // print("showList:$showList");
//     },
//     child: Text(
//       "Search Buses",
//       style: TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//           fontWeight: FontWeight.w500),
//     ),
//   ),
// ),
// if (showList)
// SizedBox(
//   height: sHeight * 0.13,
// ),
// if (showList)
//   Container(
//     color: Colors.green,
//     height: sHeight * 0.9,
//     width: sWidth * 0.88,
//   ),
//    if (showList)
// SizedBox(
//   height: sHeight * 0.2,
// ),
