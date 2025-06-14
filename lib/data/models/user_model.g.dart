// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 9;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      specialization: fields[18] as String?,
      role: fields[0] as RoleEnum,
      uid: fields[1] as String,
      fullName: fields[2] as String,
      email: fields[3] as String,
      phoneNumber: fields[4] as String,
      isOnline: fields[5] as bool,
      lastSeen: fields[6] as Timestamp?,
      createdAt: fields[7] as Timestamp?,
      fcmToken: fields[8] as String?,
      blockedUsers: (fields[9] as List).cast<String>(),
      age: fields[10] as int?,
      disease: fields[11] as String?,
      bloodType: fields[12] as BloodTypeEnum?,
      gender: fields[13] as GenderEnum?,
      weight: fields[14] as int?,
      imagePath: fields[15] as String?,
      height: fields[16] as int?,
      location: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.role)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.isOnline)
      ..writeByte(6)
      ..write(obj.lastSeen)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.fcmToken)
      ..writeByte(9)
      ..write(obj.blockedUsers)
      ..writeByte(10)
      ..write(obj.age)
      ..writeByte(11)
      ..write(obj.disease)
      ..writeByte(12)
      ..write(obj.bloodType)
      ..writeByte(13)
      ..write(obj.gender)
      ..writeByte(14)
      ..write(obj.weight)
      ..writeByte(15)
      ..write(obj.imagePath)
      ..writeByte(16)
      ..write(obj.height)
      ..writeByte(17)
      ..write(obj.location)
      ..writeByte(18)
      ..write(obj.specialization);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
