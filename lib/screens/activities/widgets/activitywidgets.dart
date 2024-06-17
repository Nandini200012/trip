import 'package:flutter/material.dart';

Widget Activitydetails(
    sHeight, sWidth, activityname, activitylocation, packagelist) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        // color: Colors.red,
        // actual size
        height: sHeight * 0.13,
        width: sWidth * 0.35,
        child: Card(
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activityname ?? "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: sHeight * 0.013,
                  ),
                  Row(
                    children: [
                      Container(
                        width: sWidth * 0.0239,
                        height: sHeight * 0.0349,
                        // color: Colors.green,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          "4.7/5",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                      SizedBox(
                        width: sWidth * 0.015,
                      ),
                      Text(
                        "(155 Reviews)",
                        style: TextStyle(
                            color: Color.fromARGB(255, 111, 111, 111),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      SizedBox(
                        width: sWidth * 0.035,
                      ),
                      Icon(
                        Icons.place_outlined,
                        color: Color.fromARGB(255, 111, 111, 111),
                      ),
                      Text(
                        activitylocation ?? "",
                        style: TextStyle(
                            color: Color.fromARGB(255, 111, 111, 111),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
      
    ],
  );
}
