import 'package:flutter/material.dart';
// import 'package:movie_app_task/utils/widget_extensions.dart';

import '../themes/colors.dart';

class SeatsOptionCardWidget extends StatelessWidget {
  const SeatsOptionCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "12:30 ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 10),
            const Text(
              "CinTech + Hall 1",
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w200),
            ),
          ],
        ),
        // bold 12:30 grey cintech

        SizedBox(height: 10),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 150,
            width: 250,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kLightBlue),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              "assets/seatsBackground.png",
              fit: BoxFit.contain,
            ),
          ),
        ),

        SizedBox(height: 10),

        Row(
          children: [
            const Text(
              "From",
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w200),
            ),
            SizedBox(width: 5),
            const Text(
              "50",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
            ),
            SizedBox(width: 5),
            const Text(
              "or",
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w200),
            ),
            SizedBox(width: 5),
            const Text(
              "100 bonus",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ],
    );
  }
}
