import 'package:flutter/material.dart';

class FlightDropdown extends StatefulWidget {
  final String title;

  FlightDropdown({  this.title});

  @override
  _FlightDropdownState createState() => _FlightDropdownState();
}

class _FlightDropdownState extends State<FlightDropdown> {
  String _selectedValue = '';

  final Map<String, List<String>> dropdownItems = {
    'adult': ['Mr', 'Ms', 'Mrs'],
    'child': ['Master', 'Ms'],
    'infant': ['Master', 'Ms']
  };

  @override
  void initState() {
    super.initState();
    _initializeSelectedValue();
  }

  void _initializeSelectedValue() {
    setState(() {
      _selectedValue = dropdownItems[widget.title.toLowerCase()]?.first ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = dropdownItems[widget.title.toLowerCase()] ?? [];
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Title',
      ),
      value: _selectedValue.isNotEmpty ? _selectedValue : null,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String newValue) {
        if (newValue != null) {
          setState(() {
            _selectedValue = newValue;
            print('Selected Value: $_selectedValue');
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a value';
        }
        return null;
      },
    );
  }
}
