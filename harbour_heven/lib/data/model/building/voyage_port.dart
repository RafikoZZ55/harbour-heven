
import 'dart:math';

import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/voyage/voyage.dart';

class VoyagePort extends Building {
  List<Voyage> currentVoyages;
  Map<VoyageShipType, int> voyageShips;
  int nextRefreshAt;


  VoyagePort({int? level, Map<VoyageShipType, int>? voyageShips, List<Voyage>? currentVoyages, int? nextRefreshAt}):
  voyageShips = {
    VoyageShipType.barteringShip: voyageShips?[VoyageShipType.barteringShip] ?? 0,
    VoyageShipType.heavyShip: voyageShips?[VoyageShipType.heavyShip] ?? 0,
    VoyageShipType.lightShip: voyageShips?[VoyageShipType.lightShip] ?? 0
  },
  currentVoyages = currentVoyages ?? [],
  nextRefreshAt = nextRefreshAt ?? 0,
  super(
    level: level ?? 1,
    type: BuildingType.voyagePort,
    description: "a port for voyage",
    price: <RecourceType,int>{}
  );
  
  @override
  Map<RecourceType, int> upgradeCost() {
    Map<RecourceType,int> cost = {
      RecourceType.stone: (200 + 2.5 * pow(2, level)).toInt(),
      RecourceType.wood: (200 + 2.5 * pow(2, level)).toInt(),
      RecourceType.fish: (200 + 2.5 * pow(2, level)).toInt(),
      RecourceType.gold: (15 * level + 5 * pow(level,2)).toInt()
    };
    return cost;
  }
  
}