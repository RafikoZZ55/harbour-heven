// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../voyage_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VoyageStateAdapter extends TypeAdapter<VoyageState> {
  @override
  final int typeId = 3;

  @override
  VoyageState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VoyageState(
      type: fields[0] as String,
      difficulty: fields[1] as String,
      recources: (fields[2] as Map).cast<String, int>(),
      successThreshold: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, VoyageState obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.difficulty)
      ..writeByte(2)
      ..write(obj.recources)
      ..writeByte(3)
      ..write(obj.successThreshold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoyageStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
