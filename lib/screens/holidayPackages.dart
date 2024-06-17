import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../api_services/holiday_packages/get_all_packages_api.dart';
import '../api_services/holiday_packages/get_holiday_categoryapi.dart';
import 'Drawer.dart';
import 'constant.dart';
import 'footer.dart';
import 'header.dart';

import 'holiday_widgets/packageList.dart';

class Holiday_Packages extends StatefulWidget {
  const Holiday_Packages({Key key}) : super(key: key);

  @override
  _Holiday_PackagesState createState() => _Holiday_PackagesState();
}

class _Holiday_PackagesState extends State<Holiday_Packages> {
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
  void initState() {
    super.initState();
    // showContents = false;
    print("init");
    getPackages();

    getholidayCategoryAPI();
    // Future.delayed(const Duration(seconds: 2), () {
    //   setState(() {
    //     showContents = true;
    //   });
    // });
  }

  List<Package> packageList = [];
  getPackages() async {
    log('1st');
    String res = await holidayPackagesAPI();
    log("res: $res");
    if (res != "failed") {
      HolidayPackageobj obj = HolidayPackageobj.fromJson(jsonDecode(res));
      List<Package> data = obj.packages;
      setState(() {
        packageList = data;
      });
    } else {
      log("failed");
    }
    log("List length:${packageList.length}");
  }

  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: currentwidth < 600
          ? AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              // iconTheme: const IconThemeData(color: Colors.black, size: 40),
              backgroundColor: Colors.white,
              title: Text(
                'Tour',
                style: blackB15,
              ),
            )
          : CustomAppBar(),
      drawer: currentwidth < 600 ? drawer() : null,
      body: (packageList.length == 0 )
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50.0),
                  PackageRow(swidth, sheight, packageList),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: sheight*.17),
                  buildFooter(),
                ],
              ),
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
                          Text('Date Of Departure',
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
}
