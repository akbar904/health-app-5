import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext) mobile;
  final Widget Function(BuildContext)? tablet;
  final Widget Function(BuildContext)? desktop;

  const ResponsiveBuilder({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100 && desktop != null) {
          return desktop!(context);
        }
        if (constraints.maxWidth >= 650 && tablet != null) {
          return tablet!(context);
        }
        return mobile(context);
      },
    );
  }
}
