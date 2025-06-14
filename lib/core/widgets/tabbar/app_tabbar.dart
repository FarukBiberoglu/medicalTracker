import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled19/core/constant/app_colors_constant.dart';
part 'app_tabbar_data.dart';
part 'app_tabbar_tab.dart';
part 'app_tabbar_view.dart';

abstract interface class IAppTabbarEnum {
  String get displayValue;
}

class AppTabbar<T extends IAppTabbarEnum> extends StatelessWidget {
  const AppTabbar({
    super.key,
    required this.tabs,
    this.onTap,
    required this.selectedValue,
    this.borderRadius,
    this.backgroundColor,
    this.spacing,
    this.padding,
    this.mainAxisAlignment,
  });

  final T selectedValue;
  final List<AppTabbarData<T>> tabs;
  final void Function(T value)? onTap;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      child: SafeArea(
        bottom: false,
        top: false,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            spacing: spacing ?? 12,
            mainAxisAlignment:
            mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
            children:
            tabs
                .where((e) => !e.hidden)
                .map<Widget>(
                  (e) => Expanded(
                child: _AppTabbarTab<T>(
                  selectedValue: selectedValue,
                  tab: e,
                  onTap: onTap,
                ),
              ),
            )
                .toList(),
          ),
        ),
      ),
    );
  }
}