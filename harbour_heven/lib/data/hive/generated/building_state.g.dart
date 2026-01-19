// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../building_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuildingStateAdapter extends TypeAdapter<BuildingState> {
  @override
  final int typeId = 1;

  @override
  BuildingState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuildingState(
      level: fields[0] as int,
      currentVoyages: (fields[1] as List?)?.cast<VoyageState>(),
      voyageShips: (fields[2] as Map?)?.cast<String, int>(),
      currentOffers: (fields[4] as List?)?.cast<OfferState>(),
      reputation: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, BuildingState obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.currentVoyages)
      ..writeByte(2)
      ..write(obj.voyageShips)
      ..writeByte(3)
      ..write(obj.reputation)
      ..writeByte(4)
      ..write(obj.currentOffers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildingStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
