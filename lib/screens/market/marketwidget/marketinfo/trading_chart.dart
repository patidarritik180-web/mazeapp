import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ChartData model
// ─────────────────────────────────────────────────────────────────────────────
class ChartData {
  ChartData(this.time, this.open, this.high, this.low, this.close, this.volume);

  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  bool get isBull => close >= open;
}

// ─────────────────────────────────────────────────────────────────────────────
// Candle generator — realistic BTC-style price walk
// ─────────────────────────────────────────────────────────────────────────────
List<ChartData> generateCandles({int count = 60, double startPrice = 20.30}) {
  final rng = Random(42);
  double price = startPrice;
  final now = DateTime.now();
  final list = <ChartData>[];

  for (int i = 0; i < count; i++) {
    final open = price + (rng.nextDouble() - 0.49) * 0.25;
    final close = open + (rng.nextDouble() - 0.48) * 0.45;
    final high = max(open, close) + rng.nextDouble() * 0.18;
    final low = min(open, close) - rng.nextDouble() * 0.18;
    final vol = rng.nextDouble() * 80 + 15;
    price = close;

    list.add(
      ChartData(
        now.subtract(Duration(hours: count - i)),
        open,
        high,
        low,
        close,
        vol,
      ),
    );
  }
  return list;
}

// ─────────────────────────────────────────────────────────────────────────────
// Chart Widget — drop this anywhere in your widget tree
// ─────────────────────────────────────────────────────────────────────────────
class TradingChart extends StatefulWidget {
  const TradingChart({super.key});

  @override
  State<TradingChart> createState() => _TradingChartState();
}

class _TradingChartState extends State<TradingChart> {
  // ── Period config ──────────────────────────────────────────────────────────
  final List<String> _periods = ['7D', '1M', '3M', '1Y', '5Y', 'Max'];
  final Map<String, int> _counts = {
    '7D': 36,
    '1M': 60,
    '3M': 90,
    '1Y': 120,
    '5Y': 150,
    'Max': 180,
  };
  String _selected = '1M';

  // ── Candle data ────────────────────────────────────────────────────────────
  late List<ChartData> _candles;

  // ── Syncfusion behaviours ──────────────────────────────────────────────────
  late ZoomPanBehavior _zoomPan;
  late TrackballBehavior _trackball;

  @override
  void initState() {
    super.initState();
    _loadCandles();

    _zoomPan = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.x,
    );

