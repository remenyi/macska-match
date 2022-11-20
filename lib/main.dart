import 'package:flutter/material.dart';
import 'package:macska_match/pages/liked_page.dart';

import 'pages/front_page.dart';
import 'widgets/navigation_bar.dart';

void main() {
  runApp(const MacskaMatch());
}

class MacskaMatch extends StatelessWidget {
  const MacskaMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.3, 0.5],
          colors: [Color.fromRGBO(255, 220, 240, 1), Colors.white],
        ),
      ),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink,
          fontFamily: 'Poppins',
        ),
        home: FrontPage(),
      ),
    );
  }
}
