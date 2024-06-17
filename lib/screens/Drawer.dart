import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constant.dart';
import 'holidayPackages.dart';
import 'hotels.dart';

class drawer extends StatelessWidget {

   drawer({
    Key key, SafeArea child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: 100.0,
                  color: Color(0xFF0d2b4d),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Raya Gaikwad', style: white20),
                        const SizedBox(height: 5.0),
                        Text('rayagaikwad20@gmail.com', style: white15),
                        SizedBox(height: 5.0),
                        Text('+91 8456256983', style: white15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextButton.icon(
                            label: Text('Flights', style: grey15),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => addMenu()),
                              // );
                            },
                            icon: Icon(
                              FontAwesomeIcons.plane,
                              color: Colors.grey,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextButton.icon(
                            label: Text('Bus Booking', style: grey15),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Hotels_Page()),
                              );
                            },
                            icon: Icon(
                              FontAwesomeIcons.hotel,
                              color: Colors.grey,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextButton.icon(
                            label: Text('Holiday Package', style: grey15),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Holiday_Packages()),
                              );
                            },
                            icon: Icon(
                              FontAwesomeIcons.hotel,
                              color: Colors.grey,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextButton.icon(
                            label: Text('Settings', style: grey15),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => addEmployee()),
                              // );
                            },
                            icon: Icon(
                              FontAwesomeIcons.bars,
                              color: Colors.grey,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextButton.icon(
                            label: Text('Logout', style: grey15),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => orders()),
                              // );
                            },
                            icon: Icon(
                              FontAwesomeIcons.firstOrder,
                              color: Colors.grey,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}