import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:macska_match/pages/disliked_page.dart';
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
        title: SvgPicture.asset('assets/logo.svg'),
      ),
      body: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case 'disliked':
                //return MaterialPageRoute(builder: (context) => HomePage());
                return _createDislikedPageRoute();
              case 'home':
                return _createHomePageRoute();
              case 'liked':
                return _createLikedPageRoute();
              default:
                return MaterialPageRoute(builder: (context) => HomePage());
            }
          }),
      /**/
      backgroundColor: Colors.transparent,
      bottomNavigationBar: MacskaMatchNavigationBar(navigatorKey: _navigatorKey),
    );
  }

  Route _createDislikedPageRoute() {
    return _createRoute(DislikedPage(), Offset(-1.0, 0.0));
  }

  Route _createLikedPageRoute() {
    return _createRoute(LikedPage(), Offset(1.0, 0.0));
  }

  Route _createHomePageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  Route _createRoute(Widget page, Offset offset) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = offset;
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
