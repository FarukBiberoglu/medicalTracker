import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled19/core/cache/hive_cache_service.dart';
import 'package:untitled19/core/extension/date_time_extension.dart';
import 'package:untitled19/data/models/note_to_self_model.dart';
import 'package:untitled19/data/service/service_locator.dart';
import '../../../../core/router/app_router.dart';
import '../../../../data/service/appointment_service.dart';
import '../../../authentication/cubit/auth/auth_cubit.dart';
import 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {

  HomeCubit() : super(HomeCubitState(notes: [])) {
    final loadedNotes = getIt.get<HiveCacheService>().loadNote;

    getIt
        .get<AppointmentService>()
        .getDoctor(
      getIt<AppRouter>()
          .navigatorKey
          .currentState!
          .context
          .read<AuthCubit>()
          .state
          .user
          ?.uid ??
          '',
    )
        .then((value) {
      if (!isClosed) {
        emit(
          state.copyWith(
            randevuModel: ()=>value
                .where((e) => e.appointmentDate.isSameDay(DateTime.now()))
                .toList(),
          ),
        );
      }
    });

    emit(state.copyWith(notes: loadedNotes));
  }




  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController tasktDateController = TextEditingController();
  final TextEditingController searchController = TextEditingController();


  Future<void> fetchDoctorAppointments(String uid) async {
    final result = await AppointmentService().getDoctor(uid);
    if (!isClosed) {
      emit(state.copyWith(randevuModel: () => result));
    }
  }

  void onChangedSearchController(String value) {
    emit(state.copyWith(search: value));
  }

  void onChangedTaskDate(DateTime value) {
    tasktDateController.text = DateFormat("dd.MM.yyyy").format(value);
    emit(state.copyWith(taskDate:() => value));
  }


  void removeNoteAt(int index) {
    final updatedNotes = List<NoteToSelfModel>.from(state.notes)..removeAt(index);
    emit(state.copyWith(notes: updatedNotes));
  }

  void titleField(String value) {
    emit(state.copyWith(title: value));
  }
  void subtitle(String value) {
    emit(state.copyWith(subtitle: value));
  }
  void deleteTask(NoteToSelfModel note) {
    final updatedList = List<NoteToSelfModel>.from(state.notes)..remove(note);
    getIt.get<HiveCacheService>().removeTask(note.id);
    emit(state.copyWith(
      notes: updatedList,
    ));
  }

  void completeNote(NoteToSelfModel note){
    final int index =  state.notes.indexOf(note);
    final updatedList = List<NoteToSelfModel>.from(state.notes)..remove(note)..insert(index, note.copyWith(isCompleted: !note.isCompleted) );
    getIt.get<HiveCacheService>().updateTask(note.copyWith(isCompleted: !note.isCompleted));
    emit(state.copyWith(
      notes: updatedList,

    ));
  }

  void addNotes() {
    final newModel = NoteToSelfModel(
      title: state.title ?? '',
      subtitle: state.subtitle ??'',
      noteDate: state.taskDate ?? DateTime.now(),


    );

    getIt.get<HiveCacheService>().saveTask(newModel);
    final updatedList = [...state.notes, newModel];

    emit(state.copyWith(
      notes: updatedList,
      title: null,
      subtitle: null,
    ));


    subtitleController.clear();
    titleController.clear();
    tasktDateController.clear();


  }
  void resetValues() {
    emit(state.copyWith(
      title: null,
      subtitle: null,
    ));
    titleController.clear();
    subtitleController.clear();

  }


}
