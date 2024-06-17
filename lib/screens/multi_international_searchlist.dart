import 'package:flutter/material.dart';
import 'package:trip/models/flight_model.dart';

import 'flight_model/multicity_route_model.dart';

class MultiSearchListPage extends StatefulWidget {
  final List<MultiFlight> flightmodel;
  String route1_dep, route1_arr;
  String route2_dep, route2_arr;
  MultiSearchListPage(
      {Key key,
      this.flightmodel,
      this.route1_arr,
      this.route1_dep,
      this.route2_arr,
      this.route2_dep
      
      }
      )
      : super(key: key);

  @override
  State<MultiSearchListPage> createState() => _MultiSearchListPageState();
}

class _MultiSearchListPageState extends State<MultiSearchListPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Trip Infos'),
        ),
        body: Container(
          child: buildFlightList(),
        ),
      ),
    );
  }

  Widget buildFlightList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 206, 219, 241),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Container(
              height: 800, width: 500,
              // color: Colors.amber,
              child: Card(
                elevation: 5.0,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.flightmodel.length,
              itemBuilder: (context, index) {
                return buildFlightCard(widget.flightmodel[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFlightCard(MultiFlight tripInfo) {
    String departure;
    String arrival;
    departure = tripInfo.departureTime.toString();
    arrival = tripInfo.arrivalTime.toString();
    String dTime = departure.substring(departure.length - 5);
    String aTime = arrival.substring(arrival.length - 5);
    String dDate = departure.substring(0, 10);
    String aDate = arrival.substring(0, 10);
    String duration = _minuteToHour(tripInfo.duration);

    // String seconddeparture=tripInfo.secondDepartureTime!=null?tripInfo.secondDepartureTime:"11-11-11T1111";
    // String s_dTime = seconddeparture.substring(seconddeparture.length - 5);
    // String s_dDate = seconddeparture.substring(0, 10);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            width: 800,
            height: 150,
            color: Colors.transparent,
            child: Card(
              elevation: 5.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Image.asset(
                            'images/AirlinesLogo/${tripInfo.airlineCode}.png'),
                      ),
                      Text(tripInfo.airlineName),
                      SizedBox(width: 10),
                      _buildDateTimeColumn('Departure', dTime, dDate),
                      SizedBox(width: 10),
                      // _buildDateTimeColumn('secondDeparture', "", tripInfo.secondDepartureTime),
                      //  SizedBox(width: 10),
                      Column(
                        children: [
                          Text(duration),
                          Container(
                              height: 5, width: 50, color: Colors.blueAccent),
                          tripInfo.stops == 0
                              ? Text(
                                  "Nonstop",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  "${tripInfo.stops} Stops",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                ),
                        ],
                      ),
                      SizedBox(width: 10),
                      _buildDateTimeColumn('Arrival', aTime, aDate),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Text(
                            " ₹${tripInfo.price.toString()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            " per adult",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeColumn(String label, String time, String date) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w300, color: Colors.black),
        ),
        Text(
          time,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          date,
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ],
    );
  }

  String _minuteToHour(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return "$hours h $remainingMinutes min";
  }
}
