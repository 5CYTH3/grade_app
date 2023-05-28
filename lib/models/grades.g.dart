// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grades.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GradesAdapter extends TypeAdapter<Grades> {
  @override
  final int typeId = 2;

  @override
  Grades read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Grades(
      grade: fields[0] as double,
      coefficient: fields[1] as double,
      denominator: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Grades obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.grade)
      ..writeByte(1)
      ..write(obj.coefficient)
      ..writeByte(2)
      ..write(obj.denominator);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
