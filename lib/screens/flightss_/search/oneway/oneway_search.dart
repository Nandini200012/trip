import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../../api_services/location_list_api.dart';


class OnewaySearchForm extends StatefulWidget {
  List<LocationData> locationList1;
   OnewaySearchForm({this.locationList1});

  @override
  State<OnewaySearchForm> createState() => _OnewaySearchFormState();
}

String address="";
bool adrsCity1;
bool showTextField=false;
bool textCity1=false;
 LocationData dropdownvalue;
 List<LocationData> locationList;
  String from_code = ''; String city = "Select an option";
class _OnewaySearchFormState extends State<OnewaySearchForm> {
  void onLocationChanged(LocationData value) {
  setState(() {
    dropdownvalue = value;
    showTextField = false;
    textCity1 = true;
    adrsCity1 = true;
    city = value.city;
    address = value.name;
    from_code = value.code;
    print("code: $from_code");
    print('city - $city');
    print('address - $address');
  });
}


@override
void initState() { 
  super.initState();
getLocationList();
}





getLocationList() async {
    print("getLocationList()");
    String res = await getLocationListAPI();
    LocationObj locationObj = LocationObj.fromJson(jsonDecode(res));
    setState(() {
      locationList = locationObj.data;
      print('locationlist');
      print(locationList.length);
    });

    return res;
  }




