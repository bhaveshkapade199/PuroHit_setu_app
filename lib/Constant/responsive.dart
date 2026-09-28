import 'package:flutter/material.dart';

/// Responsive helper providing breakpoints, orientation checks, and adaptive layout utilities.
class Responsive {
  /// Breakpoint constants
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1024.0;

  /// Max content width for forms on tablets / desktop to keep layouts balanced and clean
  static const double maxFormWidth = 480.0;
  static const double maxWideFormWidth = 680.0;
  static const double maxDialogWidth = 440.0;

  /// Screen size shortcuts
  static Size size(BuildContext context) => MediaQuery.sizeOf(context);
  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;
  static double height(BuildContext context) => MediaQuery.sizeOf(context).height;

  /// Device types
  static bool isMobile(BuildContext context) => width(context) < mobileBreakpoint;
  static bool isTablet(BuildContext context) =>
      width(context) >= mobileBreakpoint && width(context) < tabletBreakpoint;
  static bool isDesktop(BuildContext context) => width(context) >= tabletBreakpoint;

  /// Orientation
  static bool isLandscape(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.landscape;
  static bool isPortrait(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.portrait;

  /// Whether the screen is a small phone (e.g., iPhone SE, width <= 360)
  static bool isSmallPhone(BuildContext context) => width(context) <= 360;

  /// True when in landscape mode on a phone (low vertical height)
  static bool isPhoneLandscape(BuildContext context) =>
      isLandscape(context) && height(context) < 550;

  /// Proportional scaling helpers
  static double scaleHeight(BuildContext context, double factor) =>
      height(context) * factor;

  static double scaleWidth(BuildContext context, double factor) =>
      width(context) * factor;

  /// Adaptive value selector based on device type
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? landscape,
  }) {
    if (landscape != null && isLandscape(context)) {
      return landscape;
    }
    if (desktop != null && isDesktop(context)) {
      return desktop;
    }
    if (tablet != null && isTablet(context)) {
      return tablet;
    }
    return mobile;
  }
}

/// A wrapper widget that constrains content to a sensible max width and centers it on larger screens (tablets, desktops, landscape).
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.maxWidth = Responsive.maxFormWidth,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
