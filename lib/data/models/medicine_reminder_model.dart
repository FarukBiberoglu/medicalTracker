import 'package:hive/hive.dart';
import 'package:untitled19/core/enum/select_medicine.dart';
import 'package:untitled19/core/enum/type_enum.dart';
import 'package:uuid/uuid.dart';
part 'medicine_reminder_model.g.dart';

@HiveType(typeId: 0)
class MedicineReminderModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String medicineName;
  @HiveField(2)
  final int dose;
  @HiveField(3)
  final TypeEnum type;
  @HiveField(4)
  final DateTime medicineDate;
  @HiveField(5)
  final SelectMedicine selectMedicine;
  @HiveField(6)
  final String comments;
  @HiveField(7)
  bool isCompleted;
  MedicineReminderModel({
    String? id,
    required this.selectMedicine,
    required this.medicineName,
    required this.dose,
    required this.type,
    required this.medicineDate,
    required this.comments,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();
  MedicineReminderModel copyWith({
    String? id,
    String? medicineName,
    int? dose,
    TypeEnum? type,
    DateTime? medicineDate,
    SelectMedicine? selectMedicine,
    String? comments,
    bool? isCompleted,
  }) {
    return MedicineReminderModel(
      id: id ?? this.id,
      selectMedicine: selectMedicine ?? this.selectMedicine,
      medicineName: medicineName ?? this.medicineName,
      dose: dose ?? this.dose,
      type: type ?? this.type,
      medicineDate: medicineDate ?? this.medicineDate,
      comments: comments ?? this.comments,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}