

import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/building/generator.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class Sawmill extends Generator {
  Sawmill({int? level}):
  super(
    level: level ?? 1,
    type: BuildingType.sawmill,
    description: "Place where you cut wood",
    recourcetype: Recourcetype.wood,
    price: <Recourcetype,int>{}
  );



  @override
  Map<Recourcetype, double> generateRecources() {
    // TODO: implement generateRecources
    throw UnimplementedError();
  }

  @override
  Map<Recourcetype, int> upgradeCost() {
    // TODO: implement upgradeCost
    throw UnimplementedError();
  }

}