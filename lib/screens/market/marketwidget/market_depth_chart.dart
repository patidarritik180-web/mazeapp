import 'package:flutter/material.dart';
import 'package:maze_app/screens/market/marketwidget/exchange_chart.dart';

class MarketDepthChart extends StatelessWidget {
  const MarketDepthChart({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        "amount": "65.02",
        "price": "0.000147",
        "time": "21:04:01",
        "isUp": true,
      },
      {
        "amount": "65.02",
        "price": "0.000147",
        "time": "21:04:01",
        "isUp": true,
      },
      {
        "amount": "65.02",
        "price": "0.000147",
        "time": "21:04:01",
        "isUp": false,
      },
    ];

    return Column(
      children: [
        Container(child: CryptoChartWidget()),

        SizedBox(height: 20),

        Container(
          height: 30,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF082A83),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              "Latest Trade",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'SFCompact',
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          // margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFF141E57)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header
              Container(
                height: 45,
                color: const Color(0xFF0A2A87),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Amount (BTC)",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          fontFamily: 'SFCompact',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Price (ETH)",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          fontFamily: 'SFCompact',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Time",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: 'SFCompact',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Data
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final item = orders[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item["amount"] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'SFCompact',
                            ),
                          ),
                        ),

                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                item["price"] as String,
                                style: TextStyle(
                                  color: item["isUp"] as bool
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 12,
                                  fontFamily: 'SFCompact',
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                item["isUp"] as bool
                                    ? Icons.north_east
                                    : Icons.south_east,
                                color: item["isUp"] as bool
                                    ? Colors.green
                                    : Colors.red,
                                size: 12,
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              item["time"] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'SFCompact',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
