import 'package:flutter/widgets.dart';

/// Represents a single item of a guide.
class Highlight {
  const Highlight._({
    required this.widgetKey,
    this.radius = Radius.zero,
    this.padding = EdgeInsets.zero,
    this.circle = false,
  });

  const Highlight.rect(
    GlobalKey widgetKey, {
    Radius radius = Radius.zero,
    EdgeInsets padding = EdgeInsets.zero,
  }) : this._(
          widgetKey: widgetKey,
          radius: radius,
          padding: padding,
        );

  const Highlight.circular(
    GlobalKey widgetKey, {
    EdgeInsets padding = EdgeInsets.zero,
  }) : this._(
          widgetKey: widgetKey,
          padding: padding,
          circle: true,
        );

  /// The source widget key.
  final GlobalKey widgetKey;

  /// Corners radius.
  final Radius radius;

  /// The source corners padding.
  final EdgeInsets padding;

  /// Is circle.
  final bool circle;
}