  @override
  Widget build(BuildContext context) {
      final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;
    return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Container(
                height: sHeight * 0.2,
                width: sWidth * 0.96,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showTextField = true;
                            textCity1 = false;
                            adrsCity1 = false;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  city,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Expanded(
                                  child: Visibility(
                                    visible: true,
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: DropdownSearch<LocationData>(
                                        compareFn:
                                            ( item,  selectedItem) {
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
                                        items: widget.locationList1,
                                        onChanged: (value) {
                                          setState(() {
                                            dropdownvalue = value;
                                            showTextField = false;
                                            textCity1 = true;
                                            adrsCity1 = true;
                                            city = value.name;
                                            // state = value.;

                                            from_code = value.id;
                                            // var state_code1 = value.stateId;
                                            print('');
                                        
                                          });
                                        },
                                        selectedItem: dropdownvalue,
                                        itemAsString: (LocationData city) => city.name,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
VerticalDivider(),
                    // ----to-----
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       setState(() {
                    //         showTextField1 = true;
                    //         textCity2 = false;
                    //         adrsCity2 = false;
                    //       });
                    //     },
                    //     child: Container(
                    //       margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text('To',
                    //               style: TextStyle(
                    //                   color: Colors.grey, fontSize: 12)),
                    //           Text(city1,
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 18)),
                    //           Expanded(
                    //             child: Visibility(
                    //               visible: true,
                    //               child: Padding(
                    //                 padding: EdgeInsets.all(16.0),
                    //                 child: DropdownSearch<City>(
                    //                   compareFn:
                    //                       (City item1, City selectedItem1) =>
                    //                           item1 == selectedItem1,
                    //                   popupProps: PopupProps.menu(
                    //                       showSearchBox: true,
                    //                       showSelectedItems: true),
                    //                   dropdownDecoratorProps:
                    //                       DropDownDecoratorProps(
                    //                     dropdownSearchDecoration:
                    //                         InputDecoration(
                    //                       labelText: 'Search for a location',
                    //                       border: OutlineInputBorder(),
                    //                     ),
                    //                   ),
                    //                   items: widget.city,
                    //                   onChanged: (value) {
                    //                     setState(() {
                    //                       dropdownvalue1 = value;
                    //                       showTextField1 = false;
                    //                       textCity2 = true;
                    //                       adrsCity2 = true;
                    //                       city1 = value.name;
                    //                       state1 = value.state;
                    //                       to_code = value.id;
                    //                       var state_code = value.stateId;
                    //                       print('');
                    //                       print(
                    //                           'city2 - $city1,code - $to_code');
                    //                       print(
                    //                           'state2 - $state1, state id - $state_code');
                    //                     });
                    //                   },
                    //                   selectedItem: dropdownvalue1,
                    //                   itemAsString: (City city1) => city1.name,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // VerticalDivider(),
                    // // --------date
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       _selectDate(context);
                    //     });
                    //   },
                    //   child: Center(
                    //     child: Container(
                    //       width: sWidth * 0.19,
                    //       margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           SizedBox(height: 35),
                    //           SizedBox(width: 8),
                    //           Text(
                    //             'Date',
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.grey,
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //           Center(
                    //             child: Container(
                    //               width: sWidth * 0.17,
                    //               height: sHeight * 0.07,
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(5),
                    //                   border: Border.all(
                    //                       width: 1.0, color: Colors.grey)),
                    //               child: Row(
                    //                 children: [
                    //                   SizedBox(
                    //                     width: 5,
                    //                   ),
                    //                   Icon(
                    //                     Icons.calendar_month,
                    //                     color: Colors.grey,
                    //                     size: 20,
                    //                   ),
                    //                   SizedBox(
                    //                     width: 25,
                    //                   ),
                    //                   Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.center,
                    //                     children: [
                    //                       Text(
                    //                         date ?? dateController.text,
                    //                         style: TextStyle(
                    //                           fontWeight: FontWeight.bold,
                    //                           fontSize: 18,
                    //                         ),
                    //                       ),
                    //                       if (day != null)
                    //                         Text(
                    //                           day ?? '',
                    //                           style: TextStyle(
                    //                             fontWeight: FontWeight.w500,
                    //                             color: Colors.grey,
                    //                             fontSize: 12,
                    //                           ),
                    //                         )
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: sHeight * 0.1,
              ),
              Container(
                width: sWidth * 0.09,
                height: sHeight * 0.07,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromARGB(255, 226, 48, 7),
                    borderRadius: BorderRadius.circular(15)),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // if (from_code != null &&
                    //     to_code != null &&
                    //     formatted_date != null) {
                    //   print("from:$from_code");
                    //   print("to:$to_code");
                    //   print("date:$formatted_date");
                    //   getavailable_trip(from_code, to_code, formatted_date);
                    // } else {
                    //   print("from:$from_code");
                    //   print("to:$to_code");
                    //   print("date:$formatted_date");
                    //   _checkAndProceed();
                    // }
                  },
                  child: Text(
                    "Search",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ]));
  //   return Center(
  //   child: Container(
  //     width: sWidth * 0.95,
  //     height: sHeight * 0.2,
  //     decoration: BoxDecoration(
  //       color: Color.fromARGB(255, 139, 139, 139),
  //       border: Border.all(width: 0.5,color: Colors.grey),
  //       borderRadius: BorderRadius.circular(5)
  //     ),
  //     child: Row(
  //       children: [
  //        buildLocationWidget(),
  //       ],
  //     ),
  //   ),
  // );
  }
  Widget buildLocationWidget() {
  return Column(
    children: [
      buildDropdownSearch(),
      buildAddressText(),
    ],
  );
}

Widget buildDropdownSearch() {
  return Expanded(
    child: Visibility(
      visible: true,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: DropdownSearch<LocationData>(
          compareFn: (item, selectedItem) => item == selectedItem,
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
          items: widget.locationList1,
          onChanged: onLocationChanged,
          selectedItem: dropdownvalue,
          itemAsString: (location) => location.name,
        ),
      ),
    ),
  );
}
Widget buildAddressText() {
  return Visibility(
    visible: true,
    child: Column(
      children: [
        SizedBox(height: 4),
        Text(
          address,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

}



































// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';

// import '../../../../api_services/location_list_api.dart';

// class OnewaySearchForm extends StatefulWidget {
//   final List<LocationData> locationList1;

//   OnewaySearchForm({ this.locationList1});

//   @override
//   State<OnewaySearchForm> createState() => _OnewaySearchFormState();
// }

// class _OnewaySearchFormState extends State<OnewaySearchForm> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.95,
//         height: MediaQuery.of(context).size.height * 0.2,
//         decoration: BoxDecoration(
//           color: Color.fromARGB(255, 139, 139, 139),
//           border: Border.all(width: 0.5, color: Colors.grey),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Row(
//           children: [
//             _LocationWidget(locationList: widget.locationList1),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _LocationWidget extends StatelessWidget {
//   final List<LocationData> locationList;

//   const _LocationWidget({ this.locationList});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildDropdownSearch(locationList),
//         _buildAddressText(),
//       ],
//     );
//   }

//   Widget _buildDropdownSearch(List<LocationData> locationList) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: DropdownSearch<LocationData>(
//           popupProps: PopupProps.menu(
//             showSearchBox: true,
//             showSelectedItems: true,
//           ),
//           dropdownDecoratorProps: DropDownDecoratorProps(
//             dropdownSearchDecoration: InputDecoration(
//               labelText: 'Search for a location',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           items: locationList,
//           onChanged: (value) {
//             // Handle location change
//           },
//           itemAsString: (location) => location.name,
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressText() {
//     return Visibility(
//       visible: true, // Set your condition here
//       child: Column(
//         children: [
//           SizedBox(height: 4),
//           Text(
//             "Address Placeholder",
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }












