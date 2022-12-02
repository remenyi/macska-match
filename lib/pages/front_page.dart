import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:macska_match/pages/disliked_page/disliked_page.dart';
import 'package:macska_match/pages/home_page/home_page.dart';
import 'package:macska_match/pages/liked_page/liked_page.dart';
import 'package:macska_match/widgets/navigation_bar.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  final pageController = PageController(initialPage: 1, keepPage: true);
  int currentTabIndex = 1;

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
      body: PageView(
        // TODO: set to BouncingScrollPhysics after fixing the tinder-like swipe feature
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        children: const [
          DislikedPage(),
          HomePage(),
          LikedPage(),
        ],
      ),
      backgroundColor: Colors.transparent,
      bottomNavigationBar: MacskaMatchNavigationBar(
        controller: pageController,
        currentTabIndex: currentTabIndex,
      ),
    );
  }
}
