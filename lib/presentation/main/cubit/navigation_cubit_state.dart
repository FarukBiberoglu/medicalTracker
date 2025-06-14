import 'package:equatable/equatable.dart';
import 'package:untitled19/core/enum/main_navigation_enum.dart';

class NavigationState extends Equatable {
  final MainNavigationEnum selectedIndex;

  const NavigationState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];

  NavigationState copyWith({MainNavigationEnum? selectedIndex}) {
    return NavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
