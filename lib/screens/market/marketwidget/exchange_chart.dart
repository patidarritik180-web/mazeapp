import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ChartPoint {
  final double x; // percentage axis (15..57)
  final double y; // price axis
  const ChartPoint(this.x, this.y);
}

const List<ChartPoint> kData = [
  ChartPoint(15, 820),
  ChartPoint(18, 760),
  ChartPoint(21, 680),
  ChartPoint(24, 590),
  ChartPoint(27, 510),
  ChartPoint(30, 430),
  ChartPoint(33, 320),
  ChartPoint(34, 210), // trough / crossover
  ChartPoint(37, 260),
  ChartPoint(40, 330),
  ChartPoint(43, 420),
  ChartPoint(46, 530),
  ChartPoint(49, 640),
  ChartPoint(52, 760),
  ChartPoint(55, 900),
  ChartPoint(57, 980),
];

const int kCrossoverIdx = 7;
const Color kTeal = Color(0xFF00C9A7);
const Color kRed = Color(0xFFFF4D6D);
const Color kBg = Color(0xFF111827);
const Color kTooltipBg = Color(0xFF1E2A3A);
const Color kGrid = Color(0x10FFFFFF);

// ── Catmull-Rom spline ────────────────────────────────────────────────────────

double _cr(double p0, double p1, double p2, double p3, double t) {
  final t2 = t * t, t3 = t2 * t;
  return 0.5 *
      (2 * p1 +
          (-p0 + p2) * t +
          (2 * p0 - 5 * p1 + 4 * p2 - p3) * t2 +
          (-p0 + 3 * p1 - 3 * p2 + p3) * t3);
}

List<Offset> smoothPath(
  List<ChartPoint> pts,
  Rect area,
  double xMin,
  double xMax,
  double yMin,
  double yMax, {
  int steps = 20,
}) {
  double mx(double x) => area.left + (x - xMin) / (xMax - xMin) * area.width;
  double my(double y) =>
      area.top + (1 - (y - yMin) / (yMax - yMin)) * area.height;

  final result = <Offset>[];
  for (int i = 0; i < pts.length - 1; i++) {
    final p0 = pts[max(0, i - 1)];
    final p1 = pts[i];
    final p2 = pts[i + 1];
    final p3 = pts[min(pts.length - 1, i + 2)];
    for (int s = 0; s < steps; s++) {
      final t = s / steps;
      result.add(
        Offset(
          mx(_cr(p0.x, p1.x, p2.x, p3.x, t)),
          my(_cr(p0.y, p1.y, p2.y, p3.y, t)),
        ),
      );
    }
  }
  result.add(Offset(mx(pts.last.x), my(pts.last.y)));
  return result;
}

// ── Widget ────────────────────────────────────────────────────────────────────

class CryptoChartWidget extends StatefulWidget {
  const CryptoChartWidget({super.key});

  @override
  State<CryptoChartWidget> createState() => _CryptoChartWidgetState();
}

