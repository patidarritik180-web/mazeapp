import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:maze_app/bottombar/scanner.dart';
import 'package:maze_app/screens/home/home_screen.dart';
import 'package:maze_app/screens/market/exchange_market.dart';
import 'package:maze_app/screens/profilescreen/profile_screen.dart';
import 'package:maze_app/screens/walletscreen/wallet_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(), // 0
    WalletScreen(), // 1
    Scanner(), // 2
    ExchangeMarket(), // 3
    ProfileScreen(), // 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B3F),

      body: IndexedStack(index: selectedIndex, children: pages),

      floatingActionButton: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = 2; // Scanner tab
          });
        },
        child: SizedBox(
          height: 72,
          width: 72,
          child: Image.asset("assets/images/scanimg.png"),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        activeIndex: selectedIndex == 2
            ? -1
            : (selectedIndex > 2 ? selectedIndex - 1 : selectedIndex),

        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,

        leftCornerRadius: 20,
        rightCornerRadius: 20,

        height: 70,

        backgroundColor: const Color(0xFF001B6E),

        tabBuilder: (index, isActive) {
          final icons = [
            "assets/images/icon1.png",
            "assets/images/Wallet.png",
            "assets/images/stock.png",
            "assets/images/Profile.png",
          ];

          return Center(
            child: Image.asset(
              icons[index],
              width: 24,
              height: 24,
              color: isActive ? Colors.white : Colors.white54,
            ),
          );
        },

        onTap: (index) {
          setState(() {
            switch (index) {
              case 0:
                selectedIndex = 0; // Home
                break;

              case 1:
                selectedIndex = 1; // Wallet
                break;

              case 2:
                selectedIndex = 3; // Market
                break;

              case 3:
                selectedIndex = 4; // Profile
                break;
            }
          });
        },
      ),
    );
  }
}
