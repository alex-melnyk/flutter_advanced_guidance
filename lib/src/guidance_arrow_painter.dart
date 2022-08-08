import 'package:flutter/widgets.dart';

import 'path_extension.dart';

/// Guidance arrow [CustomPainter].
class GuidanceArrowPainter extends CustomPainter {
  const GuidanceArrowPainter({
    required this.from,
    required this.to,
    this.progress = 1.0,
    this.curveRadius = 180,
    this.color = const Color(0xFFFFFFFF),
    this.isUpper = false,
  });

  /// Point to draw arrow from.
  final Offset from;

  /// Point to draw arrow from.
  final Offset to;

  /// Visible progress of the arrow [0.0 - 1.0].
  final double progress;

  /// Radius of arrow curve (Default is 180).
  final double curveRadius;

  /// Arrow color.
  final Color color;

  /// Arrow arc is upper.
  final bool isUpper;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(from.dx, from.dy)
      ..arcToPoint(
        to,
        radius: Radius.circular(curveRadius),
        clockwise: isUpper ? from.dx < to.dx : from.dx > to.dx,
      );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    path.addArrowhead();

    for (final metric in path.computeMetrics()) {
      canvas.drawPath(
        metric.extractPath(0, metric.length * progress),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant GuidanceArrowPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
