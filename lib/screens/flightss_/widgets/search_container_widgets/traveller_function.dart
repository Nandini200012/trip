import 'package:flutter/material.dart';
import 'package:trip/constants/fonts.dart';
import 'package:trip/screens/flightss_/widgets/search_container_widgets/search_container_global_variables.dart';

import '../../../holiday_Packages/widgets/constants_holiday.dart';
import '../search_container.dart';

Travellerfunction(sheight, swidth, context, String adult, String child,
    String infant, String _class) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(""),
        content: Container(
          width: 505,
          height: 580,
          color: Colors.white, // Example color
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Travellertext(
                "ADULTS (12y +)",
                "on the day of travel",
              ),
              AdultGrid(
                  sheight: sheight, swidth: swidth, s: "adult", adult: adult),
              // adultGrid(sheight, swidth, "adult", adult),
              // countcontainer(sheight, swidth, "adult", adult),
              kheight20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Travellertext(
                    "CHILDREN (2y - 12y )",
                    "on the day of travel",
                  ),
                  ChildrenGrid(
                      sheight: sheight,
                      swidth: swidth,
                      s: "child",
                      child: child),
                  // countcontainersix(sheight, swidth, "child", child),
                ],
              ),
              kheight20,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Travellertext(
                    "INFANTS (below 2y)",
                    "on the day of travel",
                  ),
                  infantGrid(
                      sheight: sheight,
                      swidth: swidth,
                      s: "child",
                      Infant: infant),
                  // countcontainersix(sheight, swidth, "infant", infant),
                ],
              ),
              kheight20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Travellertext(
                    "CHOOSE TRAVEL CLASS",
                    "on the day of travel",
                  ),
                  classGrid(
                      sheight: sheight,
                      swidth: swidth,
                      s: "child",
                      cls: _class),
                  // classcontainer(sheight, swidth),
                ],
              ),
              kheight5,
              Divider(),
              kheight5,
              done(context),
              kheight5
            ],
          ),
        ),
        // actions: [

        // ],
      );
    },
  );
}

class AdultGrid extends StatefulWidget {
  final double sheight;
  final double swidth;
  final String s;
  final String adult;

  AdultGrid({this.sheight, this.swidth, this.s, this.adult});

  @override
  _AdultGridState createState() => _AdultGridState();
}

