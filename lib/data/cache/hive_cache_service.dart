import 'package:untitled19/presentation/appointment/enum/category_enum.dart';
import 'package:untitled19/presentation/appointment/model/appointment_model.dart';
import 'package:untitled19/presentation/medicine_reminder/enum/select_medicine.dart';
import 'package:untitled19/presentation/medicine_reminder/enum/type_enum.dart';
import 'package:untitled19/presentation/medicine_reminder/model/medicine_reminder_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCacheService {
  late final Box<MedicineReminderModel> reminderBox;
  late final Box<AppointmentModel> appointmentBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(MedicineReminderModelAdapter())
      ..registerAdapter(TypeEnumAdapter())
      ..registerAdapter(SelectMedicineAdapter())
      ..registerAdapter(AppointmentModelAdapter())
    ..registerAdapter(CategoryEnumAdapter());

    reminderBox = await Hive.openBox<MedicineReminderModel>('reminderBox');
    appointmentBox = await Hive.openBox<AppointmentModel>('appointmentBox');
  }

  void saveMedicine(MedicineReminderModel medicineReminderModel) {
    reminderBox.add(medicineReminderModel);
  }

  void saveAppointment(AppointmentModel appointmentModel) {
    appointmentBox.add(appointmentModel);
  }

  void updateAppointment(AppointmentModel appointmentModel) {
    final index = appointmentBox.values.toList().indexWhere(
      (e) => e.id == appointmentModel.id,
    );
    if (index != -1) {
      appointmentBox.putAt(index, appointmentModel);
    }
  }

  void removeMedicine(String id) {
    final index = reminderBox.values.toList().indexWhere((e) => e.id == id);
    if (index != -1) {
      reminderBox.deleteAt(index);
    }
  }
  void removeAppointment(String id){
    final index = appointmentBox.values.toList().indexWhere((e)=>e.id == id);
    if(index != -1){
      appointmentBox.deleteAt(index);
    }
  }

  void updateMedicine(MedicineReminderModel medicineReminderModel) {
    final index = reminderBox.values.toList().indexWhere(
      (e) => e.id == medicineReminderModel.id,
    );
    if (index != -1) {
      reminderBox.putAt(index, medicineReminderModel);
    }
  }

  List<MedicineReminderModel> get loadMedicine {
    return reminderBox.values.toList();
  }


  List<AppointmentModel> get loadAppointment {
    return appointmentBox.values.toList();
  }

}

