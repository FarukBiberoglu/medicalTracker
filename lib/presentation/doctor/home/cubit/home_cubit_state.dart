import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:untitled19/data/models/note_to_self_model.dart';

import '../../../../data/models/appointment_model.dart';

class HomeCubitState extends Equatable {
  final List<NoteToSelfModel> notes;
  final String? title;
  final String? subtitle;
  final DateTime? taskDate;
  final String search;
  final List<AppointmentModel>? randevuModel;


  const HomeCubitState({
    this.randevuModel,
    this.search='',
    this.taskDate,
    this.notes = const [],
    this.title,
    this.subtitle,
  });

  HomeCubitState copyWith({
    ValueGetter<List<AppointmentModel>?>? randevuModel  ,
    String? search,
    List<NoteToSelfModel>? notes,
    String? title,
    String? subtitle,
    ValueGetter<DateTime?>? taskDate,
  }) {
    return HomeCubitState(
      randevuModel: randevuModel != null ? randevuModel() : this.randevuModel,
      search: search ?? this.search,
      notes: notes ?? this.notes,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      taskDate: taskDate != null ? taskDate() : this.taskDate,
    );
  }

  @override
  List<Object?> get props => [notes, title, subtitle,taskDate,search,randevuModel
  ];
}
