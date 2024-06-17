import 'package:flutter/material.dart';

Widget customContainer(double width, double height) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    ),
    width: width,
    height: height,
  );
}

Widget Seatdesign(label) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      customContainer(30, 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            width: 50,
            height: 50,
            child: Center(
              child: Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          customContainer(30, 50),
        ],
      ),
      customContainer(30, 10),
    ],
  );
}

