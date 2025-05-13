import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../enum/category_enum.dart';

part 'appointment_model.g.dart';

@HiveType(typeId: 3)
class AppointmentModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String doctorName;
  @HiveField(2)
  final String specialty;
  @HiveField(3)
  final DateTime appointmentDate;
  @HiveField(4)
  final CategoryEnum categoryEnum;

  AppointmentModel({
    String? id,
    required this.doctorName,
    required this.specialty,
    required this.appointmentDate,
    required this.categoryEnum,
  }) : id = id ?? const Uuid().v4(); // Eğer dışarıdan id gelmezse UUID üretir

  AppointmentModel copyWith({
    String? id,
    String? doctorName,
    String? specialty,
    DateTime? appointmentDate,
    CategoryEnum? categoryEnum,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      doctorName: doctorName ?? this.doctorName,
      specialty: specialty ?? this.specialty,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      categoryEnum: categoryEnum ?? this.categoryEnum,
    );
  }
}
