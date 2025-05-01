import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../enum/category_enum.dart';
import '../model/appointment_model.dart';
import 'appointment_cubit_state.dart';
import 'package:image_picker/image_picker.dart';

class RandevuCubit extends Cubit<RandevuCubitState> {
  RandevuCubit() : super(const RandevuCubitState(selectedCategory: CategoryEnum.upcoming));


  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController appointmentDateController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();

  void addRandevu() {
    emit(state.copyWith(
      randevuModel: [
        ...state.randevuModel,
        AppointmentModel(
          categoryEnum: CategoryEnum.upcoming,
            doctorName: state.doctorName!,
            specialty: state.specialty!,
            appointmentDate: state.appointmentDate!,
        )],
      doctorName: () => null,
      specialty: () => null,
      appointmentDate: () => null,
    ));
    doctorNameController.clear();
    specialtyController.clear();
    appointmentDateController.clear();
  }
  // Randevu silme işlemi
  void deleteRandevu(AppointmentModel randevu) {
    final updatedList = List<AppointmentModel>.from(state.randevuModel)..remove(randevu);
    emit(state.copyWith(randevuModel: updatedList));
  }
  void completed(AppointmentModel randevu) {
    final updatedList = List<AppointmentModel>.from(state.randevuModel)..remove(randevu);
    updatedList.add(randevu.copyWith(categoryEnum: CategoryEnum.completed));
    emit(state.copyWith(randevuModel: updatedList));
  }
  void canceled(AppointmentModel randevu) {
    final updatedList = List<AppointmentModel>.from(state.randevuModel)..remove(randevu);
    updatedList.add(randevu.copyWith(categoryEnum: CategoryEnum.canceled));
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
    appointmentDateController.text = DateFormat("dd.mm.yyyy hh:MM").format(value);
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