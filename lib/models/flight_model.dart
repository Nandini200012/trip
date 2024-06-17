import 'package:flutter/material.dart';
import 'package:trip/api_services/search%20apis/return/international_return_search_api.dart';

class Flight {
  String pricceID;
  dynamic flightData;
  dynamic flightNo;
  int adult;
  int child;
  int infant;
  String from_code;
  String to_code;
  String airlineCode;
  String airlineName;
  String cabinBaggage;
  String checkingBaggage;
  int refund;
  String travellerClass;
  bool meal;
  int duration;
  int stops;
  String departureTime;
  String arrivalTime;
  String price;
  String baseFare;
  String surCharges;
  String departureCity;
  String arrivalCity;
  String departureairport;
  String arrivalairport;
  String departureTerminal;
  String arrivalTerminal;
  String departureCountry;
  String arrivalCountry;
  String flightnumber;
  String equipmentType;
  Flight({
    this.flightnumber,
    this.equipmentType,
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
//     dynamic flightData;
//     String airlineCode;
//     String airlineName;
//     int duration;
//     int stops;
//     String departureTime;
//     String arrivalTime;
//     String price;
//     String secondDepartureTime;

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

void printContents(Flight obj) {
  print('Price ID: ${obj.pricceID}');
  // if (obj.flightData is Flight) {
  //   print('Flight Data:');
  //   printContents(obj.flightData);
  // } else {
  //   print('Flight Data: ${obj.flightData}');
  // }
  print('Flight No: ${obj.flightNo}');
  print('Adult: ${obj.adult}');
  print('Child: ${obj.child}');
  print('Infant: ${obj.infant}');
  print('From Code: ${obj.from_code}');
  print('To Code: ${obj.to_code}');
  print('Airline Code: ${obj.airlineCode}');
  print('Airline Name: ${obj.airlineName}');
  print('Cabin Baggage: ${obj.cabinBaggage}');
  print('Checking Baggage: ${obj.checkingBaggage}');
  print('Refund: ${obj.refund}');
  print('Traveller Class: ${obj.travellerClass}');
  print('Meal: ${obj.meal}');
  print('Duration: ${obj.duration}');
  print('Stops: ${obj.stops}');
  print('Departure Time: ${obj.departureTime}');
  print('Arrival Time: ${obj.arrivalTime}');
  print('Price: ${obj.price}');
  print('Base Fare: ${obj.baseFare}');
  print('SurCharges: ${obj.surCharges}');
  print('Departure City: ${obj.departureCity}');
  print('Arrival City: ${obj.arrivalCity}');
  print('Departure Airport: ${obj.departureairport}');
  print('Arrival Airport: ${obj.arrivalairport}');
  print('Departure Terminal: ${obj.departureTerminal}');
  print('Arrival Terminal: ${obj.arrivalTerminal}');
  print('Departure Country: ${obj.departureCountry}');
  print('Arrival Country: ${obj.arrivalCountry}');
  print(': priceid ${obj.pricceID}');
}

// void assignFlights(Flight flight1, Flight flight2) {
//   flight1.pricceID = flight2.pricceID;
//   flight1.flightData = flight2.flightData;
//   flight1.flightNo = flight2.flightNo;
//   flight1.adult = flight2.adult;
//   flight1.child = flight2.child;
//   flight1.infant = flight2.infant;
//   flight1.from_code = flight2.from_code;
//   flight1.to_code = flight2.to_code;
//   flight1.airlineCode = flight2.airlineCode;
//   flight1.airlineName = flight2.airlineName;
//   flight1.cabinBaggage = flight2.cabinBaggage;
//   flight1.checkingBaggage = flight2.checkingBaggage;
//   flight1.refund = flight2.refund;
//   flight1.travellerClass = flight2.travellerClass;
//   flight1.meal = flight2.meal;
//   flight1.duration = flight2.duration;
//   flight1.stops = flight2.stops;
//   flight1.departureTime = flight2.departureTime;
//   flight1.arrivalTime = flight2.arrivalTime;
//   flight1.price = flight2.price;
//   flight1.baseFare = flight2.baseFare;
//   flight1.surCharges = flight2.surCharges;
//   flight1.departureCity = flight2.departureCity;
//   flight1.arrivalCity = flight2.arrivalCity;
//   flight1.departureairport = flight2.departureairport;
//   flight1.arrivalairport = flight2.arrivalairport;
//   flight1.departureTerminal = flight2.departureTerminal;
//   flight1.arrivalTerminal = flight2.arrivalTerminal;
//   flight1.departureCountry = flight2.departureCountry;
//   flight1.arrivalCountry = flight2.arrivalCountry;
// }

// class TripsecureModel {
//     Icon icon;
//     String text1;
//     String text2;
//     String text3;
//   TripsecureModel({this.icon, this.text1, this.text2, this.text3});
// }

List<Flight> comboToFlights( combo,
String adult,String child,String infant,String clas) {
  List<Flight> flights = [];

  for (var segment in combo.segments) {
    for (var total in combo.totalPriceList) {
      flights.add(
        Flight(
          flightnumber: segment.flightDetails.flightNumber,
          equipmentType: segment.flightDetails.equipmentType,
          pricceID: total.id,  // Assuming priceID should be taken from totalPriceList
          departureairport: segment.departureAirport.code,
          arrivalairport: segment.arrivalAirport.code,
          adult:  int.parse(adult),  // Assuming 1 if fareDetails exist, else 0
          child: int.parse(child),  // Default value, change as needed
          from_code: segment.departureAirport.code,
          to_code: segment.arrivalAirport.code,
          infant:  int.parse(adult),  // Default value, change as needed
          departureCountry: segment.departureAirport.country,
          arrivalCountry: segment.arrivalAirport.country,
          travellerClass: total.fareDetails.cabinClass,
          // refund: total.fareDetails.refundType,
          meal: false, // Assuming default false or add logic if necessary
          checkingBaggage: total.fareDetails.baggageInfo.includedBaggage,
          cabinBaggage: total.fareDetails.baggageInfo.cabinBaggage,
          baseFare: total.fareDetails.fareComponents.baseFare,
          flightNo: segment.flightDetails.flightNumber,
          arrivalCity: segment.arrivalAirport.city,
          departureCity: segment.departureAirport.city,
          departureTerminal: segment.departureAirport.terminal,
          arrivalTerminal: segment.arrivalAirport.terminal,
          surCharges: total.fareDetails.fareComponents.totalAdditionalFare,
          price: total.fareDetails.fareComponents.totalFare,
          flightData: segment,
          airlineCode: segment.flightDetails.airlineInfo.code,
          airlineName: segment.flightDetails.airlineInfo.name,
          duration: int.tryParse(segment.duration) ?? 0,
          stops: int.tryParse(segment.stops) ?? 0,
          departureTime: segment.departureTime,
          arrivalTime: segment.arrivalTime,
          
        ),
      );
    }
  }

  return flights;
}
