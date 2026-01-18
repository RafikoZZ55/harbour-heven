

import 'dart:math';

import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class Sawmill extends Generator {
  Sawmill({int? level}):
  super(
    level: level ?? 1,
    type: BuildingType.sawmill,
    description: "Place where you cut wood",
    recourcetype: RecourceType.wood,
    price: <RecourceType,int>{}
  );



  @override
  Map<RecourceType, int> calculateRecourcesPerCycle() {
    return {RecourceType.wood: 2 * level};
  }

  @override
  Map<RecourceType, int> upgradeCost() {
    Map<RecourceType,int> cost = {
      RecourceType.stone: 200 + 5 * pow(2, level).toInt(),
      RecourceType.fish: (150 + 2.5 * pow(2, level)).toInt(),
    };
    return cost;
  }

}