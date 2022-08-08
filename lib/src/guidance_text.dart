import 'package:flutter/widgets.dart';

class GuidanceText extends StatelessWidget {
  const GuidanceText({
    Key? key,
    required this.text,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 8,
    ),
    this.isSkipAlignedTop = false,
    this.onSkipPressed,
  }) : super(key: key);

  final String text;
  final EdgeInsets padding;
  final bool isSkipAlignedTop;
  final VoidCallback? onSkipPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSkipAlignedTop)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onSkipPressed,
                child: const Text('Skip'),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
          if (!isSkipAlignedTop)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onSkipPressed,
                child: const Text('Skip'),
              ),
            ),
        ],
      ),
    );
  }
}
