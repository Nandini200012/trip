import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/api_services/bus%20apis/get_cities_api.dart';
import 'package:trip/constants/fonts.dart';
import 'package:trip/login_variables/login_Variables.dart';
import 'package:trip/screens/blog/blog_page.dart';
import 'package:trip/screens/bus/bus_details.dart';
import 'package:trip/screens/flight_booking_screen.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import 'package:trip/screens/profile/profile_page.dart';
import 'package:trip/screens/signIn.dart';
import '../api_services/location_list_api.dart';
import 'Home.dart';
import 'activities/activities.dart';
import 'constant.dart';
import 'holidayPackages.dart';
import 'mytrip_screen/mytrip_page.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<LocationData> locationList = [];
  List<City> cities = [];
  @override
  void initState() {
    super.initState();
    getLocationList();
    fetchcities();
  }

  getLocationList() async {
    String res = await getLocationListAPI();
    LocationObj locationObj = LocationObj.fromJson(jsonDecode(res));
    setState(() {
      locationList = locationObj.data;
      print('locationlist');
      print(locationList.length);
    });
  }

  fetchcities() async {
    String res = await getCitiesAPI();
// print("res:$res");
    CityModel cityObj = CityModel.fromJson(jsonDecode(res));
    ;
    setState(() {
      cities = cityObj.cities;
      print('cities');
      print(locationList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, bottom: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Container(
                      height: 50,
                      width: 130.0,
                      child: Image.asset(
                        'images/trip-logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: currentwidth < 992 ? 10 : 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    // FlightBooking(locationList1: locationList,)));
                                    FlightBookingPage(
                                      locationList1: locationList,
                                    )));
                      },
                      child: Text(
                        'Flights',
                        style: blackB15,
                      )),
                ),
                const SizedBox(width: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusDetails(
                              city: cities,
                            )
                            // Hotels_Page()
                            ,
                          ),
                        );
                      },
                      child: Text(
                        'Bus',
                        style: blackB15,
                      )),
                ),
                const SizedBox(width: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextButton(
                      onPressed: () {
                        log("holiday");
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HolidayBookingPage()));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Holiday_Packages(),
                          ),
                        );
                      },
                      child: Text(
                        'Holiday Package',
                        style: blackB15,
                      )),
                ),
                const SizedBox(width: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AcitivitiesPage()
                              // GiftArticle()
                              ));
                    },
                    child: Text(
                      'Activities',
                      style: blackB15,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BlogPage()
                              // GiftArticle()
                              ));
                    },
                    child: Text(
                      'Blog',
                      style: blackB15,
                    ),
                  ),
                ),
                // const SizedBox(width: 30),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 10.0),
                //   child: TextButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => TicketSelectList()
                //               // GiftArticle()
                //               ));
                //     },
                //     child: Text(
                //       'Tickets',
                //       style: blackB15,
                //     ),
                //   ),
                // ),
                // const SizedBox(width: 30),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 10.0),
                //   child: TextButton(
                //     onPressed: () {
                //       // --->new
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) =>

                //                     flightsSearchpage(
                //                       locationList1: locationList,
                //                     )));
                //     },
                //     child: Text(
                //       'new',
                //       style: blackB15,
                //     ),
                //   ),
                // ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 60.0),
                  child: Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: user_name == "" ? false : true,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 3.0),
                            child: ClipOval(
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 4, 41, 84),
                                      Color.fromARGB(255, 4, 77, 161),
                                      Color.fromARGB(255, 1, 72, 130)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            if (user_name == "") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signIn()),
                              );
                            } else {
                              // Show dropdown
                            }
                          },
                          child: user_name == ""
                              ? Center(
                                  child: Text(
                                    'LOGIN/SIGNUP',
                                    style: GoogleFonts.rajdhani(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blue.shade800,
                                    ),
                                  ),
                                )
                              : PopupMenuButton<String>(
                                  onSelected: (String choice) {
                                    // Handle dropdown item selection
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'My Profile',
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfilePage()));
                                          },
                                          child: Container(
                                              child: Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                size: 25,
                                                color: Colors.grey,
                                              ),
                                              kwidth5,
                                              Text(
                                                'My Profile',
                                                style: GoogleFonts.rajdhani(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'My Trip',
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyTripPage()));
                                          },
                                          child: Container(
                                              child: Row(
                                            children: [
                                              Icon(
                                                Icons.luggage,
                                                size: 25,
                                                color: Colors.grey,
                                              ),
                                              kwidth5,
                                              Text(
                                                'My Trip',
                                                style: GoogleFonts.rajdhani(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'Logout',
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                              child: Row(
                                            children: [
                                              Icon(
                                                Icons.logout,
                                                size: 25,
                                                color: Colors.grey,
                                              ),
                                              kwidth5,
                                              Text(
                                                'Logout',
                                                style: GoogleFonts.rajdhani(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )),
                                        ),
                                      ),
                                    ];
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Hi $user_name",
                                        style: GoogleFonts.rajdhani(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blue.shade800,
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                        ),

                        // GestureDetector(
                        //   onTap: () {
                        //     if (user_name == "") {
                        //          Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => MyTripPage()));
                        //       // Navigator.push(
                        //       //     context,
                        //       //     MaterialPageRoute(
                        //       //         builder: (context) => signIn()));
                        //     } else {
                        //  Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MyTripPage()));
                        //     }
                        //   },
                        //   child: Center(
                        //     child: Text(
                        //       user_name == ""
                        //           ? 'LOGIN/SIGNUP'
                        //           : "Hi $user_name",
                        //       style: GoogleFonts.rajdhani(
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.w700,
                        //           color: Colors.blue.shade800),
                        //     ),
                        //   ),
                        // ),

                        // Column(
                        //   children: [
                        //     TextButton(
                        //       onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => signIn()));
                        //       },
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(5.0),
                        //         child: Text(
                        //           user_name == "" ? 'LOGIN/SIGNUP' : user_name,
                        //           style: blue12,
                        //         ),
                        //       ),
                        //     ),
                        //     // Text('My Trips')
                        //   ],
                        // )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
