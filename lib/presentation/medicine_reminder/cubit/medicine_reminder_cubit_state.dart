import 'package:equatable/equatable.dart';
import 'package:untitled19/presentation/medicine_reminder/enum/select_medicine.dart';
import 'package:untitled19/presentation/medicine_reminder/enum/type_enum.dart';
import 'package:untitled19/presentation/medicine_reminder/model/medicine_reminder_model.dart';

class MedicineReminderCubitState extends Equatable {
  final String? medicineName;
  final int? dose;
  final DateTime? medicineDate;
  final TypeEnum? selectedType;
  final String? comments;
  final List<MedicineReminderModel> medicineModel;
  final SelectMedicine selectedMedicine;
  final DateTime  selectDateTime;
  final String search;


  MedicineReminderCubitState({
    this.search ='',
    this.medicineName,
    this.dose,
    required this.selectedMedicine,
    this.medicineDate,
    this.selectedType,
    this.comments,
    this.medicineModel = const [],
    DateTime? selectDateTime, // <- buraya nullable olarak yazılır
  }) : selectDateTime = selectDateTime ?? DateTime.now(); // <- burada atanır

  // copyWith metodu
  MedicineReminderCubitState copyWith({
    String? search,
    DateTime? selectDateTime,
    String? medicineName,
    int? dose,
    DateTime? medicineDate,
    TypeEnum? selectedType,
    String? comments,
    List<MedicineReminderModel>? medicineModel,
    SelectMedicine? selectedMedicine,
  }) {
    return MedicineReminderCubitState(
      search: search ?? this.search,
      selectDateTime: selectDateTime ?? this.selectDateTime,
      selectedMedicine: selectedMedicine ?? this.selectedMedicine,
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
    search,
    selectDateTime,
    medicineName,
    selectedMedicine,
    dose,
    medicineDate,
    selectedType,
    comments,
    medicineModel,
  ];
}
