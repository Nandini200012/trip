
import 'package:flutter/material.dart';

// import 'package:dropdown_button2/dropdown_button2.dart';

class FlightBookingSearchPage extends StatefulWidget {
  const FlightBookingSearchPage({Key key}) : super(key: key);

  @override
  _FlightBookingSearchPageState createState() =>
      _FlightBookingSearchPageState();
}

class _FlightBookingSearchPageState extends State<FlightBookingSearchPage> {
  String selectedRadioButton = '';
  bool showTextField = false;
  String selectedValue = 'One Way';
  List<String> availableItems = ['One Way', 'Round Trip', 'Multi City'];
  List<String> listTrip = <String>['One Way', 'Round Trip', 'Multi City'];
  String dropdownValue;
  TextEditingController from_controller = TextEditingController();
  TextEditingController to_controller = TextEditingController();

  // String selectedValue = 'One Way';
  // Default selected v
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = listTrip.first;
  }

  @override
  Widget build(BuildContext context) {
    final currentwidth = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF0d2b4d)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Flights",
            style: TextStyle(color: Color(0xFF0d2b4d)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ListView(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.9,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(
                  color: Color(0xFF0d2b4d),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        dropdown1(),
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              // Container aligned at the top
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  // color: Colors.red,
                                  child: Column(
                                    children: [
                                      textfield("FROM", Icons.flight_takeoff,
                                          'New Delhi,India', from_controller),
                                    ],
                                  ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 0,
                                          width: width,
                                          color: Colors.transparent),
                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                      textfield("TO", Icons.flight_land,
                                          'Pune,India', to_controller),
                                    ],
                                  ),
                                ),
                              ),
                              // Container centered over both
                              Positioned(
                                top:
                                    0, // Adjust this value to position the container over both
                                bottom:
                                    10, // Adjust this value to position the container over both
                                left: 250,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 0.7,
                                          color:
                                              Color.fromARGB(255, 1, 49, 133)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 35,
                                    width: 35,
                                    child: Center(
                                      child: Icon(
                                        Icons.swap_vert,
                                        color: Color.fromARGB(255, 3, 4, 52),
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        textfield('DEPART', Icons.calendar_month,
                            'Thu,Nov 30 2023,', to_controller),
                        SizedBox(
                          height: 14,
                        ),
                        textfield("RETURN", Icons.calendar_month,
                            'Thu,Dec 30 2023', to_controller),
                        SizedBox(
                          height: 14,
                        ),
                        textfield('PASSENGERS & CLASS', Icons.calendar_month,
                            '1 Adult,Economy', to_controller),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Fare Type:',
                            style: TextStyle(
                                color: Color.fromARGB(255, 240, 236, 236),
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10,
                        ),
                        Radiobutton('Regular'),
                        SizedBox(
                          height: 10,
                        ),
                        Radiobutton(
                          'Student',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Radiobutton(
                          'Senior Citizen',
                        ),
                        SizedBox(
                          height: 15,
                        ),





                        
                        Container(
                          width: double
                              .infinity, // Make button fill available width
                          decoration: BoxDecoration(
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Color.fromARGB(255, 82, 127, 163).withOpacity(
                            //         0.5), // Adjust the glow color and opacity as needed
                            //     spreadRadius: 5,
                            //     blurRadius: 7,
                            //     offset: Offset(0, 3),
                            //   ),
                            // ],
                          ),
                          child: Theme(
                            data: ThemeData(
                              elevatedButtonTheme: ElevatedButtonThemeData(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 1, 95, 183),
                                  ),
                                  // You can customize other button properties here such as text color, padding, etc.
                                ),
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your button onPressed logic here
                              },
                              child: Text(
                                "Search",
                                style: TextStyle(
                                  // Customize text style for "Search"
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, // Text color
                                  // You can add more text styling properties here as needed
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
            ]),
          ),
        ));
  }

  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         // SizedBox(
  //                         //   width: 20,
  //                         // ),
  //                         Container(
  //                           height: 50,
  //                           padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
  //                           margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
  //                           decoration: BoxDecoration(
  //                             color: Color(0xfffff1A),
  //                             borderRadius: BorderRadius.circular(8),
  //                           ),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 'PASSENGERS & CLASS',
  //                                 style:
  //                                     TextStyle(color: Colors.blue, fontSize: 12),
  //                               ),
  //                               Container(
  //                                   padding: EdgeInsets.zero,
  //                                   child: Text(
  //                                     ''
  //                                     '1 Adult,Economy',
  //                                     style: TextStyle(
  //                                         color: Colors.white,
  //                                         fontWeight: FontWeight.bold),
  //                                   )),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Container(
  //                       padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
  //                       child: Row(
  //                         children: [
  //                           Text('Fare Type:',
  //                               style: TextStyle(
  //                                   color: Colors.grey,
  //                                   fontWeight: FontWeight.bold)),
  //                           SizedBox(
  //                             width: 8,
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             children: [
  //                               Container(
  //                                 padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
  //                                 // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
  //                                 decoration: BoxDecoration(
  //                                     color: Color(0xFF364C63),
  //                                     borderRadius: BorderRadius.circular(4)),
  //                                 child: Row(
  //                                   children: [
  //                                     Theme(
  //                                       data: ThemeData(
  //                                         unselectedWidgetColor: Colors
  //                                             .white70, // Change the unselected radio button color
  //                                       ),
  //                                       child: Radio(
  //                                         value: 'Regular',
  //                                         groupValue: selectedRadioButton,
  //                                         onChanged: (value) {
  //                                           setState(() {
  //                                             selectedRadioButton =
  //                                                 value.toString();
  //                                           });
  //                                         },
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       'Regular',
  //                                       style: TextStyle(color: Colors.white),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                               Container(
  //                                 padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
  //                                 margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
  //                                 decoration: BoxDecoration(
  //                                     color: Color(0xFF364C63),
  //                                     borderRadius: BorderRadius.circular(4)),
  //                                 child: Row(
  //                                   children: [
  //                                     Theme(
  //                                       data: ThemeData(
  //                                         unselectedWidgetColor: Colors
  //                                             .white70, // Change the unselected radio button color
  //                                       ),
  //                                       child: Radio(
  //                                         value: 'Student',
  //                                         groupValue: selectedRadioButton,
  //                                         onChanged: (value) {
  //                                           setState(() {
  //                                             selectedRadioButton =
  //                                                 value.toString();
  //                                           });
  //                                         },
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       'Student',
  //                                       style: TextStyle(color: Colors.white),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                               Container(
  //                                 padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
  //                                 margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
  //                                 decoration: BoxDecoration(
  //                                     color: Color(0xFF364C63),
  //                                     borderRadius: BorderRadius.circular(4)),
  //                                 child: Row(
  //                                   children: [
  //                                     Theme(
  //                                       data: ThemeData(
  //                                         unselectedWidgetColor: Colors
  //                                             .white70, // Change the unselected radio button color
  //                                       ),
  //                                       child: Radio(
  //                                         value: 'Senior Citizen',
  //                                         groupValue: selectedRadioButton,
  //                                         onChanged: (value) {
  //                                           setState(() {
  //                                             selectedRadioButton =
  //                                                 value.toString();
  //                                           });
  //                                         },
  //                                       ),
  //                                     ),
  //                                     Text(
  //                                       'Senior Citizen',
  //                                       style: TextStyle(color: Colors.white),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     )
  //       ],
  //     ),
  //   ),
  //   // ],
  // )

  //     // ],
  //     );
  //   ),
  // );
  //   ]),
  // )
  // ])
  // )
  // );
  // }

  Widget Radiobutton(text) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
      // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 1, 3, 60).withOpacity(0.3),
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor:
                  Colors.white70, // Change the unselected radio button color
            ),
            child: Radio(
              value: text,
              groupValue: selectedRadioButton,
              onChanged: (value) {
                setState(() {
                  selectedRadioButton = value.toString();
                });
              },
            ),
          ),
          Text(
            text,
            style: TextStyle(
                color: Color.fromARGB(255, 251, 251, 252),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget dropdown1() {
    return Container(
        width: 700,
        height: 52,
        padding: EdgeInsets.fromLTRB(5, 8, 10, 5),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          // color: Color(0xfffff1A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Trip Type',
                style: TextStyle(
                    color: Color.fromARGB(255, 1, 7, 41),
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.zero,
                child: DropdownButtonHideUnderline(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor:
                          Colors.white, // Change dropdown background color
                      textTheme: Theme.of(context).textTheme.copyWith(
                            caption: TextStyle(
                                color: Colors
                                    .white), // Change dropdown item text color
                          ),
                    ),
                    child: DropdownButton<String>(
                      isDense: true,
                      value: dropdownValue,
                      // icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: TextStyle(color: Colors.white),
                      onChanged: (String value) {
                        setState(() {
                          dropdownValue = value;
                          // listTrip.remove(value);
                        });
                      },
                      items: listTrip
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Color.fromARGB(255, 1, 7, 41),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              )
            ]));
  }

  Widget textfield(label, icon, text, _controller) {
    return TextFormField(
      // controller: _controller,
      decoration: InputDecoration(
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 1, 7, 41),
              fontWeight: FontWeight.bold),
          hintText: text,
          contentPadding: EdgeInsets.all(2),
          prefixIconColor: Color.fromARGB(255, 1, 7, 41),
          prefixIcon: Icon(icon),
          labelText: label,
          labelStyle:
              TextStyle(color: Color.fromARGB(255, 1, 7, 41), fontSize: 12),
          fillColor: Colors.white,
          filled: true),
      initialValue: text,
      style: TextStyle(
          color: Color.fromARGB(255, 1, 7, 41), fontWeight: FontWeight.bold),
    );
  }
}
