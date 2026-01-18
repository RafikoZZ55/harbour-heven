
import 'package:harbour_heven/data/hive_model/exeption_buildings/voyage_port_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class BuildingState {
  @HiveField(0)
  int level;

  @HiveField(1)
  VoyagePortState? voyagePortState;

  BuildingState({required this.level, this.voyagePortState});
}