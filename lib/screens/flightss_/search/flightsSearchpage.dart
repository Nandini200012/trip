import 'package:flutter/material.dart';
import 'package:trip/screens/flightbooking%20page/ismulticityformpage.dart';
import 'package:trip/screens/flightss_/search/oneway/oneway_search.dart';
import '../../../api_services/location_list_api.dart';
import '../../header.dart';

class flightsSearchpage extends StatefulWidget {
  List<LocationData> locationList1;
  flightsSearchpage({this.locationList1});

  @override
  State<flightsSearchpage> createState() => _flightsSearchpageState();
}

class _flightsSearchpageState extends State<flightsSearchpage> {
  int _flightType = 0; // 0: One-way, 1: Return, 2: Multi-city
  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: sWidth < 600
            ? AppBar(
                iconTheme: const IconThemeData(color: Colors.black, size: 40),
                backgroundColor: Color.fromARGB(255, 1, 21, 101),
                title: Text(
                  "Flights ",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              )
            : CustomAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 0, top: 30),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Container(
                      width: sWidth * 0.3,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text('One-way'),
                              value: 0,
                              groupValue: _flightType,
                              onChanged: (value) {
                                setState(() {
                                  _flightType = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text('Return'),
                              value: 1,
                              groupValue: _flightType,
                              onChanged: (value) {
                                setState(() {
                                  _flightType = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text('Multi-city'),
                              value: 2,
                              groupValue: _flightType,
                              onChanged: (value) {
                                setState(() {
                                  _flightType = value;
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 70,
                ),
                if (_flightType == 0)
                  OnewaySearchForm(locationList1:locationList1,),
                if (_flightType == 1)
                  ReturnForm(locationList1, sWidth, sHeight),
                if (_flightType == 2)
                  MultiWayForm(locationList1, sWidth, sHeight),
              ]),
        )));
  }
}



Widget ReturnForm(List<LocationData> locationList1, sWidth, sHeight) {
  return Center(
    child: Container(
      width: sWidth * 0.9,
      height: sHeight * 0.5,
      color: Color.fromARGB(255, 229, 33, 243),
      child: Text('One-way Container'),
    ),
  );
}

Widget MultiWayForm(List<LocationData> locationList1, sWidth, sHeight) {
  return Center(
    child: Container(
      width: sWidth * 0.9,
      height: sHeight * 0.5,
      color: Color.fromARGB(255, 33, 243, 47),
      child: Text('One-way Container'),
    ),
  );
}
