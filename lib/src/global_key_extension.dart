import 'package:flutter/widgets.dart';

extension GlobalKeyExtension on GlobalKey {
  /// Search the bounds of the keyed widget.
  ///
  /// Returns a [Rect] instance describes widgets' bounds,
  /// otherwise returns the [Rect.zero].
  Rect get globalPaintBounds {
    try {
      final renderObject = currentContext?.findRenderObject();
      final translation = renderObject?.getTransformTo(null).getTranslation();

      return renderObject!.paintBounds.shift(
        Offset(
          translation!.x,
          translation.y,
        ),
      );
    } catch (e) {
      return Rect.zero;
    }
  }

  /// Returns true in case the [currentContext] is not null.
  bool get isAttached => currentContext != null && currentWidget != null;
}
