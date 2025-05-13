import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../data/cache/hive_cache_service.dart';
import '../../../data/service/notification_service.dart';
import '../../../data/service/service_locator.dart';
import '../enum/category_enum.dart';
import '../model/appointment_model.dart';
import 'appointment_cubit_state.dart';
import 'package:image_picker/image_picker.dart';

class AppointmentCubit extends Cubit<AppointmentCubitState> {
  AppointmentCubit() : super(const AppointmentCubitState(selectedCategory: CategoryEnum.upcoming)){
    emit(state.copyWith(randevuModel:getIt.get<HiveCacheService>().loadAppointment ));

  }


  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController appointmentDateController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();


  void addAppointment() {
    final newModel = AppointmentModel(
      doctorName: state.doctorName  ?? '',
      appointmentDate: state.appointmentDate ?? DateTime.now(),
      specialty: state.specialty ?? '',
      categoryEnum: state.selectedCategory ?? CategoryEnum.upcoming
    );
    NotificationService.I.scheduleOneTimeNotification(dateTime: state.appointmentDate ?? DateTime.now(),title: state.doctorName,body: state.specialty);
    getIt.get<HiveCacheService>().saveAppointment(newModel);
    final updatedList = [...state.randevuModel, newModel];

    emit(state.copyWith(
     randevuModel : updatedList,
      doctorName: null,
      specialty: null,
      appointmentDate: null,
    ));



  }

  void deleteRandevu(AppointmentModel randevu) {
    final updatedList = List<AppointmentModel>.from(state.randevuModel)..remove(randevu);
    getIt.get<HiveCacheService>().removeAppointment(randevu.id);
    emit(state.copyWith(randevuModel: updatedList));
  }

  void completed(AppointmentModel randevu) {
    final updatedList = List<AppointmentModel>.from(state.randevuModel)..remove(randevu);
    getIt.get<HiveCacheService>().updateAppointment(randevu.copyWith(categoryEnum: CategoryEnum.completed));
    updatedList.add(randevu.copyWith(categoryEnum: CategoryEnum.completed));
    emit(state.copyWith(randevuModel: updatedList));
  }
  void canceled(AppointmentModel randevu) {
    final updatedList = List<AppointmentModel>.from(state.randevuModel)..remove(randevu);
    updatedList.add(randevu.copyWith(categoryEnum: CategoryEnum.canceled));
    getIt.get<HiveCacheService>().updateAppointment(randevu.copyWith(categoryEnum: CategoryEnum.canceled));
    emit(state.copyWith(randevuModel: updatedList));
  }

  // Doktor adı değiştiğinde 
  void onChangedDoctorName(String value) {
    emit(state.copyWith(doctorName: () => value));
  }

  // Uzmanlık değiştiğinde
  void onChangedSpecialty(String value) {
    emit(state.copyWith(specialty:() => value));
  }

  // Randevu tarihi değiştiğinde
  void onChangedAppointmentDate(DateTime value) {
appointmentDateController.text = DateFormat("dd.MM.yyyy").format(value);
    emit(state.copyWith(appointmentDate:() => value));
  }

  //null kontrolü
  void resetValues() {
    emit(state.copyWith(
      doctorName: () => null, 
      specialty: () => null,
      appointmentDate: () => null,
    ));
    doctorNameController.clear();
    specialtyController.clear();
    appointmentDateController.clear();
  }

  void selectCategory(CategoryEnum category) {
    emit(state.copyWith(selectedCategory: category));
  }

}