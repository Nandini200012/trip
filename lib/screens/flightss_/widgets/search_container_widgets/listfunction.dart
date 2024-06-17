import 'package:flutter/material.dart';
import 'package:trip/common/print_funtions.dart';
import 'package:trip/screens/flightss_/widgets/search_container.dart';

import '../../../../api_services/location_list_api.dart';

import 'package:flutter/material.dart';

class LocationDialog extends StatefulWidget {
  final List<LocationData> locationList;

  LocationDialog(this.locationList);

  @override
  _LocationDialogState createState() => _LocationDialogState();
}
String from_Place;
class _LocationDialogState extends State<LocationDialog> {
  List<LocationData> filteredLocations;

  @override
  void initState() {
    super.initState();
    filteredLocations = List.from(widget.locationList);
  }

  void filterLocations(String query) {
    setState(() {
      filteredLocations = widget.locationList
          .where((location) =>
              location.city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(""),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 505,
        height: 388,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                ),
                onChanged: filterLocations,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredLocations.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                        setState(() {
        from_Place=filteredLocations[index].city;
      });
                      // print(filteredLocations[index].city);
                      fromPlace = filteredLocations[index].city;
                      printWhite("from: $fromPlace");
                      // onfromChanged(fromplace: fromPlace);
                      Navigator.pop(context);
                    },
                    child: ListTile(
                      title: Text(filteredLocations[index].city),
                      // Add onTap logic if needed
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


Widget listFunction(List<LocationData> locationlist, context) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return LocationDialog(locationlist);
        },
      );
    
    },
    child: Container(
      width: 180,
      height: 180,
      color: Colors.red,
      child: Text(from_Place),
    ),
  );
}}
