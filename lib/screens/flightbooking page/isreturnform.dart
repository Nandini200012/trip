import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api_services/location_list_api.dart';


class formDataWidgetReturn extends StatefulWidget {
  bool isShow;
  int index;
  bool isReturn;
  formDataWidgetReturn({Key key, this.isShow, this.index,this.isReturn}) : super(key: key);
  @override
  _formDataWidgetReturnState createState() => _formDataWidgetReturnState();
}

List<LocationData> locationList1 = [];
// from
bool from_showTextField = false;
bool from_textCity1 = true;
bool from_adrsCity1 = true;
String from_city = 'Select a location';
String from_address = '';
String from_code = '';
LocationData from_dropdownvalue;
// to
bool to_showTextField = false;
bool to_textCity1 = true;
bool to_adrsCity1 = true;
String to_city = 'Select a location';
String to_address = '';
String to_code = '';
LocationData to_dropdownvalue;
// departure
String dayDeparture;
String dayReturn;
String dateDep;
String dateRet;
String depformat;
String retformat;
DateTime selectedDate = DateTime.now();
TextEditingController dateController = TextEditingController();
final DateFormat formatter = DateFormat('dd-MM-yyyy');
final DateFormat reverseDtFormatter = DateFormat('yyyy-MM-dd');
TextEditingController dateForController = TextEditingController();
DateTime selectedDate1 = DateTime.now();
TextEditingController date1Controller = TextEditingController();
final DateFormat formatter1 = DateFormat('dd-MM-yyyy');
final DateFormat reverseDtFormatter1 = DateFormat('yyyy-MM-dd');
TextEditingController dateForController1 = TextEditingController();

class _formDataWidgetReturnState extends State<formDataWidgetReturn> {
  @override
  void initState() {
    super.initState();
    getLocationList();
    dateController.text = formatDate(DateTime.now());
    dateForController.text = formatDate(DateTime.now());
  }

  getLocationList() async {
    String res = await getLocationListAPI();
    LocationObj locationObj = LocationObj.fromJson(jsonDecode(res));
    setState(() {
      locationList1 = locationObj.data;
      print('locationlist');
      print(locationList1.length);
    });
  }

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        print('picked.day');
        print(picked.weekday);
        print(getDayName(selectedDate));
        dayDeparture = getDayName(selectedDate);
        dateDep = formatDate(selectedDate);

