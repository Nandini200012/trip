import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({ key}) : super(key: key);

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  bool isOneWay = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isOneWay,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildCityContainer('From')),
              Expanded(child: _buildCityContainer('To')),
              Expanded(child: _buildDepartureContainer()),
              Expanded(child: _buildTravellerContainer()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCityContainer(String label) {
    return GestureDetector(
      onTap: () {
        // Your logic here
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          // Other content
        ],
      ),
    );
  }

  Widget _buildDepartureContainer() {
    return GestureDetector(
      onTap: () {
        // Your logic here
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Departure',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          // Other content
        ],
      ),
    );
  }

  Widget _buildTravellerContainer() {
    return GestureDetector(
      onTap: () {
        // Your logic here
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Traveler & Class',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          // Other content
        ],
      ),
    );
  }
}
