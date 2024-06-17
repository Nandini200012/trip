import 'package:flutter/material.dart';

class PriceSlider extends StatefulWidget {
  final double minPrice;
  final double maxPrice;
  final double initialValue;
  final ValueChanged<double> onChanged;

  const PriceSlider({
    Key key,
    @required this.minPrice,
    @required this.maxPrice,
    @required this.initialValue,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _PriceSliderState createState() => _PriceSliderState();
}
class _PriceSliderState extends State<PriceSlider> {
  double _currentValue;
  bool _showLabel = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showLabel)
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 39, 38, 38).withOpacity(0.5), // Grey container color
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              "${_currentValue.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 12, color: Colors.white), // Adjust font size and color as needed
            ),
          ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackShape: RectangularSliderTrackShape(),
            trackHeight: 4,
            // thumbColor: Color.fromARGB(255, 10, 77, 221),
            overlayColor: Colors.transparent,
            valueIndicatorColor: Colors.transparent,
          ),
          child: Slider(
            value: _currentValue,
            min: widget.minPrice,
            max: widget.maxPrice,
            onChanged: (value) {
              setState(() {
                _currentValue = value;
                _showLabel = true; // Show label when slider is changed
                widget.onChanged(value);
              });
            },
            onChangeEnd: (value) {
              setState(() {
                _showLabel = false; // Hide label when slider is not being changed
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${widget.minPrice.toStringAsFixed(2)}'),
            Text('${widget.maxPrice.toStringAsFixed(2)}'),
          ],
        ),
      ],
    );
  }
}
