import 'package:flutter/material.dart';

const int largeScreenSize = 1366;
const int mediumScreenSize = 768;
// const int smallScreenSize = 360;
const int customScreenSize = 1100;

extension ResponsiveExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  /// Between 360 and 768 :: Mobile
  bool get isSmallScreen {
    return width < mediumScreenSize;
  }

  /// Between 768 and 1366 :: Tablet Or Web
  bool get isMediumScreen {
    return width >= mediumScreenSize && width < largeScreenSize;
  }

  /// Larger Than 1366 very big screen :: Desktop
  bool get isLargeScreen {
    return width > largeScreenSize;
  }

  /// Between 768 and 1100 :: Tablet
  bool get isCustomSize {
    return width <= customScreenSize && width >= mediumScreenSize;
  }
}
