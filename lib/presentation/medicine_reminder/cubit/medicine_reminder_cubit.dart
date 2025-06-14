import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled19/data/service/service_locator.dart';
import 'package:untitled19/data/models/medicine_reminder_model.dart';
import '../../../core/cache/hive_cache_service.dart';
import 'package:untitled19/core/enum/select_medicine.dart';
import 'package:untitled19/core/enum/type_enum.dart';
import '../../../core/service/notification/notification_service.dart';
import 'medicine_reminder_cubit_state.dart';


class MedicineReminderCubit extends Cubit<MedicineReminderCubitState> {
  MedicineReminderCubit()
      : super(MedicineReminderCubitState(selectedMedicine: SelectMedicine.capcule,    medicineModel: [],
  )) {
    final loadMedicine = getIt.get<HiveCacheService>().loadMedicine;
    emit(state.copyWith(medicineModel: loadMedicine));
  }

  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController doseController = TextEditingController();
  final TextEditingController medicineDateController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  final TextEditingController searchController = TextEditingController();


  void deleteMedicine(MedicineReminderModel medicine) {
    final updatedList = List<MedicineReminderModel>.from(state.medicineModel)..remove(medicine);
    getIt.get<HiveCacheService>().removeMedicine(medicine.id);
    emit(state.copyWith(
      medicineModel: updatedList,
    ));
  }
  void completeMedicine(MedicineReminderModel medicine){
   final int index =  state.medicineModel.indexOf(medicine);
   final updatedList = List<MedicineReminderModel>.from(state.medicineModel)..remove(medicine)..insert(index, medicine.copyWith(isCompleted: !medicine.isCompleted) );
   getIt.get<HiveCacheService>().updateMedicine(medicine.copyWith(isCompleted: !medicine.isCompleted));
   emit(state.copyWith(
     medicineModel: updatedList,

   ));
  }


  void onChangedSearchController(String value) {
    emit(state.copyWith(search: value));
  }

  void selectDate(DateTime date){
    emit(state.copyWith(selectDateTime: date));
  }


  void medicineName(String value) {
    emit(state.copyWith(medicineName: value));
  }

  void dose(int value) {
    emit(state.copyWith(dose: value));
  }

  void selectMedicine(SelectMedicine value) {
    emit(state.copyWith(selectedMedicine: value));
  }

  void selectedType(TypeEnum type) {
    emit(state.copyWith(selectedType: type));
  }

  void onChangedMedicineDate(DateTime value) {
    medicineDateController.text = DateFormat("dd.MM.yyyy ").format(value);
    emit(state.copyWith(medicineDate: value));
  }

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





  void addMedicine() {
    final newModel = MedicineReminderModel(
      selectMedicine: state.selectedMedicine ,
      medicineDate: state.medicineDate ?? DateTime.now(),
      comments: state.comments ?? "",
      dose: state.dose ?? 0,
      medicineName: state.medicineName ?? '',
      type: state.selectedType ?? TypeEnum.Gr,
    );
    NotificationService.I.scheduleOneTimeNotification(dateTime: state.medicineDate ?? DateTime.now(),title: state.medicineName,body: state.comments);
    getIt.get<HiveCacheService>().saveMedicine(newModel);
    final updatedList = [...state.medicineModel, newModel];

    emit(state.copyWith(
      medicineModel: updatedList,
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
