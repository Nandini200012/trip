import 'package:flutter/material.dart';

class BookingConfirmationpage extends StatefulWidget {
  const BookingConfirmationpage({key});

  @override
  State<BookingConfirmationpage> createState() =>
      _BookingConfirmationpageState();
}

class _BookingConfirmationpageState extends State<BookingConfirmationpage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.5,
              // color: Colors.pink,
              child:Card(
                elevation: 5.0,
                child: Column(
                  children: [
                    
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
