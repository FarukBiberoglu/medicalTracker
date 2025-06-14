part of 'app_tabbar.dart';

class AppTabbarData<T extends IAppTabbarEnum> {
  AppTabbarData({
    required this.title,
    this.selectedIcon,
    this.unselectedIcon,
    required this.value,
    this.hidden = false,
  });

  final String title;
  final Widget? selectedIcon;
  final Widget? unselectedIcon;
  final T value;
  final bool hidden;
}