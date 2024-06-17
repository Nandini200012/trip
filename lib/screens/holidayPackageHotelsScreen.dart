import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Drawer.dart';
import 'MobileFilter.dart';
import 'constant.dart';
import 'footer.dart';
import 'header.dart';
import 'holidayPackageDetailPage.dart';
import 'hotels_detail_page.dart';

class holidayPackageHotelsScreen extends StatefulWidget {
  const holidayPackageHotelsScreen({Key key}) : super(key: key);

  @override
  State<holidayPackageHotelsScreen> createState() =>
      _holidayPackageHotelsScreenState();
}

class _holidayPackageHotelsScreenState
    extends State<holidayPackageHotelsScreen> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
      drawer: currentwidth < 600 ? drawer() : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return mobileScreen(context);
          } else {
            return DesktopView(width, context, swidth);
          }
        },
      ),
    );
  }

  SingleChildScrollView mobileScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              color: Color(0xFF0d2b4d),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: searchContainerCity()),
                        SizedBox(width: 5.0),
                        Expanded(
                          child: goingToContainer(),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(child: startingDateContainer()),
                        SizedBox(width: 5.0),
                        Expanded(child: searchButton()),
                      ],
                    ),
                  ],
                ),
              )),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200]),
                        color: Colors.grey[300],
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MobileFilter()));
                        },
                        child: Text('Filter',
                            style: GoogleFonts.quicksand(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0)),
                      ),
                    )),
                    SizedBox(width: 5),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[200]),
                              color: Colors.grey[300],
                            ),
                            child: buildDropdownButtonSortBy()))
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'PREMIUM PACKAGES',
                  style: blackB15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      premiumpackageshotel( context),
                      premiumpackageshotel( context),
                      premiumpackageshotel( context),
                      premiumpackageshotel( context),
                      // Container(
                      //     width: 200,
                      //     // height: 380,
                      //     child: Card(
                      //       elevation: 5,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(10.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //                 'Taj Santacruz, Mumbai Escapade 2N - With Flights',
                      //                 style: black12),
                      //             SizedBox(height: 10.0),
                      //             Container(
                      //                 height: 100,
                      //                 width: 200,
                      //                 child: Image.asset('mumbai2.jpg',
                      //                     fit: BoxFit.fill)),
                      //             SizedBox(height: 10.0),
                      //             Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.hotel,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       'Hotel',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.flight,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       'Flight',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.person,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       'Activity',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.car_rental,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       '1 Transfer',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 )
                      //               ],
                      //             ),
                      //             SizedBox(height: 10.0),
                      //             Row(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(
                      //                   '2N Mumbai',
                      //                   style: red12,
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Text(
                      //                       '\u{20B9}${20000}',
                      //                       style: blackLineThrough12,
                      //                     ),
                      //                     SizedBox(height: 5.0),
                      //                     Text(
                      //                       '\u{20B9}${19000}',
                      //                       style: blackB15,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     )),
                      // SizedBox(width: 10.0),
                      // Container(
                      //     width: 200,
                      //     // height: 380,
                      //     child: Card(
                      //       elevation: 5,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(10.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //                 'Taj Santacruz, Mumbai Escapade 2N - With Flights',
                      //                 style: black12),
                      //             SizedBox(height: 10.0),
                      //             Container(
                      //                 height: 100,
                      //                 width: 200,
                      //                 child: Image.asset('mumbai5.PNG',
                      //                     fit: BoxFit.fill)),
                      //             SizedBox(height: 10.0),
                      //             Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.hotel,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       'Hotel',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.flight,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       'Flight',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.person,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       'Activity',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.car_rental,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       '1 Transfer',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 )
                      //               ],
                      //             ),
                      //             SizedBox(height: 10.0),
                      //             Row(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(
                      //                   '2N Mumbai',
                      //                   style: red12,
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Text(
                      //                       '\u{20B9}${20000}',
                      //                       style: blackLineThrough12,
                      //                     ),
                      //                     SizedBox(height: 5.0),
                      //                     Text(
                      //                       '\u{20B9}${19000}',
                      //                       style: blackB15,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     )),
                      // SizedBox(width: 10.0),
                      // Container(
                      //     width: 200,
                      //     // height: 380,
                      //     child: Card(
                      //       elevation: 5,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(10.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //                 'Taj Santacruz, Mumbai Escapade 2N - With Flights',
                      //                 style: black12),
                      //             SizedBox(height: 10.0),
                      //             Container(
                      //                 height: 100,
                      //                 width: 200,
                      //                 child: Image.asset('mumbai.jpg',
                      //                     fit: BoxFit.fill)),
                      //             SizedBox(height: 10.0),
                      //             Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.hotel,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       'Hotel',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.flight,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       'Flight',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.person,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       'Activity',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.car_rental,
                      //                       size: 10.0,
                      //                     ),
                      //                     Text(
                      //                       '1 Transfer',
                      //                       style: black10,
                      //                     ),
                      //                   ],
                      //                 )
                      //               ],
                      //             ),
                      //             SizedBox(height: 10.0),
                      //             Row(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(
                      //                   '2N Mumbai',
                      //                   style: red12,
                      //                 ),
                      //                 Column(
                      //                   children: [
                      //                     Text(
                      //                       '\u{20B9}${20000}',
                      //                       style: blackLineThrough12,
                      //                     ),
                      //                     SizedBox(height: 5.0),
                      //                     Text(
                      //                       '\u{20B9}${19000}',
                      //                       style: blackB15,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  InkWell premiumpackageshotel(BuildContext context) {
    final currentwidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => holidayPackageDetailPage()));
      },
      child: Container(
          height:currentwidth<600?null: 380,
          width: currentwidth<600? 200: 320,
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Taj Santacruz, Mumbai Escapade 2N - With Flights',
                      style: currentwidth < 600 ? black12:blackB15),
                  SizedBox(height: 10.0),
                  Container(
                      height: currentwidth<600?100:200,
                      width:  currentwidth<600?200 : 300,
                      child: Image.asset('images/mumbai.jpg', fit: BoxFit.fill)),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.hotel,
                            size: currentwidth<600?10: 20.0,
                          ),
                          Text(
                            'Hotel',
                            style: currentwidth<600?black10:blackB1,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.flight,
                            size:  currentwidth<600?10:20.0,
                          ),
                          Text(
                            'Flight',
                            style: currentwidth<600?black10: blackB1,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.person,
                            size: currentwidth<600?10: 20.0,
                          ),
                          Text(
                            'Activity',
                            style:  currentwidth<600?black10:blackB1,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.car_rental,
                            size: currentwidth<600?10: 20.0,
                          ),
                          Text(
                            '1 Transfer',
                            style: currentwidth<600?black10: blackB1,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '2N Mumbai',
                        style: red12,
                      ),
                      Column(
                        children: [
                          Text(
                            '\u{20B9}${20000}',
                            style: currentwidth<600?blackLineThrough12:blackLineThrough,
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            '\u{20B9}${19000}',
                            style: currentwidth<600?blackB15:black20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }


  SingleChildScrollView DesktopView(
      double width, BuildContext context, double swidth) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width:1600,
              height: 90.0,
              color: Color(0xFF0d2b4d),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50.0, top: 10.0, right: 10.0, bottom: 10),
                    child: searchContainerCity(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: goingToContainer(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: startingDateContainer(),
                  ),
                 SizedBox(width:50.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: searchButton(),
                  )
                ],
              ),
            ),
          ),
          slider(width),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              filterColumn(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Premium Packages',
                        style: black30,
                      ),
                      SizedBox(height: 10.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            premiumpackageshotel(context),
                            SizedBox(width: 10.0),
                            Container(
                                width: 320,
                                height: 380,
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Taj Santacruz, Mumbai Escapade 2N - With Flights',
                                            style: blackB15),
                                        SizedBox(height: 10.0),
                                        Container(
                                            height: 200,
                                            width: 300,
                                            child: Image.asset('images/mumbai2.jpg',
                                                fit: BoxFit.fill)),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.hotel,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Hotel',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.flight,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Flight',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Activity',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.car_rental,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  '1 Transfer',
                                                  style: blackB1,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '2N Mumbai',
                                              style: red12,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '\u{20B9}${20000}',
                                                  style: blackLineThrough,
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  '\u{20B9}${19000}',
                                                  style: black20,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            SizedBox(width: 10.0),
                            Container(
                                width: 320,
                                height: 380,
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Taj Santacruz, Mumbai Escapade 2N - With Flights',
                                            style: blackB15),
                                        SizedBox(height: 10.0),
                                        Container(
                                            height: 200,
                                            width: 300,
                                            child: Image.asset('images/mumbai5.PNG',
                                                fit: BoxFit.fill)),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.hotel,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Hotel',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.flight,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Flight',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Activity',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.car_rental,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  '1 Transfer',
                                                  style: blackB1,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '2N Mumbai',
                                              style: red12,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '\u{20B9}${20000}',
                                                  style: blackLineThrough,
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  '\u{20B9}${19000}',
                                                  style: black20,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            SizedBox(width: 10.0),
                            Container(
                                width: 320,
                                height: 380,
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Taj Santacruz, Mumbai Escapade 2N - With Flights',
                                            style: blackB15),
                                        SizedBox(height: 10.0),
                                        Container(
                                            height: 200,
                                            width: 300,
                                            child: Image.asset('images/mumbai.jpg',
                                                fit: BoxFit.fill)),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.hotel,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Hotel',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.flight,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Flight',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Activity',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.car_rental,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  '1 Transfer',
                                                  style: blackB1,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '2N Mumbai',
                                              style: red12,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  '\u{20B9}${20000}',
                                                  style: blackLineThrough,
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  '\u{20B9}${19000}',
                                                  style: black20,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Romantic Escape',
                        style: black30,
                      ),
                      SizedBox(height: 20.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            romanticpacakges(),
                            SizedBox(width: 10.0),
                            Container(
                                width: 320.0,
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Taj Santacruz, Mumbai Escapade 2N - With Flights',
                                            style: blackB15),
                                        SizedBox(height: 10.0),
                                        Container(
                                            height: 200.0,
                                            width: 300.0,
                                            child: Image.asset('images/mumbai3.jpg',
                                                fit: BoxFit.fill)),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.hotel,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Hotel',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.flight,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Flight',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Activity',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.car_rental,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  '1 Transfer',
                                                  style: blackB1,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                          '2N Mumbai',
                                          style: red12,
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                          '\u{20B9}${20000}',
                                          style: blackLineThrough,
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          '\u{20B9}${19000}',
                                          style: black20,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            SizedBox(width: 10.0),
                            Container(
                                width: 320.0,
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Taj Santacruz, Mumbai Escapade 2N - With Flights',
                                            style: blackB15),
                                        SizedBox(height: 10.0),
                                        Container(
                                            height: 200.0,
                                            width: 300.0,
                                            child: Image.asset('images/mumbai4.PNG',
                                                fit: BoxFit.fill)),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.hotel,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Hotel',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.flight,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Flight',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Activity',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.car_rental,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  '1 Transfer',
                                                  style: blackB1,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                          '2N Mumbai',
                                          style: red12,
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                          '\u{20B9}${20000}',
                                          style: blackLineThrough,
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          '\u{20B9}${19000}',
                                          style: black20,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            SizedBox(width: 10.0),
                            Container(
                                width: 320.0,
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Taj Santacruz, Mumbai Escapade 2N - With Flights',
                                            style: blackB15),
                                        SizedBox(height: 10.0),
                                        Container(
                                            height: 200.0,
                                            width: 300.0,
                                            child: Image.asset('images/mumbai5.PNG',
                                                fit: BoxFit.fill)),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.hotel,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Hotel',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.flight,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Flight',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.person,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  'Activity',
                                                  style: blackB1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.car_rental,
                                                  size: 20.0,
                                                ),
                                                Text(
                                                  '1 Transfer',
                                                  style: blackB1,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                          '2N Mumbai',
                                          style: red12,
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                          '\u{20B9}${20000}',
                                          style: blackLineThrough,
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          '\u{20B9}${19000}',
                                          style: black20,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      // Text(
                      //   'Romantic Escape',
                      //   style: black30,
                      // ),

                      Container(
                        width: swidth / 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Offers:', style: black25),
                            SizedBox(height: 20.0),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  offersContainer(),
                                  offersContainer(),
                                  offersContainer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          buildFooter(),
        ],
      ),
    );
  }

  Container slider(double width) {
    return Container(
      width: width,
      height: 150.0,
      child: Image.asset(
        'images/mumbai.jpg',
        fit: BoxFit.fill,
      ),
    );
  }

  InkWell romanticpacakges() {
    return InkWell(
      onTap: () {},
      child: Container(
          width: 320.0,
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Taj Santacruz, Mumbai Escapade 2N - With Flights',
                      style: blackB15),
                  SizedBox(height: 10.0),
                  Container(
                      height: 200.0,
                      width: 300,
                      child: Image.asset('images/mumbai2.jpg', fit: BoxFit.fill)),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.hotel,
                            size: 20.0,
                          ),
                          Text(
                            'Hotel',
                            style: blackB1,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.flight,
                            size: 20.0,
                          ),
                          Text(
                            'Flight',
                            style: blackB1,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.person,
                            size: 20.0,
                          ),
                          Text(
                            'Activity',
                            style: blackB1,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.car_rental,
                            size: 20.0,
                          ),
                          Text(
                            '1 Transfer',
                            style: blackB1,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '2N Mumbai',
                    style: red12,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '\u{20B9}${20000}',
                    style: blackLineThrough,
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    '\u{20B9}${19000}',
                    style: black20,
                  ),
                ],
              ),
            ),
          )),
    );
  }



  Container offersContainer() {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return Container(
      width: 500.0,
      height: 210.0,
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
                              width: swidth / 8,
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

  Container searchButton() {
    double width = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return Container(
        height: 45,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: TextButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'SEARCH',
                style: white15,
              ),
            )));
  }

  InkWell startingDateContainer() {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        color: Color(0xFF233951),
        width: 250,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STARTING DATE',
                style: blue15,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Wed-22 June 2022',
                style: white15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell goingToContainer() {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        color: Color(0xFF233951),
        width: 250,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GOING TO',
                style: blue15,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Mumbai',
                style: white15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column filterColumn() {
    return Column(
      children: [
        Container(
            width: 300.0,
            //color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Filters',
                    style: blackB20,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Price:',
                    style: grey15,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        '\u{20B9}${0}',
                        style: blackB15,
                      ),
                      Text(' - '),
                      Text(
                        '\u{20B9}${2000}',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        '\u{20B9}${2000}',
                        style: blackB15,
                      ),
                      Text(' - '),
                      Text(
                        '\u{20B9}${3500}',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        '\u{20B9}${0}',
                        style: blackB15,
                      ),
                      Text(' - '),
                      Text(
                        '\u{20B9}${2000}',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        '\u{20B9}${3500}',
                        style: blackB15,
                      ),
                      Text(' - '),
                      Text(
                        '\u{20B9}${30000}',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        '\u{20B9}${30000}',
                        style: blackB15,
                      ),
                      Text(' + '),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Star Category:',
                    style: grey15,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        '7 Star',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        '5 Star',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        '3 Star',
                        style: blackB15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'User Rating:',
                    style: grey15,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        '4.5 & above',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        '4 & above',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        '3 & above',
                        style: blackB15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Property Type:',
                    style: grey15,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Hotel',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Villa',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Cottage',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Service Apartment',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'House',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Resort',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Guest House',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Apart-Hotel',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Hostel',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Holiday Home',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Farm House',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Beach Hut',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Lodge',
                        style: blackB15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Amenities:',
                    style: grey15,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Swimming Pool',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Spa',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Caretacker',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Parking',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Banquet Hall',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Conference Room',
                        style: blackB15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value;
                          });
                        },
                      ),
                      // SizedBox(width:20.0),
                      Text(
                        'Lift',
                        style: blackB15,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }

  InkWell searchContainerCity() {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        color: Color(0xFF233951),
        width: 250,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STARTING FROM',
                style: blue15,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Pune',
                style: white15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

DropdownButtonHideUnderline buildDropdownButtonSortBy() {
  String _friendsValue;
  List _friendsName = [
    'Popularity',
    'Price-Low to High',
    'Price-High to Low',
    'User Rating-High to low',
  ];
  return DropdownButtonHideUnderline(
    child: DropdownButton(
      hint: Text(' Sort by:',
          style: GoogleFonts.quicksand(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14.0)),
      dropdownColor: Colors.white,
      iconSize: 20.0,
      icon: Icon(Icons.arrow_drop_down),
      value: _friendsValue,
      style: GoogleFonts.quicksand(
          fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
      onChanged: (value) {
        // setState(() {
        //   _friendsValue = value;
        // });
      },
      items: _friendsName.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  );
}
