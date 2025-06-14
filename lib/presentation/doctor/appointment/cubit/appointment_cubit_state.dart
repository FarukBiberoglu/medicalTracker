
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled19/core/enum/doctor_appointment_tab_enum.dart';
import 'package:untitled19/data/models/appointment_model.dart';

class DoctorAppointmentCubitState extends Equatable {
  final DoctorAppointmentTabEnum currentTab;
  final List<AppointmentModel>? randevuModel;




  const DoctorAppointmentCubitState({required this.currentTab, this.randevuModel});

  @override
  List<Object?> get props => [currentTab,randevuModel];

  DoctorAppointmentCubitState copyWith({DoctorAppointmentTabEnum? currentTab,     ValueGetter<List<AppointmentModel>?>? randevuModel,
  }) {
    return DoctorAppointmentCubitState(
      randevuModel: randevuModel != null ? randevuModel() : this.randevuModel,
      currentTab: currentTab ?? this.currentTab,
    );
  }
}
