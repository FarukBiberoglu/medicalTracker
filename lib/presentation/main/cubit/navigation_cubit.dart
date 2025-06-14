import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/enum/main_navigation_enum.dart';
import 'navigation_cubit_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(selectedIndex: MainNavigationEnum.profile));

  void setSelectedIndex(MainNavigationEnum index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
