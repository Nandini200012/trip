import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:trip/screens/flight_model/multicity_route_model.dart';
import 'package:trip/screens/flightss_/widgets/search_container.dart';
import '../../../../api_services/location_list_api.dart';
import '../../../holiday_Packages/widgets/constants_holiday.dart';
import '../../search/oneway/oneway_search.dart';

class MulticitySearchContainer extends StatefulWidget {
  final double swidth;
  final double sheight;
  final List<LocationData> locationList1;

  MulticitySearchContainer({
    Key key,
    this.swidth,
    this.sheight,
    this.locationList1,
  }) : super(key: key);

  @override
  State<MulticitySearchContainer> createState() =>
      _MulticitySearchContainerState();
}

class _MulticitySearchContainerState extends State<MulticitySearchContainer> {
  List<LocationData> fromDropdownValues = [];
  List<LocationData> toDropdownValues = [];
  List<String> fromData = [];
  List<String> toData = [];
  List<DateTime> selectedDates = [];
  List<routes> _multiRoutes = [];
  int tripLength = 1;
  List<Color> doneCircleAvatarColors = [];
  @override
  void initState() {
    super.initState();
    _addNewTrip();
  }

  void _addNewTrip() {
    fromDropdownValues.add(null);
    toDropdownValues.add(null);
    fromData.add('');
    toData.add('');
    selectedDates.add(DateTime.now());
    _multiRoutes.add(routes());
    // tripLength = multiRoutes.length;
    doneCircleAvatarColors.add(Colors.grey.shade700);
    print("multiflights length :${_multiRoutes.length}");
  }

