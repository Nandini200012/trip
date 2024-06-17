import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final double sWidth;
  final double sHeight;
  final int count;
  final Set<String> filteredAirlines;

  FilterWidget({
     this.sWidth,
      this.sHeight,
      this.count,
      this.filteredAirlines,
  });

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  Set<String> selectedAirlines = Set();

  @override
  Widget build(BuildContext context) {
    List<String> airlineList = widget.filteredAirlines.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Container(
          width: widget.sWidth * 0.2,
          height: widget.sHeight * 0.2,
          color: Colors.red,
          child: ListView.builder(
            itemCount: airlineList.length,
            itemBuilder: (context, index) {
              String airline = airlineList[index];
              bool isSelected = selectedAirlines.contains(airline);

              return InkWell(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedAirlines.remove(airline);
                    } else {
                      selectedAirlines.add(airline);
                    }
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: (bool newValue) {
                        setState(() {
                          if (newValue != null && newValue) {
                            selectedAirlines.add(airline);
                          } else {
                            selectedAirlines.remove(airline);
                          }
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    Text(
                      airline,
                      style: TextStyle(
                        color: isSelected ? Colors.blue : Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    if (isSelected) Icon(Icons.done, color: Colors.green),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