        dateController.text = formatter.format(selectedDate);
        print('Selected date');
        print(formatDate(selectedDate));
        print(selectedDate);
        depformat = formatData(selectedDate);
        print("formatted:$depformat");
        dateForController.text = reverseDtFormatter.format(selectedDate);
        // _dateController.text = DateFormat.yMd().format(selectedDate);
        // visibledate=true;
      });
  }

  String getDayName(DateTime date) {
    return DateFormat('EEEE').format(date); // EEEE represents the full day name
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yy').format(date);
  }

  String formatData(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return locationList1 != null
        ? Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: buildDropdownWidget(
                    city: from_city,
                    showTextField: from_showTextField,
                    textCity: from_textCity1,
                    adrsCity: from_adrsCity1,
                    onTap: () {
                      setState(() {
                        from_showTextField = true;
                        from_textCity1 = false;
                        from_adrsCity1 = false;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        from_dropdownvalue = value;
                        from_showTextField = false;
                        from_textCity1 = true;
                        from_adrsCity1 = true;
                        from_city = value.city;
                        from_address = value.name;
                        from_code = value.code;
                        print("code: $from_code");
                        print('city - $from_city');
                        print('address - $from_address');
                      });
                    },
                    selectedItem: from_dropdownvalue,
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: buildDropdownWidget(
                    city: to_city,
                    showTextField: to_showTextField,
                    textCity: to_textCity1,
                    adrsCity: to_adrsCity1,
                    onTap: () {
                      setState(() {
                        to_showTextField = true;
                        to_textCity1 = false;
                        to_adrsCity1 = false;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        to_dropdownvalue = value;
                        to_showTextField = false;
                        to_textCity1 = true;
                        to_adrsCity1 = true;
                        to_city = value.city;
                        to_address = value.name;
                        to_code = value.code;
                        print("code: $to_code");
                        print('city - $to_city');
                        print('address - $to_address');
                      });
                    },
                    selectedItem: to_dropdownvalue,
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Departure',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            dateDep ?? dateController.text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            dayDeparture ?? '',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                 VerticalDivider(),
                Visibility(
                  visible: widget.isReturn,
                  child: Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              dateDep ?? dateController.text,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              dayDeparture ?? '',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // VerticalDivider(),
                // Visibility(
                //     visible: widget.isShow ? false : true,
                //     child: Expanded(
                //         child: Row(
                //       children: [
                //         Container(
                //           height: 50,
                //           child: Padding(
                //             padding: const EdgeInsets.symmetric(
                //                 vertical: 10, horizontal: 30),
                //             // child: ElevatedButton(
                //             //     onPressed: () {
                //             //       setState(() {
                //             //         globalindex = globalindex + 1;
                //             //         print("globalindex");
                //             //         print(globalindex);
                //             //         Navigator.pushReplacement(
                //             //             context,
                //             //             MaterialPageRoute(
                //             //                 builder: (context) => FlightBooking(
                //             //                       locationList1: locationList1,
                //             //                     )));
                //             //       });
                //             //     },
                //             //     child: Row(
                //             //       children: [
                //             //         Icon(Icons.add),
                //             //         SizedBox(
                //             //           width: 8,
                //             //         ),
                //             //         // Text("Add Another City")
                //             //       ],
                //             //     )),
                //           ),
                //         ),
                    //     Visibility(
                    //       visible: globalindex > 1 ? true : false,
                    //       child: IconButton(
                    //           onPressed: () {
                    //             setState(() {
                    //               globalindex = globalindex - 1;
                    //               print("globalindex");
                    //               print(globalindex);
                    //               Navigator.pushReplacement(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) => FlightBooking(
                    //                             locationList1: locationList1,
                    //                           )));
                    //               // show_multicity3 = true;
                    //             });
                    //           },
                    //           icon: Icon(
                    //             Icons.delete,
                    //             size: 30,
                    //           )),
                    //     )
                    //   ],
                    // ))),
                VerticalDivider(),
                Visibility(
                  visible: widget.isShow,
                  child: Expanded(
                    child: GestureDetector(
                      onTapDown: (details) {
                        // TravellerCountOverlay();
                        // setState(() {
                        // showTextField = true;
                        // traveller_class =
                        //     showTravellerCount(context, details.globalPosition);
                        // });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Traveler & Class',
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  "1",
                                  // '${total_count(paxinfo)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Travellers',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              // paxinfo != null ? " ${paxinfo.Class}" : 'Economy',
                              'Economy',
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Text("Null data");
  }

  void _toggleDropdown(bool from, bool to, bool departure) {
    setState(() {
      from_showTextField = from;
      from_textCity1 = !from;
      from_adrsCity1 = !from;
      to_showTextField = to;
      to_textCity1 = !to;
      to_adrsCity1 = !to;
    });
  }

  void _updateFromDropdown(LocationData value) {
    setState(() {
      from_dropdownvalue = value;
      from_showTextField = false;
      from_textCity1 = true;
      from_adrsCity1 = true;
      from_city = value.city;
      from_address = value.name;
      from_code = value.code;
      print("code: $from_code");
      print('city - $from_city');
      print('address - $from_address');
    });
  }

  void _updateToDropdown(LocationData value) {
    setState(() {
      to_dropdownvalue = value;
      to_showTextField = false;
      to_textCity1 = true;
      to_adrsCity1 = true;
      to_city = value.city;
      to_address = value.name;
      to_code = value.code;
      print("code: $to_code");
      print('city - $to_city');
      print('address - $to_address');
    });
  }

  Widget buildDropdownWidget({
    String city,
    bool showTextField,
    bool textCity,
    bool adrsCity,
    Function() onTap,
    Function(LocationData) onChanged,
    LocationData selectedItem,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            city.isNotEmpty ? city : 'From',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Visibility(
            visible: textCity,
            child: SizedBox(height: 8),
          ),
          Visibility(
            visible: textCity,
            child: Text(
              city.isNotEmpty ? city : 'Select',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: showTextField,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: DropdownSearch<LocationData>(
                  compareFn: (LocationData item, LocationData selectedItem) =>
                      item == selectedItem,
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    showSelectedItems: true,
                  ),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: 'Search for a location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  items: locationList1,
                  onChanged: onChanged,
                  selectedItem: selectedItem,
                  itemAsString: (LocationData location) => location.name,
                ),
              ),
            ),
          ),
          Visibility(
            visible: adrsCity,
            child: SizedBox(height: 4),
          ),
          Visibility(
            visible: adrsCity,
            child: Text(
              'address',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
