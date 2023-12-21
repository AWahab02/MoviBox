import 'package:flutter/material.dart';

class SeatLegend extends StatelessWidget {
  final Color color;
  final String text;

  const SeatLegend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
