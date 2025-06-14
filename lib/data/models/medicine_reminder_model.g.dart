
part of 'medicine_reminder_model.dart';

class MedicineReminderModelAdapter extends TypeAdapter<MedicineReminderModel> {
  @override
  final int typeId = 0;

  @override
  MedicineReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicineReminderModel(
      id: fields[0] as String?,
      selectMedicine: fields[5] as SelectMedicine,
      medicineName: fields[1] as String,
      dose: fields[2] as int,
      type: fields[3] as TypeEnum,
      medicineDate: fields[4] as DateTime,
      comments: fields[6] as String,
      isCompleted: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineReminderModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.medicineName)
      ..writeByte(2)
      ..write(obj.dose)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.medicineDate)
      ..writeByte(5)
      ..write(obj.selectMedicine)
      ..writeByte(6)
      ..write(obj.comments)
      ..writeByte(7)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
