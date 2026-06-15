import 'package:flutter/material.dart';
import 'package:maze_app/screens/market/time_chart.dart';

class TimelineChart extends StatelessWidget {
  const TimelineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Center(child: Container(child: TradingChartScreen())),
        ),
      ],
    );
  }
}
