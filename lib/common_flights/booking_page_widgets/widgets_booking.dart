import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCustomAlertDialog(BuildContext context, String discount) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 200,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Apply a Coupon',
                style: GoogleFonts.rajdhani(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Get a discount of $discount %',
                style: GoogleFonts.rajdhani(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showCustomAlertDialog2(
                        context,
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showCustomAlertDialog2(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 200,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'Apply a Coupon',
              //   style: GoogleFonts.rajdhani(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(height: 10),
              Text(
                'Coupon Applied 🎉',
                style: GoogleFonts.rajdhani(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: Text(
                  //     'CANCEL',
                  //     style: TextStyle(color: Colors.red),
                  //   ),
                  // ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
