import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/player/operators/player_recources_operator.dart';
import 'package:harbour_heven/data/model/player/player.dart';

extension PlayerBuildingOperator on Player {
 void upgradeBuilding({required BuildingType buildingType}) {
  Building building = buildings[buildingType] as Building;
  if(!hasEnoughRecources(recources: building.price)) return;
  
  spendRecources(recources: building.price);
  building.level++;
 }

 int buildingLevel({required BuildingType buildingType}) {
  return buildings[buildingType]!.level;
}

}