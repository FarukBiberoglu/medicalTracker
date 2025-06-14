import 'package:flutter/material.dart';

/// Radius Extension
extension RadiusExtension on Widget {
  /// Circular Radius
  Widget circularRadius(double value) => ClipRRect(
        borderRadius: BorderRadius.circular(value),
        child: this,
      );

  /// Horizontal Radius
  Widget horizontalRadius({
    double left = 0,
    double right = 0,
  }) =>
      ClipRRect(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(left),
          right: Radius.circular(right),
        ),
        child: this,
      );

  /// Vertical Radius
  Widget verticalRadius({
    double top = 0,
    double bottom = 0,
  }) =>
      ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(top),
          bottom: Radius.circular(bottom),
        ),
        child: this,
      );
}
