import 'package:flutter/material.dart';

class MacskaMatchNavigationBar extends StatelessWidget {
  const MacskaMatchNavigationBar({Key? key}) : super(key: key);

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
          backgroundColor: Color.fromRGBO(255, 129, 166, 1),
          fixedColor: Colors.white,
          unselectedItemColor: Colors.white,
          unselectedFontSize: 10,
          selectedFontSize: 10,
          unselectedIconTheme: IconThemeData(
            size: 40,
          ),
          selectedIconTheme: IconThemeData(
            size: 40,
          ),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold
          ),
          selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.clear),
              label: 'Disliked',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Liked',
            ),
          ],
        ),
      ),
    );
  }
}
