// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../offer_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfferStateAdapter extends TypeAdapter<OfferState> {
  @override
  final int typeId = 2;

  @override
  OfferState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfferState(
      type: fields[0] as String,
      reward: (fields[1] as Map).cast<String, int>(),
      price: (fields[2] as Map).cast<String, int>(),
      isCompleted: fields[3] as bool,
      maxHaggleGain: fields[5] as int,
      canHaggle: fields[4] as bool,
      patience: fields[6] as double,
      isFailed: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, OfferState obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.reward)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.canHaggle)
      ..writeByte(5)
      ..write(obj.maxHaggleGain)
      ..writeByte(6)
      ..write(obj.patience)
      ..writeByte(7)
      ..write(obj.isFailed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfferStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
