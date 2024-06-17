
import 'package:intl/intl.dart';

String formatDate(String dateTimeStr) {
  try {
    // Parse the input string to a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeStr);

    // Define the output format for the date
    DateFormat dateFormatter = DateFormat('EE, dd MMM yy');

    // Format the DateTime object to a string
    return dateFormatter.format(dateTime);
  } catch (e) {
    // Handle the error if the input string is not valid
    print('Error parsing date time: $e');
    return dateTimeStr; // Return the original string if parsing fails
  }
}

String formatTime(String dateTimeStr) {
  try {
    // Parse the input string to a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeStr);

    // Define the output format for the time
    DateFormat timeFormatter = DateFormat('h:mm a');

    // Format the DateTime object to a string
    return timeFormatter.format(dateTime);
  } catch (e) {
    // Handle the error if the input string is not valid
    print('Error parsing date time: $e');
    return dateTimeStr; // Return the original string if parsing fails
  }
}


String extractTime(String dateTimeStr) {
  try {
    // Parse the input string to a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeStr);

    // Define the output format for the time in 24-hour format
    DateFormat timeFormatter = DateFormat('HH:mm');

    // Format the DateTime object to a string
    return timeFormatter.format(dateTime);
  } catch (e) {
    // Handle the error if the input string is not valid
    print('Error parsing date time: $e');
    return dateTimeStr; // Return the original string if parsing fails
  }
}

String convertMinutesToHoursAndMinutes(int totalMinutes) {
  int hours = totalMinutes ~/ 60;
  int minutes = totalMinutes % 60;
  
  String hourPart = "$hours hr";
  String minutePart = "$minutes min";

  return "$hourPart $minutePart";
}

