import 'package:harbour_heven/data/hive/building_state.dart';
import 'package:hive_flutter/adapters.dart';

part 'generated/player_state.g.dart';

@HiveType(typeId: 0)
class PlayerState {
  
  @HiveField(0)
  Map<String,BuildingState> buildings;

  @HiveField(1)
  Map<String, int> recources;

  PlayerState({required this.buildings, required this.recources});
}