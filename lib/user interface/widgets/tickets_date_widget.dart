import 'package:flutter/material.dart';

class ticketsPage_date_widget extends StatelessWidget {
  const ticketsPage_date_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionChip(
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            label: const Text("5 Mar"),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          ActionChip(
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            label: const Text("6 Mar"),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          ActionChip(
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            label: const Text("7 Mar"),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          ActionChip(
            labelPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            label: const Text("8 Mar"),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
