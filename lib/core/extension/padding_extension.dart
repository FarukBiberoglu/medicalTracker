import 'package:flutter/material.dart';

/// Padding extension
extension PaddingExtension on Widget {
  /// all padding widget
  Widget allPadding(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );

  /// symmetric padding widget
  Widget symmetricPadding({
    double vertical = 0,
    double horizontal = 0,
  }) =>
      Padding(
        padding:
            EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
        child: this,
      );

  /// only padding widget
  Widget onlyPadding({
    double bottom = 0,
    double left = 0,
    double right = 0,
    double top = 0,
  }) =>
      Padding(
        padding:
            EdgeInsets.only(bottom: bottom, left: left, right: right, top: top),
        child: this,
      );
}
