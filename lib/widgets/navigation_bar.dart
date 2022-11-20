import 'package:flutter/material.dart';

class MacskaMatchNavigationBar extends StatefulWidget {
  int _currentTabIndex = 1;
  final GlobalKey<NavigatorState> navigatorKey;

  MacskaMatchNavigationBar({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  State<MacskaMatchNavigationBar> createState() => _MacskaMatchNavigationBarState();
}

class _MacskaMatchNavigationBarState extends State<MacskaMatchNavigationBar> {
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
          currentIndex: widget._currentTabIndex,
          backgroundColor: Color.fromRGBO(255, 129, 166, 1),
          fixedColor: Colors.white,
          unselectedItemColor: Colors.grey.shade300,
          unselectedFontSize: 12,
          selectedFontSize: 14,
          unselectedIconTheme: IconThemeData(
            size: 40,
          ),
          selectedIconTheme: IconThemeData(
            size: 40,
          ),
          unselectedLabelStyle: TextStyle(
          ),
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.clear),
              label: 'Disliked',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Liked',
              tooltip: '',
            ),
          ],
          onTap: (index) {
            if (widget._currentTabIndex == index) return;

            switch (index) {
              case 0:
                widget.navigatorKey.currentState!.popAndPushNamed("disliked");
                break;
              case 1:
                widget.navigatorKey.currentState!.popAndPushNamed("home");
                break;
              case 2:
                widget.navigatorKey.currentState!.popAndPushNamed("liked");
                break;
              default:
                widget.navigatorKey.currentState!.popAndPushNamed("home");
                break;
            }
            setState(() {
              widget._currentTabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
