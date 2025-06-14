import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note_to_self_model.g.dart';

@HiveType(typeId: 8)
class NoteToSelfModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String subtitle;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  DateTime? noteDate;


  NoteToSelfModel({
    required this.noteDate,
    String? id,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();

  NoteToSelfModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    bool? isCompleted,
    DateTime? noteDate
  }) {
    return NoteToSelfModel(
      noteDate: noteDate ?? this.noteDate,
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
