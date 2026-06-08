import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:maze_app/screens/home/transaction_card.dart';
import 'package:maze_app/screens/home/widgets/crypto_card.dart';

import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B3F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Image(
                      image: AssetImage('assets/images/Menu.png'),
                      width: 26,
                      height: 26,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SFCompact',
                      ),
                    ),
                    Image(
                      image: AssetImage('assets/images/Notification.png'),
                      width: 26,
                      height: 26,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Container(
                  height: 25,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6A759B),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Marquee(
                      direction: Axis.horizontal,
                      directionMarguee: DirectionMarguee.oneDirection,
                      animationDuration: const Duration(seconds: 10),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SFCompact',
                          ),
                          children: [
                            TextSpan(
                              text: " • ",
                              style: TextStyle(color: Color(0xFFB1C7FF)),
                            ),
                            TextSpan(
                              text: "Market Cap \$780,091 ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: " • ",
                              style: TextStyle(color: Color(0xFFB1C7FF)),
                            ),
                            TextSpan(
                              text: "BTC Dominance 32.11% ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: " • ",
                              style: TextStyle(color: Color(0xFFB1C7FF)),
                            ),
                            TextSpan(
                              text: "Cryptocurrencies 30903 ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  height: 146,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1345C7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/Dez.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          'assets/images/QR.png',
                          width: 24,
                          height: 24,
                        ),
                      ),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total portfolio balance",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SFCompact',
                              ),
                            ),

                            const SizedBox(height: 4),

                            Obx(
                              () => Text(
                                "\$${controller.balance.value.toStringAsFixed(0)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SFCompact',
                                ),
                              ),
                            ),

                            const SizedBox(height: 4),

                            Obx(
                              () => Text(
                                "+ \$${controller.profit.value.toStringAsFixed(2)} for today",
                                style: TextStyle(
                                  color: Color(0xFF00FFD1),
                                  fontSize: 12,
                                  fontFamily: 'SFCompact',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                    child: Text(
                      "Market Statistics",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SFCompact',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: CryptoCard(
                        name: "ETH",
                        symbol: "Ethereum",
                        price: "355.01",
                        percentage: "+11.75%",
                        isUp: true,
                        icon: "assets/images/etc.png",
                        spots: const [
                          FlSpot(0, 2),
                          FlSpot(1, 3),
                          FlSpot(2, 2.5),
                          FlSpot(3, 4),
                          FlSpot(4, 3.5),
                          FlSpot(5, 5),
                          FlSpot(6, 4.5),
                        ],
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: CryptoCard(
                        name: "BTC",
                        symbol: "Bitcoin",
                        price: "355.01",
                        percentage: "-11.75%",
                        isUp: false,
                        icon: "assets/images/btc.png",
                        spots: const [
                          FlSpot(0, 5),
                          FlSpot(1, 2),
                          FlSpot(2, 4.5),
                          FlSpot(3, 3),
                          FlSpot(4, 3.5),
                          FlSpot(5, 2),
                          FlSpot(6, 1.5),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Container(
                  height: 140,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(26, 61, 153, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Refer Rewards',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SFCompact',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Earn \$8.50 worth of BTC on every successful referral.Invite your friends and earn big.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SFCompact',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 33,
                          //  width: 140,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFB300),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              "Refer a Friend",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SFCompact',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  height: 30,
                  width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(0, 24, 84, 1),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Recent Transactions",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SFCompact',
                        ),
                      ),
                      Text(
                        "See All",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'SFCompact',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = controller.transactions[index];

                      return TransactionCard(
                        title: transaction.title,
                        date: transaction.date,
                        amount: transaction.amount,
                        isReceived: transaction.isReceived,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
