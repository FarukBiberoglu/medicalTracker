// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeEnumAdapter extends TypeAdapter<TypeEnum> {
  @override
  final int typeId = 1;

  @override
  TypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeEnum.Tabs;
      case 1:
        return TypeEnum.Piece;
      case 2:
        return TypeEnum.Mg;
      case 3:
        return TypeEnum.Gr;
      default:
        return TypeEnum.Tabs;
    }
  }

  @override
  void write(BinaryWriter writer, TypeEnum obj) {
    switch (obj) {
      case TypeEnum.Tabs:
        writer.writeByte(0);
        break;
      case TypeEnum.Piece:
        writer.writeByte(1);
        break;
      case TypeEnum.Mg:
        writer.writeByte(2);
        break;
      case TypeEnum.Gr:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
