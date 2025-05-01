import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:untitled19/presentation/medicine_reminder/enum/type_enum.dart';
import 'package:untitled19/presentation/medicine_reminder/model/medicine_reminder_model.dart';

import 'medicine_reminder_cubit.dart';
import 'medicine_reminder_cubit_view.dart';

class MedicineReminderCubit extends Cubit<MedicineReminderCubitState> {
  MedicineReminderCubit() : super(const MedicineReminderCubitState());

  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController doseController = TextEditingController();
  final TextEditingController medicineDateController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();

  // Ilaç Adı
  void medicineName(String value) {
    emit(state.copyWith(medicineName: value));
  }

  // Doz
  void dose(int value) {
    emit(state.copyWith(dose: value));
  }

  void selectedType ( TypeEnum type){
    emit(state.copyWith(selectedType: type));
  }
  // İlaç Tarihi
  void onChangedMedicineDate(DateTime value) {
    medicineDateController.text = DateFormat("dd.MM.yyyy HH:mm").format(value);
    emit(state.copyWith(medicineDate: value));
  }

  // Type Seçimi (tabs, piece, mg, gr)


  // Yorumlar
  void comments(String value) {
    emit(state.copyWith(comments: value));
  }

  void resetValues() {
    emit(state.copyWith(
      medicineName: null,
      dose: null,
      medicineDate: null,
      selectedType: null,
      comments: null,
    ));
    medicineNameController.clear();
    doseController.clear();
    medicineDateController.clear();
    commentsController.clear();
  }


  void deleteMedicine(MedicineReminderModel medicine) {
    final updatedList = List<MedicineReminderModel>.from(state.medicineModel)..remove(medicine);
    emit(state.copyWith(medicineModel: updatedList));
  }

  void addMedicine() {
    emit(state.copyWith(
      medicineModel: [
        ...state.medicineModel,
        MedicineReminderModel(
          medicineDate: state.medicineDate ?? DateTime.now(),
          comments: state.comments ??"",
          dose: state.dose ?? 0, // Doğru alan ve tipi
          medicineName: state.medicineName ?? '',
          type: state.selectedType ?? TypeEnum.gr,
        )
      ],
      medicineName: null,
      medicineDate: null,
      comments: null,
    ));

    doseController.clear();
    medicineNameController.clear();
    medicineDateController.clear();
    commentsController.clear();
  }


}
