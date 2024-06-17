import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../holiday_Packages/widgets/constants_holiday.dart';

details(double swidth, double sheight, String txt, String txt2) {
  return Row(
    children: [
      kwidth30,
      Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Container(
          height: 180,
          width: 200,
          // color: Colors.green,
          child: Image.asset(
            "images/nodata.jpg",
            fit: BoxFit.contain,
          ),
        ),
      ),
      kwidth10,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          kheight30,
          kheight30,
          Text(
            txt,
            style: GoogleFonts.rajdhani(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          kheight5,
          Text(
            txt2,
            style: GoogleFonts.rajdhani(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          kheight10, kheight3,
          // kwidth30,
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.blueAccent.shade700,
                    Color.fromARGB(255, 15, 51, 141)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                  child: Text(
                "Plan A Trip",
                style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              )),
            ),
          ),
        ],
      ),
    ],
  );
}