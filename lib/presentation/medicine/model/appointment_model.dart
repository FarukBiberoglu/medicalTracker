
import '../enum/category_enum.dart';

class AppointmentModel {
  final String doctorName;
  final String specialty;
  final DateTime appointmentDate;
  final CategoryEnum categoryEnum;

  AppointmentModel({
    required this.categoryEnum,
    required this.doctorName,
    required this.specialty,
    required this.appointmentDate,
  });

  AppointmentModel copyWith({
    String? doctorName,
    String? specialty,
    DateTime? appointmentDate,
    CategoryEnum? categoryEnum,
  }) {
    return AppointmentModel(
      doctorName: doctorName ?? this.doctorName,
      specialty: specialty ?? this.specialty,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      categoryEnum: categoryEnum ?? this.categoryEnum,
    );
  }
}
