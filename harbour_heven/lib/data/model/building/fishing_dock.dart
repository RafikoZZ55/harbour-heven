

import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class FishingDock extends Generator {
  FishingDock({int? level}):
  assert((level ?? 1) >=1,"level must be bigger or equal to one"),
  super(
    level: level ?? 1, 
    type: BuildingType.fishingDock,
    description: "basic description for a fishing dock",
    price: <RecourceType,int>{RecourceType.fish: 10},
    recourcetype: RecourceType.fish
  );

  @override
  Map<RecourceType, double> generateRecources() {
    // TODO: implement generateRecources
    throw UnimplementedError();
  }

  @override
  Map<RecourceType, int> upgradeCost() {
    // TODO: implement upgradeCost
    throw UnimplementedError();
  }

}