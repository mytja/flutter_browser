import 'package:flutter/material.dart';

class GuineaSlider extends StatefulWidget {
  const GuineaSlider({Key? key, this.value = 0}) : super(key: key);

  final int value;

  @override
  State<GuineaSlider> createState() => _GuineaSliderState();
}

class _GuineaSliderState extends State<GuineaSlider> {
  double _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.value.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Slider(
        value: _currentSliderValue,
        max: 100,
        divisions: 100,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }
}
