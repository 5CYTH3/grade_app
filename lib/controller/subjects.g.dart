// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjects.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectsAdapter extends TypeAdapter<Subjects> {
  @override
  final int typeId = 1;

  @override
  Subjects read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subjects(
      name: fields[0] as String,
      grades: (fields[1] as List).cast<Grades>(),
      coefficient: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Subjects obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.grades)
      ..writeByte(2)
      ..write(obj.coefficient);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
