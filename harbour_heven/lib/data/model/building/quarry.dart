import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class Quarry extends Generator{
  Quarry({int? level}):
  assert((level ?? 1) >= 1,"level must be biggaror equal to 1"),
  super(
    level: level ?? 1,
    type: BuildingType.quarry,
    description: "a stone quarry that generates stone",
    recourcetype: RecourceType.stone,
    price: <RecourceType,int>{RecourceType.fish: 15}
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