class _AdultGridState extends State<AdultGrid> {
  int selectedindex = -1; // Initialize to a value that cannot be a valid index
  @override
  void initState() {
    super.initState();
    selectedindex = int.parse(widget.adult) - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      color: Colors.white,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 10, // Set this to the number of items you want in the grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10, // Number of columns
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 4.0, bottom: 4, left: 4, right: 1),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedindex = index;
                });
                globaladult = (index + 1).toString();
                print("tra:$index, adult: $globaladult ");
              },
              child: Container(
                decoration: BoxDecoration(
                  color:
                      index == selectedindex ? Colors.blueAccent : Colors.white,
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text('${index + 1}', // Display the combined string
                      style: R15500 // Assuming R15500 is a TextStyle
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChildrenGrid extends StatefulWidget {
  final double sheight;
  final double swidth;
  final String s;
  final String child;

  ChildrenGrid({this.sheight, this.swidth, this.s, this.child});

  @override
  _ChildrenGridState createState() => _ChildrenGridState();
}

class _ChildrenGridState extends State<ChildrenGrid> {
  int selectedindex = -1; // Initialize to a value that cannot be a valid index
  String child;
  @override
  void initState() {
    super.initState();
    child = widget.child ?? "0";
    selectedindex = int.parse(child) - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      color: Colors.white,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 6, // Set this to the number of items you want in the grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10, // Number of columns
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 2.0, bottom: 2, left: 4, right: 1),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedindex = index;
                });
                globalchild = (index + 1).toString();
                print("tra:$index,child: $globalchild");
              },
              child: Container(
                decoration: BoxDecoration(
                  color:
                      index == selectedindex ? Colors.blueAccent : Colors.white,
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text('${index + 1}', // Display the combined string
                      style: R15500 // Assuming R15500 is a TextStyle
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class infantGrid extends StatefulWidget {
  final double sheight;
  final double swidth;
  final String s;
  final String Infant;

  infantGrid({this.sheight, this.swidth, this.s, this.Infant});

  @override
  _infantGridState createState() => _infantGridState();
}

class _infantGridState extends State<infantGrid> {
  int selectedindex = -1; // Initialize to a value that cannot be a valid index
  String infant;
  @override
  void initState() {
    super.initState();
    infant = widget.Infant ?? "0";
    selectedindex = int.parse(infant) - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      color: Colors.white,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 6, // Set this to the number of items you want in the grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10, // Number of columns
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 4.0, bottom: 4, left: 4, right: 1),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedindex = index;
                });
                globalinfant = (index + 1).toString();
                print("tra:$index, infant:$globalinfant");
              },
              child: Container(
                decoration: BoxDecoration(
                  color:
                      index == selectedindex ? Colors.blueAccent : Colors.white,
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text('${index + 1}', // Display the combined string
                      style: R15500 // Assuming R15500 is a TextStyle
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class classGrid extends StatefulWidget {
  final double sheight;
  final double swidth;
  final String s;
  final String cls;

  classGrid({this.sheight, this.swidth, this.s, this.cls});

  @override
  _classGridState createState() => _classGridState();
}

class _classGridState extends State<classGrid> {
  int selectedindex = -1; // Initialize to a value that cannot be a valid index
  String selectedvalue =
      "ECONOMY"; // Initialize to a value that cannot be a valid index
  List<String> values = [
    'Economy',
    'Premium Economy',
    'Bussiness',
    'First Class'
  ];
  String infant;
  @override
  void initState() {
    super.initState();
    // infant = widget.Infant ?? "0";
    selectedvalue = widget.cls;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 50,
      color: Colors.white,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: values.length ??
            0, // Set this to the number of items you want in the grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: values.length, // Number of columns
            childAspectRatio: 7 / 3),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 4.0, bottom: 4, left: 4, right: 1),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedindex = index;
                  selectedvalue = values[index];
                });
                globalclass = values[index].toUpperCase();
                print("tra:$index,class: $globalclass");
              },
              child: Container(
                // height: 40,
                // width: 80,
                decoration: BoxDecoration(
                  color:
                      values[index].toUpperCase() == selectedvalue.toUpperCase()
                          ? Colors.blueAccent
                          : Colors.white,
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text('${values[index]}', // Display the combined string
                      style: R15500 // Assuming R15500 is a TextStyle
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

done(context) {
  return Container(
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 0, bottom: 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(10), // Adjust the radius as needed
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.lightBlueAccent
                ], // Define your gradient colors
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent, // Make the button transparent
                elevation: 0, // Remove the button's elevation
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Same as the container's radius
                ),
              ),
              onPressed: () {
                globalcount = int.parse(globaladult) +
                    int.parse(globalchild ?? 0) +
                    int.parse(globalinfant ?? 0);
                print("tra: count: $globalcount");
                Navigator.of(context).pop();
              },
              child: Text("Done"),
            ),
          ),
        ),
      ],
    ),
  );
}

classcontainer(sheight, swidth) {
  List<String> classes = [
    "Economy",
    "Premium Economy",
    "Bussiness",
    "First Class"
  ];
  return Container(
    color: Colors.white,
    // width: 500,
    // height: 55,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Containerclass("Economy"),
        Containerclass("Premium Economy"),
        Containerclass("Bussiness"),
        Containerclass("First Class"),
      ],
    ),
  );
}

countcontainersix(sheight, swidth, String type, String value) {
  return Container(
    color: Colors.white,
    // width: 500,
    height: 55,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Containercount(" 1 ", value),
        Containercount(" 2 ", value),
        Containercount(" 3 ", value),
        Containercount(" 4 ", value),
        Containercount(" 5 ", value),
        Containercount(" 6 ", value),
        kwidth5,
        Containercount(" <6 ", value),
      ],
    ),
  );
}

countcontainer(sheight, swidth, String type, String value) {
  return Container(
    color: Colors.white,
    // width: 500,
    height: 55,
    child: Row(
      children: [
        Containercount(" 1 ", value),
        Containercount(" 2 ", value),
        Containercount(" 3 ", value),
        Containercount(" 4 ", value),
        Containercount(" 5 ", value),
        Containercount(" 6 ", value),
        Containercount(" 7 ", value),
        Containercount(" 8 ", value),
        Containercount(" 9 ", value),
        kwidth5,
        Containercount(" <9 ", value),
      ],
    ),
  );
}

Containerclass(count) {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0),
    child: Container(
      height: 40,
      // width: 80,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(count, style: R15500),
        ),
      ),
    ),
  );
}

Containercount(count, String value) {
  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      color: value == count ? Colors.blue.shade100 : Colors.white,
      border: Border.all(width: 1.0, color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(count, style: R15500),
    ),
  );
}
