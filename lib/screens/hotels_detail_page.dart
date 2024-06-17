import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Drawer.dart';
import 'constant.dart';
import 'footer.dart';
import 'header.dart';

class hotels_detail_page extends StatefulWidget {
  const hotels_detail_page({Key key}) : super(key: key);

  @override
  _hotels_detail_pageState createState() => _hotels_detail_pageState();
}

class _hotels_detail_pageState extends State<hotels_detail_page>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    TabController _tabController = TabController(length: 4, vsync: this);
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
      drawer: currentwidth < 600
          ? drawer()
          : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return buildSingleChildScrollViewMobileView(
                _tabController, currentwidth, width);
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
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 1500,
              height: 90.0,
              color: Color(0xFF0d2b4d),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 50.0, top: 10.0, right: 10.0, bottom: 10),
                    child: SearchContainerCity(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ContainerCheckIn(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ContainerCheckOut(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ContainerRoomsGuests(),
                  ),
                  SizedBox(width: 50.0),
                  SearchButton()
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 1200.0,
              // color: Colors.yellow,
              height: 420.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HotelName(),
                        SizedBox(
                          height: 10.0,
                        ),
                        HotelDescription(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              CarouselSliderImages(),
                              SizedBox(width: 20.0),
                              Amenities(),
                              SizedBox(width: 20.0),
                              HotelFacilities()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[200],
            thickness: 0.8,
          ),
          Center(
            child: buildContainerTabBar(_tabController, currentwidth, width),
          ),
          buildFooter(),
        ],
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollViewMobileView(
      TabController _tabController, double currentwidth, double width) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: SearchContainerCity()),
                SizedBox(width: 5),
                Expanded(child: ContainerCheckIn()),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(child: ContainerCheckOut()),
                SizedBox(width: 5),
                Expanded(child: ContainerRoomsGuests()),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            SearchButton(),
            SizedBox(
              height: 10.0,
            ),
            HotelName(),
            SizedBox(
              height: 10.0,
            ),
            HotelDescription(),
            SizedBox(
              height: 10.0,
            ),
            CarouselSliderImages(),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(child: Amenities()),
                SizedBox(width: 5.0),
                Expanded(child: HotelFacilities()),
              ],
            ),
            SizedBox(height: 10.0),
            buildContainerTabBar(_tabController, currentwidth, width),
          ],
        ),
      ),
    );
  }

  Container buildContainerTabBar(
      TabController _tabController, double currentwidth, double width) {
    return Container(
      width: 1300,
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
              TabBar(
                // indicator: BoxDecoration(
                //     // borderRadius: BorderRadius.circular(15.0),
                //     // border: Border.all(color: Colors.black),
                //     ),
                indicatorColor: Colors.blueAccent,
                labelColor: Color(0xFF0d2b4d),
                unselectedLabelColor: Colors.black,
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
                              child: Text('Amenities', style: blue15)))),
                  Container(
                      // width: 90.0,
                      decoration: BoxDecoration(

                          //color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Tab(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('About Property', style: blue15)))),
                  Container(
                      // width: 90.0,
                      decoration: BoxDecoration(
                          // color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Tab(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Users Review', style: blue15)))),
                  Container(
                      // width: 90.0,
                      decoration: BoxDecoration(
                          // color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Tab(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text('Location', style: blue15)))),
                ],
              ),
              Expanded(
                child: Container(
                  // color: Colors.grey,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      //<-----------------------amenities---------------------------->//
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Amenities at Hotel Manama', style: blackB15),
                            Divider(color: Colors.grey, thickness: 0.5),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child:
                                      Text('Popular Amenities', style: white15),
                                )),
                            SizedBox(height: 10.0),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                Row(
                                  children: [
                                    Icon(Icons.wifi, color: Colors.green),
                                    SizedBox(width: 10),
                                    Text(
                                      'Free Internet',
                                      style: blackB14,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.check, color: Colors.green),
                                    SizedBox(width: 10),
                                    Text(
                                      'Air Conditioning',
                                      style: blackB14,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.check, color: Colors.green),
                                    SizedBox(width: 10),
                                    Text(
                                      'Power backup',
                                      style: blackB14,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.check, color: Colors.green),
                                    SizedBox(width: 10),
                                    Text(
                                      'Doctor on call',
                                      style: blackB14,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.check, color: Colors.green),
                                    SizedBox(width: 10),
                                    Text(
                                      'Swimming Pool',
                                      style: blackB14,
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                            Divider(color: Colors.grey, thickness: 0.5),
                            SizedBox(height: 10.0),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dining',
                                        style: blackB15,
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Special Diet Meals',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Restaurant',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Dining Area',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Internet',
                                        style: blackB15,
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Free Wi-Fi',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Services',
                                        style: blackB15,
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Special Diet Meals',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Restaurant',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Dining Area',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Special Diet Meals',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Restaurant',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Dining Area',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Special Diet Meals',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Restaurant',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Dining Area',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'General',
                                        style: blackB15,
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Special Diet Meals',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Restaurant',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Dining Area',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Room',
                                        style: blackB15,
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Special Diet Meals',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Restaurant',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Dining Area',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Safety & Hygiene',
                                        style: blackB15,
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Special Diet Meals',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Restaurant',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Dining Area',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 30.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Others',
                                        style: blackB15,
                                      ),
                                      SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Special Diet Meals',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Restaurant',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          SizedBox(width: 10),
                                          Text(
                                            'Dining Area',
                                            style: blackB14,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                      //<------------------------about property--------------------------->//
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'OverView',
                                style: blackB15,
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                  'Hotel Manama is a good choice for travellers looking for a 3 star hotel in Mumbai. It is located in South Mumbai. Hotel is rated 3.6 out of 5, which is considered as good. The property enjoys a great location advantage and provides easy and fast connectivity to the major transit points of the city. Some of the popular transit points from Hotel Manama are Chhatrapati Shivaji Maharaj Terminus (830 mtrs), Mumbai Port Trust (850 mtrs) and Yellow Gate Victoria Docks (1.1 kms). The Hotel is in proximity to some popular tourist attractions and other places of interest in Mumbai. Some of the tourist attractions near Hotel Manama Brabourne Stadium (2.3 kms), Wankhede Stadium Mumbai (3.0 kms), Austria Embassy (3.4 kms), Chowpatty Beach (4.3 kms), Mumbai Chowpatty Beach (4.4 kms) and Siddhivinayak Temple (10.1 kms).From all the 3 Star hotels in Mumbai, Hotel Manama is very much popular among the tourists. A smooth check-in/check-out process, flexible policies and friendly management garner great customer satisfaction for this property. The Hotel has standard Check-In time as 12:00 PM and Check-Out time as 11:00 AM.78% of the guests have recommended Hotel Manama on our platform. Good service quality, nice location, good stay experience and good food are some highly appreciated and talked about aspects of the Hotel Manama. With an overall rating of 3.6 out of 5 (1066 Ratings), the property is rated very good by 25% of the guests, 30% have rated it good, 21% have rated it average and 24% have rated it as bad. Also, we recommend that guests must go through traveller reviews and ratings posted by fellow travellers on the Goibibo platform to ensure that Hotel Manama is best suited for them. For more detailed information about this hotel, you can check the Questions & Answers section as well on Goibibo. There you can find the answers of the questions asked by some of our users about this property.In terms of Location 100% people like the location of Hotel Manama. Out of which 74% guest said property is Easy to Locate. and 70% said that property is Easily Accessible. Safety And Hygiene is the top priority for the Hotel Manama with score 56%. 46% Guests like the Thermal Screening feature. Staff Hygiene feature is liked by 51% users. Social Distancing is also followed by the staff of Hotel Manama the score for this feature is 71%. Hotel Manama provides a top class Service Quality as 72% guest liked it. Overall Food of Hotel Manama is liked by the 60% guests. Hotel Manama Amenities are liked by the 75% of guest. Restaurant is liked by the 60% guests. 65% guest said Wi-Fi of Hotel Manama was good. Also 100% guest said that Television was working in their rooms.You can find numerous hotels in Mumbai under different categories and Hotel Manama is one the best hotel under its category.',
                                  style: black15),
                            ],
                          ),
                        ),
                      )),
                      //<-----------------------review---------------------------->//
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Guest Reviews & Rating for Hotel Manama',
                                  style: blackB15),
                              SizedBox(height: 10.0),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.grey[200]),
                                    // color:Colors.grey[200],
                                  ),
                                  width: currentwidth < 600 ? width : 1300.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            child: const CircleAvatar(
                                              radius: 100,
                                              backgroundImage:
                                                  AssetImage('qr.png'),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Hiren Bhandari',
                                                        style: blackB15),
                                                    SizedBox(width: 5),
                                                    Expanded(
                                                      child: Text(
                                                          '(Stayed 5 Mar, 2022)',
                                                          style: grey15),
                                                    ),
                                                    SizedBox(width: 20),
                                                    ratedStars()
                                                  ],
                                                ),
                                                Text(
                                                    'The hotel location is very good and easily identifiable. The entrance is also good and reception and loby area also good. But there after the floor lobby is very small and room size are also small but better then others hotel in this location. Staff are cooperative. Breakfast provided by them is very good',
                                                    style: black15),
                                                SizedBox(height: 20),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Container(
                                                            height: 100.0,
                                                            width: 100.0,
                                                            child: Image.asset(
                                                                'images/img_1.png',
                                                                fit: BoxFit
                                                                    .fill)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Container(
                                                            height: 100.0,
                                                            width: 100.0,
                                                            child: Image.asset(
                                                                'images/img_1.png',
                                                                fit: BoxFit
                                                                    .fill)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Container(
                                                            height: 100.0,
                                                            width: 100.0,
                                                            child: Image.asset(
                                                                'images/img_1.png',
                                                                fit: BoxFit
                                                                    .fill)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                  )),
                            ],
                          ),
                        ),
                      )),
                      //<------------------------location--------------------------->//
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Location of Hotel Manama', style: blackB15),
                            SizedBox(height: 10.0),
                            Divider(color: Colors.grey[300], thickness: 0.5),
                            SizedBox(height: 10.0),
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.grey),
                                  hintText: 'Search Area',
                                  filled: true,
                                  fillColor: Colors.grey[100]),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              height: 350.0,
                              width: 1300.0,
                              child: Image.asset('images/map.PNG', fit: BoxFit.fill),
                            ),
                          ],
                        ),
                      )),
                      //<--------------------------------------------------->//
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

  Container ratedStars() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text('5/5', style: whiteB12),
        ));
  }

  Container CarouselSliderImages() {
    return Container(
      height: 300.0,
      width: 600.0,
      child: ListView(
        children: [
          CarouselSlider(
            items: [
              //1st Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/338504/pexels-photo-338504.jpeg?cs=srgb&dl=pexels-thorsten-technoman-338504.jpg&fm=jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //2nd Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8aG90ZWxzfGVufDB8fDB8fA%3D%3D&w=1000&q=80"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //3rd Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/338504/pexels-photo-338504.jpeg?cs=srgb&dl=pexels-thorsten-technoman-338504.jpg&fm=jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //4th Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/338504/pexels-photo-338504.jpeg?cs=srgb&dl=pexels-thorsten-technoman-338504.jpg&fm=jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //5th Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/338504/pexels-photo-338504.jpeg?cs=srgb&dl=pexels-thorsten-technoman-338504.jpg&fm=jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            //Slider Container properties
            options: CarouselOptions(
              height: 300.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 400),
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Container HotelFacilities() {
    return Container(
      height: 300.0,
      width: 250.0,
      decoration: BoxDecoration(
        // color: Colors.yellow,
        // border: Border.all(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.wine_bar_rounded,
                      size: 15,
                    ),
                    Text(
                      'Free Breakfast Available',
                      style: blu12,
                    )
                  ],
                ),
              )),
          SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFfdf6e9),
              border: Border.all(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price starts at:',
                    style: blackB15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\u{20B9}${4844}',
                        style: blackB15,
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Text('+', style: blackB14),
                          Text(
                            '\u{20B9}${933}',
                            style: blackB14,
                          ),
                          SizedBox(width: 10.0),
                          Text('taxes & fee', style: black12),
                        ],
                      ),
                      Text('1 Room per night', style: black12),
                    ],
                  ),
                  SizedBox(width: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 12,
                            ),
                            SizedBox(width: 10.0),
                            Text('2 x Guests', style: blackB15),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.room_preferences,
                              size: 12,
                            ),
                            SizedBox(width: 10.0),
                            Text('1 x Room', style: blackB15),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            width: 250.0,
            decoration: BoxDecoration(
              color: Colors.orange,
              border: Border.all(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '3.6/5',
                      style: white15,
                    ),
                  ),
                  Text('1066 Verified Ratings', style: white15)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container Amenities() {
    return Container(
      height: 300.0,
      width: 250.0,
      decoration: BoxDecoration(
        // color: Colors.yellow,
        border: Border.all(color: Colors.grey[300]),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              'Amenities & Service',
              style: blackB15,
            )),
            Divider(
              color: Colors.grey[300],
              thickness: 0.5,
            ),
            Row(
              children: [
                Icon(Icons.wifi),
                SizedBox(width: 10),
                Text(
                  'Free Internet',
                  style: blackB14,
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check),
                SizedBox(width: 10),
                Text(
                  'Air Conditioning',
                  style: blackB14,
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check),
                SizedBox(width: 10),
                Text(
                  'Power backup',
                  style: blackB14,
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check),
                SizedBox(width: 10),
                Text(
                  'Doctor on call',
                  style: blackB14,
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check),
                SizedBox(width: 10),
                Text(
                  'Swimming Pool',
                  style: blackB14,
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check),
                SizedBox(width: 10),
                Text(
                  'Doctor on call',
                  style: blackB14,
                ),
              ],
            ),
            TextButton(
                onPressed: () {},
                child: Text('View all amenities', style: blue12)),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check-in',
                      style: black12,
                    ),
                    Text(
                      '12:00 PM',
                      style: blackB15,
                    )
                  ],
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check-out',
                      style: black12,
                    ),
                    Text(
                      '11:00 AM',
                      style: blackB15,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Text HotelDescription() {
    return Text(
      'Opp St. George Hospital, Near Cst Station Mello Road, Mumbai- 400001',
      style: black15,
    );
  }

  Text HotelName() {
    return Text(
      'Hotel Manama',
      style: blackB20,
    );
  }

  Container SearchButton() {
    double swidth = MediaQuery.of(context).size.width;
    return Container(
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

  InkWell ContainerRoomsGuests() {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        color: Color(0xFF233951),
        width:200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ROOMS & GUESTS',
                style: blue15,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '1 ROOM,2 ADULTS',
                style: white15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell ContainerCheckOut() {
    double swidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        color: Color(0xFF233951),
        width:200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CHECK-OUT',
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

  InkWell ContainerCheckIn() {
    double swidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        color: Color(0xFF233951),
        width:200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CHECK-IN:',
                style: blue15,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Tue,21 Jun 2022',
                style: white15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell SearchContainerCity() {
    double swidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        color: Color(0xFF233951),
        width:250,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CITY/AREA OR PROPERTY',
                style: blue15,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                'Mumbai,Maharashtra,India',
                style: white15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
