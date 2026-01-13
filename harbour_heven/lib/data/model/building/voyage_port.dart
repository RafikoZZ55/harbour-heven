
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class VoyagePort extends Building {
  VoyagePort({int? level}):
  super(
    level: level ?? 1,
    type: BuildingType.voyagePort,
    description: "a port for voyage",
    price: <Recourcetype,int>{}
  );
  
  @override
  Map<Recourcetype, int> upgradeCost() {
    // TODO: implement upgradeCost
    throw UnimplementedError();
  }
  
}