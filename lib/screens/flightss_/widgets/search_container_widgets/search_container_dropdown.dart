import 'package:flutter/material.dart';
import '../../../../api_services/location_list_api.dart';
import '../../../../constants/fonts.dart';
import '../search_container.dart';

String selectedTitle;
String selectedType;

class routedropdown extends StatefulWidget {
  double sWidth;
  String option, title;
  List<String> Options;
  Function(String) onChanged;

  routedropdown(
      {this.sWidth, this.option, this.Options, this.title, this.onChanged});

  @override
  _routedropdownState createState() => _routedropdownState();
}

class _routedropdownState extends State<routedropdown> {
  @override
  void initState() {
    super.initState();
    selectedTitle = widget.option;
  }

  @override
  Widget build(BuildContext context) {
    void onChanged(String newValue) {
      setState(() {
        selectedTitle = newValue;
        // Call the callback function to pass the selected value
        widget.onChanged(selectedTitle);
      });
    }

    return Container(
      width: widget.sWidth,
      height: 80,
      decoration: BoxDecoration(
        color: darkblue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: rajdhaniblue, // Define your rajdhaniblue style
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 30,
              width: widget.sWidth,
              child: DropdownButton<String>(
                iconSize: 15,
                style: rajdhaniwhite,
                dropdownColor: Color.fromARGB(255, 20, 28, 61).withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
                elevation: 0,
                underline: Container(), // No underline
                isExpanded: false,
                value: selectedTitle,
                onChanged: onChanged,
                items: widget.Options.map((String value) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.bottomCenter,
                    value: value,
                    child: Text(
                      value,
                      style: rajdhaniwhite,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TypeDropdown extends StatefulWidget {
  final double sWidth;
  final String option, title;
  final List<String> options;
  final Function(String) onChanged;

  TypeDropdown({
    @required this.sWidth,
    @required this.option,
    @required this.options,
    @required this.title,
    @required this.onChanged,
  });

  @override
  _TypeDropdownState createState() => _TypeDropdownState();
}

class _TypeDropdownState extends State<TypeDropdown> {
  String selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = widget.option;
  }

  @override
  Widget build(BuildContext context) {
    void onChanged(String newValue) {
      setState(() {
        selectedType = newValue;
        // Call the callback function to pass the selected value
        widget.onChanged(selectedType);
      });
    }

    return Container(
      width: widget.sWidth,
      height: 80,
      decoration: BoxDecoration(
        color: darkblue, // Define your darkblue color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: rajdhaniblue, // Define your rajdhaniblue style
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 30,
              width: widget.sWidth,
              child: DropdownButton<String>(
                iconSize: 15,
                style: TextStyle(
                    color: Colors.white), // Define your rajdhaniwhite style
                dropdownColor: Color.fromARGB(255, 20, 28, 61).withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
                elevation: 0,
                underline: Container(), // No underline
                isExpanded: false,
                value: selectedType,
                onChanged: onChanged,
                items: widget.options.map((String value) {
                  return DropdownMenuItem<String>(
                    alignment: Alignment.bottomCenter,
                    value: value,
                    child: Text(
                      value,
                      style: rajdhaniwhite, // Define your rajdhaniwhite style
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LocationDropdown extends StatefulWidget {
  double sWidthh;
  String option, title;
  List<LocationData> Options;
  Function(LocationData) onChanged;

  LocationDropdown({
    this.sWidthh,
    this.option,
    this.Options,
    this.title,
    this.onChanged,
  });

  @override
  _LocationDropdownState createState() => _LocationDropdownState();
}

class _LocationDropdownState extends State<LocationDropdown> {
  LocationData selectedLocation;

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.Options.firstWhere(
      (location) => location.city == widget.option,
      orElse: () => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    void onChanged(LocationData newValue) {
      setState(() {
        selectedLocation = newValue;
        widget.onChanged(selectedLocation);
      });
    }

    return Container(
      width: widget.sWidthh,
      //  height: 80,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 20, 138, 12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 30,
              width: 50,
              child: DropdownButton<LocationData>(
                iconSize: 15,
                iconEnabledColor: Colors.white,
                iconDisabledColor: Colors.white,
                style: rajdhaniwhite,
                dropdownColor: Color.fromARGB(255, 20, 28, 61).withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
                elevation: 0,
                underline: Container(),
                isExpanded: true,
                value: selectedLocation,
                onChanged: onChanged,
                items: widget.Options.map((LocationData value) {
                  return DropdownMenuItem<LocationData>(
                    alignment: Alignment.bottomCenter,
                    value: value,
                    child: Text(
                      value.name,
                      style: rajdhaniwhite,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
