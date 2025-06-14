// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppointmentModelAdapter extends TypeAdapter<AppointmentModel> {
  @override
  final int typeId = 3;

  @override
  AppointmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentModel(
      doktorRef: fields[8] as DocumentReference<Object>,
      userModel: fields[6] as UserModel?,
      doktorModel: fields[5] as UserModel?,
      id: fields[0] as String?,
      doctorName: fields[1] as String,
      appointmentDate: fields[2] as DateTime,
      categoryEnum: fields[3] as CategoryEnum,
      userRef: fields[4] as DocumentReference<Object>,
      appointmentStateEnum: fields[7] as AppointmentStateEnum,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.doctorName)
      ..writeByte(2)
      ..write(obj.appointmentDate)
      ..writeByte(3)
      ..write(obj.categoryEnum)
      ..writeByte(4)
      ..write(obj.userRef)
      ..writeByte(5)
      ..write(obj.doktorModel)
      ..writeByte(6)
      ..write(obj.userModel)
      ..writeByte(7)
      ..write(obj.appointmentStateEnum)
      ..writeByte(8)
      ..write(obj.doktorRef);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
