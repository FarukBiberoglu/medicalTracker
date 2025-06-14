import 'package:equatable/equatable.dart';
import 'package:untitled19/presentation/doctor/main/enum/doctor_main_navigation_enum.dart';

class DoctorNavigationState extends Equatable {
  final DoctorMainNavigationEnum selectedIndex;

  const DoctorNavigationState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];

  DoctorNavigationState copyWith({DoctorMainNavigationEnum? selectedIndex}) {
    return DoctorNavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
