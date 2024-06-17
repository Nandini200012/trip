import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/oneway_model.dart';

class OneWaysearchList extends StatefulWidget {
  SearchResult tripinfos;
  OneWaysearchList({key, this.tripinfos});

  @override
  State<OneWaysearchList> createState() => _OneWaysearchListState();
}

SearchResult tripdata;
List<Onward> onwardlist = [];
List<SI> si = [];
List<TotalPriceList> pricelist = [];

class _OneWaysearchListState extends State<OneWaysearchList> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() {
    setState(() {
      tripdata = widget.tripinfos;
      onwardlist = tripdata.tripInfos.onward;
      print("onwardlist:${onwardlist.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _buildGradientContainer(screenWidth),
            Column(
              children: [
                SizedBox(height: 180),
                Container(
                  height: screenHeight,
                  width: screenWidth * 0.8,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // _buildAirlineFilters(),
                      SizedBox(width: 20),
                      // _buildFlightsDetails()
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientContainer(double width) {
    return Container(
      height: 250, // Adjust the height as needed
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 1, 29, 140),
            Color.fromARGB(255, 1, 29, 140),
            Color.fromARGB(255, 3, 38, 177),
            Color.fromARGB(255, 51, 68, 248),
          ],
        ),
      ),
    );
  }
}
