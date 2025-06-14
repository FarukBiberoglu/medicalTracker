import 'package:bloc/bloc.dart';
import 'package:untitled19/core/enum/doctor_appointment_tab_enum.dart';
import 'package:untitled19/data/models/appointment_model.dart';
import 'package:untitled19/data/service/appointment_service.dart';
import 'package:untitled19/data/service/service_locator.dart';
import 'package:untitled19/presentation/doctor/appointment/cubit/appointment_cubit_state.dart';

class DoctorAppointmentCubit extends Cubit<DoctorAppointmentCubitState> {

  final AppointmentService _appointmentService;

  DoctorAppointmentCubit(String uid)
      : _appointmentService = getIt<AppointmentService>(),
        super(DoctorAppointmentCubitState(currentTab: DoctorAppointmentTabEnum.all)) {
    _fetchDoctorAppointments(uid);
  }

  Future<void> changeAppointmentState(AppointmentModel appointment) async{
    await _appointmentService.updateAppointment(appointment);
    _fetchDoctorAppointments(appointment.doktorModel!.uid);

  }

  Future<void> _fetchDoctorAppointments(String uid) async {
    if (!isClosed) {
      emit(state.copyWith(randevuModel: () => null));
    }
    final result = await _appointmentService.getDoctor(uid);
    if (!isClosed) {
      emit(state.copyWith(randevuModel: () => result));
    }
  }
  Future<void> fetchDoctorDailyAppointment(String doktorId) async {
    final result = await _appointmentService.getDoctor(doktorId);
    if (!isClosed) {
      emit(state.copyWith(randevuModel: () => result));
    }
  }



  void setSelectedTab(DoctorAppointmentTabEnum tab) {
    if (!isClosed) {
      emit(state.copyWith(currentTab: tab));
    }
  }
}
