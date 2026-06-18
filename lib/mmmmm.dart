import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Candlestick Chart Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CandleChartPage(),
    );
  }
}

class CandleChartPage extends StatefulWidget {
  const CandleChartPage({super.key});

  @override
  State<CandleChartPage> createState() => _CandleChartPageState();
}

class _CandleChartPageState extends State<CandleChartPage> {
  late List<ChartData> chartData;
  late TooltipBehavior tooltipBehavior;
  late ZoomPanBehavior zoomPanBehavior;

  @override
  void initState() {
    super.initState();

    chartData = [
      ChartData('CHN', 38, 10, 21, 29),
      ChartData('GER', 32, 12, 19, 30),
      ChartData('RUS', 37, 7, 17, 24),
      ChartData('BRZ', 34, 9, 16, 27),
      ChartData('IND', 35, 13, 18, 31),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Syncfusion Candlestick Chart')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SfCartesianChart(
          title: ChartTitle(text: 'Country Market Data'),
          legend: const Legend(isVisible: true),
          tooltipBehavior: tooltipBehavior,
          zoomPanBehavior: zoomPanBehavior,
          primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Country')),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 40,
            interval: 5,
            title: AxisTitle(text: 'Value'),
          ),
          series: <CartesianSeries<ChartData, String>>[
            CandleSeries<ChartData, String>(
              name: 'Gold',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.country,
              highValueMapper: (ChartData data, _) => data.high,
              lowValueMapper: (ChartData data, _) => data.low,
              openValueMapper: (ChartData data, _) => data.open,
              closeValueMapper: (ChartData data, _) => data.close,

              // Bull candle
              bullColor: Colors.green,

              // Bear candle
              bearColor: Colors.red,

              enableSolidCandles: true,
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.country, this.high, this.low, this.open, this.close);

  final String country;
  final double high;
  final double low;
  final double open;
  final double close;
}
