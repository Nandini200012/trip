import 'package:flutter/material.dart';

class Adultcount extends StatefulWidget {
  final Function(int) onNumberSelected;

  Adultcount(this.onNumberSelected);

  @override
  _AdultcountState createState() => _AdultcountState();
}

class _AdultcountState extends State<Adultcount> {
  int selectedNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 590,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                int number = index + 1;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedNumber = number;
                      widget.onNumberSelected(selectedNumber);
                    });
                  },
                  child: Card(
                    elevation: 4,
                    child: Container(
                      width: 40.0,
                      margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        color: selectedNumber == number
                            ? Colors.blue // Change to your desired color
                            : Colors.white,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: Text(
                          number > 9 ? '>9' : number.toString(),
                          style: TextStyle(
                            color: selectedNumber == number
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Card(
            elevation: 4,
            child: Container(
              width: 34.0,
              height: 38,
              margin: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Center(
                child: Text(
                  '>9',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
