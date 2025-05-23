import 'package:flutter/widgets.dart';

enum Breakpoint {
  small(0, 600),
  medium(600, 840),
  large(840, double.infinity);

  final double minWidth;

  /// The maximum value (exclusive)
  final double maxWidth;

  const Breakpoint(this.minWidth, this.maxWidth);

  bool containsWidth(double width) => width >= minWidth && width < maxWidth;
}

class BreakpointBuilder extends StatelessWidget {
  final Widget small;
  final Widget? medium;
  final Widget? large;

  const BreakpointBuilder({
    super.key,
    required this.small,
    this.medium,
    this.large,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (large != null && size.width >= Breakpoint.medium.maxWidth) {
      return large!;
    }
    if (medium != null && size.width >= Breakpoint.small.maxWidth) {
      return medium!;
    }
    return small;
  }
}

class SizedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Breakpoint? fullSizeFor;

  const SizedContainer({
    super.key,
    required this.child,
    this.padding,
    this.fullSizeFor = Breakpoint.medium,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final breakpoint = Breakpoint.values.firstWhere(
      (b) => b.containsWidth(screenWidth),
    );
    final isFullSize =
        fullSizeFor != null && screenWidth < fullSizeFor!.maxWidth;
    final width = isFullSize ? double.infinity : breakpoint.minWidth;
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: width),
        padding: padding,
        child: child,
      ),
    );
  }
}
