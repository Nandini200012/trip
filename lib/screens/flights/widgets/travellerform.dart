import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class TravellerForm extends StatefulWidget {
  final String title;
  final String label;
  final String prefix;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mobileController;
  final TextEditingController emailController;
  final TextEditingController PassportNumberController;
  final TextEditingController PassportNationalityController;
  final TextEditingController ExpiryDateController;
  final TextEditingController DateofBirthController;
  final TextEditingController PassportIssuedDateController;
  final TextEditingController AddressController;

  TravellerForm({
    Key key,
    @required this.title,
    @required this.label,
    @required this.prefix,
    @required this.firstNameController,
    @required this.lastNameController,
    @required this.mobileController,
    @required this.emailController,
    @required this.PassportNumberController,
    @required this.PassportNationalityController,
    @required this.ExpiryDateController,
    @required this.DateofBirthController,
    @required this.PassportIssuedDateController,
    @required this.AddressController,
  }) : super(key: key);

  @override
  _TravellerFormState createState() => _TravellerFormState();
}

class _TravellerFormState extends State<TravellerForm> {
  String selectedValue = '';
  final _formKey = GlobalKey<FormState>();

  DropdownButtonFormField<String> buildFlightDropdown() {
    final List<String> dropdownItems = ['Mr', 'Ms', 'Mrs'];
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Title',
      ),
      value: selectedValue.isNotEmpty ? selectedValue : null,
      items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          selectedValue = newValue;
        });
        print('Selected Value: $selectedValue');
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a value';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.blue.shade200,
                    child: Center(
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                  SizedBox(width: 3),
                  Text(
                    "${widget.title}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Card(
              elevation: 2.0,
              child: Container(
                color: Color.fromARGB(255, 255, 212, 148).withOpacity(0.5),
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Important:",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      " Enter name as mentioned on your passport or Government approved IDs.",
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Divider(),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: buildFlightDropdown(),
                        ),
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: widget.firstNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'First Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: widget.lastNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: widget.PassportNumberController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Passport Number',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: widget.PassportNationalityController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Passport Nationality',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: widget.ExpiryDateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Expiry Date',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: widget.DateofBirthController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Date of Birth',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: widget.PassportIssuedDateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Passport Issued Date',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: TextFormField(
                            controller: widget.AddressController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Address',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Country Code',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.8, color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: CountryCodePicker(
                                flagWidth: 25,
                                onChanged: (CountryCode countryCode) {
                                  print(
                                      'New country selected: ${countryCode.name}');
                                },
                                initialSelection: 'भारत',
                                favorite: ['+91', 'भारत'],
                                showCountryOnly: true,
                                alignLeft: false,
                                textStyle: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobile Number',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: 250,
                              height: 50,
                              child: TextFormField(
                                controller: widget.mobileController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Mobile Number',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: 250,
                              height: 50,
                              child: TextFormField(
                                controller: widget.emailController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:country_code_picker/country_code_picker.dart';

// import 'dropdown_form.dart';

// class Travellerform extends StatefulWidget {
//   final String title;
//   final String label;
//   final String prefix;
//   final TextEditingController firstNameController;
//   final TextEditingController lastNameController;
//   final TextEditingController mobileController;
//   final TextEditingController emailController;
//   // final ValueNotifier<String> genderNotifier;

//   Travellerform({
//     Key key,
//     @required this.title,
//     @required this.label,
//     @required this.prefix,
//     @required this.firstNameController,
//     @required this.lastNameController,
//     @required this.mobileController,
//     @required this.emailController,
//     // @required this.genderNotifier,
//   }) : super(key: key);

//   @override
//   _TravellerformState createState() => _TravellerformState();
// }

// class _TravellerformState extends State<Travellerform> {
//   // /Color maleContainerColor = Colors.white;
//   // Color femaleContainerColor = Colors.white;

//   DropdownButtonFormField<String> buildFlightDropdown(String title) {
//     String selectedValue = '';

//     final List<String> dropdownItems = ['Mr', 'Ms', 'Mrs'];
//     //   'adult': ['Mr', 'Ms', 'Mrs'],
//     //   'child': ['Master', 'Ms'],
//     //   'infant': ['Master', 'Ms']
//     // };

//     // selectedValue = dropdownItems[title.toLowerCase()]?.first ?? '';

//     List<String> items = dropdownItems;
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'Title',
//       ),
//       value: selectedValue.isNotEmpty ? selectedValue : null,
//       items: items.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (String newValue) {
//         if (newValue != null) {
//           selectedValue = newValue;
//           print('Selected Value: $selectedValue');
//         }
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please select a value';
//         }
//         return null;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 14,
//                   backgroundColor: Colors.blue.shade200,
//                   child: Center(
//                     child: Icon(
//                       Icons.person_rounded,
//                       color: Colors.black,
//                       size: 25,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 3),
//                 Text(
//                   "${widget.title}",
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 5),
//           Card(
//             elevation: 2.0,
//             child: Container(
//               color: Color.fromARGB(255, 255, 212, 148).withOpacity(0.5),
//               height: 25,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Important:",
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                   Text(
//                     " Enter name as mentioned on your passport or Government approved IDs.",
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Card(
//             elevation: 5.0,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.label,
//                     style: TextStyle(fontWeight: FontWeight.w700),
//                   ),
//                   Divider(),
//                   SizedBox(height: 30),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(
//                           width: 250,
//                           height: 50,
//                           child: buildFlightDropdown(widget.title)
//                           // child: FlightDropdown(
//                           // title: widget.title,
//                           // ),
//                           ),

//                       SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: TextFormField(
//                           controller: widget.firstNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'First Name',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: TextFormField(
//                           controller: widget.lastNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Last Name',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       // Row(
//                       //   children: [
//                       //     GestureDetector(
//                       //       onTap: () {
//                       //         setState(() {
//                       //           maleContainerColor = Colors.blue;
//                       //           femaleContainerColor = Colors.white;
//                       //           widget.genderNotifier.value = "Male";
//                       //         });
//                       //       },
//                       //       child: Container(
//                       //         height: 50,
//                       //         width: 125,
//                       //         decoration: BoxDecoration(
//                       //           border: Border.all(width: 1.0, color: Colors.grey),
//                       //           borderRadius: BorderRadius.circular(5),
//                       //           color: maleContainerColor,
//                       //         ),
//                       //         child: Center(
//                       //           child: Text(
//                       //             "Male",
//                       //             style: TextStyle(
//                       //               color: maleContainerColor == Colors.blue
//                       //                   ? Colors.white
//                       //                   : Colors.black,
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //     GestureDetector(
//                       //       onTap: () {
//                       //         setState(() {
//                       //           femaleContainerColor = Colors.blue;
//                       //           maleContainerColor = Colors.white;
//                       //           widget.genderNotifier.value = "Female";
//                       //         });
//                       //       },
//                       //       child: Container(
//                       //         height: 50,
//                       //         width: 125,
//                       //         decoration: BoxDecoration(
//                       //           border: Border.all(width: 1.0, color: Colors.grey),
//                       //           borderRadius: BorderRadius.circular(5),
//                       //           color: femaleContainerColor,
//                       //         ),
//                       //         child: Center(
//                       //           child: Text(
//                       //             "Female",
//                       //             style: TextStyle(
//                       //               color: femaleContainerColor == Colors.blue
//                       //                   ? Colors.white
//                       //                   : Colors.black,
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                     ],
//                   ),
//                   SizedBox(height: 30),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: TextFormField(
//                           controller: widget.firstNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Passport Number',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: TextFormField(
//                           controller: widget.firstNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Passport Nationality',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: TextFormField(
//                           controller: widget.lastNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Expiry Date',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                      SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: TextFormField(
//                           controller: widget.firstNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Date of Birth',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: TextFormField(
//                           controller: widget.firstNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Passport Issued Date',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: TextFormField(
//                           controller: widget.lastNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Extra',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       // Row(
//                       //   children: [
//                       //     GestureDetector(
//                       //       onTap: () {
//                       //         setState(() {
//                       //           maleContainerColor = Colors.blue;
//                       //           femaleContainerColor = Colors.white;
//                       //           widget.genderNotifier.value = "Male";
//                       //         });
//                       //       },
//                       //       child: Container(
//                       //         height: 50,
//                       //         width: 125,
//                       //         decoration: BoxDecoration(
//                       //           border: Border.all(width: 1.0, color: Colors.grey),
//                       //           borderRadius: BorderRadius.circular(5),
//                       //           color: maleContainerColor,
//                       //         ),
//                       //         child: Center(
//                       //           child: Text(
//                       //             "Male",
//                       //             style: TextStyle(
//                       //               color: maleContainerColor == Colors.blue
//                       //                   ? Colors.white
//                       //                   : Colors.black,
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //     GestureDetector(
//                       //       onTap: () {
//                       //         setState(() {
//                       //           femaleContainerColor = Colors.blue;
//                       //           maleContainerColor = Colors.white;
//                       //           widget.genderNotifier.value = "Female";
//                       //         });
//                       //       },
//                       //       child: Container(
//                       //         height: 50,
//                       //         width: 125,
//                       //         decoration: BoxDecoration(
//                       //           border: Border.all(width: 1.0, color: Colors.grey),
//                       //           borderRadius: BorderRadius.circular(5),
//                       //           color: femaleContainerColor,
//                       //         ),
//                       //         child: Center(
//                       //           child: Text(
//                       //             "Female",
//                       //             style: TextStyle(
//                       //               color: femaleContainerColor == Colors.blue
//                       //                   ? Colors.white
//                       //                   : Colors.black,
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Country Code',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Container(
//                             width: 250,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               border:
//                                   Border.all(width: 0.8, color: Colors.grey),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: CountryCodePicker(
//                               flagWidth: 25,
//                               onChanged: (CountryCode countryCode) {
//                                 print(
//                                     'New country selected: ${countryCode.name}');
//                               },
//                               initialSelection: 'भारत',
//                               favorite: ['+91', 'भारत'],
//                               showCountryOnly: true,
//                               alignLeft: false,
//                               textStyle: TextStyle(fontSize: 15),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Mobile Number',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           SizedBox(
//                             width: 250,
//                             height: 50,
//                             child: TextFormField(
//                               controller: widget.mobileController,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 labelText: 'Mobile Number (optional)',
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter some text';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Email',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           SizedBox(
//                             width: 250,
//                             height: 50,
//                             child: TextFormField(
//                               controller: widget.emailController,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 labelText: 'Email (optional)',
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter some text';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30),
//                   Divider(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

















// import 'package:flutter/material.dart';
// import 'package:country_code_picker/country_code_picker.dart';

// class Travellerform extends StatefulWidget {
//   final String title;
//   final String label;
//   final String prefix;

//   Travellerform({Key key, @required this.title, @required this.label, @required this.prefix}) : super(key: key);

//   @override
//   _TravellerformState createState() => _TravellerformState();
// }

// class _TravellerformState extends State<Travellerform> {
//   TextEditingController _firstNameController = TextEditingController();
//   TextEditingController _lastNameController = TextEditingController();
//   TextEditingController _mobileController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
// Color maleContainerColor = Colors.white;
//   Color femaleContainerColor = Colors.white;
//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _mobileController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 14,
//                   backgroundColor: Colors.blue.shade200,
//                   child: Center(
//                     child: Icon(
//                       Icons.person_rounded,
//                       color: Colors.black,
//                       size: 25,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 3,
//                 ),
//                 Text(
//                   "${widget.title}",
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Card(
//             elevation: 2.0,
//             child: Container(
//               color: Color.fromARGB(255, 255, 212, 148).withOpacity(0.5),
//               height: 25,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Important:",
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                   Text(
//                     " Enter name as mentioned on your passport or Government approved IDs.",
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Card(
//             elevation: 5.0,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.label,
//                     style: TextStyle(fontWeight: FontWeight.w700),
//                   ),
//                   Divider(),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: TextFormField(
//                           controller: _firstNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'First Name',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: TextFormField(
//                           controller: _lastNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Last Name',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       Row(
//   children: [
//     GestureDetector(
//       onTap: () {
//         setState(() {
//           maleContainerColor = Colors.blue;
//           femaleContainerColor = Colors.white;
//         });
//       },
//       child: Container(
//         height: 50,
//         width: 125,
//         decoration: BoxDecoration(
//           border: Border.all(width: 1.0, color: Colors.grey),
//           borderRadius: BorderRadius.circular(5),
//           color: maleContainerColor, // Set the color dynamically
//         ),
//         child: Center(
//           child: Text(
//             "Male",
//             style: TextStyle(
//               color: maleContainerColor == Colors.blue
//                   ? Colors.white
//                   : Colors.black,
//             ),
//           ),
//         ),
//       ),
//     ),
//     GestureDetector(
//       onTap: () {
//         setState(() {
//           femaleContainerColor = Colors.blue;
//           maleContainerColor = Colors.white;
//         });
//       },
//       child: Container(
//         height: 50,
//         width: 125,
//         decoration: BoxDecoration(
//           border: Border.all(width: 1.0, color: Colors.grey),
//           borderRadius: BorderRadius.circular(5),
//           color: femaleContainerColor, // Set the color dynamically
//         ),
//         child: Center(
//           child: Text(
//             "Female",
//             style: TextStyle(
//               color: femaleContainerColor == Colors.blue
//                   ? Colors.white
//                   : Colors.black,
//             ),
//           ),
//         ),
//       ),
//     ),
//   ],
// ),

//                     ],
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Country Code', // Text added here
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14,
//                             ),
//                           ),
//                           SizedBox(
//                               height:
//                               10), // Added spacing between text and CountryCodePicker
//                           // Row(
//                           // children: [
//                           Container(
//                             width: 250,
//                             height: 50,
//                             decoration: BoxDecoration(
//                                 border:
//                                 Border.all(width: 0.8, color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(5)),
//                             // Here you can use the controller
//                             child: CountryCodePicker(
//                               flagWidth: 25,
//                               onChanged: (CountryCode countryCode) {
//                                 // Handle country code change
//                                 print(
//                                     'New country selected: ${countryCode.name}');
//                               },
//                               initialSelection: 'भारत', // Initial country code
//                               favorite: [
//                                 '+91',
//                                 'भारत'
//                               ], // Optional: favorite country codes
//                               showCountryOnly:
//                               true, // Display only the country name
//                               alignLeft:
//                               false, // Align the flag and the country code to the left
//                               textStyle: TextStyle(
//                                   fontSize:
//                                   15), // Style for the country code text
//                             ),
//                           ),
//                           // ],
//                           // ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Mobile Number', // Text added here
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           SizedBox(
//                             width: 250,
//                             height: 50,
//                             child: TextFormField(
//                               controller: _mobileController,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 labelText: 'Mobile Number (optional)',
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter some text';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Email', // Text added here
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           SizedBox(
//                             width: 250,
//                             height: 50,
//                             child: TextFormField(
//                               controller: _emailController,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 labelText: 'Email (optional)',
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter some text';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),

//                   SizedBox(
//                     height: 30,
//                   ),
//                   Divider(),
//                   // Text(
//                   //   "+ ADD NEW $label",
//                   //   style: TextStyle(
//                   //       fontSize: 12,
//                   //       fontWeight: FontWeight.w500,
//                   // color: Colors.blue),
//                   // )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
