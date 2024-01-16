import 'package:flutter/material.dart';
import 'package:movies_tickets_task/user_interface/screens/media_library.dart';
import 'package:movies_tickets_task/user_interface/screens/more.dart';
import 'package:movies_tickets_task/user_interface/screens/watch_screen.dart';
import 'package:movies_tickets_task/user_interface/screens/welcome_page.dart';
import '../themes/colors.dart';

class CustomNavBar extends StatefulWidget {
  final int curr_index;

  const CustomNavBar({Key? key, required this.curr_index}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  void _onIconTapped(int index) {
    setState(() {
      // Update _selectedIndex with the clicked index
      _selectedIndex = index;

      switch (_selectedIndex) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WatchScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MediaLibraryPage()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MorePage()),
          );
          break;
        // Add more cases for other indices if needed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
      decoration: const BoxDecoration(
        color: kNavBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: widget.curr_index,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: _onIconTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.space_dashboard_rounded),
            label: 'Dashboard',
            backgroundColor: kNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled_rounded),
            label: 'Watch',
            backgroundColor: kNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Discover',
            backgroundColor: kNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
            backgroundColor: kNavBarColor,
          ),
        ],
      ),
    );
  }
}
