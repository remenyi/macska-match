import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macska_match/di/di.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'ui/pages/front_page.dart';

void main() async {
  initDependencies();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.5],
                colors: [Color.fromRGBO(255, 220, 239, 1), Colors.white],
              ),
            ),
            child: MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.pink,
                fontFamily: 'Poppins',
              ),
              home: const FrontPage(),
              localizationsDelegates: L10n.localizationsDelegates,
              supportedLocales: L10n.supportedLocales,
            ),
          );
        }
        return Container(
          color: Colors.pinkAccent,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
