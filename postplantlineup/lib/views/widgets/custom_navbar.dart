import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../screens/adblock.dart';
import '../screens/agents.dart';
import '../screens/donate.dart';
import '../screens/home.dart';
import '../utils/colors.dart';

class CustomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final PageController pageController;

  const CustomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    const double bottomNavigationBarHeight = kBottomNavigationBarHeight;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    final iconSize = MediaQuery.of(context).size.width * 0.07; // 6% of the screen width

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(Icons.home, size: iconSize,color: Colors.white, ),
          Icon(Icons.accessibility_new_outlined, size: iconSize, color: Colors.white,),
          Icon(Icons.account_balance_wallet_outlined, size: iconSize,color: Colors.white,),
          Icon(Icons.adb, size: iconSize,color: Colors.white,),
          Icon(Icons.favorite, size: iconSize,color: Colors.white,),
        ],
        color: CustomColors.accentColor,
        buttonBackgroundColor: CustomColors.accentColor,
        backgroundColor: CustomColors.primaryColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          pageController.jumpToPage(index);
        },
        index: currentIndex,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            bottomNavigationBarHeight -
            bottomPadding,
        child: PageView(
          controller: pageController,
          onPageChanged: onTabTapped,
          children: const [
            HomePageContent(),
            AgentsPage(),
            DonationPage(),
            AdblockPage(),
          ],
        ),
      ),
    );
  }
}
