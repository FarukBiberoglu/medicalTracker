import 'package:flutter/material.dart';

/// [BuildContext] extension
extension ContextExtension on BuildContext {
  /// [ThemeData] getter
  ThemeData get theme => Theme.of(this);

  /// [MediaQueryData] getter Height
  double get height => MediaQuery.sizeOf(this).height;

  /// [MediaQueryData] getter Width
  double get width => MediaQuery.sizeOf(this).width;

  T byOrientation<T>({required T portrait, required T landscape}) {
    return MediaQuery.orientationOf(this) == Orientation.portrait
        ? portrait
        : landscape;
  }

  T byScreenOrientation<T>({required T portrait, required T landscape}) {
    return width < height ? portrait : landscape;
  }
}
