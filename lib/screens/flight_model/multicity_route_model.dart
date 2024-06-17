List<routes> multiRoutes = [];

class routes {
  String fromCode;
  String toCode;
  String date;
  String fromcity;
  String tocity;

  routes({this.fromCode, this.toCode, this.date, this.tocity,this.fromcity});
}

class MultiFlight {
  //  final String departurecity;
  //  final String arrivalcity;
  final String pricceID;
  final dynamic flightData;
  final dynamic flightNo;
  final int adult;
  final int child;
  final int infant;
  final String from_code;
  final String to_code;
  final String airlineCode;
  final String airlineName;
  final String cabinBaggage;
  final String checkingBaggage;
  final int refund;
  final String travellerClass;
  final bool meal;
  final int duration;
  final int stops;
  final String departureTime;
  final String arrivalTime;
  final String price;
  final String baseFare;
  final String surCharges;
  final String departureCity;
  final String arrivalCity;
  final String departureairport;
  final String arrivalairport;
  final String departureTerminal;
  final String arrivalTerminal;
  final String departureCountry;
  final String arrivalCountry;

  MultiFlight({
    //   this.departurecity,
    //  this.arrivalcity,
    this.pricceID,
    this.departureairport,
    this.arrivalairport,
    this.adult,
    this.child,
    this.from_code,
    this.to_code,
    this.infant,
    this.departureCountry,
    this.arrivalCountry,
    this.travellerClass,
    this.refund,
    this.meal,
    this.checkingBaggage,
    this.cabinBaggage,
    this.baseFare,
    this.flightNo,
    this.arrivalCity,
    this.departureCity,
    this.departureTerminal,
    this.arrivalTerminal,
    this.surCharges,
    this.price,
    this.flightData,
    this.airlineCode,
    this.airlineName,
    this.duration,
    this.stops,
    this.departureTime,
    this.arrivalTime,
  });
}

// class MultiFlight {
//   final dynamic flightData;
//   final String airlineCode;
//   final String airlineName;
//   final int duration;
//   final int stops;
//   final String departureTime;
//   final String arrivalTime;
//   final String price;
//   final String secondDepartureTime;

//   MultiFlight(
//       {this.price,
//       this.flightData,
//       this.airlineCode,
//       this.airlineName,
//       this.duration,
//       this.stops,
//       this.departureTime,
//       this.arrivalTime,
//       this.secondDepartureTime});
// }



// void printContents(Flight obj) {
//   print('Price ID: ${obj.pricceID}');
//   // if (obj.flightData is Flight) {
//   //   print('Flight Data:');
//   //   printContents(obj.flightData); 
//   // } else {
//   //   print('Flight Data: ${obj.flightData}');
//   // }
//   print('Flight No: ${obj.flightNo}');
//   print('Adult: ${obj.adult}');
//   print('Child: ${obj.child}');
//   print('Infant: ${obj.infant}');
//   print('From Code: ${obj.from_code}');
//   print('To Code: ${obj.to_code}');
//   print('Airline Code: ${obj.airlineCode}');
//   print('Airline Name: ${obj.airlineName}');
//   print('Cabin Baggage: ${obj.cabinBaggage}');
//   print('Checking Baggage: ${obj.checkingBaggage}');
//   print('Refund: ${obj.refund}');
//   print('Traveller Class: ${obj.travellerClass}');
//   print('Meal: ${obj.meal}');
//   print('Duration: ${obj.duration}');
//   print('Stops: ${obj.stops}');
//   print('Departure Time: ${obj.departureTime}');
//   print('Arrival Time: ${obj.arrivalTime}');
//   print('Price: ${obj.price}');
//   print('Base Fare: ${obj.baseFare}');
//   print('SurCharges: ${obj.surCharges}');
//   print('Departure City: ${obj.departureCity}');
//   print('Arrival City: ${obj.arrivalCity}');
//   print('Departure Airport: ${obj.departureairport}');
//   print('Arrival Airport: ${obj.arrivalairport}');
//   print('Departure Terminal: ${obj.departureTerminal}');
//   print('Arrival Terminal: ${obj.arrivalTerminal}');
//   print('Departure Country: ${obj.departureCountry}');
//   print('Arrival Country: ${obj.arrivalCountry}');
// }







// // class TripsecureModel {
// //   final Icon icon;
// //   final String text1;
// //   final String text2;
// //   final String text3;
// //   TripsecureModel({this.icon, this.text1, this.text2, this.text3});
// // }

