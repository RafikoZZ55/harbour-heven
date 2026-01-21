import 'package:hive_flutter/hive_flutter.dart';
import 'package:harbour_heven/data/hive/building_state.dart';

part 'generated/player_state.g.dart';

@HiveType(typeId: 0)
class PlayerState {
  @HiveField(0)
  List<BuildingState> buildings;

  @HiveField(1)
  Map<String, int> recources;

  @HiveField(2)
  DateTime lastInteractionTimeStamp;

  PlayerState({
    required this.buildings,
    required this.recources,
    required this.lastInteractionTimeStamp,
  });
}
