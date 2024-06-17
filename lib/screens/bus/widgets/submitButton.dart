import 'package:flutter/material.dart';
import 'package:trip/common/print_funtions.dart';
import 'package:trip/screens/bus/widgets/bustravellerform.dart';


Widget BusSubmitButton(sWidth, passengers, id, boardingpnt, droppingpnt, source,
    destination, context) {
  return Center(
    child: SizedBox(
      width: 100,
      child: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue,
         
           Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
        child: ElevatedButton(
          onPressed: () async {
            String res = await submitForm(passengers, id, boardingpnt,
                droppingpnt, source, destination, context);
            printred("blockkey: $res");
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent, // This is important to make the button background transparent
            elevation: 10,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            width: sWidth * 0.15,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Submit",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
