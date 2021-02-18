// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smartphone.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SmartphoneAdapter extends TypeAdapter<Smartphone> {
  @override
  final int typeId = 1;

  @override
  Smartphone read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Smartphone()
      .._id = fields[0] as String
      .._model = fields[1] as String
      .._brand = fields[2] as String
      .._price = fields[3] as double
      .._imagePath = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Smartphone obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._model)
      ..writeByte(2)
      ..write(obj._brand)
      ..writeByte(3)
      ..write(obj._price)
      ..writeByte(4)
      ..write(obj._imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SmartphoneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
