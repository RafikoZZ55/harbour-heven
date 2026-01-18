import 'dart:math';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class Quarry extends Generator{
  Quarry({int? level}):
  super(
    level: level ?? 1,
    type: BuildingType.quarry,
    description: "a stone quarry that generates stone",
    recourcetype: RecourceType.stone,
    price: <RecourceType,int>{RecourceType.fish: 15}
  );

    @override
  Map<RecourceType, int> calculateRecourcesPerCycle() {
    return {RecourceType.stone: 2 * level};
  }

  @override
  Map<RecourceType, int> upgradeCost() {
    Map<RecourceType,int> cost = {
      RecourceType.wood: 200 + 5 * pow(2, level).toInt(),
      RecourceType.fish: (10 + 2.5 * pow(2, level)).toInt(),
      RecourceType.gold: (15 + 5 * pow(level,2)).toInt()
    };
    return cost;
  }

}