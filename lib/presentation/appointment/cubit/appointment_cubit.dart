import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled19/core/enum/appointment_state_enum.dart';
import 'package:untitled19/data/service/appointment_service.dart';
import '../../../core/router/app_router.dart';
import '../../../core/service/notification/notification_service.dart';
import '../../../data/service/service_locator.dart';
import 'package:untitled19/core/enum/blood_type_enum.dart';
import 'package:untitled19/core/enum/category_enum.dart';
import 'package:untitled19/core/enum/gender_enum.dart';
import 'package:untitled19/core/enum/select_medicine.dart';
import 'package:untitled19/core/enum/type_enum.dart';
import '../../../data/models/appointment_model.dart';
import '../../authentication/cubit/auth/auth_cubit.dart';
import 'appointment_cubit_state.dart';
import 'package:image_picker/image_picker.dart';

class AppointmentCubit extends Cubit<AppointmentCubitState> {
  AppointmentCubit() : super(const AppointmentCubitState(selectedCategory: CategoryEnum.upcoming )){
    getIt.get<AppointmentService>().getAppointment(getIt<AppRouter>().navigatorKey.currentState!.context.read<AuthCubit>().state.user?.uid ?? '').then(
        (value) {
          if(!isClosed)
          emit(state.copyWith(
          randevuModel: value
        ));
        }
    );
  }


  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController appointmentDateController = TextEditingController();
  final TextEditingController searchController = TextEditingController();



  final ImagePicker imagePicker = ImagePicker();

  void onChangedSearchController(String value) {
    emit(state.copyWith(search: value));
  }


  Future<void> addAppointment() async {
    final newModel = AppointmentModel(

      appointmentStateEnum: AppointmentStateEnum.pending,
        doktorRef: FirebaseFirestore.instance.collection('users').doc(state.doctorId ?? ''),
        userRef: FirebaseFirestore.instance.collection('users').doc(getIt<AppRouter>().navigatorKey.currentState!.context.read<AuthCubit>().state.user?.uid ?? ''),
      doctorName: state.doctorName  ?? '',
      appointmentDate: state.appointmentDate ?? DateTime.now(),
      categoryEnum: state.selectedCategory ?? CategoryEnum.upcoming
    );
    NotificationService.I.scheduleOneTimeNotification(dateTime: state.appointmentDate ?? DateTime.now(),title: state.doctorName,body: state.specialization);
  final model = await  getIt.get<AppointmentService>().saveAppointment(newModel);
    final updatedList = [...state.randevuModel,model ];

    emit(state.copyWith(
     randevuModel : updatedList,
      doctorName: null,
      specialization: null,
      appointmentDate: null,
    ));
  }

  void deleteRandevu(AppointmentModel randevu) {
    final updatedList = List<AppointmentModel>.from(state.randevuModel)..remove(randevu);
    getIt.get<AppointmentService>().deleteAppointment(randevu);
    emit(state.copyWith(randevuModel: updatedList));
  }

  void completed(AppointmentModel randevu) {
    final updatedList = List<AppointmentModel>.from(state.randevuModel)..remove(randevu);
    getIt.get<AppointmentService>().updateAppointment(randevu.copyWith(categoryEnum: CategoryEnum.completed));
    updatedList.add(randevu.copyWith(categoryEnum: CategoryEnum.completed));
    emit(state.copyWith(randevuModel: updatedList));
  }
  void canceled(AppointmentModel randevu) {
    final updatedList = List<AppointmentModel>.from(state.randevuModel)..remove(randevu);
    updatedList.add(randevu.copyWith(categoryEnum: CategoryEnum.canceled));
    getIt.get<AppointmentService>().updateAppointment(randevu.copyWith(categoryEnum: CategoryEnum.canceled));
    emit(state.copyWith(randevuModel: updatedList));
  }

  void onChangedDoctorName(String value) {
    doctorNameController.text = value;
    emit(state.copyWith(doctorName: () => value));
  }

  void doctorId(String id){
    emit(state.copyWith(doctorId: ()=>id));
  }



  void onChangedSpecialty(String value) {
    emit(state.copyWith(specialization:() => value));
  }

  void onChangedAppointmentDate(DateTime value) {
appointmentDateController.text = DateFormat("dd.MM.yyyy").format(value);
    emit(state.copyWith(appointmentDate:() => value));
  }

  void resetValues() {
    emit(state.copyWith(
      doctorName: () => null,
      specialization: () => null,
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