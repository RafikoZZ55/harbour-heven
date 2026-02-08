
import 'dart:math';

import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';
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
  nextRefreshAt = nextRefreshAt ?? DateTime.now().millisecondsSinceEpoch + 1000,
  super(
    level: level ?? 1,
    type: BuildingType.voyagePort,
    description: "a port for voyage",
    price: <ResourceType,int>{}
  );
  
  @override
  Map<ResourceType, int> upgradeCost() {
    Map<ResourceType,int> cost = {
      ResourceType.stone: (200 + 2.5 * pow(2, level)).toInt(),
      ResourceType.wood: (200 + 2.5 * pow(2, level)).toInt(),
      ResourceType.fish: (200 + 2.5 * pow(2, level)).toInt(),
      ResourceType.gold: (15 * level + 5 * pow(level,2)).toInt()
    };
    return cost;
  }
  
}