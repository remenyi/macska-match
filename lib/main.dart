import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macska_match/di/di.dart';

import 'pages/front_page.dart';

void main() {
  initDependencies();
  runApp(const MacskaMatch());
}

class MacskaMatch extends StatelessWidget {
  const MacskaMatch({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return FutureBuilder(
      future: injector.allReady(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.3, 0.5],
                colors: [Color.fromRGBO(255, 220, 239, 1), Colors.white],
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
        return Container(
          color: Colors.pinkAccent,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
