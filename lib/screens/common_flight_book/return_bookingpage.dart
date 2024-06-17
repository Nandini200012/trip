import 'package:flutter/material.dart';

import '../../models/flight_model.dart';

class returnFlightBook extends StatefulWidget {
  List<Flight> flightmodel;
  returnFlightBook({key, this.flightmodel});

  @override
  State<returnFlightBook> createState() => _returnFlightBookState();
}

class _returnFlightBookState extends State<returnFlightBook> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getflights();
  }

  getflights() {
    print("getflights");
    print(widget.flightmodel.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrangeAccent,
    );
  }
}
