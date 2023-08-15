import 'package:flutter/material.dart';

class TextSlider extends StatefulWidget {
  const TextSlider(
      {super.key,
      required this.text,
      required this.onChanged,
      this.defaultValue = 0});

  final Function(double) onChanged;
  final String text;
  final double defaultValue;

  @override
  State<TextSlider> createState() => _TextSliderState();
}

class _TextSliderState extends State<TextSlider> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.text),
        Slider(
          value: value,
          onChanged: (v) {
            setState(() {
              value = v;
            });
            widget.onChanged(v);
          },
          min: 0,
          max: 1,
        ),
        Text(value.toString()),
      ],
    );
  }
}
