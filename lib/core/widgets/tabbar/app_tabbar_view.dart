
part of 'app_tabbar.dart';

class AppTabbarStackView<T extends IAppTabbarEnum> extends StatelessWidget {
  const AppTabbarStackView({
    super.key,
    required this.selectedValue,
    required this.tabs,
    required this.tabEnums,
    this.hiddenTabs = const [],
  }) : assert(
  tabs.length == tabEnums.length,
  'Tabs and tabEnums must have the same length',
  ),
        assert(tabs.length > 0, 'Tabs must not be empty');

  final T selectedValue;
  final List<Widget> tabs;
  final List<T> tabEnums;
  final List<T> hiddenTabs;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: (selectedValue as Enum).index,
      children:
      tabs.where((tab) {
        final index = tabs.indexOf(tab);
        return !hiddenTabs.contains(tabEnums[index]);
      }).toList(),
    );
  }
}

class AppTabbarPageView<T extends IAppTabbarEnum> extends StatelessWidget {
  const AppTabbarPageView({
    super.key,
    required this.tabs,
    required this.pageController,
    required this.tabEnums,
    this.onPageChanged,
  }) : assert(
  tabs.length == tabEnums.length,
  'Tabs and tabEnums must have the same length',
  ),
        assert(tabs.length > 0, 'Tabs must not be empty');

  final PageController pageController;
  final List<Widget> tabs;
  final List<T> tabEnums;
  final void Function(T value)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: (value) => onPageChanged?.call(tabEnums.elementAt(value)),
      children: tabs.toList(),
    );
  }
}
