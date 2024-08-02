import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value; // Current value of the slider
  final ValueChanged<double> onChanged; // Callback when value changes

  CustomSlider({
    required this.value,
    required this.onChanged,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(CustomSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        _currentValue = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Colors.blue,
      value: _currentValue,
      min: 0,
      max: 1, // Adjust the max value as needed
      onChanged: (newValue) {
        setState(() {
          _currentValue = newValue;
        });
        widget.onChanged(newValue); // Notify parent about the change
      },
    );
  }
}