

import 'dart:math';

import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';

class Sawmill extends Generator {
  Sawmill({int? level}):
  super(
    level: level ?? 1,
    type: BuildingType.sawmill,
    description: "Cuts timber passively, even while away. Higher levels boost production.",
    recourcetype: ResourceType.wood,
    price: <ResourceType,int>{}
  );



  @override
  Map<ResourceType, int> calculateRecourcesPerCycle() {
    return {ResourceType.wood: 2 * level};
  }

  @override
  Map<ResourceType, int> upgradeCost() {
    Map<ResourceType,int> cost = {
      ResourceType.stone: 200 + 5 * pow(2, level).toInt(),
      ResourceType.fish: (150 + 2.5 * pow(2, level)).toInt(),
    };
    return cost;
  }

}