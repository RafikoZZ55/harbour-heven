import 'dart:math';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';

class Quarry extends Generator{
  Quarry({int? level}):
  super(
    level: level ?? 1,
    type: BuildingType.quarry,
    description: "Quarry lets you generate stone passively even if you`re offline, upgrading it will incricce mount of recources generated per cycle",
    recourcetype: ResourceType.stone,
    price: <ResourceType,int>{ResourceType.fish: 15}
  );

    @override
  Map<ResourceType, int> calculateRecourcesPerCycle() {
    return {ResourceType.stone: 2 * level};
  }

  @override
  Map<ResourceType, int> upgradeCost() {
    Map<ResourceType,int> cost = {
      ResourceType.wood: 200 + 5 * pow(2, level).toInt(),
      ResourceType.fish: (10 + 2.5 * pow(2, level)).toInt(),
      ResourceType.gold: (15 + 5 * pow(level,2)).toInt()
    };
    return cost;
  }

}