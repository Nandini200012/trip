import 'package:flutter/material.dart';
import 'package:trip/screens/bus/bus_tripdetail.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import '../../../api_services/bus apis/trip_details_api.dart';

Widget roundedTextBox(
    String labelText, int maxLength, int maxLines, String hintText,
    [TextEditingController Controller]) {
  return SizedBox(
    width: 100,
    height: 50,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: Controller,
        // maxLength: maxLength,
        // maxLines: maxLines,
        decoration: InputDecoration(
          // labelText: labelText,
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    ),
  );
}

Widget buildTextBoxRow(
    String labelText, int maxLength, int maxLines, String hintText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        labelText,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      SizedBox(width: 10),
      roundedTextBox(labelText, maxLength ?? 100, maxLines ?? 1, hintText),
    ],
  );
}

Widget buildTextRow(String label, String value, double fontSize, Color color) {
  return Padding(
    padding: const EdgeInsets.only(top: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // SizedBox(width: 250),
        Text(
          label,
          style: TextStyle(
              color: color ?? Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 150,
          // height: 50,
          child: Text(
            value,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}

Widget buildTextRow1({
  String value1,
  String value2,
  String value3,
  double fontSize,
  Color color,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 3.0, left: 40),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (value1 != null) ...[
          Text(
            value1,
            style: TextStyle(
              color: color ?? Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (value2 != null && value2 != value1) SizedBox(height: 3),
          if (value2 != null && value2 != value1)
            Text(
              value2,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
          if (value3 != null && value3 != value2 && value3 != value1)
            SizedBox(height: 3),
          if (value3 != null && value3 != value2 && value3 != value1)
            Text(
              value3,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ],
    ),
  );
}

Widget verticalSeat(label, color) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      border: Border.all(width: 1.0, color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
    ),
    width: 38,
    height: 50,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.0,
                color: (color == Colors.green) ? Colors.white : Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 32,
          height: 15,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget horizontalSeat(label, color) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      border: Border.all(width: 1.0, color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
    ),
    width: 80,
    height: 40,
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.0,
                color: (color == Colors.green) ? Colors.white : Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 10,
          height: 25,
        ),
      ],
    ),
  );
}

seatPick(String length, String width, String name, Color color, Seat seat) {
  if (length == '1' && width == '1') {
    return Seatdesign(
      seat.name,
      selectedSeats.contains(seat.name) ? Colors.green : seatcolor(seat),
    );
    // Seatdesign(name, seatcolor(seat));
  } else if (length == '2' && width == '1') {
    // Seatdesign(seat.name, seatcolor(seat));
    return horizontalSeat(name, seatcolor(seat));
  } else if (length == '1' && width == '2') {
    // Seatdesign(seat.name, seatcolor(seat));
    return verticalSeat(name, seatcolor(seat));
  } else {
    return Seatdesign(
      seat.name,
      selectedSeats.contains(seat.name) ? Colors.green : seatcolor(seat),
    );
  }
}
List<List<List<Seat>>> create3DArray(List<Seat> seats) {
  // Find the maximum row, column, and zIndex values
  int maxRow = seats.map((seat) => int.parse(seat.row)).reduce((value, element) => value > element ? value : element);
  int maxColumn = seats.map((seat) => int.parse(seat.column)).reduce((value, element) => value > element ? value : element);
  int maxZIndex = seats.map((seat) => int.parse(seat.zIndex)).reduce((value, element) => value > element ? value : element);

  // Create a 3D array with null values
  List<List<List<Seat>>> array3D = List.generate(
    maxZIndex + 1,
    (zIndex) => List.generate(
      maxRow + 1,
      (row) => List<Seat>.filled(maxColumn + 1, null),
    ),
  );

  // Populate the 3D array with seat objects
  for (Seat seat in seats) {
    int zIndex = int.parse(seat.zIndex);
    int rowIndex = int.parse(seat.row);
    int columnIndex = int.parse(seat.column);
    array3D[zIndex][rowIndex][columnIndex] = seat;
  }

  print("array3D");
  print(array3D[maxZIndex][maxRow][maxColumn].row);
  print(array3D[maxZIndex][maxRow][maxColumn].column);
  print("Maxrow: $maxRow");
  print("Maxcolumn: $maxColumn");
  print("MaxZIndex: $maxZIndex");

  return array3D;
}


// List<List<Seat>> create2DArray(List<Seat> seats) {
//   // Find the maximum row and column values
//   int maxRow = seats
//       .map((seat) => int.parse(seat.row))
//       .reduce((value, element) => value > element ? value : element);
//   int maxColumn = seats
//       .map((seat) => int.parse(seat.column))
//       .reduce((value, element) => value > element ? value : element);

//   // Create a 2D array with null values
//   List<List<Seat>> array2D = List.generate(
//       maxRow + 1, (index) => List<Seat>.filled(maxColumn + 1, null));

//   // Populate the 2D array with seat objects
//   for (Seat seat in seats) {
//     int rowIndex = int.parse(seat.row);
//     int columnIndex = int.parse(seat.column);
//     array2D[rowIndex][columnIndex] = seat;
//   }
//   print("array2D");
//   print(array2D[maxRow][maxColumn].row);
//   print(array2D[maxRow][maxColumn].column);
//   print("Maxrow: $maxRow");
//   print("Maxcolumn: $maxColumn");
//   return array2D;
// }

String totalfare(String fares) {
  final double fare = double.parse(fares);
  // final double fare = double.parse(tripdetails.fareDetails[0].totalFare);
  final int totalFare = (fare * selectedSeats.length).toInt();
  return totalFare.toString();
}

Widget customContainer(double width, double height, Color color) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      border: Border.all(width: 1.0, color: Colors.grey),
      borderRadius: BorderRadius.circular(20),
    ),
    width: width,
    height: height,
  );
}

Widget Seatdesign(label, color) {
  return SizedBox(
    width: 50,
    height: 50,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customContainer(18, 10, color),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              width: 22,
              height: 22,
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            customContainer(15, 22, color),
          ],
        ),
        customContainer(18, 10, color),
      ],
    ),
  );
}

seatcolor(Seat seat) {
  if (seat.available == 'true') {
    if (seat.ladiesSeat == 'true') {
      return Colors.pinkAccent;
    } else if (seat.malesSeat == 'true') {
      return Colors.blueAccent;
    } else {
      return Color.fromARGB(255, 255, 255, 255);
    }
  } else {
    return Colors.grey.shade400;
  }
}
