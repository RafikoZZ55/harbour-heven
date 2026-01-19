// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../player_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerStateAdapter extends TypeAdapter<PlayerState> {
  @override
  final int typeId = 0;

  @override
  PlayerState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayerState(
      buildings: (fields[0] as Map).cast<String, BuildingState>(),
      recources: (fields[1] as Map).cast<String, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayerState obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.buildings)
      ..writeByte(1)
      ..write(obj.recources);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
