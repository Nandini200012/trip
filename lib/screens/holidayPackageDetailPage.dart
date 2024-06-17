import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trip/common/print_funtions.dart';
import 'package:trip/screens/footer.dart';

import '../api_services/holiday_packages/get_all_packages_api.dart';
import '../api_services/holiday_packages/get_holiday_categoryapi.dart';
import '../api_services/holiday_packages/get_packages_byid_api.dart';
import 'Drawer.dart';
import 'constant.dart';
import 'header.dart';

class holidayPackageDetailPage extends StatefulWidget {
  String pid;
  holidayPackageDetailPage({this.pid});

  @override
  State<holidayPackageDetailPage> createState() =>
      _holidayPackageDetailPageState();
}
// Details packageDetails;
class _holidayPackageDetailPageState extends State<holidayPackageDetailPage>
    with TickerProviderStateMixin {
  final dataKey = GlobalKey();
  final datakeyDetailedPrice = GlobalKey();
  final dataKeyOverview = GlobalKey();
  final dataKeyItineary = GlobalKey();
  final List<int> steps = [1, 2, 3, 4];
 @override
    void initState() {
      super.initState();
      // getPackageDetails(widget.pid);
      // getholidayCategoryAPI();
    }
  // getPackageDetails(String pid) async {
  //   String res = await getHolidayPackagesdetailsAPI(widget.pid);
  //   if (res != "failed") {
  //     HolidayPackagedetails obj =
  //         HolidayPackagedetails.fromJson(jsonDecode(res));
  //     List<Details> data = obj.data;
  //     setState(() {
  //       packageDetails = data[0];
  //     });
  //   }
  //   printred("List length:${packageDetails.categoryName}");
  // }

  @override
  Widget build(BuildContext context) {
   

    double width = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    TabController _tabController = TabController(length: 2, vsync: this);
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
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return MobileScreen(swidth, sheight, _tabController);
              } else {
                return DesktopScreen(swidth, sheight, _tabController, width);
              }
            },
          ),
        ));
  }

//  MobileScreen(swidth, sheight, _tabController),
  Padding MobileScreen(
      double swidth, double sheight, TabController _tabController) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          detailContainer(swidth, sheight),
          tabbar(swidth, _tabController),
          specialNote(),
          cancellationPolicy(),
          remarks(),
        ],
      ),
    );
  }

