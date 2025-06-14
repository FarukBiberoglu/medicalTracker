// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenderEnumAdapter extends TypeAdapter<GenderEnum> {
  @override
  final int typeId = 7;

  @override
  GenderEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GenderEnum.Male;
      case 1:
        return GenderEnum.Female;
      default:
        return GenderEnum.Male;
    }
  }

  @override
  void write(BinaryWriter writer, GenderEnum obj) {
    switch (obj) {
      case GenderEnum.Male:
        writer.writeByte(0);
        break;
      case GenderEnum.Female:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenderEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
