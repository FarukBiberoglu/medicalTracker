import 'dart:developer';
import 'package:untitled19/core/enum/blood_type_enum.dart';
import 'package:untitled19/core/enum/category_enum.dart';
import 'package:untitled19/core/enum/gender_enum.dart';
import 'package:untitled19/core/enum/select_medicine.dart';
import 'package:untitled19/core/enum/type_enum.dart';
import 'package:untitled19/data/models/appointment_model.dart';
import 'package:untitled19/data/models/medicine_reminder_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled19/data/models/note_to_self_model.dart';
import 'package:untitled19/data/models/user_model.dart';


class HiveCacheService {
  late final Box<MedicineReminderModel> reminderBox;
  late final Box<AppointmentModel> appointmentBox;
  late final Box<UserModel>  profileBox;
  late final Box<NoteToSelfModel> noteBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive

      ..registerAdapter(MedicineReminderModelAdapter())
      ..registerAdapter(UserModelAdapter())
      ..registerAdapter(TypeEnumAdapter())
      ..registerAdapter(SelectMedicineAdapter())
      ..registerAdapter(AppointmentModelAdapter())
    ..registerAdapter(CategoryEnumAdapter())
      ..registerAdapter(BloodTypeEnumAdapter())
    ..registerAdapter(GenderEnumAdapter())
      ..registerAdapter(NoteToSelfModelAdapter());

    noteBox =  await Hive.openBox<NoteToSelfModel>('noteModel');
    profileBox =  await Hive.openBox<UserModel>('profileModel');
    reminderBox = await Hive.openBox<MedicineReminderModel>('reminderBox');
    appointmentBox = await Hive.openBox<AppointmentModel>('appointmentBox');
  }



  void saveProfile(UserModel profileModel) async{
    await  profileBox.put('profile',profileModel);
  }

  void removeProfile(String id) {
    final index = reminderBox.values.toList().indexWhere((e) => e.id == id);
    if (index != -1) {
      reminderBox.deleteAt(index);
    }
  }

  void saveMedicine(MedicineReminderModel medicineReminderModel) {
    reminderBox.add(medicineReminderModel);
  }
  void saveTask (NoteToSelfModel noteToSelfModel) {
     noteBox.add(noteToSelfModel);
  }





  void removeTask(String id) {
    final index = noteBox.values.toList().indexWhere((e) => e.id == id);
    if (index != -1) {
      noteBox.deleteAt(index);
    }
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
  void updateTask(NoteToSelfModel noteToSelModel) {
    final index = noteBox.values.toList().indexWhere(
          (e) => e.id == noteToSelModel.id,
    );
    if (index != -1) {
      noteBox.putAt(index, noteToSelModel);
    }
  }




  List<MedicineReminderModel> get loadMedicine {
    return reminderBox.values.toList();
  }

  List<NoteToSelfModel> get loadNote {
    return noteBox.values.toList();
  }

  List<AppointmentModel> get loadAppointment {
    return appointmentBox.values.toList();
  }

  UserModel? get loadProfile {
    log(profileBox.get('profile').toString());
    return profileBox.get('profile');
  }

}

