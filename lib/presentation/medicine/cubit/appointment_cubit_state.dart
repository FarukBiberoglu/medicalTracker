import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../enum/category_enum.dart';
import '../model/appointment_model.dart';

class RandevuCubitState extends Equatable {
  final String? doctorName;
  final String? specialty;
  final DateTime? appointmentDate;
  final List<AppointmentModel> randevuModel;
  final CategoryEnum selectedCategory;



  const RandevuCubitState({
    required this.selectedCategory,
    this.doctorName,
    this.specialty,
    this.appointmentDate,
    this.randevuModel = const [],
  });
  bool get addButtonCheck {
    return doctorName != null &&
        specialty != null &&
        appointmentDate != null;
  }

  RandevuCubitState copyWith({

    ValueGetter<String?>? doctorName,
    ValueGetter<String?>? specialty,
    ValueGetter<DateTime?>? appointmentDate,
    List<AppointmentModel>? randevuModel,
     CategoryEnum? selectedCategory ,
  }) {
    return RandevuCubitState(
      doctorName: doctorName != null ? doctorName() : this.doctorName,
      specialty: specialty != null ? specialty() : this.specialty,
      appointmentDate: appointmentDate != null ? appointmentDate() : this.appointmentDate,
      randevuModel:  randevuModel ?? this.randevuModel,
        selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [
    doctorName,
    specialty,
    appointmentDate,
    randevuModel,
    selectedCategory
  ];
}