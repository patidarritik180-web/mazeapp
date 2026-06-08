import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final String name;
  final String symbol;
  final String price;
  final String percentage;
  final bool isUp;
  final String icon;
  final List<FlSpot> spots;

  const CryptoCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.price,
    required this.percentage,
    required this.isUp,
    required this.icon,
    required this.spots,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF19204A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(icon, width: 25),
                  Text(
                    symbol,
                    style: const TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                ],
              ),

              Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),

              Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  Text(
                    percentage,
                    style: TextStyle(
                      fontSize: 10,
                      color: isUp ? Colors.greenAccent : Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// MINI CHART
          SizedBox(
            height: 60,
            width: double.infinity,
            child: LineChart(
              LineChartData(
                minX: 0,

                maxX: 6,
                minY: 0,
                maxY: 6,
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),

                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: isUp ? const Color(0xFF00FFD1) : Colors.redAccent,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          (isUp ? const Color(0xFF00FFD1) : Colors.redAccent)
                              .withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
