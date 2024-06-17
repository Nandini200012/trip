import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Drawer.dart';
import 'constant.dart';
import 'filter_screen.dart';
import 'footer.dart';
import 'header.dart';
import 'holidayPackageHotelsScreen.dart';
import 'hotels_detail_page.dart';

class Hotels_Page extends StatefulWidget {
  const Hotels_Page({Key key}) : super(key: key);

  @override
  _Hotels_PageState createState() => _Hotels_PageState();
}

class _Hotels_PageState extends State<Hotels_Page>
    with TickerProviderStateMixin {
  int svalue = 1;
  CarouselController carouselController = CarouselController();
  int selectedValue = 1;
  bool _isExpanded = false;
  bool isStayVisible = false;
  bool isDestVisible = false;
  bool isDepartureVisible = false;
  bool isDDepartVisible = false;
  bool isDuratVisible = false;
  bool isMoreFilterVisible = false;
  bool checkVal = false;

  // carouselController:carouselController,
  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    TabController _tabController = TabController(length: 6, vsync: this);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: currentwidth < 600
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 40),
              backgroundColor: Colors.white,
              title: Text(
                'Book Domestic and International hotels Online',
                style: blackB15,
              ),
            )
          : CustomAppBar(),
      drawer: currentwidth < 600 ? drawer() : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return buildSingleChildScrollViewMobileView(
                width, _tabController, currentwidth);
          } else {
            return buildSingleChildScrollViewDesktopView(
                width, _tabController, currentwidth);
          }
        },
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollViewDesktopView(
      double width, TabController _tabController, double currentwidth) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                  // border: Border.all(color: Colors.grey[100]),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      selectWayRow(),
                      Visibility(
                        visible: isStayVisible,
                        child: Container(
                          // padding: EdgeInsets.all(20),
                          child: Card(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(44, 40, 44, 40),
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2),
                                    color: Colors.grey.shade200,
                                  ),
                                  height: 128,
                                  child: Column(
                                    children: [
                                      Icon(Icons.beach_access),
                                      SizedBox(height: 4,),
                                      Text('STAY')
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  color: Colors.grey.shade200,
                                  height: 124,
                                  child: Column(
                                    children: [
                                      Icon(Icons.electrical_services_rounded),
                                      SizedBox(height: 4,),
                                      Text('CIRCUIT')
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  color: Colors.grey.shade200,
                                  height: 124,
                                  child: Column(
                                    children: [
                                      Icon(Icons.directions_boat),
                                      SizedBox(height: 4,),
                                      Text('CRUISE')
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  color: Colors.grey.shade200,
                                  height: 124,
                                  child: Column(
                                    children: [
                                      Icon(Icons.vpn_key_outlined),
                                      SizedBox(height: 4,),
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
                                            borderRadius: BorderRadius.all(Radius.circular(90.0)),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0)
                                      ),
                                    )
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text('TOP DESTINATIONS',style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Text('France'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Text('Spain'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Text('Corcia'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Text('Italy'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Text('Portugal'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Text('Greece'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey.shade200,
                                      ),
                                      child: Text('Morocco'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                                      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
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
                        child: Container(
                          // padding: EdgeInsets.all(20),
                          child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Text('TOP AIRPORTS',style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            fillColor: MaterialStateProperty.all(Colors.grey),
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
                                            fillColor: MaterialStateProperty.all(Colors.grey),
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
                                            fillColor: MaterialStateProperty.all(Colors.grey),
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
                                          SizedBox(width: 40),
                                          Checkbox(
                                            fillColor: MaterialStateProperty.all(Colors.grey),
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
                                            fillColor: MaterialStateProperty.all(Colors.grey),
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
                                            fillColor: MaterialStateProperty.all(Colors.grey),
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
                                            fillColor: MaterialStateProperty.all(Colors.grey),
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
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text('Flexibility',style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('Fixed',style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('+/-1d',style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('+/-3d',style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('+/-5d',style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Text('+/-7d',style: TextStyle(fontWeight: FontWeight.bold),),
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
                                      firstDay: DateTime.utc(2010,10,20),
                                      lastDay: DateTime.utc(2040,10,20),
                                      focusedDay: DateTime.now(),
                                      headerVisible: true,
                                      daysOfWeekVisible: true,
                                      sixWeekMonthsEnforced: true,
                                      shouldFillViewport: false,
                                      calendarFormat: CalendarFormat.month,
                                      headerStyle: HeaderStyle(
                                          titleTextStyle: TextStyle(fontSize: 10, color: Colors.deepPurple, fontWeight: FontWeight.w800)
                                      ),
                                      calendarStyle: CalendarStyle(
                                        // cellMargin: EdgeInsets.fromLTRB(4, 4, 4, 4),
                                          todayTextStyle: TextStyle(fontSize:10, color: Colors.white, fontWeight: FontWeight.bold )
                                      ),
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
                                          Text('Shorts Stay (1 to 5 nights)'),
                                          SizedBox(width: 60),
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
                                          SizedBox(width: 60),
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
                                          SizedBox(width: 60),
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
                                          Text('+2 Week ()17 nightsand +'),
                                        ],
                                      )
                                  ),
                                ],
                              )
                          ),
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
                                        Text('Hotel Categories',style: TextStyle(fontWeight: FontWeight.bold),),
                                        Icon(Icons.keyboard_arrow_down_outlined),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    child: Row(
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
                                        Text('5 Stars'),
                                        SizedBox(width: 150),
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
                                        Text('4 Stars'),
                                        SizedBox(width: 150),
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
                                        Text('3 Stars'),
                                        SizedBox(width: 150),
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
                                        Text('2 Stars'),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    child: Row(
                                      children: [
                                        Text('Pension',style: TextStyle(fontWeight: FontWeight.bold),),
                                        Icon(Icons.keyboard_arrow_down_outlined),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    child: Row(
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
                                        SizedBox(width: 150),
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
                                        SizedBox(width: 150),
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
                                        SizedBox(width: 150),
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
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    child: Row(
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
                                        SizedBox(width: 94),
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
          // Container(
          //   height: 380.0,
          //
          //   width: width,
          //   // color: Colors.blueAccent,
          //   color: Color(0xFF0d2b4d),
          //
          //   child: Center(
          //     child: Container(
          //       width:swidth/1.1,
          //       // width: 1300.0,
          //       height: 230.0,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         // border: Border.all(color: Colors.grey[100]),
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       child: Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Center(
          //                 child: Text(
          //               'Book Domestic and International hotels Online.',
          //               style: blackB15,
          //             )),
          //             Padding(
          //               padding: const EdgeInsets.all(10.0),
          //               child: Container(
          //                 width: 1250.0,
          //                 height: 120.0,
          //                 decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   border: Border.all(color: Colors.grey[100]),
          //                   borderRadius: BorderRadius.circular(10.0),
          //                 ),
          //                 child: Row(
          //                   children: [
          //                     buildInkWellSearchCityHotel(),
          //                     SizedBox(width: 30.0),
          //                     checkIn(),
          //                     checkout(),
          //                     roomandguest(),
          //                     filter()
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             popularfilters()
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.only(top:50.0,bottom: 50.0,left:80.0,right:80.0),
            child: Center(
              child: Container(

                // width: 1300.0,
                height: 350.0,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 60.0, bottom: 50.0, right: 20.0, left: 20.0),
                        child: Container(
                          width: 300.0,
                          child: IntroductionColumn(),
                        ),
                      ),
                      discoverByBrands(),
                      discoverByBrands(),
                      discoverByBrands(),
                      discoverByBrands(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(bottom:50.0,left:80.0,right:80.0),
            child: Center(
              child: Container(
                // width: 1300,
                height: 320.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  //border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TabBarcard(_tabController, currentwidth),
              ),
            ),
          ),
          // SizedBox(height: 20.0),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom:50.0,left:80.0,right:80.0),
              child: Container(
                // width: 1300.0,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Offers:', style: black25),
                            Padding(
                              padding: const EdgeInsets.only(top:10.0,right:10),
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
                      ),
                      SizedBox(height: 20.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            offersContainer(),
                            offersContainer(),
                            offersContainer(),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
      double width, TabController _tabController, double currentwidth) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInkWellSearchCityHotel(),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      checkIn(),
                      Expanded(child: checkout()),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [roomandguest(), filter()],
                  ),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: searchButton(),
                  )),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    IntroductionColumn(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        discoverByBrands(),
                        discoverByBrands(),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: width,
              height: 320.0,
              decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TabBarcard(_tabController, currentwidth),
            ),
            Container(
              width: width,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: currentwidth < 600 ? 10 : 70.0, top: 10.0),
                      child: Text('Offers:', style: black25),
                    ),
                    SizedBox(height: 20.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          offersContainer(),
                          offersContainer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Container offersContainer() {
    return Container(
      width: 500.0,
      child: Card(
        elevation: 10.0,
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
                            'Irresistible Tuesday Temptation:',
                            style: blackB20,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Get FLAT 15% OFF*',
                            style: blackB15,
                          ),
                          SizedBox(height: 10.0),
                          Text(
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
                                  onPressed: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => hotels_detail_page()));
                                    });

                                  },
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

  Card TabBarcard(TabController _tabController, double currentwidth) {
    return Card(
      elevation: 20.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              indicatorColor: Colors.blueAccent,
              labelColor: Color(0xFF0d2b4d),
              unselectedLabelColor: Colors.black,
              isScrollable: true,
              controller: _tabController,
              tabs: [
                Container(
                    // width: 90.0,
                    decoration: BoxDecoration(

                        // color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Tab(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Beach Vacations', style: blackB15)))),
                Container(
                    // width: 90.0,
                    decoration: BoxDecoration(

                        //color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Tab(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Weekend Gateways', style: blackB15)))),
                Container(
                    // width: 90.0,
                    decoration: BoxDecoration(
                        // color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Tab(
                        child: Align(
                            alignment: Alignment.center,
                            child:
                                Text('Mountains Calling', style: blackB15)))),
                Container(
                    // width: 90.0,
                    decoration: BoxDecoration(
                        // color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Tab(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Stay Like Royal', style: blackB15)))),
                Container(
                    // width: 90.0,
                    decoration: BoxDecoration(
                        // color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Tab(
                        child: Align(
                            alignment: Alignment.center,
                            child:
                                Text('Indian Pilgrimage', style: blackB15)))),
                Container(
                    // width: 90.0,
                    decoration: BoxDecoration(
                        // color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Tab(
                        child: Align(
                            alignment: Alignment.center,
                            child:
                                Text('Party Destinations', style: blackB15)))),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                              ),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_2.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Goa',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/mumbai.jpg',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Mumbai',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/mumbai2.jpg',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Otty',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/mumbai4.PNG',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Kokan',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                              ),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_2.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Goa',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    //<--------------------------------------------------->//
                    Container(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Goa',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Mumbai',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Otty',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Kokan',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    //<--------------------------------------------------->//
                    Container(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Goa',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Mumbai',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Otty',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Kokan',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    //<--------------------------------------------------->//
                    Container(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Goa',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Mumbai',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Otty',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Kokan',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    //<--------------------------------------------------->//
                    Container(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Goa',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Mumbai',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Otty',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Kokan',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    //<--------------------------------------------------->//
                    Container(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Goa',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Mumbai',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Otty',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                // height: 300.0,
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 180.0,
                                          width: 250.0,
                                          child: Image.asset('images/img_1.png',
                                              fit: BoxFit.fill)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 10.0, top: 10.0),
                                        child: Text(
                                          'Kokan',
                                          style: blackB20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding discoverByBrands() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 250.0,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 160.0,
                  width: 270.0,
                  child: Image.asset('images/img.png', fit: BoxFit.fill)),
              Padding(
                padding:
                    const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
                child: Text('Discover by Brands', style: black25),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
                child: Text(
                  'Taj, Marriott,Oberoi, Hyatt & More',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column IntroductionColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INTRODUCING',
          style: black25,
        ),
        Text(
          'MMT Luxe\nSelection',
          style: GoogleFonts.quicksand(
              color: Colors.deepOrangeAccent,
              fontSize: 35.0,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            style: blackB15),
        SizedBox(height: 20.0),
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
                    'LEARN MORE',
                    style: white15,
                  ),
                )))
      ],
    );
  }

  Padding popularfilters() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Text(
            'Popular\nFilters:',
            style: grey12,
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            // color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: svalue,
                    onChanged: (int value) {
                      setState(() {
                        svalue = value;
                      });
                    },
                  ),
                  Text('Homestays', style: black12),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            // color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: svalue,
                    onChanged: (int value) {
                      setState(() {
                        svalue = value;
                      });
                    },
                  ),
                  Text('Free Cancellation', style: black12),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            // color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Radio(
                    value: 3,
                    groupValue: svalue,
                    onChanged: (int value) {
                      setState(() {
                        svalue = value;
                      });
                    },
                  ),
                  Text('Breakfast Available', style: black12),
                ],
              ),
            ),
          ),
          Spacer(),
          searchButton()
        ],
      ),
    );
  }

  selectWayRow() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                    constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Kind of trip',style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text('Stay',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
                              ),
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
                  onTap: (){
                    setState(() {
                      if(isStayVisible == false){
                        isStayVisible = true;
                        isDestVisible = false;
                        isDepartureVisible = false;
                        isDDepartVisible = false;
                        isDuratVisible = false;
                        isMoreFilterVisible = false;
                      }else{
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
                      constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                      child:Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Destination',style: TextStyle(fontSize: 12)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                    child: Text('Anywhere',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
                                ),
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
                    }
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: GestureDetector(
                  child: Container(
                    constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    height: 80,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Departure City',style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text('All Airports',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
                              ),
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
                  onTap: (){
                    setState(() {
                      if(isDepartureVisible == false){
                        isDepartureVisible = true;
                        isDestVisible = false;
                        isStayVisible = false;
                        isDDepartVisible = false;
                        isDuratVisible = false;
                        isMoreFilterVisible = false;
                      }else{
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
                    constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    height: 80,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Date Of Departure',style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text('Whenever',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
                              ),
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
                  onTap: (){
                    setState(() {
                      if(isDDepartVisible == false){
                        isDDepartVisible = true;
                        isDestVisible = false;
                        isStayVisible = false;
                        isDepartureVisible = false;
                        isDuratVisible = false;
                        isMoreFilterVisible = false;
                      }else{
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
                    constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Duration',style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text('Never Minds',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
                              ),
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
                  onTap: (){
                    setState(() {
                      if(isDuratVisible == false){
                        isDuratVisible = true;
                        isDDepartVisible = false;
                        isDestVisible = false;
                        isStayVisible = false;
                        isDepartureVisible = false;
                        isMoreFilterVisible = false;
                      }else{
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
                  constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('More Filters',style: TextStyle(fontSize: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                  child: Text('(None)',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 12),)
                              ),
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
                    onTap: (){
                      setState(() {
                        if(isMoreFilterVisible == false){
                          isMoreFilterVisible = true;
                          isDDepartVisible = false;
                          isDestVisible = false;
                          isStayVisible = false;
                          isDepartureVisible = false;
                          isDuratVisible = false;
                        }else{
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
                  constraints: BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                  color: Colors.orange,
                  child:  Container(
                    // padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, color: Colors.white,),
                        SizedBox(width: 8,),
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text('Search',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 12),)
                        ),
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

  InkWell filter() {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'FILTERS',
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
                'Price Range &',
                style: blackB15,
              ),
              Text(
                'Property Type',
                style: black15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell roomandguest() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 200.0,
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
                    'ROOMS & GUESTS',
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
                '1 Room 2 Guests',
                style: blackB20,
              ),
              // Text('15 Jun 22',style: black25,),
              // Text('Wednesday',style: black12,)
            ],
          ),
        ),
      ),
    );
  }

  InkWell checkout() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 200.0,
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
                    'CHECK-OUT',
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
                '15 Jun 22',
                style: black25,
              ),
              Text(
                'Wednesday',
                style: black15,
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell checkIn() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 200.0,
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
                    'CHECK-IN',
                    style: blackB15,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.blueAccent,
                    size: 15,
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                '15 Jun 22',
                style: black25,
              ),
              Text(
                'Wednesday',
                style: black15,
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildInkWellSearchCityHotel() {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 0.5, color: Colors.grey[200]),
          ),
        ),
        width:250.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CITY/HOTEL/AREA/BUILDING',
                style: black15,
              ),
              SizedBox(height: 10.0),
              Text('Search Anywhere', style: black20),
              // Text(
              //   'India',
              //   style: black12,
              // )
            ],
          ),
        ),
      ),
    );
  }

  Container searchButton() {
    double width = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    return Container(
        height: currentwidth < 600 ? 40.0 : null,
        width: 150.0,
        decoration: BoxDecoration(
          color: Color(0xFF0d2b4d),
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => filter_Screen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'SEARCH',
                style: white15,
              ),
            )));
  }


}
