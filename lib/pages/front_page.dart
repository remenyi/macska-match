import 'package:flutter/material.dart';
import 'package:macska_match/pages/home_page.dart';
import 'package:macska_match/pages/liked_page.dart';
import 'package:macska_match/widgets/navigation_bar.dart';

class FrontPage extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  FrontPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        flexibleSpace: Container(),
        centerTitle: true,
        title: const Icon(
          Icons.accessibility_new_sharp,
          color: Colors.pink,
          size: 50,
        ),
      ),
      body: Navigator(key: _navigatorKey, onGenerateRoute: (settings){
        switch (settings.name) {
          case 'disliked':
            //return MaterialPageRoute(builder: (context) => HomePage());
            return _createRoute(HomePage());
          case 'home':
            return _createRoute(HomePage());
          case 'liked':
            return _createRoute(LikedPage());
          default:
            return MaterialPageRoute(builder: (context) => HomePage());
        }
      }),/**/
      backgroundColor: Colors.transparent,
      bottomNavigationBar: MacskaMatchNavigationBar(navigatorKey: _navigatorKey),
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
