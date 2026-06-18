import 'package:flutter/material.dart';
import 'package:maze_app/screens/market/marketwidget/marketinfo/trading_chart.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class MarketDetailsScreen extends StatefulWidget {
  const MarketDetailsScreen({super.key});

  @override
  State<MarketDetailsScreen> createState() => _MarketDetailsScreenState();
}

class _MarketDetailsScreenState extends State<MarketDetailsScreen> {
  late List<ChartData> chartData;
  late TooltipBehavior tooltipBehavior;
  late ZoomPanBehavior zoomPanBehavior;
  @override
  void initState() {
    super.initState();

    chartData = [
      ChartData('1D', 38, 10, 21, 29),
      ChartData('1W', 22, 12, 19, 10),
      ChartData('1M', 37, 7, 17, 24),
      ChartData('1Y', 34, 9, 16, 27),
      ChartData('max', 35, 13, 18, 31),
    ];

    tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.x\nHigh: point.high\nLow: point.low',
    );

    zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      zoomMode: ZoomMode.x,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020B3F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),

              ///topbar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/Menu.png', height: 22, width: 22),
                  Text(
                    "Trading Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SFCompact',
                    ),
                  ),

                  Image.asset(
                    'assets/images/Notification.png',
                    height: 22,
                    width: 22,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// price card
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _statColumn(
                                "High",
                                "53,952.01",
                                Colors.greenAccent,
                              ),
                              _statColumn("Low", "39,902.42", Colors.redAccent),
                            ],
                          ),

                          const SizedBox(height: 10),

                          const Divider(color: Colors.white, height: 1),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MarketDetailsScreen(),
                            ),
                          );
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              TradingChart(),
            ],
          ),
        ),
      ),
    );
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
}

class ChartData {
  ChartData(this.time, this.high, this.low, this.open, this.close);

  final String time;
  final double high;
  final double low;
  final double open;
  final double close;
}
