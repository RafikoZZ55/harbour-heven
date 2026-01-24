import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/building/fishing_dock.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/building/quarry.dart';
import 'package:harbour_heven/data/model/building/sawmill.dart';
import 'package:harbour_heven/data/model/building/tawern.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/difficulty_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/model/voyage/voyage.dart';
import 'package:harbour_heven/data/model/barghter/offer.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/model/enum/offer_type.dart';
import 'dart:math';

part 'operators/player_building_operator.dart';
part 'operators/player_offer_operator.dart';
part 'operators/player_recources_operator.dart';
part 'operators/player_voyage_operator.dart';

class Player {
  List<Building> buildings;
  Map<RecourceType, int> recources;
  int lastTickAt;

  Player({
    required this.buildings, 
    required this.recources,
    required this.lastTickAt,
  });

  Player copyWith({
    List<Building>? buildings,
    Map<RecourceType, int>? recources,
    int? lastInteractionTimeStamp,
    int? lastTickAt,
  }) {
    return Player(
      buildings: buildings ?? this.buildings, 
      recources: recources ?? this.recources,
      lastTickAt: lastTickAt ?? this.lastTickAt
    );
  }

  static Player empty(){
    Player player = Player(
    buildings: [
      FishingDock(level: 1),
      Quarry(level: 1),
      Sawmill(level: 1),
      Tawern(level: 1),
      TradingPort(reputation: 0.5, level: 1),
      VoyagePort(level: 1),
    ],
    recources: {},
    lastTickAt: 0,
    );

    for(RecourceType recourceType in RecourceType.values) {player.recources[recourceType] = 0;}
    for(VoyageShipType voyageShipType in VoyageShipType.values) {player.buildings.whereType<VoyagePort>().first.voyageShips[voyageShipType] = 0;}

    return player;
  }


  Random get _random => Random();

}