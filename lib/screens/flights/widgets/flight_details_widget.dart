import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';

import '../../../api_services/search apis/return/international_return_search_api.dart';
import '../return/return_widgets/return_widgest.dart';

class FlightDetailsScreen extends StatefulWidget {
  Combo combo;
  FlightDetailsScreen({this.combo});
  @override
  _FlightDetailsScreenState createState() => _FlightDetailsScreenState();
}

class _FlightDetailsScreenState extends State<FlightDetailsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      height: 500,
      width: screenWidth * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 50, bottom: 10),
            child: Row(
              children: [
                _buildTab(
                  screenHeight,
                  screenWidth,
                  "FARE DETAILS",
                  0,
                ),
                SizedBox(width: 10),
                _buildTab(
                  screenHeight,
                  screenWidth,
                  "FARE SUMMARY",
                  1,
                ),
                SizedBox(width: 10),
                _buildTab(
                  screenHeight,
                  screenWidth,
                  "CANCELLATION",
                  2,
                ),
                SizedBox(width: 10),
                _buildTab(
                  screenHeight,
                  screenWidth,
                  "DATE CHANGE",
                  3,
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildContent(screenWidth, screenHeight),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
      double screenHeight, double screenWidth, String text, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        height: screenHeight * 0.05,
        width: screenWidth * 0.08,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(width: 0.5, color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.rajdhani(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(double swidth, double sheight) {
    switch (selectedIndex) {
      case 0:
         return _buildFareDetails(swidth, sheight);
      case 1:
        return Container(
          color: Colors.blue,
          height: 20,
          width: 150,
        );
      case 2:
        return Container(
          color: Colors.green,
          height: 20,
          width: 150,
        );
      case 3:
        return Container(
          color: Colors.purple,
          height: 20,
          width: 150,
        );
      default:
        return Container();
    }
  }
  Widget _buildFareDetails(double swidth, double sheight) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 28, right: 0),
      child: Row(
        children: [
          _buildFlightSegmentDetails(widget.combo.segments[0], swidth, sheight),
          SizedBox(width: 20),
          _buildFlightSegmentDetails(widget.combo.segments[1], swidth, sheight),
        ],
      ),
    );
  }

  Widget _buildFlightSegmentDetails(Segment segment, double swidth, double sheight) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.78, color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      height: sheight * 0.5,
      width: swidth * 0.26,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${segment.departureAirport.city} to ${segment.arrivalAirport.city}, ${formatDate(segment.departureTime)}",
              style: GoogleFonts.rajdhani(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    'images/AirlinesLogo/${segment.flightDetails.airlineInfo.code}.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "${segment.flightDetails.airlineInfo.name}",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 18),
            _buildFlightTimesAndLocations(segment),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightTimesAndLocations(Segment segment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          _buildLocationDetails(segment.departureTime, segment.departureAirport),
          Spacer(),
          _buildLocationDetails(segment.arrivalTime, segment.arrivalAirport),
        ],
      ),
    );
  }

  Widget _buildLocationDetails(String time,  airport) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${extractTime(time)}",
          style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 3),
        Text(
          "${formatDate(time)}",
          style: GoogleFonts.rajdhani(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        SizedBox(height: 3),
        Text(
          "${airport.terminal}",
          style: GoogleFonts.rajdhani(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        SizedBox(height: 3),
        Text(
          "${airport.city}",
          style: GoogleFonts.rajdhani(fontWeight: FontWeight.w500, fontSize: 15),
        ),
        SizedBox(height: 3),
        Text(
          "${airport.country}",
          style: GoogleFonts.rajdhani(fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ],
    );
  }
}


