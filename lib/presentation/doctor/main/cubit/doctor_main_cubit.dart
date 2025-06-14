import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/presentation/doctor/main/enum/doctor_main_navigation_enum.dart';
import 'doctor_main_cubit_state.dart';

class DoctorNavigationCubit extends Cubit<DoctorNavigationState> {
  DoctorNavigationCubit() : super(const DoctorNavigationState(selectedIndex: DoctorMainNavigationEnum.home));

  void setSelectedIndex(DoctorMainNavigationEnum index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
