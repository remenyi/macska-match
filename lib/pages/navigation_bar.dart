import 'package:flutter/material.dart';

class MacskaMatchNavigationBar extends StatefulWidget {
  final int currentTabIndex;
  final PageController controller;

  const MacskaMatchNavigationBar({
    Key? key,
    required this.controller,
    required this.currentTabIndex,
  }) : super(key: key);

  @override
  State<MacskaMatchNavigationBar> createState() => _MacskaMatchNavigationBarState();
}

class _MacskaMatchNavigationBarState extends State<MacskaMatchNavigationBar> {
  late int currentTabIndex = widget.currentTabIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: widget.currentTabIndex,
          elevation: 10,
          backgroundColor: const Color.fromRGBO(255, 129, 166, 1),
          fixedColor: Colors.white,
          unselectedItemColor: Colors.grey.shade300,
          unselectedFontSize: 12,
          selectedFontSize: 14,
          unselectedIconTheme: const IconThemeData(
            size: 40,
          ),
          selectedIconTheme: const IconThemeData(
            size: 40,
          ),
          unselectedLabelStyle: const TextStyle(),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          items: const [
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.clear),
              icon: Icon(Icons.clear_outlined),
              label: 'Disliked',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.favorite),
              icon: Icon(Icons.favorite_outline),
              label: 'Liked',
              tooltip: '',
            ),
          ],
          onTap: (index) {
            widget.controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
            setState(() {
              currentTabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
