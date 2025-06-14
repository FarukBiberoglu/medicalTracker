// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodTypeEnumAdapter extends TypeAdapter<BloodTypeEnum> {
  @override
  final int typeId = 6;

  @override
  BloodTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BloodTypeEnum.APositive;
      case 1:
        return BloodTypeEnum.ANegative;
      case 2:
        return BloodTypeEnum.BPositive;
      case 3:
        return BloodTypeEnum.BNegative;
      case 4:
        return BloodTypeEnum.ABPositive;
      case 5:
        return BloodTypeEnum.ABNegative;
      case 6:
        return BloodTypeEnum.OPositive;
      case 7:
        return BloodTypeEnum.ONegative;
      default:
        return BloodTypeEnum.APositive;
    }
  }

  @override
  void write(BinaryWriter writer, BloodTypeEnum obj) {
    switch (obj) {
      case BloodTypeEnum.APositive:
        writer.writeByte(0);
        break;
      case BloodTypeEnum.ANegative:
        writer.writeByte(1);
        break;
      case BloodTypeEnum.BPositive:
        writer.writeByte(2);
        break;
      case BloodTypeEnum.BNegative:
        writer.writeByte(3);
        break;
      case BloodTypeEnum.ABPositive:
        writer.writeByte(4);
        break;
      case BloodTypeEnum.ABNegative:
        writer.writeByte(5);
        break;
      case BloodTypeEnum.OPositive:
        writer.writeByte(6);
        break;
      case BloodTypeEnum.ONegative:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
