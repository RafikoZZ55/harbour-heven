
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class Tawern extends Building {
  Tawern({int? level}):
  super(
    level: level ?? 1,
    description: "Increses capacity and lets you get progers",
    type: BuildingType.tawern,
    price: <Recourcetype,int>{}
  );


  @override
  Map<Recourcetype, int> upgradeCost() {
    // TODO: implement upgradeCost
    throw UnimplementedError();
  }

}