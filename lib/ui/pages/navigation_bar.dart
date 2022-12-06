import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

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
    final l10n = L10n.of(context)!;

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
          items: [
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.clear),
              icon: const Icon(Icons.clear_outlined),
              label: l10n.disliked,
              tooltip: '',
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.home),
              icon: const Icon(Icons.home_outlined),
              label: l10n.home,
              tooltip: '',
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(Icons.favorite),
              icon: const Icon(Icons.favorite_outline),
              label: l10n.liked,
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
