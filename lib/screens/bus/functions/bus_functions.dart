import 'package:flutter/material.dart';

String convertToTime(String data) {
  if (data.length != 4) {
    return data;
  }

  String hours = data.substring(0, 2);
  String minutes = data.substring(2);

  return '$hours:$minutes';
}



String buildFaresText(dynamic fares) {
  if (fares is List) {
    // If fares is a list, take the first element
    return "${fares[0]}";
  } else {
    // If fares is not a list, return it as is
    return "$fares";
  }
}

