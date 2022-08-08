import 'package:flutter/material.dart';

import 'defaults.dart';
import 'guidance_arrow_painter.dart';

final _fadeTween = Tween(
  begin: 0.0,
  end: 1.0,
);

class GuidanceArrow extends StatefulWidget {
  const GuidanceArrow({
    Key? key,
    required this.from,
    required this.to,
    this.padding,
    this.alignment,
    this.size,
    this.duration = animationDuration,
    this.color = Colors.white,
    this.isUpper = false,
    this.curveRadius = 180,
  }) : super(key: key);

  final Offset from;
  final Offset to;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final Size? size;
  final Duration duration;
  final Color color;
  final bool isUpper;
  final double curveRadius;

  @override
  GuidanceArrowState createState() => GuidanceArrowState();
}

class GuidanceArrowState extends State<GuidanceArrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _animation = _animationController.drive(_fadeTween);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      alignment: widget.alignment,
      width: double.maxFinite,
      height: double.maxFinite,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          return CustomPaint(
            painter: GuidanceArrowPainter(
              isUpper: widget.isUpper,
              from: widget.from,
              to: widget.to,
              progress: _animation.value,
              color: widget.color,
              curveRadius: widget.curveRadius,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}
