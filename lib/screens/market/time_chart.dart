import 'dart:math';

import 'package:flutter/material.dart';

const kBg = Color(0xFF0D1226);
const kCardBg = Color(0xFF111829);
const kGreen = Color(0xFF22C55E);
const kRed = Color(0xFFEF4444);
const kMA1 = Color(0xFF818CF8); // indigo MA line
const kMA2 = Colors.white;
const kGrid = Color(0x14FFFFFF);
const kLabel = Color(0xFF64748B);
const kPriceBadge = Color(0xFF22C55E);
const kVolGreen = Color(0xFF12DD00);
const kVolRed = Color(0xFFDC2626);

// ── Data model ────────────────────────────────────────────────────────────────
class Candle {
  final double open, high, low, close, volume;
  bool get isBull => close >= open;
  const Candle(this.open, this.high, this.low, this.close, this.volume);
}

// Generate semi-realistic candles
List<Candle> _generateCandles(int count, double startPrice, Random rng) {
  final candles = <Candle>[];
  double price = startPrice;
  for (int i = 0; i < count; i++) {
    final change = (rng.nextDouble() - 0.46) * price * 0.03;
    final open = price;
    final close = (price + change).clamp(price * 0.92, price * 1.08);
    final high = max(open, close) + rng.nextDouble() * price * 0.015;
    final low = min(open, close) - rng.nextDouble() * price * 0.015;
    final vol = 50 + rng.nextDouble() * 200;
    candles.add(Candle(open, high, low, close, vol));
    price = close;
  }
  return candles;
}

// ── Moving average helper ─────────────────────────────────────────────────────
List<double?> _ma(List<Candle> candles, int period) {
  final result = <double?>[];
  for (int i = 0; i < candles.length; i++) {
    if (i < period - 1) {
      result.add(null);
      continue;
    }
    final sum = candles
        .sublist(i - period + 1, i + 1)
        .fold(0.0, (s, c) => s + c.close);
    result.add(sum / period);
  }
  return result;
}

// ── Main widget ───────────────────────────────────────────────────────────────
class TradingChartScreen extends StatefulWidget {
  const TradingChartScreen({super.key});
  @override
  State<TradingChartScreen> createState() => _TradingChartScreenState();
}

class _TradingChartScreenState extends State<TradingChartScreen> {
  final _rng = Random(42);
  final _periods = ['1D', '3D', '7D', '1M', '3M', '1Y', '5Y', 'Max'];
  int _selectedPeriod = 3; // 1M
  late List<Candle> _candles;
  int? _hoverIdx;

  @override
  void initState() {
    super.initState();
    _generateData();
  }

  void _generateData() {
    final counts = [24, 36, 48, 60, 72, 90, 100, 100];
    _candles = _generateCandles(counts[_selectedPeriod], 20.30, _rng);
  }

