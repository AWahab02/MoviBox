import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../themes/colors.dart';
import '../../widgets/seats_details.dart';
import './seat_selector.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key, required this.title, required this.release});

  final String title, release;

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  int selectedDateIndex = 0;
  String selectedHall = '';
  List<bool> selection = [false, false, false];

  @override
  Widget build(BuildContext context) {
    // Generate a list of dates from today until the end of the month
    DateTime now = DateTime.now();
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    List<String> dateList = List.generate(daysInMonth, (index) {
      DateTime date = DateTime(now.year, now.month, index + 1);
      return DateFormat('MMM d').format(date);
    });

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        foregroundColor: Colors.black,
        backgroundColor: kAppBarBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.title.toString(),
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
            Text(
              "In Theaters ${widget.release}",
              style: const TextStyle(color: Colors.blue, fontSize: 12),
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
            const SizedBox(height: 10),
            const Text(
              "Date",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(height: 10),
            // Horizontally scrollable date picker
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dateList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedDateIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: index == selectedDateIndex
                              ? kGetTickets
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: kGetTickets,
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            dateList[index],
                            style: TextStyle(
                              color: index == selectedDateIndex
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SeatsOptionCardWidget(
                    hall: 'CinTech + Hall 1',
                    time: '12:30',
                    selected: selectedHall == 'CinTech + Hall 1',
                    onSelect: () {
                      setState(() {
                        selectedHall = 'CinTech + Hall 1';
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  SeatsOptionCardWidget(
                    hall: 'CinTech + Hall 2',
                    time: '13:30',
                    selected: selectedHall == 'CinTech + Hall 2',
                    onSelect: () {
                      setState(() {
                        selectedHall = 'CinTech + Hall 2';
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  SeatsOptionCardWidget(
                    hall: 'CinTech + Hall 3',
                    time: '14:30',
                    selected: selectedHall == 'CinTech + Hall 3',
                    onSelect: () {
                      setState(() {
                        selectedHall = 'CinTech + Hall 3';
                      });
                    },
                  ),
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
                  onPressed: () {
                    if (selectedHall.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeatSelector(
                            title: widget.title,
                            release: widget.release,
                            time: (selectedDateIndex + 1).toString(),
                            hall: selectedHall,
                          ),
                        ),
                      );
                    } else {
                      // Display an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please select a hall before proceeding.'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
