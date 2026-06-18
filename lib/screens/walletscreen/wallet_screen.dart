import 'package:flutter/material.dart';
import 'package:maze_app/screens/appbar/custom_app_bar.dart';
import 'package:maze_app/screens/walletscreen/balance_card.dart';
import 'package:maze_app/screens/walletscreen/shopping_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late PageController pageController;
  // Temporary placeholder controller to avoid undefined identifier error.
  // Replace with actual GetX controller when available.
  final _DummyController controller = _DummyController();

  @override
  void initState() {
    super.initState();

    pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B3F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20),

                const CustomAppBar(title: "My Card"),

                const SizedBox(height: 50),
                SizedBox(
                  height: 260,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Back Card 2
                      Positioned(
                        top: 50,
                        right: -18,
                        child: Transform.rotate(
                          angle: 0.12,
                          child: SizedBox(
                            height: 196,
                            width: 320,
                            child: Image.asset("assets/images/reflex2.png"),
                          ),
                        ),
                      ),

                      // Back Card 1
                      Positioned(
                        top: 40,
                        right: -13,
                        child: Transform.rotate(
                          angle: 0.08,
                          child: SizedBox(
                            height: 196,
                            width: 320,
                            child: Image.asset("assets/images/reflex1.png"),
                          ),
                        ),
                      ),

                      // Main Card
                      Container(
                        height: 196,
                        width: double.infinity,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1546E8),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Card Holder",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'SFCompact',
                              ),
                            ),

                            const SizedBox(height: 2),

                            const Text(
                              "Edwin Izantim",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SFCompact',
                              ),
                            ),

                            const Spacer(),

                            Row(
                              children: [
                                SizedBox(
                                  width: 36,
                                  height: 28,
                                  child: Image.asset(
                                    "assets/images/chip.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                const SizedBox(width: 30),

                                const Text(
                                  "5061   0000   0000   0000",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'SFCompact',
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 22,
                                        height: 22,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                            255,
                                            255,
                                            17,
                                            1,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(-8, 0),
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: const BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 4),

                                  const Text(
                                    "Mastercard",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF082A83),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Operations',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SFCompact',
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Column(
                  children: [
                    SizedBox(
                      height: 85,
                      child: PageView.builder(
                        controller: PageController(
                          viewportFraction:
                              0.55, // shows ~1.8 cards → peek on both sides
                        ),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: BalanceCard(
                              title: "Balance",
                              icon: "assets/images/balance.png",
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 18),

                    SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        expansionFactor: 3,
                        spacing: 6,
                        radius: 10,
                        dotWidth: 8,
                        dotHeight: 8,
                        activeDotColor: Color(0xFF1546E8),
                        dotColor: Color(0xFF8FA8F8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF082A83),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Transactions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SFCompact',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today", style: TextStyle(color: Colors.white)),
                    Container(
                      width: 70,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.search, color: Colors.white24),
                          Text(
                            "search",
                            style: TextStyle(color: Colors.white24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const ShoppingCard(
                      title: "Shopping",
                      date: "Today, 10:30 AM",
                      amount: "- \$25,000",
                      isShoppig: true,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Simple placeholder controller with empty transactions list.
class _DummyController {
  final List transactions = [];
}