class _CryptoChartWidgetState extends State<CryptoChartWidget> {
  Offset? _hover;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 520,
      height: 313,
      decoration: BoxDecoration(
        color: const Color(0xFF0A1145),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 60,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onPanUpdate: (d) => setState(() => _hover = d.localPosition),
          onPanEnd: (_) => setState(() => _hover = null),
          child: MouseRegion(
            onHover: (e) => setState(() => _hover = e.localPosition),
            onExit: (_) => setState(() => _hover = null),
            child: CustomPaint(
              painter: _ChartPainter(hover: _hover),
              size: const Size(520, 340),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Painter ───────────────────────────────────────────────────────────────────

class _ChartPainter extends CustomPainter {
  final Offset? hover;
  _ChartPainter({this.hover});

  static const pad = EdgeInsets.fromLTRB(44, 30, 30, 48);
  static const xMin = 15.0, xMax = 57.0;
  static const yPad = 80.0;

  @override
  void paint(Canvas canvas, Size size) {
    final area = Rect.fromLTWH(
      pad.left,
      pad.top,
      size.width - pad.left - pad.right,
      size.height - pad.top - pad.bottom,
    );

    final yMin = kData.map((p) => p.y).reduce(min) - yPad;
    final yMax = kData.map((p) => p.y).reduce(max) + yPad;

    double mx(double x) => area.left + (x - xMin) / (xMax - xMin) * area.width;
    double my(double y) =>
        area.top + (1 - (y - yMin) / (yMax - yMin)) * area.height;

    final crossX = kData[kCrossoverIdx].x;
    final tealPts = kData.sublist(0, kCrossoverIdx + 1);
    final redPts = kData.sublist(kCrossoverIdx);

    final tealSmooth = smoothPath(tealPts, area, xMin, xMax, yMin, yMax);
    final redSmooth = smoothPath(redPts, area, xMin, xMax, yMin, yMax);
    final allSmooth = smoothPath(kData, area, xMin, xMax, yMin, yMax);

    _drawGrid(canvas, area, mx, my, yMin, yMax);
    _drawArea(canvas, tealSmooth, area, mx(crossX), my(yMin), kTeal);
    _drawArea(canvas, redSmooth, area, mx(xMax), my(yMin), kRed);
    _drawLine(canvas, tealSmooth, kTeal);
    _drawLine(canvas, redSmooth, kRed);
    _drawKeyDots(canvas, mx, my);
    _drawAxesLabels(canvas, area, mx, my, yMin, yMax);

    if (hover != null) {
      _drawHoverAndTooltip(canvas, area, mx, my, allSmooth, yMin, yMax);
    }
  }

  // ── Grid ──────────────────────────────────────────────────────────────────

  void _drawGrid(
    Canvas canvas,
    Rect area,
    double Function(double) mx,
    double Function(double) my,
    double yMin,
    double yMax,
  ) {
    final paint = Paint()
      ..color = kGrid
      ..strokeWidth = 1;

    // Vertical
    for (final x in [15.0, 25.0, 35.0, 45.0, 55.0]) {
      canvas.drawLine(
        Offset(mx(x), area.top),
        Offset(mx(x), area.bottom),
        paint,
      );
    }
    // Horizontal
    for (int i = 0; i < 6; i++) {
      final y = area.top + i / 5 * area.height;
      canvas.drawLine(Offset(area.left, y), Offset(area.right, y), paint);
    }
  }

  // ── Area fill ─────────────────────────────────────────────────────────────

  void _drawArea(
    Canvas canvas,
    List<Offset> pts,
    Rect area,
    double endX,
    double baseY,
    Color color,
  ) {
    if (pts.isEmpty) return;
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (final p in pts.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    path.lineTo(endX, baseY);
    path.lineTo(pts.first.dx, baseY);
    path.close();

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withOpacity(0.35), color.withOpacity(0.02)],
      ).createShader(area)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  // ── Line ──────────────────────────────────────────────────────────────────

  void _drawLine(Canvas canvas, List<Offset> pts, Color color) {
    if (pts.length < 2) return;
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (final p in pts.skip(1)) path.lineTo(p.dx, p.dy);

    // Glow
    canvas.drawPath(
      path,
      Paint()
        ..color = color.withOpacity(0.3)
        ..strokeWidth = 8
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    // Line
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  void _drawDashedLine(
    Canvas canvas,
    Offset from,
    Offset to,
    double dashLength,
    double gapLength,
    Paint paint,
  ) {
    final dx = to.dx - from.dx;
    final dy = to.dy - from.dy;
    final dist = sqrt(dx * dx + dy * dy);
    if (dist <= 0) return;

    final xStep = dx / dist;
    final yStep = dy / dist;
    double start = 0;
    bool drawDash = true;
    final path = Path();

    while (start < dist) {
      final segmentLength = drawDash ? dashLength : gapLength;
      final end = min(start + segmentLength, dist);
      if (drawDash) {
        final p0 = Offset(from.dx + xStep * start, from.dy + yStep * start);
        final p1 = Offset(from.dx + xStep * end, from.dy + yStep * end);
        path.moveTo(p0.dx, p0.dy);
        path.lineTo(p1.dx, p1.dy);
      }
      start = end;
      drawDash = !drawDash;
    }

    canvas.drawPath(path, paint);
  }

  // ── Key dots ──────────────────────────────────────────────────────────────

  void _drawKeyDots(
    Canvas canvas,
    double Function(double) mx,
    double Function(double) my,
  ) {
    void dot(ChartPoint p, Color c) {
      canvas.drawCircle(Offset(mx(p.x), my(p.y)), 5, Paint()..color = c);
    }

    dot(kData[0], kTeal);
    dot(kData[kCrossoverIdx], kTeal);
    dot(kData[kData.length - 2], kRed);
  }

  // ── Axes labels ───────────────────────────────────────────────────────────

  void _drawAxesLabels(
    Canvas canvas,
    Rect area,
    double Function(double) mx,
    double Function(double) my,
    double yMin,
    double yMax,
  ) {
    final style = TextStyle(
      color: Colors.white.withOpacity(0.25),
      fontSize: 11,
      fontFamily: 'Inter',
    );

    // X
    for (final x in [15, 25, 35, 45, 55]) {
      _drawText(
        canvas,
        '$x%',
        Offset(mx(x.toDouble()), area.bottom + 14),
        style,
        TextAlign.center,
      );
    }

    // Y
    for (int i = 0; i < 6; i++) {
      final val = yMax - i / 5 * (yMax - yMin);
      final label = '${(val / 100).round()}k';
      _drawText(
        canvas,
        label,
        Offset(area.left - 8, area.top + i / 5 * area.height),
        style,
        TextAlign.right,
      );
    }
  }

  // ── Hover & Tooltip ───────────────────────────────────────────────────────

  void _drawHoverAndTooltip(
    Canvas canvas,
    Rect area,
    double Function(double) mx,
    double Function(double) my,
    List<Offset> allSmooth,
    double yMin,
    double yMax,
  ) {
    final hx = hover!.dx;

    // Find nearest point
    Offset nearest = allSmooth.first;
    double bestDist = double.infinity;
    for (final p in allSmooth) {
      final d = (p.dx - hx).abs();
      if (d < bestDist) {
        bestDist = d;
        nearest = p;
      }
    }

    final dataX = xMin + (nearest.dx - area.left) / area.width * (xMax - xMin);
    final isTeal = dataX <= kData[kCrossoverIdx].x;
    final dotColor = isTeal ? kTeal : kRed;

    // Vertical crosshair
    _drawDashedLine(
      canvas,
      Offset(nearest.dx, area.top),
      Offset(nearest.dx, area.bottom),
      4,
      3,
      Paint()
        ..color = Colors.white.withOpacity(0.12)
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt,
    );

    // Dot
    canvas.drawCircle(
      nearest,
      7,
      Paint()
        ..color = dotColor.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawCircle(nearest, 5.5, Paint()..color = dotColor);
    canvas.drawCircle(
      nearest,
      5.5,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Tooltip box
    final dataY =
        yMin + (1 - (nearest.dy - area.top) / area.height) * (yMax - yMin);
    final price = '0.${(dataY * 0.557).round().toString().padLeft(6, '0')} BTC';
    final amount = (dataY / 400).toStringAsFixed(5);

    const tw = 180.0, th = 76.0;
    final tx = (nearest.dx - 20).clamp(area.left, area.right - tw);
    final ty = (nearest.dy - th - 16).clamp(area.top, area.bottom - th);

    // Connector
    _drawDashedLine(
      canvas,
      Offset(nearest.dx, ty + th),
      Offset(nearest.dx, nearest.dy - 6),
      3,
      2,
      Paint()
        ..color = dotColor.withOpacity(0.5)
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.butt,
    );

    // Box
    final rr = RRect.fromRectAndRadius(
      Rect.fromLTWH(tx, ty, tw, th),
      const Radius.circular(10),
    );
    canvas.drawRRect(
      rr,
      Paint()
        ..color = kTooltipBg
        ..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      rr,
      Paint()
        ..color = Colors.white.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    // Tooltip text
    final bold = const TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.w700,
    );
    final dim = TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 11);
    final bright = const TextStyle(color: Colors.white, fontSize: 11);

    _drawText(canvas, price, Offset(tx + 14, ty + 12), bold, TextAlign.left);
    _drawText(canvas, 'Amount:', Offset(tx + 14, ty + 34), dim, TextAlign.left);
    _drawText(
      canvas,
      '${amount}BTC',
      Offset(tx + 78, ty + 34),
      bright,
      TextAlign.left,
    );
    _drawText(canvas, 'Total:', Offset(tx + 14, ty + 52), dim, TextAlign.left);
    _drawText(
      canvas,
      '${amount}ETH',
      Offset(tx + 78, ty + 52),
      bright,
      TextAlign.left,
    );
  }

  // ── Helper ────────────────────────────────────────────────────────────────

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset,
    TextStyle style,
    TextAlign align,
  ) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textAlign: align,
      textDirection: TextDirection.ltr,
    )..layout();
    Offset pos = offset;
    if (align == TextAlign.center)
      pos = offset.translate(-tp.width / 2, -tp.height / 2);
    if (align == TextAlign.right)
      pos = offset.translate(-tp.width, -tp.height / 2);
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(_ChartPainter old) => old.hover != hover;
}
