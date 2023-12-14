import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:movies_tickets_task/user%20interface/screens/tickets_page.dart';
import 'package:movies_tickets_task/user%20interface/themes/colors.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.name,
    required this.description,
    required this.bannerurl,
    required this.posterurl,
    required this.vote,
    required this.launch_on,
  }) : super(key: key);

  final String name, description, bannerurl, posterurl, vote, launch_on;

  @override
  Widget build(BuildContext context) {
    // Format the launch_on date
    final formattedLaunchOn =
        DateFormat('MMMM dd, yyyy').format(DateTime.parse(launch_on));

    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: double.infinity,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        posterurl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 10,
                            blurRadius: 8,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(
                        top: 16,
                        bottom: 24, // Increase bottom padding as needed
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "In Theatres $formattedLaunchOn", // Use the formatted date
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    (context),
                                    MaterialPageRoute(
                                        builder: (context) => TicketsScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kGetTickets,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Increase squareness of border
                                ),
                                minimumSize: Size(
                                    220, 50), // Increase height of the button
                              ),
                              child: const Text(
                                "Get Tickets",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                                height: 24), // Increase height as needed
                            ElevatedButton.icon(
                              onPressed: () {
                                // Handle Watch Trailer button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side: BorderSide(color: kGetTickets),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Increase squareness of border
                                ),
                                minimumSize: Size(
                                    220, 50), // Increase height of the button
                              ),
                              icon: const Icon(
                                Icons.play_arrow,
                              ),
                              label: const Text(
                                "Watch Trailer",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
                  child: Text(
                    "Genres",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 48.0, vertical: 24.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
                  child: Text(
                    "Overview",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
