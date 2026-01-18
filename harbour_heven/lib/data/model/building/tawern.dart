
import 'dart:math';

import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class Tawern extends Building {
  Tawern({int? level}):
  super(
    level: level ?? 1,
    description: "Increses capacity and lets you get progers",
    type: BuildingType.tawern,
    price: <RecourceType,int>{}
  );


  @override
  Map<RecourceType, int> upgradeCost() {
    Map<RecourceType,int> cost = {
      RecourceType.stone: (200 + 5.25 * pow(2, level)).toInt(),
      RecourceType.wood: (200 + 5.25 * pow(2, level)).toInt(),
      RecourceType.fish: (200 + 5.25 * pow(2, level)).toInt(),
      RecourceType.gold: (pow(2,level + 1) + 25 * level).toInt()
    };
    return cost;
  }

}