
part of 'note_to_self_model.dart';

class NoteToSelfModelAdapter extends TypeAdapter<NoteToSelfModel> {
  @override
  final int typeId = 8;

  @override
  NoteToSelfModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteToSelfModel(
      noteDate: fields[4] as DateTime?,
      id: fields[0] as String?,
      title: fields[1] as String,
      subtitle: fields[2] as String,
      isCompleted: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NoteToSelfModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.noteDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteToSelfModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
