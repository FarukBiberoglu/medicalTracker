import 'package:untitled19/presentation/medicine_reminder/enum/type_enum.dart';

class MedicineReminderModel {
  final String medicineName;
  final int dose;
  final TypeEnum type;
  final DateTime medicineDate;
  final String comments;

  MedicineReminderModel({
    required this.medicineName,
    required this.dose,
    required this.type,
    required this.medicineDate,
    required this.comments,
  });

}
