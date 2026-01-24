import 'package:harbour_heven/data/hive/player_state.dart';
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/hive/building_state.dart';
import 'package:harbour_heven/data/hive/offer_state.dart';
import 'package:harbour_heven/data/hive/voyage_state.dart';
import 'package:harbour_heven/data/model/barghter/offer.dart';
import 'package:harbour_heven/data/model/building/fishing_dock.dart';
import 'package:harbour_heven/data/model/building/quarry.dart';
import 'package:harbour_heven/data/model/building/sawmill.dart';
import 'package:harbour_heven/data/model/building/tawern.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/difficulty_type.dart';
import 'package:harbour_heven/data/model/enum/offer_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_type.dart';
import 'package:harbour_heven/data/model/voyage/voyage.dart';


part 'player_mapper_from_state_opperator.dart';
part 'player_mapper_to_state_opperator.dart';

class PlayerMapper {

  Player fromState({required PlayerState playerState}){
    return Player(
      buildings: playerState.buildings.map((buildingState) => _convertBuildingState(buildingState: buildingState)).whereType<Building>().toList(), 
      recources: _convertRecourcesState(recourcesState: playerState.recources),
      lastTickAt: playerState.lastTickAt,
    );
  }

  PlayerState toState({required Player player}){
    return PlayerState(
      buildings: player.buildings.map((building) => _convertBuilding(building: building)).whereType<BuildingState>().toList(), 
      recources: _convertRecources(recources: player.recources),
      lastTickAt: player.lastTickAt,
    );
  }
}