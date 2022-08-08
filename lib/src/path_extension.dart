import 'dart:math' as math;
import 'dart:ui';

extension PathExtension on Path {
  /// Add an arrow to the end of the last drawn curve in the given path.
  ///
  /// The returned path is moved to the end of the curve. Always add the arrow
  /// before moving the path, not after, else the move will be lost.
  /// After adding the arrow you can move the path, draw more and apply
  /// an arrow to the new drawn part.
  ///
  /// [tipLength] is the length (in pixels) of each of the 2 lines making
  /// the arrow.
  ///
  /// [tipAngle] is the angle (in radians) between each of the 2 lines making
  /// the arrow and the curve at this point.
  void addArrowhead({
    double tipLength = 15,
    double tipAngle = math.pi * 0.2,
  }) {
    var adjustmentAngle = 0.0;

    final angle = math.pi - tipAngle;
    var lastPathMetric = computeMetrics().last;

    var tan = lastPathMetric.getTangentForOffset(lastPathMetric.length);

    final originalPosition = tan!.position;

    var firstTipVector =
        _rotateVector(tan.vector, angle - adjustmentAngle) * tipLength;
    moveTo(tan.position.dx, tan.position.dy);
    relativeLineTo(firstTipVector.dx, firstTipVector.dy);

    final secondTipVector =
        _rotateVector(tan.vector, -angle - adjustmentAngle) * tipLength;
    moveTo(tan.position.dx, tan.position.dy);
    relativeLineTo(secondTipVector.dx, secondTipVector.dy);

    moveTo(originalPosition.dx, originalPosition.dy);
  }

  static Offset _rotateVector(Offset vector, double angle) => Offset(
        math.cos(angle) * vector.dx - math.sin(angle) * vector.dy,
        math.sin(angle) * vector.dx + math.cos(angle) * vector.dy,
      );
}
