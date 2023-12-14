import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:movie_app_task/models/movie_model.dart';
// import 'package:movie_app_task/ui/themes/colors.dart';
// import 'package:movie_app_task/utils/widget_extensions.dart';
import '../themes/colors.dart';
import '../widgets/seats_details.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  // final MovieModel movie;

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        foregroundColor: Colors.black,
        backgroundColor: kAppBarBackgroundColor,
        elevation: 0,
        title: Column(
          children: [
            Text(
              // widget.movie.original_title,
              "Title",
              style: const TextStyle(),
            ),
            SizedBox(height: 10),
            Text(
              // "In Theaters ${widget.movie.release_date}",
              "In Theaters Date",
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            SizedBox(height: 10),
            const Text(
              "Date",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
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
                  SizedBox(width: 10),
                  ActionChip(
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    label: const Text("6 Mar"),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                  ActionChip(
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    label: const Text("7 Mar"),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                  ActionChip(
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    label: const Text("8 Mar"),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SeatsOptionCardWidget(),
                  SizedBox(width: 10),
                  const SeatsOptionCardWidget(),
                  SizedBox(width: 10),
                  const SeatsOptionCardWidget(),
                ],
              ),
            ),
            Expanded(child: Container()),
            Center(
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                width: double.infinity,
                child: CupertinoButton(
                  color: kLightBlue,
                  child: const Text("Select Seats"),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
