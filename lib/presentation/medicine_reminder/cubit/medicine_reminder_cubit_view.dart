import 'package:equatable/equatable.dart';
import 'package:untitled19/presentation/medicine_reminder/enum/type_enum.dart';
import 'package:untitled19/presentation/medicine_reminder/model/medicine_reminder_model.dart';

class MedicineReminderCubitState extends Equatable {
  final String? medicineName;
  final int? dose;
  final DateTime? medicineDate;
  final TypeEnum? selectedType;
  final String? comments;
  final List<MedicineReminderModel> medicineModel;

  const MedicineReminderCubitState({
    this.medicineName,
    this.dose,
    this.medicineDate,
    this.selectedType,
    this.comments,
    this.medicineModel = const [],
  });

  // copyWith metodu, state'in güncellenmesi için kullanılır
  MedicineReminderCubitState copyWith({
    String? medicineName,
    int? dose,
    DateTime? medicineDate,
    TypeEnum? selectedType,
    String? comments,
    List<MedicineReminderModel>? medicineModel,
  }) {
    return MedicineReminderCubitState(
      medicineName: medicineName ?? this.medicineName,
      dose: dose ?? this.dose,
      medicineDate: medicineDate ?? this.medicineDate,
      selectedType: selectedType ?? this.selectedType,
      comments: comments ?? this.comments,
      medicineModel: medicineModel ?? this.medicineModel,
    );
  }

  @override
  List<Object?> get props => [
    medicineName,
    dose,
    medicineDate,
    selectedType,
    comments,
    medicineModel,
  ];
}
