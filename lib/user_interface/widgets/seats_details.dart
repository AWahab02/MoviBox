import 'package:flutter/material.dart';

import '../themes/colors.dart';

class SeatsOptionCardWidget extends StatelessWidget {
  const SeatsOptionCardWidget({
    Key? key,
    required this.time,
    required this.hall,
    required this.selected,
    required this.onSelect,
  }) : super(key: key);

  final String time, hall;
  final bool selected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              time,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              hall,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onSelect,
          child: Container(
            height: 150,
            width: 250,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: selected ? kLightBlue : Colors.white,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "assets/seatsBackground.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            Text(
              "From",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "50",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "or",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "100 bonus",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
