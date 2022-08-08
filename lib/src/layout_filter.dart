import 'package:flutter/widgets.dart';

class LayoutFilter extends StatelessWidget {
  const LayoutFilter({
    Key? key,
    required this.child,
    this.backdropColor = const Color(0xDD000000),
  }) : super(key: key);

  final Widget child;
  final Color backdropColor;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        backdropColor,
        BlendMode.srcOut,
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.dstOut,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
