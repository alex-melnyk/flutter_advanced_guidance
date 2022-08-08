import 'package:flutter/material.dart';

import 'defaults.dart';
import 'global_key_extension.dart';
import 'highlight.dart';
import 'layout_filter.dart';

/// A widget that guides user on a screen.
class GuidanceLayout extends StatefulWidget {
  const GuidanceLayout({
    Key? key,
    this.highlights = const [],
    this.pages = const [],
    this.textStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Color(0xFFFFFFFF),
    ),
    this.duration = animationDuration,
    this.backdropColor = const Color(0xDD000000),
    this.cycling = true,
    required this.child,
    required this.onFinished,
  })  : assert(
          highlights.length == pages.length,
          'Properties "highlights" and "pages" should have equal length.',
        ),
        super(key: key);

  /// Pages that guides user.
  final List<Highlight> highlights;

  /// Pages that guides user.
  final List<Widget> pages;

  /// Pages text style.
  final TextStyle textStyle;

  /// Transition animation duration.
  final Duration duration;

  /// Background layout color.
  final Color backdropColor;

  /// The child widget.
  final Widget child;

  /// Indicates that pages should be cycled.
  final bool cycling;

  /// On steps finished callback.
  final VoidCallback? onFinished;

  @override
  GuidanceLayoutState createState() => GuidanceLayoutState();
}

class GuidanceLayoutState extends State<GuidanceLayout> {
  final _currentPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    if (widget.highlights.isEmpty || widget.pages.isEmpty) {
      return widget.child;
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        GestureDetector(
          onTap: _handlePressed,
          child: Stack(
            fit: StackFit.expand,
            children: [
              LayoutFilter(
                backdropColor: widget.backdropColor,
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentPage,
                  builder: (context, value, child) {
                    final guidedPage = widget.highlights[value];

                    if (!guidedPage.widgetKey.isAttached) {
                      return child!;
                    }

                    final rect = guidedPage.padding
                        .inflateRect(guidedPage.widgetKey.globalPaintBounds);
                    final radius = guidedPage.circle
                        ? Radius.circular((rect.width + rect.height) / 2)
                        : guidedPage.radius;

                    return AnimatedPositioned.fromRect(
                      duration: widget.duration,
                      rect: rect,
                      child: AnimatedContainer(
                        duration: widget.duration,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.all(radius),
                        ),
                      ),
                    );
                  },
                  child: const SizedBox(),
                ),
              ),
              Material(
                color: const Color(0x00000000),
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentPage,
                  builder: (_, value, child) {
                    return AnimatedSwitcher(
                      duration: widget.duration,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: SizedBox(
                        key: ValueKey<int>(value),
                        child: DefaultTextStyle.merge(
                          style: widget.textStyle,
                          child: widget.pages[value],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handlePressed() {
    if (_currentPage.value + 1 < widget.highlights.length) {
      _currentPage.value += 1;
      return;
    }

    if (widget.cycling) {
      _currentPage.value = 0;
    } else if (widget.onFinished != null) {
      widget.onFinished!();
    }
  }

  @override
  void dispose() {
    _currentPage.dispose();

    super.dispose();
  }
}
