import 'dart:math';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class FishingDock extends Generator {
  FishingDock({int? level}):
  super(
    level: level ?? 1, 
    type: BuildingType.fishingDock,
    description: "basic description for a fishing dock",
    price: <RecourceType,int>{RecourceType.fish: 10},
    recourcetype: RecourceType.fish
  );

  @override
  Map<RecourceType, int> calculateRecourcesPerCycle() {
    return {RecourceType.fish: 2 * level};
  }

  @override
  Map<RecourceType, int> upgradeCost() {
    Map<RecourceType,int> cost = {
      RecourceType.stone: (10 + 2.5 * pow(2, level)).toInt(),
      RecourceType.wood: 200 + 5 * pow(2, level).toInt()
    };
    return cost;
  }
  

}