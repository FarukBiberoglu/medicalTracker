import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:untitled19/core/enum/category_enum.dart';
import '../../../data/models/appointment_model.dart';

class AppointmentCubitState extends Equatable {
  final String? doctorName;
  final String? specialization;
  final DateTime? appointmentDate;
  final List<AppointmentModel> randevuModel;
  final CategoryEnum selectedCategory;
  final String? doctorId;
  final String search;




  const AppointmentCubitState({
    this.search ='',
     this.doctorId,
    required this.selectedCategory,
    this.doctorName,
    this.specialization,
    this.appointmentDate,
    this.randevuModel = const [],
  });
  bool get addButtonCheck {
    return doctorName != null &&
        specialization != null &&
        appointmentDate != null;
  }

  AppointmentCubitState copyWith({
    String? search,
    ValueGetter<String?>? doctorId,
    ValueGetter<String?>? doctorName,
    ValueGetter<String?>? specialization,
    ValueGetter<DateTime?>? appointmentDate,
    List<AppointmentModel>? randevuModel,
     CategoryEnum? selectedCategory ,
  }) {
    return AppointmentCubitState(
      search: search ?? this.search,
      doctorId: doctorId != null ? doctorId() : this.doctorId,
      doctorName: doctorName != null ? doctorName() : this.doctorName,
      specialization: specialization != null ? specialization() : this.specialization,
      appointmentDate: appointmentDate != null ? appointmentDate() : this.appointmentDate,
      randevuModel:  randevuModel ?? this.randevuModel,
        selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [
    search,
    doctorId,
    doctorName,
    specialization,
    appointmentDate,
    randevuModel,
    selectedCategory
  ];
}