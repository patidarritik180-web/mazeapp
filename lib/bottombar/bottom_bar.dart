import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:maze_app/screens/home/home_screen.dart';
import 'package:maze_app/screens/profilescreen/profile_screen.dart';
import 'package:maze_app/screens/stockscreen/stock_screen.dart';
import 'package:maze_app/screens/walletscreen/wallet_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      const HomeScreen(),
      const WalletScreen(),
      const StockScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B3F),

      body: IndexedStack(index: selectedIndex, children: pages),

      floatingActionButton: GestureDetector(
        onTap: () {
          // Open Scanner
        },
        child: Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,

            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              "assets/images/scanimg.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,

        activeIndex: selectedIndex,

        gapLocation: GapLocation.center,

        notchSmoothness: NotchSmoothness.softEdge,

        leftCornerRadius: 20,
        rightCornerRadius: 20,

        height: 70,

        backgroundColor: const Color(0xFF001B6E),

        tabBuilder: (int index, bool isActive) {
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
              fit: BoxFit.contain,
              color: isActive ? Colors.white : Colors.white70,
            ),
          );
        },

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