  @override
  Widget build(BuildContext context) {
    final currentPrice = _candles.last.close;
    final priceStr = '\$${currentPrice.toStringAsFixed(2)}';

    return Container(
      width: 380,
      decoration: BoxDecoration(
        color: const Color(0xFF0A1145),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 40),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Chart
          SizedBox(
            height: 380,
            child: GestureDetector(
              onPanUpdate: (d) {
                final box = context.findRenderObject() as RenderBox?;
                if (box != null) _updateHover(d.localPosition, box.size);
              },
              onPanEnd: (_) => setState(() => _hoverIdx = null),
              child: MouseRegion(
                onHover: (e) {
                  final box = context.findRenderObject() as RenderBox?;
                  if (box != null) _updateHover(e.localPosition, box.size);
                },
                onExit: (_) => setState(() => _hoverIdx = null),
                child: CustomPaint(
                  painter: _CandlestickPainter(
                    candles: _candles,
                    hoverIdx: _hoverIdx,
                    ma1: _ma(_candles, 7),
                    ma2: _ma(_candles, 20),
                  ),
                  size: const Size(double.infinity, 300),
                ),
              ),
            ),
          ),

          // Time period selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _periods.asMap().entries.map((e) {
                final selected = e.key == _selectedPeriod;
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedPeriod = e.key;
                    _generateData();
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? kGreen.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      e.value,
                      style: TextStyle(
                        color: selected ? kGreen : kLabel,
                        fontSize: 12,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const Divider(color: Color(0x18FFFFFF), height: 1),

          // Buy / Sell buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
            child: Row(
              children: [
                // Sell
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 49,
                      decoration: BoxDecoration(
                        border: Border.all(color: kRed, width: 1.5),
                        borderRadius: BorderRadius.circular(4),
                        color: kRed.withOpacity(0.08),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.remove, color: kRed, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Sell',
                            style: TextStyle(
                              color: kRed,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Buy
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 49,
                      decoration: BoxDecoration(
                        color: const Color(0xFF097100),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Buy',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.add, color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateHover(Offset local, Size widgetSize) {
    // Chart area starts after header (~76px) and is 300px tall
    // We'll re-compute based on painter's paddings
    const chartTop = 76.0;
    const padL = 8.0, padR = 62.0;
    final chartW = widgetSize.width - padL - padR;
    final candleW = chartW / _candles.length;
    final idx = ((local.dx - padL) / candleW).floor();
    setState(() {
      _hoverIdx = idx.clamp(0, _candles.length - 1);
    });
  }
}

// ── Painter ───────────────────────────────────────────────────────────────────
class _CandlestickPainter extends CustomPainter {
  final List<Candle> candles;
  final int? hoverIdx;
  final List<double?> ma1, ma2;

  const _CandlestickPainter({
    required this.candles,
    required this.ma1,
    required this.ma2,
    this.hoverIdx,
  });

  static const padL = 8.0;
  static const padR = 62.0;
  static const padT = 16.0;
  static const padB = 54.0; // room for volume
  static const volH = 36.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (candles.isEmpty) return;

    final chartW = size.width - padL - padR;
    final chartH = size.height - padT - padB;
    final candleW = chartW / candles.length;

    // Price range
    double pMin = candles.map((c) => c.low).reduce(min);
    double pMax = candles.map((c) => c.high).reduce(max);
    final pRange = pMax - pMin;
    pMin -= pRange * 0.05;
    pMax += pRange * 0.05;

    // Volume range
    double vMax = candles.map((c) => c.volume).reduce(max);

    double px(double price) =>
        padT + (1 - (price - pMin) / (pMax - pMin)) * chartH;
    double cx(int i) => padL + (i + 0.5) * candleW;
    double vY(double vol) => size.height - padB + volH - (vol / vMax) * volH;

    // ── Grid ────────────────────────────────────────────────────────────────
    final gridPaint = Paint()
      ..color = kGrid
      ..strokeWidth = 1;
    for (int i = 0; i <= 5; i++) {
      final y = padT + i / 5 * chartH;
      canvas.drawLine(Offset(padL, y), Offset(padL + chartW, y), gridPaint);
      final price = pMax - i / 5 * (pMax - pMin);
      _text(
        canvas,
        '\$${price.toStringAsFixed(2)}',
        Offset(padL + chartW + 6, y - 7),
        color: kLabel,
        fontSize: 10,
      );
    }
    // Vertical grid (sparse)
    final step = max(1, candles.length ~/ 6);
    for (int i = 0; i < candles.length; i += step) {
      final x = cx(i);
      canvas.drawLine(Offset(x, padT), Offset(x, padT + chartH), gridPaint);
    }

    // ── Volume bars ─────────────────────────────────────────────────────────
    for (int i = 0; i < candles.length; i++) {
      final c = candles[i];
      final bW = (candleW * 0.6).clamp(1.5, 6.0);
      final x = cx(i);
      final top = vY(c.volume);
      final bot = size.height - padB + volH;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x - bW / 2, top, bW, bot - top),
          const Radius.circular(2),
        ),
        Paint()
          ..color = (c.isBull ? kVolGreen.withOpacity(0.8) : kVolRed)
              .withOpacity(0.2),
      );
    }

    // ── Candles ─────────────────────────────────────────────────────────────
    for (int i = 0; i < candles.length; i++) {
      final c = candles[i];
      final color = c.isBull ? kGreen : kRed;
      final x = cx(i);
      final bodyW = (candleW * 0.55).clamp(2.0, 8.0);
      final top = px(max(c.open, c.close));
      final bot = px(min(c.open, c.close));
      final bodyH = max(bot - top, 1.5);
      final paint = Paint()..color = color;

      // Wick
      canvas.drawLine(
        Offset(x, px(c.high)),
        Offset(x, px(c.low)),
        Paint()
          ..color = color
          ..strokeWidth = 1.0,
      );

      // Body
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x - bodyW / 2, top, bodyW, bodyH),
          const Radius.circular(2),
        ),
        paint,
      );
    }

    // ── Moving averages ──────────────────────────────────────────────────────
    void drawMA(List<double?> values, Color color, {bool dashed = false}) {
      final pts = <Offset>[];
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) pts.add(Offset(cx(i), px(values[i]!)));
      }
      if (pts.length < 2) return;
      final path = Path()..moveTo(pts.first.dx, pts.first.dy);
      for (final p in pts.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      final paint = Paint()
        ..color = color
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      // Dashed path effects require additional APIs/packages. Fallback to
      // drawing a solid line when dashed is requested.
      canvas.drawPath(path, paint);
    }

