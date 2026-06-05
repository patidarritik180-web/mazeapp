import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:marquee_widget/marquee_widget.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        style: TextStyle(fontSize: 12, fontFamily: 'SFCompact'),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    height: 141,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFF19204A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Container(
                    height: 141,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFF19204A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
