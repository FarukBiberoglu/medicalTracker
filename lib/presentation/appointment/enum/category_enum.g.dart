// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryEnumAdapter extends TypeAdapter<CategoryEnum> {
  @override
  final int typeId = 4;

  @override
  CategoryEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CategoryEnum.upcoming;
      case 1:
        return CategoryEnum.completed;
      case 2:
        return CategoryEnum.canceled;
      default:
        return CategoryEnum.upcoming;
    }
  }

  @override
  void write(BinaryWriter writer, CategoryEnum obj) {
    switch (obj) {
      case CategoryEnum.upcoming:
        writer.writeByte(0);
        break;
      case CategoryEnum.completed:
        writer.writeByte(1);
        break;
      case CategoryEnum.canceled:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
