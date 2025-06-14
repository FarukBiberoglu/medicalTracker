import 'package:untitled19/data/models/appointment_model.dart';
import 'package:untitled19/data/service/base_repository.dart';

class AppointmentService extends BaseRepository {


  Future<List<AppointmentModel>> getAppointment(String userId) async {
    try {
      final userRef = firestore.collection('users').doc(userId);
      final snapshot = await firestore.collection("appointment").where(
        'userRef',isEqualTo: userRef
      ).get();
      final appointments = <AppointmentModel>[];
      for(final doc in snapshot.docs){
        final data = await AppointmentModel.fromJson(doc.data());
        appointments.add(data);
      }
      return appointments ;
    } catch (e) {
      throw "Failed to save user data";
    }
  }
  Future<List<AppointmentModel>> getDoctor(String doctorId) async {
    try {
      final userRef = firestore.collection('users').doc(doctorId);
      final snapshot = await firestore.collection("appointment").where(
          'doktorRef',isEqualTo: userRef
      ).get();
      final appointments = <AppointmentModel>[];
      for(final doc in snapshot.docs){
        final data = await AppointmentModel.fromJson(doc.data());
        appointments.add(data);

      }

      return appointments ;
    } catch (e) {
      throw "Failed to save user data";
    }
  }
  Future<AppointmentModel> saveAppointment(AppointmentModel appointmentModel) async{

    try {
      final ref= await firestore.collection("appointment").doc();

      await firestore.collection("appointment").doc(ref.id).set(appointmentModel.copyWith(id: ref.id).toJson());
      final res= await firestore.collection("appointment").doc(ref.id).get();
      final data = res.data() as Map<String,dynamic> ;
      final model = await AppointmentModel.fromJson(data);


      return model;
    } catch (e) {
      throw "Failed to save user data";
    }
  }
  Future<void> updateAppointment(AppointmentModel appointmentModel) async {
    try {
      if (appointmentModel.id == null) {
        throw "Appointment ID is null";
      }

      await firestore
          .collection("appointment")
          .doc(appointmentModel.id)
          .update(appointmentModel.toJson());
    } catch (e) {
      throw "Failed to update appointment";
    }
  }Future<void> deleteAppointment(AppointmentModel appointmentModel) async {
    try {
      if (appointmentModel.id == null) {
        throw "Appointment ID is null";
      }

      await firestore
          .collection("appointment")
          .doc(appointmentModel.id)
          .delete();
    } catch (e) {
      throw "Failed to delete appointment";
    }
  }

}