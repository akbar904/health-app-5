import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    Key? key,
    required this.mobileBody,
    required this.tabletBody,
    required this.desktopBody,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktopBody;
        } else if (constraints.maxWidth >= 600) {
          return tabletBody;
        } else {
          return mobileBody;
        }
      },
    );
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
    DeviceType deviceType,
  ) builder;

  const ResponsiveBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        DeviceType deviceType;
        if (constraints.maxWidth >= 1200) {
          deviceType = DeviceType.desktop;
        } else if (constraints.maxWidth >= 600) {
          deviceType = DeviceType.tablet;
        } else {
          deviceType = DeviceType.mobile;
        }
        return builder(context, constraints, deviceType);
      },
    );
  }
}

enum DeviceType { mobile, tablet, desktop }

extension ResponsiveHelpers on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 600;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 600 &&
      MediaQuery.of(this).size.width < 1200;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1200;
  
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight => MediaQuery.of(this).size.height;
  
  double get paddingValue => isMobile ? 16 : isTablet ? 24 : 32;
  
  EdgeInsets get responsivePadding => EdgeInsets.all(paddingValue);
  
  double get responsiveWidth {
    if (isDesktop) return deviceWidth * 0.5;
    if (isTablet) return deviceWidth * 0.7;
    return deviceWidth;
  }
}