import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trip/common/print_funtions.dart';

import '../api_services/blog_api/get_blog_details_api.dart';
import '../api_services/bus apis/get_cities_api.dart';
import '../api_services/coupons/activity_coupon_api.dart';
import '../api_services/coupons/buscoupon_api.dart';
import '../api_services/holiday_packages/get_coupons_api.dart';
import '../api_services/location_list_api.dart';
import '../api_services/offer/offer_api.dart';
import '../api_services/promo_codes_api/show-promocodes_api.dart';
import '../constants/fonts.dart';
import 'Drawer.dart';
import 'activities/activities.dart';
import 'bus/bus_details.dart';
import 'constant.dart';
import 'flight_booking_screen.dart';
import 'flight_booking_search_screen.dart';
import 'footer.dart';
import 'header.dart';
import 'holidayPackages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// List<offerData> offerdata;
bool loader = false;

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    getoffers();
    blogdetails();
    flightCoupons();
    busCoupons();
    holidayCoupons();
    activityCoupons();
    // Set a timer to change a variable to true after 2 seconds
    Timer(Duration(seconds: 2), () {
      setState(() {
        // Update the variable here
        loader = true;
      });
    });
  }

  List<LocationData> locationList = [];
  List<City> cities = [];
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

  List<flightCoupon> _flightcoupons = [];
  flightCoupons() async {
    String res = await showPromoCodesAPI();
    print("flight coupon: $res");
    FlightCoupons data = FlightCoupons.fromJson(jsonDecode(res));
    setState(() {
      _flightcoupons = data.data;
    });
  }

  List<BusCouponCode> buscoupon = [];
  busCoupons() async {
    String res = await getBusCouponsAPI();
    print("bus coupon: $res");
    BusCoupons data = BusCoupons.fromJson(jsonDecode(res));
    setState(() {
      buscoupon = data.couponCodes;
    });
    printWhite("buscoupon $buscoupon");
  }

  List<CouponCode> holidaycoupons = [];
  holidayCoupons() async {
    String res = await holidayoffersAPI();
    print("holidayoffersAPI(): $res");
    Holidaycoupon obj = Holidaycoupon.fromJson(jsonDecode(res));
    List<CouponCode> data = obj.couponCodes;
    setState(() {
      holidaycoupons = data;
    });
  }

  List<ActivityCouponCode> activitycoupons = [];
  activityCoupons() async {
    String res = await getActivityCouponsAPI();
    print("activity coupon: $res");
    Activitycoupons obj = Activitycoupons.fromJson(jsonDecode(res));
    List<ActivityCouponCode> data = obj.couponCodes;
    setState(() {
      activitycoupons = data;
    });
  }

  List<Datum> blogdata = [];
  blogdetails() async {
    BlogObj obj = await getblog();
    List<Datum> data = obj.data;
    setState(() {
      blogdata = data;
    });
  }

  void getoffers() async {
    String res = await homeoffersAPI();
    if (res != 'failed') {
      Homeoffers obj = Homeoffers.fromJson(jsonDecode(res));
      List<offerData> data = obj.data;
      setState(() {
        // offerdata = data;
      });
      // printred("ofr:${offerdata.length}");
    }
  }

  int selectedValue = 1;
  int svalue = 1;
  bool _isExpanded = false;
  bool isStayVisible = false;
  bool isDestVisible = false;
  bool isDepartureVisible = false;
  bool isDDepartVisible = false;
  bool isDuratVisible = false;
  bool isMoreFilterVisible = false;
  bool checkVal = false;

  @override
  Widget build(BuildContext context) {
// List<Domesticonewayobj> demoneway = []; // Make sure demoneway is declared as a list
  Future<void> _simulateLoading() async {
    await Future.delayed(Duration(seconds: 2));
  }
    final currentwidth = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width;
    TabController _tabController = TabController(length: 6, vsync: this);

    return Scaffold(
      appBar: currentwidth < 600
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 40),
              backgroundColor: Colors.white,
              title: Text(
                'Tour',
                style: blackB15,
              ),
            )
          : CustomAppBar(),
      drawer: currentwidth < 700 ? drawer() : null,
      body:FutureBuilder<void>(
        future: _simulateLoading(),
        builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 700) {
                  return buildSingleChildScrollViewMobileView(
                    width,
                    _tabController,
                  );
                } else {
                  return buildSingleChildScrollViewDesktopView(
                    width,
                    _tabController,
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  //         // offerdata.length==0||offerdata==null
  //         // ? Center(child:Text(" Cming Soon"))
  //         LayoutBuilder(
  //       builder: (context, constraints) {
  //         if (constraints.maxWidth < 700) {
  //           return buildSingleChildScrollViewMobileView(
  //             width,
  //             _tabController,
  //           );
  //         } else {
  //           return buildSingleChildScrollViewDesktopView(
  //             width,
  //             _tabController,
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  SingleChildScrollView buildSingleChildScrollViewDesktopView(
      double width, TabController _tabController) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: false,
            child: Container(
              // height: sheight * 0.6 ,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              width: width,
              // color: Colors.blueAccent,
              color: Color(0xFF0d2b4d),
              child: Center(
                child: Container(
                  width: swidth / 1.1,
                  // width: 1300.0,
                  // height: sheight * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // Colors.white
                    // border: Border.all(color: Colors.grey[100]),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        selectWayRow(),
                        Visibility(
                          visible: false,
                          child: Container(
                            // padding: EdgeInsets.all(20),
                            child: Card(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(44, 40, 44, 40),
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2),
                                      color: Colors.grey.shade200,
                                    ),
                                    height: 128,
                                    child: Column(
                                      children: [
                                        Icon(Icons.beach_access),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text('STAY')
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 40, 40, 40),
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                    color: Colors.grey.shade200,
                                    height: 124,
                                    child: Column(
                                      children: [
                                        Icon(Icons.electrical_services_rounded),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text('CIRCUIT')
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 40, 40, 40),
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                    color: Colors.grey.shade200,
                                    height: 124,
                                    child: Column(
                                      children: [
                                        Icon(Icons.directions_boat),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text('CRUISE')
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 40, 40, 40),
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                    color: Colors.grey.shade200,
                                    height: 124,
                                    child: Column(
                                      children: [
                                        Icon(Icons.vpn_key_outlined),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text('LEASE')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isDestVisible,
                          child: Container(
                            // padding: EdgeInsets.fromLTRB(20, top, right, bottom),
                            child: Card(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            label: Text('Anywhere'),
                                            fillColor: Colors.grey.shade200,
                                            filled: true,
                                            border: OutlineInputBorder(
                                              // width: 0.0 produces a thin "hairline" border
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(90.0)),
                                              borderSide: BorderSide.none,
                                            ),
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0)),
                                      )),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Text(
                                      'TOP DESTINATIONS',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 20),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('France'),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 20),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('Spain'),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 20),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('Corcia'),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 20),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('Italy'),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 20),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('Portugal'),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 20),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('Greece'),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 20),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('Morocco'),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 20),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('Malta'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: isDepartureVisible,
                            child: MediaQuery.of(context).size.width > 800
                                ? Container(
                                    // padding: EdgeInsets.all(20),
                                    child: Card(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Text(
                                            'TOP AIRPORTS',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                20, 20, 0, 20),
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey),
                                                  activeColor: Colors.grey,
                                                  // checkColor: Colors.grey,
                                                  value: this.checkVal,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      this.checkVal = value;
                                                    });
                                                  },
                                                ),
                                                Text('Paris\n(All Airports)'),
                                                SizedBox(width: 30),
                                                Checkbox(
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey),
                                                  activeColor: Colors.grey,
                                                  // checkColor: Colors.grey,
                                                  value: this.checkVal,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      this.checkVal = value;
                                                    });
                                                  },
                                                ),
                                                Text('Marseilles'),
                                                SizedBox(width: 40),
                                                Checkbox(
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey),
                                                  activeColor: Colors.grey,
                                                  // checkColor: Colors.grey,
                                                  value: this.checkVal,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      this.checkVal = value;
                                                    });
                                                  },
                                                ),
                                                Text('Paris'),
                                                SizedBox(width: 45),
                                                Checkbox(
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey),
                                                  activeColor: Colors.grey,
                                                  // checkColor: Colors.grey,
                                                  value: this.checkVal,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      this.checkVal = value;
                                                    });
                                                  },
                                                ),
                                                Text('Toulouse'),
                                                SizedBox(width: 40),
                                                Checkbox(
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey),
                                                  activeColor: Colors.grey,
                                                  // checkColor: Colors.grey,
                                                  value: this.checkVal,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      this.checkVal = value;
                                                    });
                                                  },
                                                ),
                                                Text('Nantes'),
                                                SizedBox(width: 40),
                                                Checkbox(
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey),
                                                  activeColor: Colors.grey,
                                                  // checkColor: Colors.grey,
                                                  value: this.checkVal,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      this.checkVal = value;
                                                    });
                                                  },
                                                ),
                                                Text('Lyons'),
                                                SizedBox(width: 40),
                                                Checkbox(
                                                  fillColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey),
                                                  activeColor: Colors.grey,
                                                  // checkColor: Colors.grey,
                                                  value: this.checkVal,
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      this.checkVal = value;
                                                    });
                                                  },
                                                ),
                                                Text('Bordeaux'),
                                              ],
                                            )),
                                      ],
                                    )),
                                  )
                                : Container(
                                    height: 500,
                                    width: 500,
                                    color: Colors.amber,
                                  )),
                        Visibility(
                          visible: isDDepartVisible,
                          child: Container(
                            // padding: EdgeInsets.all(20),
                            child: Card(
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            'Flexibility',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 8, 10, 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.grey.shade200,
                                          ),
                                          child: Text(
                                            'Fixed',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 8, 10, 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.grey.shade200,
                                          ),
                                          child: Text(
                                            '+/-1d',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 8, 10, 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.grey.shade200,
                                          ),
                                          child: Text(
                                            '+/-3d',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 8, 10, 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.grey.shade200,
                                          ),
                                          child: Text(
                                            '+/-5d',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 8, 10, 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.grey.shade200,
                                          ),
                                          child: Text(
                                            '+/-7d',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    // height: 100,
                                    width: 300,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: TableCalendar(
                                        firstDay: DateTime.utc(2010, 10, 20),
                                        lastDay: DateTime.utc(2040, 10, 20),
                                        focusedDay: DateTime.now(),
                                        headerVisible: true,
                                        daysOfWeekVisible: true,
                                        sixWeekMonthsEnforced: true,
                                        shouldFillViewport: false,
                                        calendarFormat: CalendarFormat.month,
                                        headerStyle: HeaderStyle(
                                            titleTextStyle: TextStyle(
                                                fontSize: 10,
                                                color: Colors.deepPurple,
                                                fontWeight: FontWeight.w800)),
                                        calendarStyle: CalendarStyle(
                                            // cellMargin: EdgeInsets.fromLTRB(4, 4, 4, 4),
                                            todayTextStyle: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isDuratVisible,
                          child: Container(
                            // padding: EdgeInsets.all(20),
                            child: Card(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.fromLTRB(40, 20, 0, 20),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          fillColor: MaterialStateProperty.all(
                                              Colors.grey),
                                          // activeColor: Colors.grey,
                                          // checkColor: Colors.grey,
                                          value: this.checkVal,
                                          onChanged: (bool value) {
                                            setState(() {
                                              this.checkVal = value;
                                            });
                                          },
                                        ),
                                        Text('Shorts Stay (1 to 5 nights)'),
                                        SizedBox(width: 60),
                                        Checkbox(
                                          fillColor: MaterialStateProperty.all(
                                              Colors.grey),
                                          activeColor: Colors.grey,
                                          checkColor: Colors.grey,
                                          value: this.checkVal,
                                          onChanged: (bool value) {
                                            setState(() {
                                              this.checkVal = value;
                                            });
                                          },
                                        ),
                                        Text('1 Week(6 to 9 nights)'),
                                        SizedBox(width: 60),
                                        Checkbox(
                                          fillColor: MaterialStateProperty.all(
                                              Colors.grey),
                                          activeColor: Colors.grey,
                                          checkColor: Colors.grey,
                                          value: this.checkVal,
                                          onChanged: (bool value) {
                                            setState(() {
                                              this.checkVal = value;
                                            });
                                          },
                                        ),
                                        Text('2 Weeks(10 to 16 nights)'),
                                        SizedBox(width: 60),
                                        Checkbox(
                                          fillColor: MaterialStateProperty.all(
                                              Colors.grey),
                                          activeColor: Colors.grey,
                                          checkColor: Colors.grey,
                                          value: this.checkVal,
                                          onChanged: (bool value) {
                                            setState(() {
                                              this.checkVal = value;
                                            });
                                          },
                                        ),
                                        Text('+2 Week ()17 nightsand +'),
                                      ],
                                    )),
                              ],
                            )),
                          ),
                        ),
                        Visibility(
                          visible: isMoreFilterVisible,
                          child: Container(
                            // padding: EdgeInsets.all(20),
                            // height: 100,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Card(
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Hotel Categories',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(Icons
                                              .keyboard_arrow_down_outlined),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            // activeColor: Colors.grey,
                                            // checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('5 Stars'),
                                          SizedBox(width: 150),
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('4 Stars'),
                                          SizedBox(width: 150),
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('3 Stars'),
                                          SizedBox(width: 150),
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('2 Stars'),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Pension',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(Icons
                                              .keyboard_arrow_down_outlined),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            // activeColor: Colors.grey,
                                            // checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('Half Pension'),
                                          SizedBox(width: 150),
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('Accommodation only'),
                                          SizedBox(width: 150),
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('Full board'),
                                          SizedBox(width: 150),
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('Breakfast'),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            // activeColor: Colors.grey,
                                            // checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('According to program'),
                                          SizedBox(width: 94),
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('All-in'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: SingleChildScrollView(
                        //     scrollDirection: Axis.horizontal,
                        //     child: Container(
                        //       // width: 1250.0,
                        //       height: 130.0,
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         border: Border.all(color: Colors.grey[100]),
                        //         borderRadius: BorderRadius.circular(10.0),
                        //       ),
                        //       child: Row(
                        //         children: [
                        //           FromContainer(),
                        //           swapButton(),
                        //           SizedBox(width: 30.0),
                        //           ToContainer(),
                        //           DepartureContainer(),
                        //           returnContainer(),
                        //           TravelllerClass()
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10.0),
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         'Select A\nFare Type:',
                        //         style: grey12,
                        //       ),
                        //       SizedBox(
                        //         width: 5,
                        //       ),
                        //       Container(
                        //         // color: Colors.grey[200],
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(5.0),
                        //           child: Row(
                        //             children: [
                        //               Radio(
                        //                 value: 1,
                        //                 groupValue: svalue,
                        //                 onChanged: (int value) {
                        //                   setState(() {
                        //                     svalue = value;
                        //                   });
                        //                 },
                        //               ),
                        //               Text('Regular Fares', style: black12),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 5,
                        //       ),
                        //       Container(
                        //         // color: Colors.grey[200],
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(5.0),
                        //           child: Row(
                        //             children: [
                        //               Radio(
                        //                 value: 2,
                        //                 groupValue: svalue,
                        //                 onChanged: (int value) {
                        //                   setState(() {
                        //                     svalue = value;
                        //                   });
                        //                 },
                        //               ),
                        //               Text('Student Fares', style: black12),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 5,
                        //       ),
                        //       Container(
                        //         // color: Colors.grey[200],
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(5.0),
                        //           child: Row(
                        //             children: [
                        //               Radio(
                        //                 value: 3,
                        //                 groupValue: svalue,
                        //                 onChanged: (int value) {
                        //                   setState(() {
                        //                     svalue = value;
                        //                   });
                        //                 },
                        //               ),
                        //               Text('Senior Fares', style: black12),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       Spacer(),
                        //       searchButton()
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 65.0, right: 65.0),
            child: Container(
              height:sheight*0.25,
              width:swidth*0.23,
              color:Colors.blue,
            )
          ),
          //----------------offers-----------//
          Padding(
            padding: const EdgeInsets.only(left: 65.0, right: 65.0),
            child: offersTabBar(_tabController),
          ),
          SizedBox(height: 20.0),
          whatsNewContainer(width),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 80.0, right: 80.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 250.0,
                width: width,
                child: Card(
                    elevation: 10.0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Download The App !', style: black30),
                                  // SizedBox(height: 10.0),
                                  Text('Get India\'s 1 travel super app.',
                                      style: grey20),
                                  SizedBox(height: 20.0),
                                  Expanded(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 100.0,
                                              height: 100.0,
                                              child: Image.asset(
                                                  'images/downloadapp.png',
                                                  fit: BoxFit.fill)),
                                          SizedBox(width: 10.0),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Use code WELCOME and get upto Rs 500 off.',
                                                    style: black15),
                                                SizedBox(height: 10.0),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        5)),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Text('+91',
                                                                style:
                                                                    blackB20),
                                                          ),
                                                          Container(
                                                            width: swidth / 6,
                                                            child: TextField(
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors
                                                                .blueAccent,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                          5)),
                                                        ),
                                                        width: 100.0,
                                                        child: TextButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                              'Get App Link',
                                                              style: blue15),
                                                        )),
                                                  ],
                                                )
                                              ])
                                        ]),
                                  )
                                ]),
                            SizedBox(width: 100.0),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text('MORE WAYS TO GET THE APP',
                                        style: blackB15),
                                    Row(children: [
                                      Column(children: [
                                        Container(
                                            height: 50.0,
                                            width: swidth / 9,
                                            child: Image.asset(
                                                'images/googlePlayStore.png',
                                                fit: BoxFit.fill)),
                                        SizedBox(height: 10.0),
                                        Container(
                                            height: 50.0,
                                            width: swidth / 9,
                                            child: Image.asset(
                                                'images/applePlayStore.png',
                                                fit: BoxFit.fill)),
                                      ]),
                                      SizedBox(width: 50.0),
                                      Container(
                                          height: 150.0,
                                          width: 150.0,
                                          child: Image.asset('images/qr.png',
                                              fit: BoxFit.fill)),
                                    ])
                                  ])),
                            )
                          ]),
                    )),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          buildFooter(),
        ],
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollViewMobileView(
      double width, TabController _tabController) {
    return SingleChildScrollView(
      child: Column(
        children: [
          selectWayRowdrawer(),
          // selectWayRowdrawer1(),
          selectWayRowMobile(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Visibility(
                  visible: isStayVisible,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cards("STAY", Icons.beach_access),
                      cards('CIRCUIT', Icons.electrical_services_rounded),
                      cards('CRUISE', Icons.directions_boat),
                      cards('LEASE', Icons.vpn_key_outlined),
                    ],
                  ),
                ),
                // Visibility(
                //   visible: isDepartureVisible,
                //   child: Card(
                //       child: Container(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                //           child: Text(
                //             'TOP AIRPORTS',
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //         Container(
                //             margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
                //             child: Row(
                //               children: [
                //                 Checkbox(
                //                   fillColor:
                //                       MaterialStateProperty.all(Colors.grey),
                //                   activeColor: Colors.grey,
                //                   // checkColor: Colors.grey,
                //                   value: this.checkVal,
                //                   onChanged: (bool value) {
                //                     setState(() {
                //                       this.checkVal = value;
                //                     });
                //                   },
                //                 ),
                //                 Text('Paris\n(All Airports)'),
                //                 SizedBox(width: 30),
                //                 Checkbox(
                //                   fillColor:
                //                       MaterialStateProperty.all(Colors.grey),
                //                   activeColor: Colors.grey,
                //                   // checkColor: Colors.grey,
                //                   value: this.checkVal,
                //                   onChanged: (bool value) {
                //                     setState(() {
                //                       this.checkVal = value;
                //                     });
                //                   },
                //                 ),
                //                 Text('Marseilles'),
                //                 SizedBox(width: 40),
                //                 Checkbox(
                //                   fillColor:
                //                       MaterialStateProperty.all(Colors.grey),
                //                   activeColor: Colors.grey,
                //                   // checkColor: Colors.grey,
                //                   value: this.checkVal,
                //                   onChanged: (bool value) {
                //                     setState(() {
                //                       this.checkVal = value;
                //                     });
                //                   },
                //                 ),
                //                 Text('Paris'),
                //                 SizedBox(width: 40),
                //                 Checkbox(
                //                   fillColor:
                //                       MaterialStateProperty.all(Colors.grey),
                //                   activeColor: Colors.grey,
                //                   // checkColor: Colors.grey,
                //                   value: this.checkVal,
                //                   onChanged: (bool value) {
                //                     setState(() {
                //                       this.checkVal = value;
                //                     });
                //                   },
                //                 ),
                //                 Text('Toulouse'),
                //                 SizedBox(width: 40),
                //                 Checkbox(
                //                   fillColor:
                //                       MaterialStateProperty.all(Colors.grey),
                //                   activeColor: Colors.grey,
                //                   // checkColor: Colors.grey,
                //                   value: this.checkVal,
                //                   onChanged: (bool value) {
                //                     setState(() {
                //                       this.checkVal = value;
                //                     });
                //                   },
                //                 ),
                //                 Text('Nantes'),
                //                 SizedBox(width: 40),
                //                 Checkbox(
                //                   fillColor:
                //                       MaterialStateProperty.all(Colors.grey),
                //                   activeColor: Colors.grey,
                //                   // checkColor: Colors.grey,
                //                   value: this.checkVal,
                //                   onChanged: (bool value) {
                //                     setState(() {
                //                       this.checkVal = value;
                //                     });
                //                   },
                //                 ),
                //                 Text('Lyons'),
                //                 SizedBox(width: 40),
                //                 Checkbox(
                //                   fillColor:
                //                       MaterialStateProperty.all(Colors.grey),
                //                   activeColor: Colors.grey,
                //                   // checkColor: Colors.grey,
                //                   value: this.checkVal,
                //                   onChanged: (bool value) {
                //                     setState(() {
                //                       this.checkVal = value;
                //                     });
                //                   },
                //                 ),
                //                 Text('Bordeaux'),
                //               ],
                //             )),
                //       ],
                //     ),
                //   )),
                // ),
                Row(
                  children: [
                    Visibility(
                        visible: isDestVisible,
                        child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.45,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: TextField(
                                  decoration: InputDecoration(
                                      label: Text('Anywhere'),
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        // width: 0.0 produces a thin "hairline" border
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0)),
                                ),
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Text(
                                  'TOP DESTINATIONS',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    places('France'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    places('Spain'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    places('Corcia'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    places('Italy'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    places('Portugal'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    places('Greece'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    places('Morocco'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    places('Maltas'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                    Visibility(
                      visible: isDepartureVisible,
                      child: MediaQuery.of(context).size.width < 600
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'TOP AIRPORTS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            // checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('Paris\n(All Airports)'),
                                          SizedBox(width: 45),
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            // checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('Marseiles'),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            // checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('Paris'),
                                          SizedBox(width: 92),
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            // checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('Toulouse'),
                                          // SizedBox(
                                          //   width: 26.3,
                                          // ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            // checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('Nantes'),
                                          SizedBox(width: 78),
                                          Checkbox(
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            activeColor: Colors.grey,
                                            // checkColor: Colors.grey,
                                            value: this.checkVal,
                                            onChanged: (bool value) {
                                              setState(() {
                                                this.checkVal = value;
                                              });
                                            },
                                          ),
                                          Text('Lyons'),
                                        ]),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // SizedBox(
                                        //   width: 27.5,
                                        // ),
                                        Checkbox(
                                          fillColor: MaterialStateProperty.all(
                                              Colors.grey),
                                          activeColor: Colors.grey,
                                          // checkColor: Colors.grey,
                                          value: this.checkVal,
                                          onChanged: (bool value) {
                                            setState(() {
                                              this.checkVal = value;
                                            });
                                          },
                                        ),
                                        Text('Bordeaux'),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(), // Empty container only for smaller screens
                    )

                    // color: Colors.amber,
                    // padding: EdgeInsets.all(20),
                    // child: Card(
                    //     child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Container(
                    //       margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    //       child: Text(
                    //         'TOP AIRPORTS',
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //     Container(
                    //         margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
                    //         child: Row(
                    //           children: [
                    //             Checkbox(
                    //               fillColor: MaterialStateProperty.all(
                    //                   Colors.grey),
                    //               activeColor: Colors.grey,
                    //               // checkColor: Colors.grey,
                    //               value: this.checkVal,
                    //               onChanged: (bool value) {
                    //                 setState(() {
                    //                   this.checkVal = value;
                    //                 });
                    //               },
                    //             ),
                    //             Text('Paris\n(All Airports)'),
                    //             SizedBox(width: 30),
                    //             Checkbox(
                    //               fillColor: MaterialStateProperty.all(
                    //                   Colors.grey),
                    //               activeColor: Colors.grey,
                    //               // checkColor: Colors.grey,
                    //               value: this.checkVal,
                    //               onChanged: (bool value) {
                    //                 setState(() {
                    //                   this.checkVal = value;
                    //                 });
                    //               },
                    //             ),
                    //             Text('Marseilles'),
                    //             SizedBox(width: 40),
                    //             Checkbox(
                    //               fillColor: MaterialStateProperty.all(
                    //                   Colors.grey),
                    //               activeColor: Colors.grey,
                    //               // checkColor: Colors.grey,
                    //               value: this.checkVal,
                    //               onChanged: (bool value) {
                    //                 setState(() {
                    //                   this.checkVal = value;
                    //                 });
                    //               },
                    //             ),
                    //             Text('Paris'),
                    //             SizedBox(width: 40),
                    //             Checkbox(
                    //               fillColor: MaterialStateProperty.all(
                    //                   Colors.grey),
                    //               activeColor: Colors.grey,
                    //               // checkColor: Colors.grey,
                    //               value: this.checkVal,
                    //               onChanged: (bool value) {
                    //                 setState(() {
                    //                   this.checkVal = value;
                    //                 });
                    //               },
                    //             ),
                    //             Text('Toulouse'),
                    //             SizedBox(width: 40),
                    //             Checkbox(
                    //               fillColor: MaterialStateProperty.all(
                    //                   Colors.grey),
                    //               activeColor: Colors.grey,
                    //               // checkColor: Colors.grey,
                    //               value: this.checkVal,
                    //               onChanged: (bool value) {
                    //                 setState(() {
                    //                   this.checkVal = value;
                    //                 });
                    //               },
                    //             ),
                    //             Text('Nantes'),
                    //             SizedBox(width: 40),
                    //             Checkbox(
                    //               fillColor: MaterialStateProperty.all(
                    //                   Colors.grey),
                    //               activeColor: Colors.grey,
                    //               // checkColor: Colors.grey,
                    //               value: this.checkVal,
                    //               onChanged: (bool value) {
                    //                 setState(() {
                    //                   this.checkVal = value;
                    //                 });
                    //               },
                    //             ),
                    //             Text('Lyons'),
                    //             SizedBox(width: 40),
                    //             Checkbox(
                    //               fillColor: MaterialStateProperty.all(
                    //                   Colors.grey),
                    //               activeColor: Colors.grey,
                    //               // checkColor: Colors.grey,
                    //               value: this.checkVal,
                    //               onChanged: (bool value) {
                    //                 setState(() {
                    //                   this.checkVal = value;
                    //                 });
                    //               },
                    //             ),
                    //             Text('Bordeaux'),
                    //           ],
                    //         )),
                    //   ],
                    // )),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          selectWayRowMobile1(),
          Row(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Visibility(
                  visible: isDDepartVisible,
                  child: Container(
                      child: SizedBox(
                    // height: 100,
                    width: 300,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 20),
                        lastDay: DateTime.utc(2040, 10, 20),
                        focusedDay: DateTime.now(),
                        headerVisible: true,
                        daysOfWeekVisible: true,
                        sixWeekMonthsEnforced: true,
                        shouldFillViewport: false,
                        calendarFormat: CalendarFormat.month,
                        headerStyle: HeaderStyle(
                            titleTextStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w800)),
                        calendarStyle: CalendarStyle(
                            // cellMargin: EdgeInsets.fromLTRB(4, 4, 4, 4),
                            todayTextStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  )),
                ),
              ),
              Visibility(
                visible: isDuratVisible,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.36,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Card(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              fillColor: MaterialStateProperty.all(Colors.grey),
                              value: this.checkVal,
                              onChanged: (bool value) {
                                setState(() {
                                  this.checkVal = value;
                                });
                              },
                            ),
                            Text('Shorts Stay (1 to 5 nights)'),
                            // SizedBox(width: 60),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              fillColor: MaterialStateProperty.all(Colors.grey),
                              activeColor: Colors.grey,
                              checkColor: Colors.grey,
                              value: this.checkVal,
                              onChanged: (bool value) {
                                setState(() {
                                  this.checkVal = value;
                                });
                              },
                            ),
                            Text('1 Week(6 to 9 nights)'),
                            // SizedBox(width: 60),

                            // SizedBox(width: 60),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              fillColor: MaterialStateProperty.all(Colors.grey),
                              activeColor: Colors.grey,
                              checkColor: Colors.grey,
                              value: this.checkVal,
                              onChanged: (bool value) {
                                setState(() {
                                  this.checkVal = value;
                                });
                              },
                            ),
                            Text('2 Weeks(10 to 16 nights)'),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                fillColor:
                                    MaterialStateProperty.all(Colors.grey),
                                activeColor: Colors.grey,
                                checkColor: Colors.grey,
                                value: this.checkVal,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkVal = value;
                                  });
                                },
                              ),
                              Text('+2 Week ()17 nightsand +'),
                            ])
                      ],
                    )),
                  ),
                ),
              ),
              Visibility(
                visible: isMoreFilterVisible,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.43,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(75, 10, 0, 0),
                          child: Row(
                            children: [
                              Center(
                                child: Text(
                                  'Hotel Categories',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_outlined),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                fillColor:
                                    MaterialStateProperty.all(Colors.grey),
                                // activeColor: Colors.grey,
                                // checkColor: Colors.grey,
                                value: this.checkVal,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkVal = value;
                                  });
                                },
                              ),
                              Text('5 Stars'),
                              SizedBox(width: 50),
                              Checkbox(
                                fillColor:
                                    MaterialStateProperty.all(Colors.grey),
                                activeColor: Colors.grey,
                                checkColor: Colors.grey,
                                value: this.checkVal,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkVal = value;
                                  });
                                },
                              ),
                              Text('4 Stars'),
                              // SizedBox(width: 10),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Checkbox(
                                fillColor:
                                    MaterialStateProperty.all(Colors.grey),
                                activeColor: Colors.grey,
                                checkColor: Colors.grey,
                                value: this.checkVal,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkVal = value;
                                  });
                                },
                              ),
                              Text('3 Stars'),
                              SizedBox(width: 50),
                              Checkbox(
                                fillColor:
                                    MaterialStateProperty.all(Colors.grey),
                                activeColor: Colors.grey,
                                checkColor: Colors.grey,
                                value: this.checkVal,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.checkVal = value;
                                  });
                                },
                              ),
                              Text('2 Stars'),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(75, 10, 0, 5),
                          child: Row(
                            children: [
                              Text(
                                'Pension',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.keyboard_arrow_down_outlined),
                            ],
                          ),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              fillColor: MaterialStateProperty.all(Colors.grey),
                              // activeColor: Colors.grey,
                              // checkColor: Colors.grey,
                              value: this.checkVal,
                              onChanged: (bool value) {
                                setState(() {
                                  this.checkVal = value;
                                });
                              },
                            ),
                            Text('Half Pension'),
                            // SizedBox(width: 10),
                            Checkbox(
                              fillColor: MaterialStateProperty.all(Colors.grey),
                              activeColor: Colors.grey,
                              checkColor: Colors.grey,
                              value: this.checkVal,
                              onChanged: (bool value) {
                                setState(() {
                                  this.checkVal = value;
                                });
                              },
                            ),
                            Text('Accommodation only'),
                            // SizedBox(width: 10),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              fillColor: MaterialStateProperty.all(Colors.grey),
                              activeColor: Colors.grey,
                              checkColor: Colors.grey,
                              value: this.checkVal,
                              onChanged: (bool value) {
                                setState(() {
                                  this.checkVal = value;
                                });
                              },
                            ),
                            Text('Full board'),
                            SizedBox(width: 17.5),
                            Checkbox(
                              fillColor: MaterialStateProperty.all(Colors.grey),
                              activeColor: Colors.grey,
                              checkColor: Colors.grey,
                              value: this.checkVal,
                              onChanged: (bool value) {
                                setState(() {
                                  this.checkVal = value;
                                });
                              },
                            ),
                            Text('Breakfast'),
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              fillColor: MaterialStateProperty.all(Colors.grey),
                              // activeColor: Colors.grey,
                              // checkColor: Colors.grey,
                              value: this.checkVal,
                              onChanged: (bool value) {
                                setState(() {
                                  this.checkVal = value;
                                });
                              },
                            ),
                            Text('According to program'),
                            SizedBox(width: 10),
                            Checkbox(
                              fillColor: MaterialStateProperty.all(Colors.grey),
                              activeColor: Colors.grey,
                              checkColor: Colors.grey,
                              value: this.checkVal,
                              onChanged: (bool value) {
                                setState(() {
                                  this.checkVal = value;
                                });
                              },
                            ),
                            Text('All-in'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          selectWayRowMobilesearch(),
          // Container(
          //   color: Color(0xFF0d2b4d),
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     // child: Card(
          //     //   elevation: 10,
          //     //   child: Column(
          //     //     crossAxisAlignment: CrossAxisAlignment.start,
          //     //     children: [
          //     //       // Row(
          //     //       //   children: [
          //     //       //     Expanded(child: FromContainer()),
          //     //       //     Expanded(child: swapButton()),
          //     //       //     Expanded(child: ToContainer()),
          //     //       //   ],
          //     //       // ),
          //     //       // Divider(),
          //     //       // Row(
          //     //       //   children: [
          //     //       //     Expanded(child: DepartureContainer()),
          //     //       //     Expanded(child: returnContainer()),
          //     //       //   ],
          //     //       // ),
          //     //       // Divider(),
          //     //       // TravelllerClass(),
          //     //       // Padding(
          //     //       //   padding: const EdgeInsets.all(10.0),
          //     //       //   child: Center(child: searchButton()),
          //     //       // ),
          //     //       // SizedBox(height: 20.0),
          //     //     ],
          //     //   ),
          //     // ),
          //   ),
          // ),
          Container(
            width: width,
            height: 350.0,
            decoration: BoxDecoration(
              color: Colors.white,
              //border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Offers',
                          style: black30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 10),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1, color: Colors.grey[200],
                                        //style: BorderStyle.solid
                                      ),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios_outlined,
                                      color: Colors.blue,
                                      size: 15,
                                    ),
                                    onPressed: () {},
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1, color: Colors.grey[200],
                                      //style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.blue,
                                    size: 15,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TabBar(
                      // indicator: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(15.0),
                      //   // border: Border.all(color: Colors.black),
                      // ),
                      indicatorColor: Colors.blueAccent,
                      labelColor: Color(0xFF0d2b4d),
                      unselectedLabelColor: Colors.black,
                      controller: _tabController,
                      isScrollable: true,
                      tabs: [
                        Container(
                            // width: 90.0,
                            decoration: BoxDecoration(

                                // color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Tab(
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Text('All _Offers', style: blackB15)))),
                        Container(
                            // width: 90.0,
                            decoration: BoxDecoration(
                                //color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Tab(
                                child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Text('Bank Offers', style: blackB15)))),
                        Container(
                            // width: 90.0,
                            decoration: BoxDecoration(
                                // color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Tab(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Flights', style: blackB15)))),
                        Container(
                            // width: 90.0,
                            decoration: BoxDecoration(
                                // color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Tab(
                                child: Align(
                                    alignment: Alignment.center,
                                    // Hotel
                                    child:
                                        Text('Bus Booking', style: blackB15)))),
                        Container(
                            // width: 90.0,
                            decoration: BoxDecoration(
                                // color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Tab(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Holidays', style: blackB15)))),
                        Container(
                            // width: 90.0,
                            decoration: BoxDecoration(
                                // color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Tab(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Activity', style: blackB15)))),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        // color: Colors.grey,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            //<--------------------------------------------------->//
                            Container(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  // FlightBookingPage(),

                                  offerMethod(),
                                  offerMethod(),
                                ],
                              ),
                            )),
                            //<------------------------------------------------->//
                            Container(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  offerMethod(),
                                  offerMethod(),
                                ],
                              ),
                            )),
                            //<---------------------------------------------------------->//
                            Container(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  offerMethod(),
                                  offerMethod(),
                                ],
                              ),
                            )),
                            //<--------------------------------------------------->//
                            Container(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  offerMethod(),
                                  offerMethod(),
                                ],
                              ),
                            )),
                            //<--------------------------------------------------->//
                            Container(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  offerMethod(),
                                  offerMethod(),
                                ],
                              ),
                            )),
                            //<---------------------------------------------------------->//
                            Container(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  offerMethod(),
                                  offerMethod(),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          whatsNewContainer(width),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Container offersTabBar(TabController _tabController) {
    return Container(
      // width: 1300,
      height: 600.0,
      decoration: BoxDecoration(
        color: Colors.white,
        //border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Card(
        elevation: 20.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Offers',
                    style: black30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10),
                    child: Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1, color: Colors.grey[200],
                                  //style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20))),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Colors.blue,
                                size: 15,
                              ),
                              onPressed: () {},
                            )),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1, color: Colors.grey[200],
                                //style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                              size: 15,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              TabBar(
                // indicator: BoxDecoration(
                //   borderRadius: BorderRadius.circular(15.0),
                //   // border: Border.all(color: Colors.black),
                // ),
                indicatorColor: Colors.blueAccent,
                labelColor: Color(0xFF0d2b4d),
                unselectedLabelColor: Colors.black,
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  // Container(
                  //     // width: 90.0,
                  //     decoration: BoxDecoration(

                  //         // color: kPrimaryColor,
                  //         borderRadius: BorderRadius.circular(10.0)),
                  //     child: Tab(
                  //         child: Align(
                  //             alignment: Alignment.center,
                  //             child: Text('All Offers', style: blackB15)))),
                  // Container(
                  //     // width: 90.0,
                  //     decoration: BoxDecoration(
                  //         //color: kPrimaryColor,
                  //         borderRadius: BorderRadius.circular(10.0)),
                  //     child: Tab(
                  //         child: Align(
                  //             alignment: Alignment.center,
                  //             child: Text('Bank Offers', style: blackB15)))),
                  Container(
                      // width: 90.0,
                      decoration: BoxDecoration(
                          // color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Tab(
                          child: GestureDetector(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Flights', style: blackB15)),
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => FlightBookingPage()));
                        // },
                      ))),
                  Container(
                      // width: 90.0,
                      decoration: BoxDecoration(
                          // color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Tab(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Bus Booking', style: blackB15)))),
                  Container(
                      // width: 90.0,
                      decoration: BoxDecoration(
                          // color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Tab(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Holidays', style: blackB15)))),
                  Container(
                      // width: 90.0,
                      decoration: BoxDecoration(
                          // color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Tab(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Activity', style: blackB15)))),
                ],
              ),
              Expanded(
                child: Container(
                  // color: Colors.grey,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      //<--------------------------------------------------->//
                      // GridView.builder(
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 3,
                      //     mainAxisSpacing: 10.0,
                      //     crossAxisSpacing: 10.0,
                      //     childAspectRatio: 0.5 / 0.2,
                      //   ),
                      //   itemBuilder: (context, index) {
                      //     var flightcoupondata = _flightcoupons[index];
                      //     return Card(
                      //       elevation: 5.0,
                      //       child: Container(
                      //         color: Colors.white,
                      //         child: Row(
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.all(3.0),
                      //               child: Container(
                      //                   width: 120.0,
                      //                   height: 80.0,
                      //                   child: Image.network(
                      //                     'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=170667a&w=0&k=20&c=Q7gLG-xfScdlTlPGFohllqpNqpxsU1jy8feD_fob87U=',
                      //                     fit: BoxFit.fill,
                      //                   )),
                      //             ),
                      //             SizedBox(width: 20.0),
                      //             Expanded(
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(10.0),
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text('Flight coupons', style: grey12),
                      //                     SizedBox(height: 10.0),
                      //                     Text(
                      //                       " ${flightcoupondata.title}" ??
                      //                           'Irresistible Tueday Temptation:',
                      //                       style: blackB20,
                      //                     ),
                      //                     SizedBox(height: 10.0),
                      //                     Text(
                      //                       " ${flightcoupondata.discount}% discount" ??
                      //                           'Irresistible Tueday Temptation:',
                      //                       style: blackB15,
                      //                     ),
                      //                     SizedBox(height: 10.0),
                      //                     Text(
                      //                         " ${flightcoupondata.description}" ??
                      //                             "On top-rated hotels & homestays in India,for your dreamy break",
                      //                         style: grey12),
                      //                     SizedBox(height: 10.0),
                      //                     Container(
                      //                         width: 150.0,
                      //                         decoration: BoxDecoration(
                      //                           color: Color(0xFF0d2b4d),
                      //                           // border: Border.all(color: Colors.grey),
                      //                           borderRadius:
                      //                               BorderRadius.circular(15.0),
                      //                         ),
                      //                         child: TextButton(
                      //                             onPressed: () {},
                      //                             child: Padding(
                      //                               padding:
                      //                                   const EdgeInsets.all(
                      //                                       5.0),
                      //                               child: Text(
                      //                                 'BOOK NOW',
                      //                                 style: white15,
                      //                               ),
                      //                             )))
                      //                   ],
                      //                 ),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      //   itemCount: _flightcoupons
                      //       .length, // Total number of items in the grid
                      // ),
                      // Container(
                      //     child: SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           coupons(),
                      //           offerMethod(),
                      //         ],
                      //       ),
                      //       SizedBox(width: 10.0),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           offerMethod(),
                      //           offerMethod(),
                      //         ],
                      //       ),
                      //       SizedBox(width: 10.0),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           offerMethod(),
                      //           offerMethod(),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // )),
                      //<------------------------------------------------->//
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 0.5 / 0.2,
                        ),
                        itemBuilder: (context, index) {
                          var flightcoupondata = _flightcoupons[index];
                          return Card(
                            elevation: 5.0,
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                        width: 120.0,
                                        height: 80.0,
                                        child: Image.network(
                                          "${flightcoupondata.image}" ??
                                              'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=170667a&w=0&k=20&c=Q7gLG-xfScdlTlPGFohllqpNqpxsU1jy8feD_fob87U=',
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  SizedBox(width: 20.0),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Flight coupons', style: grey12),
                                          SizedBox(height: 10.0),
                                          Text(
                                            " ${flightcoupondata.title}" ??
                                                'Irresistible Tueday Temptation:',
                                            style: blackB20,
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            " ${flightcoupondata.discount}% discount" ??
                                                'Irresistible Tueday Temptation:',
                                            style: blackB15,
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                              " ${flightcoupondata.description}" ??
                                                  "On top-rated hotels & homestays in India,for your dreamy break",
                                              style: grey12),
                                          SizedBox(height: 10.0),
                                          Container(
                                              width: 150.0,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF0d2b4d),
                                                // border: Border.all(color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                // FlightBooking(locationList1: locationList,)));
                                                                FlightBookingPage(
                                                                  locationList1:
                                                                      locationList,
                                                                )));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      'BOOK NOW',
                                                      style: white15,
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: _flightcoupons
                            .length, // Total number of items in the grid
                      ),
                      //<---------------------------------------------------------->//
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 0.5 / 0.2,
                        ),
                        itemBuilder: (context, index) {
                          var buscoupondata = buscoupon[index];
                          return Card(
                            elevation: 5.0,
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                        width: 120.0,
                                        height: 80.0,
                                        child: Image.network(
                                          "${buscoupondata.image}" ??
                                              'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=170667a&w=0&k=20&c=Q7gLG-xfScdlTlPGFohllqpNqpxsU1jy8feD_fob87U=',
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  SizedBox(width: 20.0),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Bus coupons', style: grey12),
                                          SizedBox(height: 10.0),
                                          Text(
                                            " ${buscoupondata.title}" ??
                                                'Irresistible Tueday Temptation:',
                                            style: blackB20,
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            " ${buscoupondata.discount} discount" ??
                                                'Irresistible Tueday Temptation:',
                                            style: blackB15,
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                              " ${buscoupondata.description}" ??
                                                  "On top-rated hotels & homestays in India,for your dreamy break",
                                              style: grey12),
                                          SizedBox(height: 10.0),
                                          Container(
                                              width: 150.0,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF0d2b4d),
                                                // border: Border.all(color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            BusDetails(
                                                          city: cities,
                                                        )
                                                        // Hotels_Page()
                                                        ,
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      'BOOK NOW',
                                                      style: white15,
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: buscoupon
                            .length, // Total number of items in the grid
                      ),
                      //<--------------------------------------------------->//
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 0.5 / 0.2,
                        ),
                        itemBuilder: (context, index) {
                          var holidaycoupondata = holidaycoupons[index];
                          return Card(
                            elevation: 5.0,
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                        width: 120.0,
                                        height: 80.0,
                                        child: Image.network(
                                          "${holidaycoupondata.image}" ??
                                              'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=170667a&w=0&k=20&c=Q7gLG-xfScdlTlPGFohllqpNqpxsU1jy8feD_fob87U=',
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  SizedBox(width: 20.0),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Holiday Packages coupons',
                                              style: grey12),
                                          SizedBox(height: 10.0),
                                          Text(
                                            " ${holidaycoupondata.title}" ??
                                                'Irresistible Tueday Temptation:',
                                            style: blackB20,
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            " ${holidaycoupondata.discount} discount" ??
                                                'Irresistible Tueday Temptation:',
                                            style: blackB15,
                                          ),
                                          SizedBox(height: 10.0),
                                          // Text(
                                          //     " ${holidaycoupondata.description}" ??
                                          //         "On top-rated hotels & homestays in India,for your dreamy break",
                                          //     style: grey12),
                                          // SizedBox(height: 10.0),
                                          Container(
                                              width: 150.0,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF0d2b4d),
                                                // border: Border.all(color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Holiday_Packages(),
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      'BOOK NOW',
                                                      style: white15,
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: holidaycoupons
                            .length, // Total number of items in the grid
                      ),
                      //<--------------------------------------------------->//
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 0.5 / 0.2,
                        ),
                        itemBuilder: (context, index) {
                          var coupondata = activitycoupons[index];
                          return Card(
                            elevation: 5.0,
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                        width: 120.0,
                                        height: 80.0,
                                        child: Image.network(
                                          "${coupondata.image}" ??
                                              'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=170667a&w=0&k=20&c=Q7gLG-xfScdlTlPGFohllqpNqpxsU1jy8feD_fob87U=',
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  SizedBox(width: 20.0),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Activity coupons',
                                              style: grey12),
                                          SizedBox(height: 5.0),
                                          Text(
                                            " ${coupondata.title}" ??
                                                'Irresistible Tueday Temptation:',
                                            style: blackB20,
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            " ${coupondata.discount} discount" ??
                                                'Irresistible Tueday Temptation:',
                                            style: blackB15,
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                              " ${coupondata.description}" ??
                                                  "On top-rated hotels & homestays in India,for your dreamy break",
                                              style: grey12),
                                          // SizedBox(height: 10.0),
                                          Container(
                                              width: 150.0,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF0d2b4d),
                                                // border: Border.all(color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AcitivitiesPage()
                                                            // GiftArticle()
                                                            ));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      'BOOK NOW',
                                                      style: white15,
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: activitycoupons
                            .length, // Total number of items in the grid
                      ),
                      //<---------------------------------------------------------->//
                      // Container(
                      //     child: SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Center(child: offerMethod()),
                      //           Center(child: offerMethod()),
                      //         ],
                      //       ),
                      //       SizedBox(width: 10.0),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Center(child: offerMethod()),
                      //           Center(child: offerMethod()),
                      //         ],
                      //       ),
                      //       SizedBox(width: 10.0),
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Center(child: offerMethod()),
                      //           Center(child: offerMethod()),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container coupons() {
    return Container(
      height: 150,
      width: 500,
      color: Colors.red,
      child: Column(),
    );
  }

  Container offerMethod() {
    return Container(
      width: 500.0,
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      width: 120.0,
                      height: 80.0,
                      child: Image.asset(
                        'images/hotel.jpg',
                        fit: BoxFit.fill,
                      )),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('DOM HOTELS', style: grey12),
                          SizedBox(height: 10.0),
                          Text(
                            "offerdata[0].title" ??
                                'Irresistible Tueday Temptation:',
                            style: blackB20,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Get FLAT {offerdata[0].discount} OFF*',
                            style: blackB15,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                              "offerdata[0].description" ??
                                  "On top-rated hotels & homestays in India,for your dreamy break",
                              style: grey12),
                          SizedBox(height: 10.0),
                          Container(
                              width: 150.0,
                              decoration: BoxDecoration(
                                color: Color(0xFF0d2b4d),
                                // border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'BOOK NOW',
                                      style: white15,
                                    ),
                                  )))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container whatsNewContainer(double width) {
    return Container(
        width: width,
        height: 320.0,
        color: Color(0xFF0d2b4d),
        // color: Colors.blueAccent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('What\'s new?', style: white20),
                SizedBox(height: 5.0),
                Text('See,why India loves to book with us', style: white20),
                SizedBox(height: 20.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: 400.0,
                          child: Card(
                              elevation: 30.0,
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                      blogdata[0].blogName ?? 'Nearby Airports',
                                      style: blackB15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Card(
                                      // color: Colors.grey[200],
                                      child: Row(children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                          width: 100.0,
                                          height: 80.0,
                                          child: Image.network(
                                            'https://gotodestination.in/api/images/blog_img/${blogdata[0].images}',
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: 150.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text('Near Airports',
                                                //     style: white15),
                                                Text(blogdata[0].description ??
                                                    'All nearby airports,all airlines.Our super smart systems always recommend the best possible routes to save your time & money.')
                                              ]),
                                        ),
                                      ),
                                    )
                                  ])),
                                )
                              ])),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: 400.0,
                          child: Card(
                              elevation: 30.0,
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                      blogdata[1].blogName ?? 'Nearby Airports',
                                      style: blackB15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Card(
                                      // color: Colors.grey[200],
                                      child: Row(children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                          width: 100.0,
                                          height: 80.0,
                                          child: Image.network(
                                            'https://gotodestination.in/api/images/blog_img/${blogdata[1].images}',
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: 150.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(  blogdata[1].blogName ??'Near Airports',
                                                //     style: blackB15),

                                                SizedBox(
                                                  height: 50,
                                                  child: Text(blogdata[1]
                                                          .description ??
                                                      'All nearby airports,all airlines.Our super smart systems always recommend the best possible routes to save your time & money.'),
                                                )
                                              ]),
                                        ),
                                      ),
                                    )
                                  ])),
                                )
                              ])),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: 400.0,
                          child: Card(
                              elevation: 30.0,
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                      blogdata[2].blogName ?? 'Nearby Airports',
                                      style: blackB15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Card(
                                      // color: Colors.grey[200],
                                      child: Row(children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                          width: 100.0,
                                          height: 80.0,
                                          child: Image.network(
                                            'https://gotodestination.in/api/images/blog_img/${blogdata[2].images}',
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: 150.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text('Near Airports',
                                                //     style: white15),
                                                SizedBox(
                                                  height: 50,
                                                  child: Text(blogdata[2]
                                                          .description ??
                                                      'All nearby airports,all airlines.Our super smart systems always recommend the best possible routes to save your time & money.'),
                                                )
                                              ]),
                                        ),
                                      ),
                                    )
                                  ])),
                                )
                              ])),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
        ));
  }

  Container searchButton() {
    return Container(
        width: 150.0,
        decoration: BoxDecoration(
          color: Color(0xFF0d2b4d),
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: TextButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => holidayPackageHotelsScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'SEARCH',
                style: white15,
              ),
            )));
  }

  InkWell TravelllerClass() {
    return InkWell(
      onTap: () {},
      child: Container(
        // width:200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'TRAVELLERS & CLASS',
                    style: blackB15,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.blueAccent,
                    size: 15,
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                '1 Traveller',
                style: blackB15,
              ),
              Text(
                'Economy/Premium Economy',
                style: black12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell returnContainer() {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        width: swidth / 6,
        decoration: BoxDecoration(
            border: Border(
          right: BorderSide(width: 0.5, color: Colors.grey[200]),
        )
            // borderRadius: BorderRadius.circular(10.0),
            ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'RETURN',
                    style: blackB15,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.blueAccent,
                    size: 15,
                  )
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                'Tap to add a return date for bigger discounts.',
                style: grey12,
              ),
              // Text('15 Jun 22',style: black25,),
              // Text('Wednesday',style: black12,)
            ],
          ),
        ),
      ),
    );
  }

  // InkWell DepartureContainer() {
  //   double sheight = MediaQuery.of(context).size.height;
  //   double swidth = MediaQuery.of(context).size.width;
  //   return InkWell(
  //     onTap: () {},
  //     child: Container(
  //       width: swidth/6.5,
  //       decoration: BoxDecoration(
  //           border: Border(
  //         right: BorderSide(width: 0.5, color: Colors.grey[200]),
  //       )
  //           // borderRadius: BorderRadius.circular(10.0),
  //           ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 Text(
  //                   'DEPARTURE',
  //                   style: blackB15,
  //                 ),
  //                 Icon(
  //                   Icons.keyboard_arrow_down_outlined,
  //                   color: Colors.blueAccent,
  //                   size: 15,
  //                 )
  //               ],
  //             ),
  //             SizedBox(height: 10.0),
  //             Text(
  //               '15 Jun 22',
  //               style: black25,
  //             ),
  //             Text(
  //               'Wednesday',
  //               style: black12,
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // InkWell ToContainer() {
  //   double sheight = MediaQuery.of(context).size.height;
  //   double swidth = MediaQuery.of(context).size.width;
  //   double width = MediaQuery.of(context).size.width;
  //   return InkWell(
  //     onTap: () {},
  //     child: Container(
  //       decoration: BoxDecoration(
  //           border: Border(
  //         right: BorderSide(width: 0.5, color: Colors.grey[200]),
  //       )
  //           // borderRadius: BorderRadius.circular(10.0),
  //           ),
  //       // width: 300.0,
  //       width: swidth / 7,
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'To',
  //               style: black15,
  //             ),
  //             SizedBox(height: 10.0),
  //             Text(
  //               'Delhi',
  //               style: GoogleFonts.quicksand(
  //                   color: Colors.black,
  //                   fontSize: 25.0,
  //                   fontWeight: FontWeight.bold),
  //             ),
  //             Text(
  //               'DEL,Delhi Airport India',
  //               style: black12,
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Container swapButton() {
  //   return Container(
  //       decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
  //       child: Padding(
  //         padding: const EdgeInsets.only(bottom: 10.0, right: 5, top: 5),
  //         child: IconButton(
  //             icon: Icon(
  //               Icons.swap_horiz,
  //               size: 30.0,
  //               color: Colors.blueAccent,
  //             ),
  //             onPressed: () {}),
  //       ));
  // }

  // InkWell FromContainer() {
  //   double sheight = MediaQuery.of(context).size.height;
  //   double swidth = MediaQuery.of(context).size.width;
  //   double width = MediaQuery.of(context).size.width;
  //   return InkWell(
  //     onTap: () {},
  //     child: Container(
  //       // decoration: BoxDecoration(
  //       //   border: Border(
  //       //     right: BorderSide(width:0.5),
  //       //   )
  //       //   // borderRadius: BorderRadius.circular(10.0),
  //       // ),
  //       // width: 300.0,
  //       width: swidth / 6,
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'FROM',
  //               style: black15,
  //             ),
  //             SizedBox(height: 10.0),
  //             Text('Mumbai', style: black25),
  //             Text(
  //               'BOM, Chhatrapati Shivaji International Airport India',
  //               style: black12,
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  selectWayRow() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
      child: Card(
        elevation: 5,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    // color: Colors.blue,
                    height: 80,
                    constraints:
                        BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Kind of trip', style: rajdhani12
                              // TextStyle(fontSize: 12)
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text(
                                    'Stay', style: rajdhaniB12,
                                    // style: TextStyle(
                                    //     fontWeight: FontWeight.bold,
                                    //     color: Colors.black,
                                    //     fontSize: 12),
                                  )),
                              // SizedBox(width: 60,),
                              // GestureDetector(
                              //   child: Icon(Icons.check, color: Colors.green,),
                              //   onTap: (){
                              //     setState(() {
                              //       if(isStayVisible == false){
                              //         isStayVisible = true;
                              //          isDestVisible = false;
                              //          isDepartureVisible = false;
                              //          isDDepartVisible = false;
                              //          isDuratVisible = false;
                              //          isMoreFilterVisible = false;
                              //       }else{
                              //         isStayVisible = false;
                              //       }
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (isStayVisible == false) {
                        isStayVisible = true;
                        isDestVisible = false;
                        isDepartureVisible = false;
                        isDDepartVisible = false;
                        isDuratVisible = false;
                        isMoreFilterVisible = false;
                      } else {
                        isStayVisible = false;
                      }
                    });
                  },
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: GestureDetector(
                    child: Container(
                      height: 80,
                      constraints: BoxConstraints(
                          minWidth: 0, maxWidth: double.infinity),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Destination', style: rajdhani12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                    child: Text('Anywhere', style: rajdhaniB12
                                        // TextStyle(
                                        //     fontWeight: FontWeight.bold,
                                        //     color: Colors.black,
                                        //     fontSize: 12),
                                        )),
                                // SizedBox(width: 60,),
                                // GestureDetector(
                                //   child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.black,size: 15,),
                                //   onTap: (){
                                //     setState(() {
                                //       if(isDestVisible == false){
                                //         isDestVisible = true;
                                //         isStayVisible = false;
                                //         isDepartureVisible = false;
                                //         isDDepartVisible = false;
                                //         isDuratVisible = false;
                                //         isMoreFilterVisible = false;
                                //       }else{
                                //         isDestVisible = false;
                                //       }
                                //     });
                                //
                                //   },
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (isDestVisible == false) {
                          isDestVisible = true;
                          isStayVisible = false;
                          isDepartureVisible = false;
                          isDDepartVisible = false;
                          isDuratVisible = false;
                          isMoreFilterVisible = false;
                        } else {
                          isDestVisible = false;
                        }
                      });
                    }),
              ),
              VerticalDivider(),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    constraints:
                        BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    height: 80,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Departure City', style: rajdhani12
                              //  TextStyle(fontSize: 12)
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text('All Airports', style: rajdhaniB12
                                      // TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.black,
                                      //     fontSize: 12),
                                      )),
                              // SizedBox(width: 60,),
                              // GestureDetector(
                              //   child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.black,size: 15,),
                              //   onTap: (){
                              //     setState(() {
                              //       if(isDepartureVisible == false){
                              //         isDepartureVisible = true;
                              //         isDestVisible = false;
                              //         isStayVisible = false;
                              //         isDDepartVisible = false;
                              //         isDuratVisible = false;
                              //         isMoreFilterVisible = false;
                              //       }else{
                              //         isDepartureVisible = false;
                              //       }
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (isDepartureVisible == false) {
                        isDepartureVisible = true;
                        isDestVisible = false;
                        isStayVisible = false;
                        isDDepartVisible = false;
                        isDuratVisible = false;
                        isMoreFilterVisible = false;
                      } else {
                        isDepartureVisible = false;
                      }
                    });
                  },
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    constraints:
                        BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    height: 80,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Date Of Departure', style: rajdhani12
                              // TextStyle(fontSize: 12)
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text('Whenever', style: rajdhaniB12
                                      // TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.black,
                                      //     fontSize: 12),
                                      )),
                              // SizedBox(width: 60,),
                              // GestureDetector(
                              //     child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.black,size: 15,),
                              //   onTap: (){
                              //     setState(() {
                              //       if(isDDepartVisible == false){
                              //         isDDepartVisible = true;
                              //         isDestVisible = false;
                              //         isStayVisible = false;
                              //         isDepartureVisible = false;
                              //         isDuratVisible = false;
                              //         isMoreFilterVisible = false;
                              //       }else{
                              //         isDDepartVisible = false;
                              //       }
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (isDDepartVisible == false) {
                        isDDepartVisible = true;
                        isDestVisible = false;
                        isStayVisible = false;
                        isDepartureVisible = false;
                        isDuratVisible = false;
                        isMoreFilterVisible = false;
                      } else {
                        isDDepartVisible = false;
                      }
                    });
                  },
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    height: 80,
                    constraints:
                        BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Duration', style: rajdhani12
                              // TextStyle(fontSize: 12)
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text('Never Minds', style: rajdhaniB12
                                      // TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.black,
                                      //     fontSize: 12),
                                      )),
                              // SizedBox(width: 60,),
                              // GestureDetector(
                              //     child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.black,size: 15,),
                              //   onTap: (){
                              //     setState(() {
                              //       if(isDuratVisible == false){
                              //         isDuratVisible = true;
                              //         isDDepartVisible = false;
                              //         isDestVisible = false;
                              //         isStayVisible = false;
                              //         isDepartureVisible = false;
                              //         isMoreFilterVisible = false;
                              //       }else{
                              //         isDuratVisible = false;
                              //       }
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (isDuratVisible == false) {
                        isDuratVisible = true;
                        isDDepartVisible = false;
                        isDestVisible = false;
                        isStayVisible = false;
                        isDepartureVisible = false;
                        isMoreFilterVisible = false;
                      } else {
                        isDuratVisible = false;
                      }
                    });
                  },
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: Container(
                  height: 80,
                  constraints:
                      BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('More Filters', style: rajdhani12
                              // TextStyle(fontSize: 12)
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text('(None)', style: rajdhaniB12
                                      // TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.black,
                                      //     fontSize: 12),
                                      )),
                              // SizedBox(width: 60,),
                              // GestureDetector(
                              //   child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.black,size: 15,),
                              //   onTap: (){
                              //     setState(() {
                              //       if(isMoreFilterVisible == false){
                              //         isMoreFilterVisible = true;
                              //         isDDepartVisible = false;
                              //         isDestVisible = false;
                              //         isStayVisible = false;
                              //         isDepartureVisible = false;
                              //         isDuratVisible = false;
                              //       }else{
                              //         isMoreFilterVisible = false;
                              //       }
                              //     });
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (isMoreFilterVisible == false) {
                          isMoreFilterVisible = true;
                          isDDepartVisible = false;
                          isDestVisible = false;
                          isStayVisible = false;
                          isDepartureVisible = false;
                          isDuratVisible = false;
                        } else {
                          isMoreFilterVisible = false;
                        }
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 80,
                  constraints:
                      BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                  color: Colors.orange,
                  child: Container(
                    // padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(
                              'Search',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            // children: [
            //   Container(
            //     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text('Kind of trip',style: TextStyle(fontSize: 12)),
            //         Row(
            //           children: [
            //             Container(
            //                 padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
            //                 child: Text('Stay',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
            //             ),
            //             SizedBox(width: 60,),
            //             Icon(Icons.check, color: Colors.green,),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            //   VerticalDivider(),
            //   Container(
            //     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text('Kind of trip',style: TextStyle(fontSize: 12)),
            //         Row(
            //           children: [
            //             Container(
            //                 padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
            //                 child: Text('Stay',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
            //             ),
            //             SizedBox(width: 60,),
            //             Icon(Icons.check, color: Colors.green,),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            //   VerticalDivider(),
            //   Container(
            //     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text('Kind of trip',style: TextStyle(fontSize: 12)),
            //         Row(
            //           children: [
            //             Container(
            //                 padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
            //                 child: Text('Stay',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
            //             ),
            //             SizedBox(width: 60,),
            //             Icon(Icons.check, color: Colors.green,),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            //   VerticalDivider(),
            //   Container(
            //     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text('Kind of trip',style: TextStyle(fontSize: 12)),
            //         Row(
            //           children: [
            //             Container(
            //                 padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
            //                 child: Text('Stay',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
            //             ),
            //             SizedBox(width: 60,),
            //             Icon(Icons.check, color: Colors.green,),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            //   VerticalDivider(),
            //   Container(
            //     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text('Kind of trip',style: TextStyle(fontSize: 12)),
            //         Row(
            //           children: [
            //             Container(
            //                 padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
            //                 child: Text('Stay',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
            //             ),
            //             SizedBox(width: 60,),
            //             Icon(Icons.check, color: Colors.green,),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            //   VerticalDivider(),
            //   Container(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text('Kind of trip',style: TextStyle(fontSize: 12)),
            //         Row(
            //           children: [
            //             Container(
            //                 padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
            //                 child: Text('Stay',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
            //             ),
            //             SizedBox(width: 60,),
            //             Icon(Icons.check, color: Colors.green,),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            //   VerticalDivider(),
            //   Container(
            //     color: Colors.orange,
            //     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            //     child: Row(
            //       children: [
            //         Icon(Icons.search, color: Colors.white,),
            //         Text('To Search',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12))
            //       ],
            //     ),
            //   ),
            //   // Radio(
            //   //   value: 1,
            //   //   groupValue: selectedValue,
            //   //   onChanged: (int value) {
            //   //     setState(() {
            //   //       selectedValue = value;
            //   //     });
            //   //   },
            //   // ),
            //   // Text('ONEWAY', style: grey15),
            //   // SizedBox(width: 30.0),
            //   // Radio(
            //   //   value: 2,
            //   //   groupValue: selectedValue,
            //   //   onChanged: (int value) {
            //   //     setState(() {
            //   //       selectedValue = value;
            //   //     });
            //   //   },
            //   // ),
            //   // Text('ROUND TRIP', style: grey15),
            //   // SizedBox(width: 30.0),
            //   // Radio(
            //   //   value: 3,
            //   //   groupValue: selectedValue,
            //   //   onChanged: (int value) {
            //   //     setState(() {
            //   //       selectedValue = value;
            //   //     });
            //   //   },
            //   // ),
            //   // Text('MULTI CITY', style: grey15),
            // ],
          ),
        ),
      ),
    );
  }

  selectWayRowMobile() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
      constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
      child: Card(
        elevation: 2,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  child: Container(
                    // color: Colors.blue,
                    height: 80,
                    constraints:
                        BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Kind of trip', style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text(
                                    'Stay',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (isStayVisible == false) {
                        isStayVisible = true;
                        isDestVisible = false;
                        isDepartureVisible = false;
                        isDDepartVisible = false;
                        isDuratVisible = false;
                        isMoreFilterVisible = false;
                      } else {
                        isStayVisible = false;
                      }
                    });
                  },
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: GestureDetector(
                    child: Container(
                      height: 80,
                      constraints: BoxConstraints(
                          minWidth: 0, maxWidth: double.infinity),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Destination', style: TextStyle(fontSize: 12)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                    child: Text(
                                      'Anywhere',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 12),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (isDestVisible == false) {
                          isDestVisible = true;
                          isStayVisible = false;
                          isDepartureVisible = false;
                          isDDepartVisible = false;
                          isDuratVisible = false;
                          isMoreFilterVisible = false;
                        } else {
                          isDestVisible = false;
                        }
                      });
                    }),
              ),
              VerticalDivider(),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    constraints:
                        BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    height: 80,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Departure City',
                              style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text(
                                    'All Airports',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (isDepartureVisible == false) {
                        isDepartureVisible = true;
                        isDestVisible = false;
                        isStayVisible = false;
                        isDDepartVisible = false;
                        isDuratVisible = false;
                        isMoreFilterVisible = false;
                      } else {
                        isDepartureVisible = false;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectWayRowMobile1() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
      constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
      child: Card(
        elevation: 2,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // VerticalDivider(),

              Expanded(
                child: GestureDetector(
                  child: Container(
                    constraints:
                        BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    height: 80,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(' Departure Date ',
                              style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text(
                                    'Whenever',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (isDDepartVisible == false) {
                        isDDepartVisible = true;
                        isDestVisible = false;
                        isStayVisible = false;
                        isDepartureVisible = false;
                        isDuratVisible = false;
                        isMoreFilterVisible = false;
                      } else {
                        isDDepartVisible = false;
                      }
                    });
                  },
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    height: 80,
                    constraints:
                        BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Duration', style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text(
                                    'Never Minds',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      if (isDuratVisible == false) {
                        isDuratVisible = true;
                        isDDepartVisible = false;
                        isDestVisible = false;
                        isStayVisible = false;
                        isDepartureVisible = false;
                        isMoreFilterVisible = false;
                      } else {
                        isDuratVisible = false;
                      }
                    });
                  },
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: Container(
                  height: 80,
                  constraints:
                      BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('More Filters', style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text(
                                    '(None)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 12),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (isMoreFilterVisible == false) {
                          isMoreFilterVisible = true;
                          isDDepartVisible = false;
                          isDestVisible = false;
                          isStayVisible = false;
                          isDepartureVisible = false;
                          isDuratVisible = false;
                        } else {
                          isMoreFilterVisible = false;
                        }
                      });
                    },
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(
              //     height: 80,
              //     constraints:
              //         BoxConstraints(minWidth: 0, maxWidth: double.infinity),
              //     color: Colors.orange,
              //     child: Container(
              //       // padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
              //       alignment: Alignment.center,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(
              //             Icons.search,
              //             color: Colors.white,
              //           ),
              //           SizedBox(
              //             width: 8,
              //           ),
              //           Container(
              //               padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              //               child: Text(
              //                 'Search',
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.white,
              //                     fontSize: 12),
              //               )),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  selectWayRowMobilesearch() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 2, 20, 20),
      constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
      child: Card(
        elevation: 2,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  height: 35,
                  constraints:
                      BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                  color: Colors.orange,
                  child: Container(
                    // padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(
                              'Search',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectWayRowdrawer() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
      constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              print("flights");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlightBookingSearchPage(),
                  ));
            },
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, bottom: 5, right: 2),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.08,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          // label: Text('Flights', style: grey15),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FlightBookingSearchPage(),
                                ));
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => addMenu()),
                            // );
                          },
                          icon: Icon(
                            FontAwesomeIcons.plane,
                            color: Colors.grey,
                          )),
                      Text(
                        'Flights',
                        style: grey12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0, bottom: 5, right: 2),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.height * 0.08,
                child: Column(
                  children: [
                    IconButton(
                        // label: Text('Flights', style: grey15),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => addMenu()),
                          // );
                        },
                        icon: Icon(
                          FontAwesomeIcons.bus,
                          color: Colors.grey,
                        )),
                    Text(
                      'Bus',
                      style: grey12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0, bottom: 5, right: 2),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.height * 0.08,
                child: Column(
                  children: [
                    IconButton(
                        // label: Text('Flights', style: grey15),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => addMenu()),
                          // );
                        },
                        icon: Icon(
                          FontAwesomeIcons.hotel,
                          color: Colors.grey,
                        )),
                    Center(
                        child: Text(
                      ' Holiday \npackages ',
                      style: grey12,
                    )),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 2.0, bottom: 5, right: 2),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.height * 0.08,
                child: Column(
                  children: [
                    IconButton(
                        // label: Text('Flights', style: grey15),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => addMenu()),
                          // );
                        },
                        icon: Icon(
                          // Icons.settings,
                          FontAwesomeIcons.bars,
                          color: Colors.grey,
                        )),
                    Text(
                      'Activities',
                      style: grey12,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  selectWayRowdrawer1() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
      constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
      child: Row(
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextButton.icon(
                  label: Text('Flights', style: grey15),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => addMenu()),
                    // );
                  },
                  icon: Icon(
                    FontAwesomeIcons.plane,
                    color: Colors.grey,
                  )),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextButton.icon(
                  label: Text('Flights', style: grey15),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => addMenu()),
                    // );
                  },
                  icon: Icon(
                    FontAwesomeIcons.plane,
                    color: Colors.grey,
                  )),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextButton.icon(
                  label: Text('Flights', style: grey15),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => addMenu()),
                    // );
                  },
                  icon: Icon(
                    FontAwesomeIcons.plane,
                    color: Colors.grey,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget cards(text, icon) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              text,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget places(text) {
    return Container(
      height: 40,
      width: 80,
      margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade200,
      ),
      child: Center(child: Text(text)),
    );
  }
}