    drawMA(ma1, kMA1);
    drawMA(ma2, kMA2, dashed: true);

    // ── Current price line ───────────────────────────────────────────────────
    final lastPrice = candles.last.close;
    final lineY = px(lastPrice);
    canvas.drawLine(
      Offset(padL, lineY),
      Offset(padL + chartW, lineY),
      Paint()
        ..color = const Color.fromARGB(255, 136, 166, 147).withOpacity(0.7)
        ..strokeWidth = 1,
    );
    // Price badge
    final badgeRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(padL + chartW + 4, lineY - 9, 56, 18),
      const Radius.circular(4),
    );
    canvas.drawRRect(badgeRect, Paint()..color = kPriceBadge);
    _text(
      canvas,
      '\$${lastPrice.toStringAsFixed(2)}',
      Offset(padL + chartW + 6, lineY - 7),
      color: Colors.white,
      fontSize: 10,
      bold: true,
    );

    // ── Hover crosshair ──────────────────────────────────────────────────────
    if (hoverIdx != null && hoverIdx! < candles.length) {
      final i = hoverIdx!;
      final c = candles[i];
      final x = cx(i);
      final midY = (px(c.high) + px(c.low)) / 2;

      final crossPaint = Paint()
        ..color = Colors.white.withOpacity(0.2)
        ..strokeWidth = 1;
      canvas.drawLine(Offset(x, padT), Offset(x, padT + chartH), crossPaint);
      canvas.drawLine(
        Offset(padL, midY),
        Offset(padL + chartW, midY),
        crossPaint,
      );

      // Tooltip
      const tw = 120.0, th = 68.0;
      final tx = (x + 8).clamp(padL, padL + chartW - tw);
      final ty = (midY - th / 2).clamp(padT, padT + chartH - th);
      final rr = RRect.fromRectAndRadius(
        Rect.fromLTWH(tx, ty, tw, th),
        const Radius.circular(8),
      );
      canvas.drawRRect(rr, Paint()..color = const Color(0xFF1E2A3A));
      canvas.drawRRect(
        rr,
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );

      _text(
        canvas,
        'O: \$${c.open.toStringAsFixed(2)}',
        Offset(tx + 8, ty + 8),
        color: Colors.white70,
        fontSize: 10,
      );
      _text(
        canvas,
        'H: \$${c.high.toStringAsFixed(2)}',
        Offset(tx + 8, ty + 22),
        color: kGreen,
        fontSize: 10,
      );
      _text(
        canvas,
        'L: \$${c.low.toStringAsFixed(2)}',
        Offset(tx + 8, ty + 36),
        color: kRed,
        fontSize: 10,
      );
      _text(
        canvas,
        'C: \$${c.close.toStringAsFixed(2)}',
        Offset(tx + 8, ty + 50),
        color: c.isBull ? kGreen : kRed,
        fontSize: 10,
        bold: true,
      );
    }
  }

  void _text(
    Canvas canvas,
    String text,
    Offset offset, {
    Color color = Colors.white,
    double fontSize = 11,
    bool bold = false,
  }) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_CandlestickPainter old) =>
      old.hoverIdx != hoverIdx || old.candles != candles;
}