//DesktopScreen(swidth, sheight, _tabController, width),
  SingleChildScrollView DesktopScreen(double swidth, double sheight,
      TabController _tabController, double width) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 100.0,
              right: 100.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailContainer(swidth, sheight),
                    SizedBox(width: 50.0),
                    Expanded(
                      child: Column(
                        children: [
                          PriceCard(),
                          SizedBox(height: 20.0),
                          OffersAndCoupons()
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: tabbar(swidth, _tabController),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: specialNote(),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                    // height:swidth/4,
                    width: width,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: cancellationPolicy(),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: remarks(),
                          ),
                        )
                      ],
                    )),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          buildFooter()
        ],
      ),
    );
  }

  Column remarks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Remarks', style: blackB15),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Airlines/Room up-gradation and complimentary will not be entertained during the tour unless if specified at the time of booking..',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 There is no refund for any services not utilized during the tour.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Security deposit is required either in cash or credit card by hotels which is refundable provided no room incidentals are incurred. This security deposit is not included in this quote and must be paid by the guests/corporate directly to the hotel when checking in..',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Guests are advised not to keep valuables in the coach/vehicle while sightseeing. The Company shall not be responsible for loss of valuables from the coach / vehicle . If the coach / vehicle is accidentally or otherwise damaged by the Guest, s/he will be required to pay compensation for the same..',
          style: black15,
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Column specialNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(' Special Note', style: blackB15),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Holiday Price valid for travel till 30th September 2022.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Please carry original ID Proof (Voter ID card /Passport/Driving License/) etc. for security purpose & hotel policy.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Confirmation of room is subject to availability.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Rate cannot be availed in conjunction with any other ongoing offers or promotion.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Rates are subject to change without prior notice.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Check-in timing is 1400 hrs and our check-out time is 1200 hrs.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Vehicle will be not at disposal. If guest wish to go for additional sightseeing extra charges will be applicable.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Itinerary is subject to change without prior notice ',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 The Hotel Rooms are subject to availability. If the above mentioned hotels are not available similar category hotels will be used.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 The above holiday Price is approximate & based on Standard room of individual hotel, however if similar category of room is unavailable, the upgradation cost will be borne by the guest..',
          style: black15,
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Container tabbar(double swidth, TabController _tabController) {
    return Container(
      height: 500.0,
      // height: swidth / 3,
      // width: 500.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tour Information',
              key: dataKey,
              style: black20,
            ),
            SizedBox(height: 20.0),
            TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.blueAccent),
              ),
              indicatorColor: Colors.blueAccent,
              labelColor: Color(0xFF0d2b4d),
              unselectedLabelColor: Colors.black,
              controller: _tabController,
              isScrollable: true,
              tabs: [
                Container(
                    height: 30.0,
                    // width: 90.0,
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //     width: 2,
                    //     color: Colors.grey[100],
                    //   ),
                    //   borderRadius: BorderRadius.circular(5.0),
                    // ),
                    child: Tab(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Inclusions', style: blackB15)))),
                Container(
                    height: 30.0,
                    // width: 90.0,
                    decoration: BoxDecoration(
                        //color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Tab(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Exclusion', style: blackB15)))),
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
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u2022 The rates are valid for Indian nationals only',
                            style: black15,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '\u2022 The rates are valid for Indian nationals only',
                            style: black15,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '\u2022 Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                            style: black15,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '\u2022 The rates are valid for Indian nationals only',
                            style: black15,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '\u2022 The rates are valid for Indian nationals only',
                            style: black15,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '\u2022 Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                            style: black15,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '\u2022 The rates are valid for Indian nationals only',
                            style: black15,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '\u2022 Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                            style: black15,
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    )),
                    //<------------------------------------------------->//
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\u2022 Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
                            style: black15,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '\u2022 The rates are valid for Indian nationals only',
                            style: black15,
                          ),
                        ],
                      ),
                    )),
                    //<---------------------------------------------------------->//
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column cancellationPolicy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cancellation Policy', style: blackB15),
        SizedBox(height: 10.0),
        Text(
          '\u2022 If the Guest decides to cancel the tour for any reason whatsoever then s/he shall give a written application to the Company within specified time limit along with original receipt issued by the Company. Such cancellation will attract cancellation charges stated hereunder.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Cancellation charges will be calculated on gross tour cost and the cancellation charges shall depend on date of departure and date of cancellation.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Cancellation charges for any type of transport ticket are applicable as per the rules of the concerned authority..',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Air tickets issued on special fares are NON REFUNDABLE and Guest shall bear cancellation charges.',
          style: black15,
        ),
        SizedBox(height: 10.0),
        Text(
          '\u2022 Any refund payable to the Guest will be paid after the Company receives refund from the respective authorities. The Company deducts processing charges from the refund to be paid to the Guest.',
          style: black15,
        ),
      ],
    );
  }

  Container detailContainer(double swidth, double sheight) {
    double width = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    return Container(
      width: currentwidth < 600 ? width : swidth / 1.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Home > India >Goa > Goa Kyriad Prestige Calangute',
                    style: blackB14,
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                  'Goa Kyriad Prestige Calangute',
                    style: black25,
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    '4 Days - 1 country 1 City',
                    style: blackB14,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                    width: currentwidth < 600 ? width : swidth / 1.8,
                    height: sheight / 3,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'images/holiday.jpg',
                          fit: BoxFit.fill,
                        ))),
                SizedBox(height: 10.0),
                Container(
                  width: currentwidth < 600 ? width : swidth / 1.8,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Scrollable.ensureVisible(
                                  dataKeyOverview.currentContext);
                            },
                            child: Text(
                              'OverView',
                              style: blackB15,
                            )),
                        SizedBox(
                          width: 30.0,
                        ),
                        TextButton(
                            onPressed: () {
                              Scrollable.ensureVisible(
                                  dataKeyItineary.currentContext);
                            },
                            child: Text(
                              'Itineary',
                              style: blackB15,
                            )),
                        SizedBox(
                          width: 30.0,
                        ),
                        TextButton(
                            onPressed: () {
                              Scrollable.ensureVisible(
                                  datakeyDetailedPrice.currentContext);
                            },
                            child: Text(
                              'Detailed Price',
                              style: blackB15,
                            )),
                        SizedBox(
                          width: 30.0,
                        ),
                        TextButton(
                            onPressed: () {
                              Scrollable.ensureVisible(dataKey.currentContext);
                            },
                            child: Text(
                              'Tour Information',
                              style: blackB15,
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            key: dataKeyOverview,
            style: black15,
          ),
          SizedBox(height: 20.0),
          Text(
            'Holiday Experience',
            style: black15,
          ),
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 5,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text('Explore Goa', style: black15),
            ],
          ),
          SizedBox(height: 20.0),
          Text('Itinerary', key: dataKeyItineary, style: black20),
          SizedBox(height: 20.0),
          Container(
            width: currentwidth < 600 ? width : swidth / 1.8,
            // height: sheight / 3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  color: Colors.blue.shade100,
                  constraints:
                      BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.blue)),
                        child: Text(
                          '5 DAY PLAN',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.shade200,
                        ),
                        child: Text('2 FLIGHTS'),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.shade200,
                        ),
                        child: Text('1 HOTEL'),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.shade200,
                        ),
                        child: Text('2 ACTIVITIES'),
                      ),
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     Container(
                //       padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                //       child: Text('Day Plan'),
                //     ),
                //     Container(
                //       padding: EdgeInsets.fromLTRB(40, 0, 10, 10),
                //       child: Text('Day 1 - Arrival in Male', style: TextStyle(fontWeight: FontWeight.bold),),
                //     ),
                //   ],
                // ),
                Container(
                  constraints:
                      BoxConstraints(minWidth: 0, maxWidth: double.infinity),
                  width: currentwidth < 600 ? width : swidth / 1.8,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                              child: Text('Day Plan'),
                            ),
                            IntrinsicHeight(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
                                child: Column(
                                  children: [
                                    Container(
                                      // color: Colors.black,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Icon(Icons.circle,
                                                  color: Colors.grey, size: 10),
                                              SizedBox(
                                                height: 24,
                                                child: VerticalDivider(
                                                  color: Colors.grey,
                                                  thickness: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 20),
                                              child: Text('28-04-2023'))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Icon(Icons.circle,
                                                  color: Colors.grey, size: 10),
                                              SizedBox(
                                                height: 24,
                                                child: VerticalDivider(
                                                  color: Colors.grey,
                                                  thickness: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 20),
                                              child: Text('29-04-2023'))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Icon(Icons.circle,
                                                  color: Colors.grey, size: 10),
                                              SizedBox(
                                                height: 24,
                                                child: VerticalDivider(
                                                  color: Colors.grey,
                                                  thickness: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 20),
                                              child: Text('30-04-2023'))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Icon(Icons.circle,
                                                  color: Colors.grey, size: 10),
                                              SizedBox(
                                                height: 24,
                                                child: VerticalDivider(
                                                  color: Colors.grey,
                                                  thickness: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 20),
                                              child: Text('01-05-2023'))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IntrinsicHeight(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 0, maxWidth: double.infinity),
                                  color: Colors.grey.shade200,
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        padding:
                                            EdgeInsets.fromLTRB(8, 4, 8, 4),
                                        color: Colors.deepOrangeAccent.shade100,
                                        child: Text(
                                          'Day 1 - Arrival in Male',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // SizedBox(width: 200),
                                      Spacer(),
                                      Container(
                                        // padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                                        child: Text(
                                          'INCLUDED:',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        // padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                                        child: RotatedBox(
                                          quarterTurns: 1,
                                          child: Icon(
                                            Icons.airplanemode_active,
                                            textDirection: TextDirection.ltr,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        // padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                                        child: Text('1 Flight',
                                            style: TextStyle(fontSize: 10)),
                                      ),
                                      VerticalDivider(),
                                      Icon(
                                        Icons.apartment,
                                        size: 10,
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        // padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                                        child: Text('1 Hotel',
                                            style: TextStyle(fontSize: 10)),
                                      ),
                                      VerticalDivider(),
                                      Icon(
                                        Icons.elderly_sharp,
                                        size: 10,
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        // padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                                        child: Text('1 Activity',
                                            style: TextStyle(fontSize: 10)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Text(
                                              'Flight for New Delhi to Male'),
                                        ),
                                        SizedBox(width: 4),
                                        Container(
                                          child: Text(
                                            '07h 30m',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // SizedBox(width: 340),
                                        Spacer(),
                                        Container(
                                          child: Text('REMOVE',
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          child: Text('CHANGE',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                          minWidth: 0,
                                          maxWidth: double.infinity),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  20, 0, 0, 0),
                                              child: Icon(
                                                Icons.airplanemode_active,
                                                size: 20,
                                                color: Colors.blue,
                                              )),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 20, 0, 0),
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '09:35',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'Fri,28 Oct',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  'New Delhi',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            Icons.circle,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            width: width * 0.02,
                                            child: Divider(thickness: 1.5),
                                          ),
                                          Container(
                                            child: RotatedBox(
                                                quarterTurns: 1,
                                                child: Icon(
                                                  Icons.airplanemode_active,
                                                  color: Colors.blue,
                                                  size: 20,
                                                )),
                                          ),
                                          Container(
                                            width: width * 0.02,
                                            child: Divider(thickness: 1.5),
                                          ),
                                          Icon(
                                            Icons.circle,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 20, 0, 0),
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '12:45',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  'Fri,28 Oct',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  'Kochi',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Baggage',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 8),
                                                IntrinsicHeight(
                                                  child: Row(
                                                    children: [
                                                      Text('Cabin: 7 Kgs',
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                      VerticalDivider(),
                                                      Row(
                                                        children: [
                                                          Text('Check-In:',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      12)),
                                                          Text('20 Kgs',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                          minWidth: 0,
                                          maxWidth: double.infinity),
                                      color: Colors.grey.shade200,
                                      width: double.infinity,
                                      // padding: EdgeInsets.fromLTRB(width/4, 8, 0, 8),
                                      // margin: EdgeInsets.fromLTRB(200, 0, 0, 0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '02h 35m  Layover in COK, Kochi',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  20, 0, 0, 0),
                                              child: Icon(
                                                Icons.airplanemode_active,
                                                size: 20,
                                                color: Colors.blue,
                                              )),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 20, 0, 0),
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '15:20',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('Fri,28 Oct',
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                Text('Kochi',
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            Icons.circle,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            width: width * 0.02,
                                            child: Divider(thickness: 1.5),
                                          ),
                                          Container(
                                            child: RotatedBox(
                                                quarterTurns: 1,
                                                child: Icon(
                                                  Icons.airplanemode_active,
                                                  color: Colors.blue,
                                                  size: 20,
                                                )),
                                          ),
                                          Container(
                                            width: width * 0.02,
                                            child: Divider(thickness: 1.5),
                                          ),
                                          Icon(
                                            Icons.circle,
                                            size: 10,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 20, 0, 0),
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '16:35',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('Fri,28 Oct',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                                Text('Male',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Baggage',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 8),
                                                IntrinsicHeight(
                                                  child: Row(
                                                    children: [
                                                      Text('Cabin: 7 Kgs',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          )),
                                                      VerticalDivider(),
                                                      Row(
                                                        children: [
                                                          Text('Check-In:',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              )),
                                                          Text('20 Kgs',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // ExpansionTile(
                //   title: Row(
                //     children: [
                //       Text('Day 1', style: blackB16),
                //       SizedBox(width: 100.0),
                //       Text(
                //         'Goa Airport - Hotel',
                //         style: blackB15,
                //       ),
                //     ],
                //   ),
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(10.0),
                //       child: Text(
                //           'Arrive at Goa Airport and proceed by scheduled shared transfer to your hotel. You have the rest of the day at leisure. Overnight in Goa.'),
                //     )
                //   ],
                // ),
                // SizedBox(height: 20.0),
                // ExpansionTile(
                //   title: Row(
                //     children: [
                //       Text('Day 2', style: blackB16),
                //       SizedBox(width: 100.0),
                //       Text(
                //         'Goa – North Goa sightseeing',
                //         style: blackB15,
                //       ),
                //     ],
                //   ),
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(10.0),
                //       child: Text(
                //           'Today proceed for a half day sightseeing trip of North Goa. Visit Vagator Beach & Fort Aguada. Overnight in Goa.'),
                //     )
                //   ],
                // ),
                // SizedBox(height: 20.0),
                // ExpansionTile(
                //   title: Row(
                //     children: [
                //       Text('Day 3', style: blackB16),
                //       SizedBox(width: 100.0),
                //       Text(
                //         'Goa – Day is at leisure',
                //         style: blackB15,
                //       ),
                //     ],
                //   ),
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(10.0),
                //       child: Text(
                //           'Today after breakfast, day is at leisure. Enjoy free time on the beach. Overnight in Goa.'),
                //     )
                //   ],
                // ),
                // SizedBox(height: 20.0),
                // ExpansionTile(
                //   title: Row(
                //     children: [
                //       Text('Day 4', style: blackB16),
                //       SizedBox(width: 100.0),
                //       Text(
                //         'Goa – Departure to hometown',
                //         style: blackB15,
                //       ),
                //     ],
                //   ),
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(10.0),
                //       child: Text(
                //           'After breakfast it’s time to check out. Transfer to the airport for your flight back home. Holiday Concludes. Let’s stay in touch on Facebook\email and meet again on another memorable Holiday. See you soon!'),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Text('Detailed Tour Price',
              key: datakeyDetailedPrice, style: black20),
          SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            width: currentwidth < 600 ? width : swidth / 1.8,
            // height: sheight / 3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15, left: 15),
                          child: Text(
                            'Room Type',
                            style: blackB15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Center(
                              child: Text(
                            '1-10 Guest',
                            style: blackB15,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15, left: 15),
                          child: Text(
                            'Triple Sharing',
                            style: black15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Center(
                              child: Text(
                            'INR 10,000',
                            style: black15,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15, left: 15),
                          child: Text(
                            'Twin Sharing',
                            style: black15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Center(
                              child: Text(
                            'INR 11,000',
                            style: black15,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15, left: 15),
                          child: Text(
                            'Child With Mattress',
                            style: black15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Center(
                              child: Text(
                            'INR 9,000',
                            style: black15,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15, left: 15),
                          child: Text(
                            'Child (4-11)',
                            style: black15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                          child: Center(
                              child: Text(
                            'INR 8,000',
                            style: black15,
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'NOTES',
                    style: blackB15,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Payment Terms',
                          style: blue12,
                        ),
                      ),
                      SizedBox(width: 30.0),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Cancellation Policy',
                            style: blue12,
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                '\u2022 The rates are valid for Indian nationals only',
                style: black15,
              ),
              Text(
                '\u2022 Hotels might ask for a refundable Security Deposit at the time of check-in, which is payable in Cash or by Credit Card',
                style: black15,
              ),
              Text(
                '\u2022 The value and currency of the deposit might vary as per the hotel policy.',
                style: black15,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Card PriceCard() {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Container(
            color: Color(0xFFEAF5FF),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\u{20B9}${26000}',
                        style: blackLineThrough,
                      ),
                      Container(
                        color: Colors.redAccent[400],
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            '29% OFF',
                            style: white15,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '\u{20B9}{packageDetails.packageAmount}',
                        style: blackB20,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'per person*',
                        style: black12,
                      )
                    ],
                  ),
                  Text(
                    'Excluding applicable taxes',
                    style: black12,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                  size: 15,
                ),
                SizedBox(width: 10.0),
                Text(
                  '2 Sep - 5 Sep',
                  style: blackB15,
                ),
                Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Mofify',
                      style: blue12,
                    ))
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent[400],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'PROCEED TO BOOK ONLINE',
                        style: white15,
                      )),
                )),
          )
        ],
      ),
    );
  }

  Card OffersAndCoupons() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coupons & Offers',
              style: blackB20,
            ),
            SizedBox(height: 20.0),
            Container(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'No Cost EMI @',
                          style: blackB1,
                        ),
                        Text('\u{20B9}${2000}', style: blackB1),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Book your holidays with Easy',
                      style: grey12,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Emi Options',
                          style: blue12,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    width: 1, color: Colors.grey[200],
                    //style: BorderStyle.solid
                  )),
              height: 40.0,
              child: TextField(
                decoration: InputDecoration(
                  // focusColor: Colors.grey[200],
                  border: InputBorder.none,
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Apply',
                      style: blue12,
                    ),
                  ),
                  hintText: "   Have a coupon code?",
                  hintStyle: blackB1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