  void showLocationDialog(
    BuildContext context,
    List<LocationData> locationList,
    Function(LocationData) onChanged,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Done"),
              ),
            ),
          ],
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1.0,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: true,
                              child: SizedBox(height: 8),
                            ),
                            Expanded(
                              child: Visibility(
                                visible: true,
                                child: Positioned(
                                  top: 0,
                                  child: Padding(
                                    padding: EdgeInsets.all(1.0),
                                    child: DropdownSearch<LocationData>(
                                      compareFn: (LocationData item,
                                          LocationData selectedItem) {
                                        return item == selectedItem;
                                      },
                                      popupProps: PopupProps.menu(
                                        showSearchBox: true,
                                        showSelectedItems: true,
                                      ),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelText: 'Search for a location',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      items: locationList,
                                      onChanged: (value) {
                                        onChanged(value);
                                        Navigator.of(context).pop();
                                      },
                                      itemAsString: (LocationData location) =>
                                          location.name,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget fromContainer(double sheight, double swidth, String data, int index) {
    return Container(
      height: sheight * 0.1,
      width: swidth * 0.15,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 11, 39, 68),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "From",
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              data.isEmpty ? "City" : data,
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget toContainer(double sheight, double swidth, String data, int index) {
    return Container(
      height: sheight * 0.1,
      width: swidth * 0.12,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 11, 39, 68),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "To",
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              data.isEmpty ? "City" : data,
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context, int index) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDates[index],
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDates[index]) {
      setState(() {
        selectedDates[index] = picked;
        selectedDates[index] = picked;
        _multiRoutes[index].date = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget dateContainer(double sheight, double swidth, int index) {
    return GestureDetector(
      onTap: () async {
        final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDates[index],
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (picked != null && picked != selectedDates[index]) {
          setState(() {
            selectedDates[index] = picked;
            _multiRoutes[index].date = DateFormat('yyyy-MM-dd').format(picked);
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Container(
          width: swidth * 0.12,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 11, 39, 68),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dep Date",
                  style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  DateFormat('yyyy-MM-dd').format(selectedDates[index]),
                  style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tripContainer(
    double sheight,
    double swidth,
    BuildContext context,
    List<LocationData> locationList,
    int index,
  ) {
    if (index >= tripLength) {
      return SizedBox
          .shrink(); // Return an empty widget if the index is out of bounds
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trip ${index + 1}",
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showLocationDialog(context, locationList, (value) {
                      setState(() {
                        fromDropdownValues[index] = value;
                        fromData[index] = value.city;
                        _multiRoutes[index].fromCode = value.code;
                        _multiRoutes[index].fromcity = value.city;
                      });
                    });
                  },
                  child: fromContainer(sheight, swidth, fromData[index], index),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    showLocationDialog(context, locationList, (value) {
                      setState(() {
                        toDropdownValues[index] = value;
                        toData[index] = value.city;
                        _multiRoutes[index].toCode = value.code;
                        _multiRoutes[index].tocity = value.city;
                      });
                    });
                  },
                  child: toContainer(sheight, swidth, toData[index], index),
                ),
                SizedBox(width: 5),
                dateContainer(sheight, swidth, index),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _removeTrip(int index) {
    setState(() {
      if (tripLength > 1) {
        tripLength--;
        fromDropdownValues.removeAt(index);
        toDropdownValues.removeAt(index);
        fromData.removeAt(index);
        toData.removeAt(index);
        selectedDates.removeAt(index);
        _multiRoutes.removeAt(index);
      }
    });
  }

  void _saveRouteData(int index) {
    setState(() {
      // Assuming LocationData has properties 'code' and 'city'
      _multiRoutes[index].fromCode = fromDropdownValues[index].code;
      _multiRoutes[index].fromcity = fromDropdownValues[index].city;
      _multiRoutes[index].toCode = toDropdownValues[index].code;
      _multiRoutes[index].tocity = toDropdownValues[index].city;
      _multiRoutes[index].date =
          DateFormat('yyyy-MM-dd').format(selectedDates[index]);

      // Change the color of the "Done" circle avatar
      doneCircleAvatarColors[index] =
          Colors.green; // Assuming doneCircleAvatarColors is a List<Color>
    });
  }

  Widget rowContainer(
    double sheight,
    double swidth,
    BuildContext context,
    List<LocationData> locationList,
    int index,
  ) {
    return Row(
      children: [
        tripContainer(sheight, swidth, context, locationList, index),
        SizedBox(width: 10),
        Visibility(
          visible: tripLength > 1,
          child: GestureDetector(
            onTap: () {
              _removeTrip(index);
            },
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.grey.shade700,
              child: Center(
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Visibility(
          visible: true,
          child: GestureDetector(
            onTap: () {
              _saveRouteData(index);
            },
            child: CircleAvatar(
              radius: 8,
              backgroundColor:
                  doneCircleAvatarColors[index], // Use a default color
              child: Center(
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget addCityButton(double sheight, double swidth) {
    return Visibility(
      visible: tripLength < 5,
      child: GestureDetector(
        onTap: () {
          setState(() {
            tripLength++;
            _addNewTrip();
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueAccent, width: 0.8),
          ),
          height: sheight * 0.0538,
          width: swidth * 0.0538,
          child: Center(
            child: Text(
              "+ Add City",
              style: GoogleFonts.rajdhani(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isclicked = false;
    return Column(
      children: [
        for (int i = 0; i < tripLength; i++)
          rowContainer(
              widget.sheight, widget.swidth, context, widget.locationList1, i),
        SizedBox(height: 10),
        Row(
          children: [
            addCityButton(widget.sheight, widget.swidth),
            kwidth10,
            GestureDetector(
              onTap: () {
                isclicked = !isclicked;
                print("_multiRoutes.length");
                print(_multiRoutes.length);
                multiRoutes.clear();
                for (int i = 0; i < _multiRoutes.length; i++) {
                  multiRoutes.add(_multiRoutes[i]);
                  print("date $i :${multiRoutes[i].date}");
                }
              },
              child: Container(
                height: widget.sheight * 0.0538,
                width: widget.swidth * 0.0538,
                decoration: BoxDecoration(
                  color: isclicked ? Colors.green : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent, width: 0.8),
                ),
                child: Center(
                  child: Text(
                    "Done",
                    style: GoogleFonts.rajdhani(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}























// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart'; // For date formatting
// import 'package:trip/screens/flight_model/multicity_route_model.dart';
// import '../../../../api_services/location_list_api.dart';
// import '../../../holiday_Packages/widgets/constants_holiday.dart';
// import '../../search/oneway/oneway_search.dart';
// bool showContainer=false;
// class MulticitySearchContainer extends StatefulWidget {
//   final double swidth;
//   final double sheight;
//   final List<LocationData> locationList1;

//   MulticitySearchContainer({
//     Key key,
//     this.swidth,
//     this.sheight,
//     this.locationList1,
//   }) : super(key: key);

//   @override
//   State<MulticitySearchContainer> createState() =>
//       _MulticitySearchContainerState();
// }

// class _MulticitySearchContainerState extends State<MulticitySearchContainer> {
//   List<LocationData> fromDropdownValues = List<LocationData>.filled(3, null);
//   List<LocationData> toDropdownValues = List<LocationData>.filled(3, null);
//   List<String> fromData = List<String>.filled(3, '');
//   List<String> toData = List<String>.filled(3, '');
//   List<DateTime> selectedDates = List<DateTime>.filled(3, DateTime.now());
//   List<routes> multiRoutes = List<routes>.generate(3, (index) => routes());
//   int tripLength = 0;
//   @override
//   void initState() {
//     super.initState();
//     print("multiflights length :${multiRoutes.length}");
//   }

//   void showLocationDialog(
//     BuildContext context,
//     List<LocationData> locationList,
//     Function(LocationData) onChanged,
//   ) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           actions: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 gradient: LinearGradient(
//                   colors: [Colors.blue, Colors.lightBlueAccent],
//                 ),
//               ),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.transparent,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("Done"),
//               ),
//             ),
//           ],
//           content: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: 500,
//               height: 200,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(8.0),
//                 border: Border.all(
//                   color: Colors.grey.shade300,
//                   width: 1.0,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 10),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Visibility(
//                               visible: true,
//                               child: SizedBox(height: 8),
//                             ),
//                             Expanded(
//                               child: Visibility(
//                                 visible: true,
//                                 child: Positioned(
//                                   top: 0,
//                                   child: Padding(
//                                     padding: EdgeInsets.all(1.0),
//                                     child: DropdownSearch<LocationData>(
//                                       compareFn: (LocationData item,
//                                           LocationData selectedItem) {
//                                         return item == selectedItem;
//                                       },
//                                       popupProps: PopupProps.menu(
//                                         showSearchBox: true,
//                                         showSelectedItems: true,
//                                       ),
//                                       dropdownDecoratorProps:
//                                           DropDownDecoratorProps(
//                                         dropdownSearchDecoration:
//                                             InputDecoration(
//                                           labelText: 'Search for a location',
//                                           border: OutlineInputBorder(),
//                                         ),
//                                       ),
//                                       items: locationList,
//                                       onChanged: (value) {
//                                         onChanged(value);
//                                         Navigator.of(context).pop();
//                                       },
//                                       itemAsString: (LocationData location) =>
//                                           location.name,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget fromContainer(double sheight, double swidth, String data) {
//     return Container(
//       height: sheight * 0.1,
//       width: swidth * 0.15,
//       decoration: BoxDecoration(
//         color: Color.fromARGB(255, 11, 39, 68),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(2.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "From",
//               style: GoogleFonts.rajdhani(
//                 color: Colors.white,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             kheight10,
//             Text(
//               data.isEmpty ? "City" : data,
//               style: GoogleFonts.rajdhani(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget toContainer(double sheight, double swidth, String data) {
//     return Container(
//       height: sheight * 0.1,
//       width: swidth * 0.15,
//       decoration: BoxDecoration(
//         color: Color.fromARGB(255, 11, 39, 68),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(2.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "To",
//               style: GoogleFonts.rajdhani(
//                 color: Colors.white,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             kheight10,
//             Text(
//               data.isEmpty ? "City" : data,
//               style: GoogleFonts.rajdhani(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> selectDate(BuildContext context, int index) async {
//     final DateTime picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDates[index],
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDates[index])
//       setState(() {
//         selectedDates[index] = picked;
//         multiRoutes[index].date = DateFormat('yyyy-MM-dd').format(picked);
//       });
//   }

//   Widget dateContainer(double sheight, double swidth, int index) {
//     return GestureDetector(
//       onTap: () {
//         selectDate(context, index);
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(top: 35.0),
//         child: Container(
//           height: sheight * 0.1,
//           width: swidth * 0.12,
//           decoration: BoxDecoration(
//             color: Color.fromARGB(255, 11, 39, 68),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Dep Date",
//                   style: GoogleFonts.rajdhani(
//                     color: Colors.white,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 kheight10,
//                 Text(
//                   DateFormat('yyyy-MM-dd').format(selectedDates[index]),
//                   style: GoogleFonts.rajdhani(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget tripContainer(double sheight, double swidth, BuildContext context,
//       List<LocationData> locationList, int index) {
//     return Container(
//       width: swidth * 0.33,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(2.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Trip ${index + 1}",
//               style: GoogleFonts.rajdhani(
//                 color: Colors.white,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             kheight10,
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     showLocationDialog(context, locationList, (value) {
//                       setState(() {
//                         fromDropdownValues[index] = value;
//                         fromData[index] = value.city;
//                         multiRoutes[index].fromCode = value.code;
//                         multiRoutes[index].fromcity = value.city;
//                         print('fromData[$index] - ${fromData[index]}');
//                       });
//                     });
//                   },
//                   child: fromContainer(sheight, swidth, fromData[index]),
//                 ),
//                 kwidth10,
//                 GestureDetector(
//                   onTap: () {
//                     showLocationDialog(context, locationList, (value) {
//                       setState(() {
//                         toDropdownValues[index] = value;
//                         toData[index] = value.city;
//                         multiRoutes[index].toCode = value.code;
//                         multiRoutes[index].tocity = value.city;
//                         print('toData[$index] - ${toData[index]}');
//                       });
//                     });
//                   },
//                   child: toContainer(sheight, swidth, toData[index]),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget rowContainer(double sheight, double swidth, BuildContext context,
//       List<LocationData> locationList, int index) {
//     return Row(
//       children: [
//         tripContainer(sheight, swidth, context, locationList, index),
//         kwidth10,
//         dateContainer(sheight, swidth, index),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//              print("before:$showContainer");
//             showContainer=!showContainer;
//             print("after:$showContainer");
//           },
//           child: Container(
//             height: widget.sheight * 0.1,
//             width: widget.swidth * 0.45,
//             decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 3, 38, 67),
//                 borderRadius: BorderRadius.circular(15)),
//             child: Center(
//                 child: Text(
//               "delhi to mumbai ",
//               style: GoogleFonts.rajdhani(
//                 color: Colors.white,
//                 fontSize: 17,
//                 fontWeight: FontWeight.w600,
//               ),
//             )),
//           ),
//         ),
//         kheight10,
//         kheight10,
//         for (int i = 0; i <= tripLength; i++)
//           additionalContainer(widget.swidth, widget.sheight),
//         kheight10,
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             SizedBox(
//               width: 610,
//             ),
//             Visibility(
//               visible:showContainer? (tripLength<=1?false:true):false,
//               child: GestureDetector(
//                  onTap: () {
//                   setState(() {
//                      tripLength--;
//                   });
//                 },
//                 child: CircleAvatar(
//                   radius: 8,
//                   backgroundColor: Colors.grey.shade700,
//                   child: Center(
//                       child: Icon(
//                     Icons.clear,
//                     color: Colors.white,
//                     size: 10,
//                   )),
//                 ),
//               ),
//             ),
//             kwidth3,
//             kwidth5,
//             Visibility(
//               visible: showContainer?(tripLength>=4?false:true):false,
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                      tripLength++;
//                   });
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.blueAccent, width: 0.8)),
//                   height: widget.sheight * 0.0538,
//                   width: widget.swidth * 0.0538,
//                   child: Center(
//                     child: Text(
//                       "+ Add City",
//                       style: GoogleFonts.rajdhani(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

// additionalContainer(double swidth, double sheight) {
//   return Visibility(
//     visible: showContainer,
//     child: Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: Container(
//         decoration: BoxDecoration(
//             // color: Colors.red,
//             // borderRadius: BorderRadius.circular(15)
//             ),
//         height: sheight * 0.1,
//         width: swidth * 0.45,
//         child: Row(
//           children: [
//             Container(
//               height: 150,
//               width: 270,
//               color: Color.fromARGB(255, 16, 0, 94).withOpacity(0.8),
//             ),
//             kwidth5,
//             Container(
//               height: 150,
//               width: 270,
//               color: Color.fromARGB(255, 16, 0, 94).withOpacity(0.8),
//             ),
//             kwidth5,
//             Container(
//               height: 150,
//               width: 140,
//               color: Color.fromARGB(255, 16, 0, 94).withOpacity(0.8),
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }
