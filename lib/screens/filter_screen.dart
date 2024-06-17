import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Drawer.dart';
import 'MobileFilter.dart';
import 'constant.dart';
import 'footer.dart';
import 'header.dart';
import 'hotels_detail_page.dart';

class filter_Screen extends StatefulWidget {
  const filter_Screen({Key key}) : super(key: key);

  @override
  _filter_ScreenState createState() => _filter_ScreenState();
}

class _filter_ScreenState extends State<filter_Screen> {
  bool value = false;
  String _friendsValue;
  List _friendsName = [
    'Popularity',
    'Price-Low to High',
    'Price-High to Low',
    'User Rating-High to low',
  ];
  String tripType;
  List _list = ['Buisness', 'Family', 'Romantic'];

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
            return buildSingleChildScrollViewMobileView(width, currentwidth);
          } else {
            return buildSingleChildScrollViewDesktopView(width, currentwidth);
          }
        },
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollViewMobileView(
      double width, double currentwidth) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: searchContainerCity()),
                SizedBox(width: 5),
                Expanded(child: checkInContainer()),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(child: checkoutContainer()),
                SizedBox(width: 5),
                Expanded(child: roomsguestContainer()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: searchButton(),
            ),
            Container(
              width: width,
              color: Color(0xFFcfeffe),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextNavScreens(),
                    SizedBox(height: 20.0),
                    buildTextTitles(currentwidth),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildDropdownButtonSelectTrip(),
                        buildDropdownButtonSortBy(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MobileFilter()));
                          },
                          child: Text(
                            'Filter',
                            style: blue12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    totalPropertiesText(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Recommended for you',
                style: blackB20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [hotelImages(), hotelDetailsColumn()],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [hotelImages(), hotelDetailsColumn()],
                    ),
                  )),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollViewDesktopView(
      double width, double currentwidth) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 1600,
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
                    child: checkInContainer(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: checkoutContainer(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: roomsguestContainer(),
                  ),
                  // Spacer(),
                  SizedBox(width: 50.0),
                  Padding(
                    padding: const EdgeInsets.only(right:20.0),
                    child: searchButton(),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: width,
            height: 150.0,
            color: Color(0xFFcfeffe),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 100.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextNavScreens(),
                      SizedBox(
                        height: 35.0,
                      ),
                      buildTextTitles(currentwidth),
                      Row(
                        children: [
                          buildDropdownButtonSelectTrip(),
                          SizedBox(width: 20.0),
                          buildDropdownButtonSortBy(),
                          SizedBox(width: 20.0),
                          totalPropertiesText(),
                        ],
                      )
                    ],
                  ),
                ),
                // SizedBox(width:200.0),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              filter(value: value),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Recommended for you',
                        style: blackB20,
                      ),
                    ),
                    recommendColumn(),
                    recommendColumn(),
                  ],
                ),
              )
            ],
          ),

          SizedBox(height: 20.0),
          buildFooter(),
        ],
      ),
    );
  }
  //
  // Column filterColumn() {
  //   return Column(
  //     children: [
  //
  //     ],
  //   );
  // }

  Column recommendColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]),
                borderRadius: BorderRadius.circular(5),
              ),
              width: 950.0,
              // height: 225.0,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: hotelImages(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: hotelDetailsColumn(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column hotelImages() {
    double width = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => hotels_detail_page()));
          },
          child: Container(
              height: 130.0,
              width: currentwidth < 600 ? width : 230.0,
              child: Image.asset('images/img.png', fit: BoxFit.fill)),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10),
              child: Container(
                  height: 50.0,
                  width: 50.0,
                  child: Image.asset('images/img_1.png', fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10),
              child: Container(
                  height: 50.0,
                  width: 50.0,
                  child: Image.asset('images/img.png', fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10),
              child: Container(
                  height: 50.0,
                  width: 50.0,
                  child: Image.asset('images/img_2.png', fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10),
              child: Container(
                  height: 50.0,
                  width: 50.0,
                  child: Image.asset('images/img_1.png', fit: BoxFit.fill)),
            ),
          ],
        )
      ],
    );
  }

  Column hotelDetailsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The Lalit Mumbai',
          style: blackB20,
        ),
        Text(
          'Near Mumbai Airport ,1.3 km from T2- Chhatrapati Shivaji International Airport',
          style: blackB14,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
            color: Colors.green[200],
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Couple Friendly',
                style: blackB14,
              ),
            )),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Free cancellation till 24 hrs before check in',
          style: blue12,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '4.3/5 Ratings - 4766 Ratings',
                style: red12,
              ),
            )),
        Divider(
          color: Colors.grey[300],
          thickness: 0.2,
        ),
        Row(
          children: [
            Text(
              '\u{20B9}${9334}',
              style: blackB20,
            ),
            SizedBox(width: 20.0),
            Text(
              '\u{20B9}${10034}',
              style: blackLineThrough,
            ),
          ],
        ),
        Text(
          '+2488 taxes & fees per Night  ',
          style: grey12,
        ),
      ],
    );
  }

  Text buildTextTitles(double currentwidth) {
    return Text(
      'Hotels,Villas,Apartments and more in Mumbai',
      style: currentwidth < 600 ? black20 : black30,
    );
  }

  Text buildTextNavScreens() {
    return Text(
      'Home> Hotels and more in Mumbai',
      style: blackB15,
    );
  }

  DropdownButtonHideUnderline buildDropdownButtonSortBy() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: Text('Sort by:',
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
          setState(() {
            _friendsValue = value;
          });
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

  DropdownButtonHideUnderline buildDropdownButtonSelectTrip() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: Text('Select Trip Type',
            style: GoogleFonts.quicksand(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14.0)),
        // dropdownColor: Colors.white,
        iconSize: 20.0,
        icon: Icon(Icons.arrow_drop_down),
        value: tripType,
        style: GoogleFonts.quicksand(
            fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
        onChanged: (value) {
          setState(() {
            tripType = value;
          });
        },
        items: _list.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Text totalPropertiesText() {
    return Text('Showing 819 properties in Mumbai', style: blackB14);
  }

  Container searchButton() {
    double width = MediaQuery.of(context).size.width;
    final currentwidth = MediaQuery.of(context).size.width;
    return Container(
        height:45,
        width:150.0,
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

  InkWell roomsguestContainer() {
    return InkWell(
      onTap: () {},
      child: Container(
        color: Color(0xFF233951),
        width: 200.0,
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

  InkWell checkoutContainer() {
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

  InkWell checkInContainer() {
    double swidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        color: Color(0xFF233951),
        width:150,
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

  InkWell searchContainerCity() {
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


