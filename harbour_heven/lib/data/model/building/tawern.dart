
import 'dart:math';

import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';

class Tawern extends Building {
  Tawern({int? level}):
  super(
    level: level ?? 1,
    description: "Taver incricces capacity of storage and letts you progres the game by making offers and voyages more valueble but olso more dangerous, olso increcces amount of recource generated iin produce tab",
    type: BuildingType.tawern,
    price: <ResourceType,int>{}
  );


  @override
  Map<ResourceType, int> upgradeCost() {
    Map<ResourceType,int> cost = {
      ResourceType.stone: (200 + 5.25 * pow(2, level)).toInt(),
      ResourceType.wood: (200 + 5.25 * pow(2, level)).toInt(),
      ResourceType.fish: (200 + 5.25 * pow(2, level)).toInt(),
      ResourceType.gold: (pow(2,level + 1) + 25 * level).toInt()
    };
    return cost;
  }

}