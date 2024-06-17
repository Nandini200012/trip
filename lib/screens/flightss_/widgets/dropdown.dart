import 'package:flutter/material.dart';
import 'package:trip/constants/fonts.dart';

class TripTypeSelector extends StatefulWidget {
  final double containerWidth;

  TripTypeSelector({Key key, this.containerWidth}) : super(key: key);

  @override
  _TripTypeSelectorState createState() => _TripTypeSelectorState();
}

class _TripTypeSelectorState extends State<TripTypeSelector> {
  String selectedTripType = 'One Way';

  void onTripTypeChanged(String newValue) {
    setState(() {
      selectedTripType = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> tripTypes = ['One Way', 'Return', 'Multi Way'];

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.all(16),
              child: DropdownButton<String>(
                value: selectedTripType,
                onChanged: onTripTypeChanged,
                items: tripTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
      },
      child: Container(
        width: widget.containerWidth,
        height: 60,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 27, 50, 141),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TRIP TYPE',
              style: rajdhaniblue
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedTripType,
                  style: rajdhaniwhite
                ),
                Icon(Icons.arrow_drop_down,size: 15,color: Colors.white,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
