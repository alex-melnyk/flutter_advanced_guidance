import 'package:flutter/material.dart';

import 'global_key_extension.dart';
import 'guidance_arrow.dart';
import 'guidance_text.dart';

class GuidancePage extends StatefulWidget {
  const GuidancePage({
    Key? key,
    required this.text,
    required this.childOffset,
    this.curveRadius = 270,
    this.alignment = Alignment.center,
    this.onSkipPressed,
  }) : super(key: key);

  final String text;
  final Offset childOffset;
  final double curveRadius;
  final Alignment alignment;
  final VoidCallback? onSkipPressed;

  @override
  State<GuidancePage> createState() => _GuidancePageState();
}

class _GuidancePageState extends State<GuidancePage> {
  final textKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isTopSide = widget.childOffset.dy < mediaQuery.size.height / 2.25;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (isTopSide && textKey.isAttached)
          GuidanceArrow(
            isUpper: true,
            from: textKey.globalPaintBounds.topCenter,
            to: widget.childOffset,
            curveRadius: widget.curveRadius,
          ),
        Align(
          alignment: widget.alignment,
          child: GuidanceText(
            key: textKey,
            isSkipAlignedTop: !isTopSide,
            text: widget.text,
            onSkipPressed: widget.onSkipPressed,
          ),
        ),
        if (!isTopSide && textKey.isAttached)
          GuidanceArrow(
            isUpper: true,
            from: textKey.globalPaintBounds.bottomCenter,
            to: widget.childOffset,
            curveRadius: widget.curveRadius,
          ),
      ],
    );
  }
}
