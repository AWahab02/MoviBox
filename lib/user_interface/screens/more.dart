import 'package:flutter/material.dart';
import '../bottom_navbar/navbar.dart';
import '../themes/colors.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> _showFeedbackReceivedDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: const Text('Feedback Received'),
            content: const Text('Thank you for your feedback!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: kAppBarBackgroundColor,
          title: const Text(
            'More',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
              child: Text(
                "About Us",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dignissim, tellus vitae blandit fringilla, ex metus faucibus leo, non viverra purus est ac tortor. Ut id velit vitae arcu elementum interdum. Nam sapien nulla, elementum vitae tincidunt ut, sollicitudin ut neque. Nulla vulputate tempor scelerisque.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Image(
                image: AssetImage('assets/CowlarLogo.png'),
                height: 180,
                width: 200,
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.0),
                child: Text(
                  "Presented by Cowlar Design Studios",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
              child: Text(
                "App Feedback",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: TextFormField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: const InputDecoration(
                  fillColor: kNavBarColor,
                  hintText: "Provide your feedback here...",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kGetTickets),
                onPressed: () {
                  _feedbackController.clear();
                  _showFeedbackReceivedDialog(context);
                },
                child: const Text("Submit Feedback"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(
        curr_index: 3,
      ),
    );
  }
}
