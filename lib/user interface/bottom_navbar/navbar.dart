import 'package:flutter/material.dart';
import '../themes/colors.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  void _onIconTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        currentIndex: _selectedIndex,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        onTap: _onIconTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
            backgroundColor: kNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Watch',
            backgroundColor: kNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_media_sharp),
            label: 'Media Library',
            backgroundColor: kNavBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_sharp),
            label: 'More',
            backgroundColor: kNavBarColor,
          ),
        ],
      ),
    );
  }
}
