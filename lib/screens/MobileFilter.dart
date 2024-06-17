import 'package:flutter/material.dart';

import 'constant.dart';
import 'filter_screen.dart';

class MobileFilter extends StatefulWidget {
  const MobileFilter({Key key}) : super(key: key);

  @override
  _MobileFilterState createState() => _MobileFilterState();
}

class _MobileFilterState extends State<MobileFilter> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: filter(value: value),

      ),
    );
  }
}
class filter extends StatelessWidget {
  const filter({
    Key key,
    @required this.value,
  }) : super(key: key);

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300.0,
        //color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Filters',
                style: blackB20,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Price:',
                style: grey15,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    '\u{20B9}${0}',
                    style: blackB15,
                  ),
                  Text(' - '),
                  Text(
                    '\u{20B9}${2000}',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    '\u{20B9}${2000}',
                    style: blackB15,
                  ),
                  Text(' - '),
                  Text(
                    '\u{20B9}${3500}',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    '\u{20B9}${0}',
                    style: blackB15,
                  ),
                  Text(' - '),
                  Text(
                    '\u{20B9}${2000}',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    '\u{20B9}${3500}',
                    style: blackB15,
                  ),
                  Text(' - '),
                  Text(
                    '\u{20B9}${30000}',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    '\u{20B9}${30000}',
                    style: blackB15,
                  ),
                  Text(' + '),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Star Category:',
                style: grey15,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    '7 Star',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    '5 Star',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    '3 Star',
                    style: blackB15,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'User Rating:',
                style: grey15,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    '4.5 & above',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    '4 & above',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    '3 & above',
                    style: blackB15,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Property Type:',
                style: grey15,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Hotel',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Villa',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Cottage',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Service Apartment',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'House',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Resort',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Guest House',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Apart-Hotel',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Hostel',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Holiday Home',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Farm House',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Beach Hut',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Lodge',
                    style: blackB15,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Amenities:',
                style: grey15,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Swimming Pool',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Spa',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Caretacker',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Parking',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Banquet Hall',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Conference Room',
                    style: blackB15,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: value,
                    onChanged: (value) {
                      // setState(() {
                      //   this.value = value;
                      // });
                    },
                  ),
                  // SizedBox(width:20.0),
                  Text(
                    'Lift',
                    style: blackB15,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}