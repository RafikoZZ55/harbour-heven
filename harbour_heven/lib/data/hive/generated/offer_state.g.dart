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
      type: fields[1] as String,
      reward: (fields[2] as Map).cast<String, int>(),
      price: (fields[3] as Map).cast<String, int>(),
      isCompleted: fields[4] as bool,
      maxHaggleGain: fields[6] as int,
      canHaggle: fields[5] as bool,
      patience: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, OfferState obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.reward)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.isCompleted)
      ..writeByte(5)
      ..write(obj.canHaggle)
      ..writeByte(6)
      ..write(obj.maxHaggleGain)
      ..writeByte(7)
      ..write(obj.patience);
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
