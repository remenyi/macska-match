import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cats_view_page/cats_view_page.dart';
import 'home_page/home_page.dart';
import 'navigation_bar.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  late final PageController pageController;
  int currentTabIndex = 1;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1, keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

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
          CatsViewPage(
            catsViewType: CatsViewType.disliked,
          ),
          HomePage(),
          CatsViewPage(
            catsViewType: CatsViewType.liked,
          ),
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
