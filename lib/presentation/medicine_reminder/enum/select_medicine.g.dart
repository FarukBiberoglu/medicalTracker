// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_medicine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectMedicineAdapter extends TypeAdapter<SelectMedicine> {
  @override
  final int typeId = 2;

  @override
  SelectMedicine read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SelectMedicine.pills;
      case 1:
        return SelectMedicine.eyedrops;
      case 2:
        return SelectMedicine.liguid;
      case 3:
        return SelectMedicine.capcule;
      default:
        return SelectMedicine.pills;
    }
  }

  @override
  void write(BinaryWriter writer, SelectMedicine obj) {
    switch (obj) {
      case SelectMedicine.pills:
        writer.writeByte(0);
        break;
      case SelectMedicine.eyedrops:
        writer.writeByte(1);
        break;
      case SelectMedicine.liguid:
        writer.writeByte(2);
        break;
      case SelectMedicine.capcule:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectMedicineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
