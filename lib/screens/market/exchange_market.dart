import 'package:flutter/material.dart';

import 'package:maze_app/screens/appbar/custom_app_bar.dart';
import 'package:maze_app/screens/market/marketwidget/market_depth_chart.dart';
import 'package:maze_app/screens/market/marketwidget/timeline_chart.dart';

class ExchangeMarket extends StatefulWidget {
  const ExchangeMarket({super.key});

  @override
  State<ExchangeMarket> createState() => _ExchangeMarketState();
}

class _ExchangeMarketState extends State<ExchangeMarket> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B3F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                const SizedBox(height: 20),

                const CustomAppBar(title: "Exchange Market"),

                const SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      /// HEADER
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF11256D),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _statColumn(
                                        "High",
                                        "53,952.01",
                                        Colors.greenAccent,
                                      ),
                                      _statColumn(
                                        "Low",
                                        "39,902.42",
                                        Colors.redAccent,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  const Divider(color: Colors.white, height: 1),

                                  const SizedBox(height: 10),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _statColumn(
                                        "Vol(BTC)",
                                        "53,952.01",
                                        Colors.white70,
                                      ),
                                      _statColumn(
                                        "Vol(ETH)",
                                        "39,902.42",
                                        Colors.white70,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "\$66,360.55",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              const Text(
                                "(+1.25%)",
                                style: TextStyle(
                                  color: Colors.cyanAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 20),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1B255D),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "USD/BTC",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// TABS
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF111C56),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTab = 0;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedTab == 0
                                        ? const Color(0xFF234CCF)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons
                                              .access_time_outlined, // watch icon
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        Text(
                                          "Timeline",
                                          style: TextStyle(
                                            fontFamily: 'SFCompact',
                                            color: selectedTab == 0
                                                ? Colors.white
                                                : Colors.white54,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTab = 1;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedTab == 1
                                        ? const Color(0xFF234CCF)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.copy, // watch icon
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        Text(
                                          "Market Depth",
                                          style: TextStyle(
                                            fontFamily: 'SFCompact',
                                            color: selectedTab == 1
                                                ? Colors.white
                                                : Colors.white54,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      selectedTab == 0
                          ? const TimelineChart()
                          : const MarketDepthChart(),
                    ],
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

Widget _statColumn(String label, String value, Color color) {
  return Column(
    children: [
      Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          fontFamily: 'SFCompact',
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontFamily: 'SFCompact',
        ),
      ),
    ],
  );
}