    _trackball = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      lineType: TrackballLineType.vertical,
      lineColor: Colors.white30,
      lineWidth: 1,
      tooltipSettings: const InteractiveTooltip(
        enable: true,
        color: Color(0xFF1B2E6E),
        textStyle: TextStyle(color: Colors.white, fontSize: 9.5),
        format: 'O: point.open  H: point.high\nL: point.low   C: point.close',
      ),
    );
  }

  void _loadCandles() {
    _candles = generateCandles(count: _counts[_selected]!);
  }

  // ── Compute moving average ─────────────────────────────────────────────────
  double _ma(int index, int period) {
    final sl = _candles.sublist(max(0, index - period + 1), index + 1);
    return sl.map((c) => c.close).reduce((a, b) => a + b) / sl.length;
  }

  // ── Max volume for secondary axis ceiling ──────────────────────────────────
  double get _maxVol =>
      _candles.isEmpty ? 500 : _candles.map((c) => c.volume).reduce(max);

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A1145),
        borderRadius: BorderRadius.circular(12),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate widths based on available space
          final chartWidth = constraints.maxWidth * 0.72; // 72% for chart
          final orderBookWidth =
              constraints.maxWidth * 0.28; // 28% for order book

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Chart (left) ──────────────────────────────────────────────────────
                SizedBox(
                  width: chartWidth,
                  child: Column(
                    children: [
                      // ── Candlestick chart ──────────────────────────────────────────────
                      SizedBox(
                        height: 400,
                        child: SfCartesianChart(
                          backgroundColor: Colors.transparent,
                          plotAreaBorderWidth: 0,
                          plotAreaBackgroundColor: Colors.transparent,
                          margin: const EdgeInsets.fromLTRB(0, 10, 4, 0),

                          zoomPanBehavior: _zoomPan,
                          trackballBehavior: _trackball,

                          // ── X-axis ────────────────────────────────────────────────────
                          primaryXAxis: DateTimeAxis(
                            isVisible: true,
                            dateFormat: null,
                            majorGridLines: const MajorGridLines(width: 0),
                            minorGridLines: const MinorGridLines(width: 0),
                            axisLine: const AxisLine(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                            labelStyle: const TextStyle(
                              color: Color(0xFF4A6FA0),
                              fontSize: 8,
                            ),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            intervalType: DateTimeIntervalType.hours,
                            interval: (_counts[_selected]! / 5).ceilToDouble(),
                          ),

                          // ── Y-axis (price) — right side ───────────────────────────────
                          primaryYAxis: NumericAxis(
                            isVisible: true,
                            opposedPosition: true,
                            axisLine: const AxisLine(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                            majorGridLines: const MajorGridLines(
                              width: 0.5,
                              color: Color(0x18FFFFFF),
                              dashArray: [4, 4],
                            ),
                            labelStyle: const TextStyle(
                              color: Color(0xFF4A6FA0),
                              fontSize: 8,
                            ),
                            labelFormat: '\${value}',
                            decimalPlaces: 2,
                          ),

                          series: <CartesianSeries>[
                            // 1) ── Candlesticks ──────────────────────────────────────────
                            CandleSeries<ChartData, DateTime>(
                              dataSource: _candles,
                              xValueMapper: (d, _) => d.time,
                              openValueMapper: (d, _) => d.open,
                              highValueMapper: (d, _) => d.high,
                              lowValueMapper: (d, _) => d.low,
                              closeValueMapper: (d, _) => d.close,
                              bullColor: const Color(0xFF22C55E),
                              bearColor: const Color(0xFFEF4444),
                              enableSolidCandles: true,
                              width: 0.6,
                              animationDuration: 600,
                            ),

                            // 2) ── MA-7 white dashed line ───────────────────────────────
                            LineSeries<ChartData, DateTime>(
                              dataSource: _candles,
                              xValueMapper: (d, _) => d.time,
                              yValueMapper: (d, i) => _ma(i, 7),
                              color: Colors.white,
                              width: 1.2,
                              dashArray: const [5, 3],
                              markerSettings: const MarkerSettings(
                                isVisible: false,
                              ),
                              enableTooltip: false,
                              animationDuration: 600,
                            ),

                            // 3) ── Volume bars on hidden secondary axis ──────────────────
                            ColumnSeries<ChartData, DateTime>(
                              dataSource: _candles,
                              xValueMapper: (d, _) => d.time,
                              yValueMapper: (d, _) => d.volume,
                              yAxisName: 'volAxis',
                              pointColorMapper: (d, _) => d.isBull
                                  ? const Color(0xFF22C55E).withOpacity(0.30)
                                  : const Color(0xFFEF4444).withOpacity(0.30),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(2),
                              ),
                              enableTooltip: false,
                              animationDuration: 600,
                            ),
                          ],

                          // Secondary Y-axis for volume
                          axes: [
                            NumericAxis(
                              name: 'volAxis',
                              isVisible: false,
                              minimum: 0,
                              maximum: _maxVol * 5,
                            ),
                          ],
                        ),
                      ),

                      // ── Period selector ────────────────────────────────────────────────
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 6,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _periods.map((p) {
                            final sel = p == _selected;
                            return GestureDetector(
                              onTap: () => setState(() {
                                _selected = p;
                                _loadCandles();
                              }),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: sel
                                      ? const Color(
                                          0xFF1546E8,
                                        ).withOpacity(0.25)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  p,
                                  style: TextStyle(
                                    color: sel
                                        ? Colors.white
                                        : const Color(0xFF4A6FA0),
                                    fontSize: 11,
                                    fontWeight: sel
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // ── H1 + icon chip buttons ─────────────────────────────────────────
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _chip(label: 'H1'),
                            const SizedBox(width: 8),
                            _chip(icon: Icons.compare_arrows_rounded),
                            const SizedBox(width: 8),
                            _chip(icon: Icons.water_drop_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ─── Order book (right) ─────────────────────────────────────────────
                SizedBox(
                  width: orderBookWidth,
                  child: Container(
                    height: 400,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A1145),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(
                            child: Text(
                              "Order book",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Green Orders
                          ...List.generate(
                            12,
                            (index) =>
                                _bookRow("253.11", "0.001", isGreen: true),
                          ),
                          const SizedBox(height: 8),

                          // Red Orders
                          ...List.generate(
                            12,
                            (index) =>
                                _bookRow("253.11", "0.001", isGreen: false),
                          ),
                          const SizedBox(height: 24),

                          const Center(
                            child: Text(
                              "Trades",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          ...List.generate(
                            20,
                            (index) => _bookRow(
                              "253.11",
                              "0.001",
                              isGreen: index.isEven,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _chip({String? label, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF1546E8),
        borderRadius: BorderRadius.circular(7),
      ),
      child: label != null
          ? Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            )
          : Icon(icon, color: Colors.white, size: 15),
    );
  }
}

Widget _bookRow(String price, String amount, {required bool isGreen}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          price,
          style: TextStyle(
            color: isGreen ? const Color(0xFF12DD00) : const Color(0xFFFF3B30),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(amount, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    ),
  );
}
