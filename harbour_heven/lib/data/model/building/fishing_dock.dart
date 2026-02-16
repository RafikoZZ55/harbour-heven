import 'dart:math';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';

class FishingDock extends Generator {
  FishingDock({int? level}):
  super(
    level: level ?? 1, 
    type: BuildingType.fishingDock,
    description: "Produces fish passively, even while away. Higher levels boost production.",
    price: <ResourceType,int>{ResourceType.fish: 10},
    recourcetype: ResourceType.fish
  );

  @override
  Map<ResourceType, int> calculateRecourcesPerCycle() {
    return {ResourceType.fish: 2 * level};
  }

  @override
  Map<ResourceType, int> upgradeCost() {
    Map<ResourceType,int> cost = {
      ResourceType.stone: (10 + 2.5 * pow(2, level)).toInt(),
      ResourceType.wood: 200 + 5 * pow(2, level).toInt()
    };
    return cost;
  }
  
  

}