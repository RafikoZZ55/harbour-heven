part of '../player.dart';

extension PlayerBuildingOperator on Player {
 void upgradeBuilding({required BuildingType buildingType}) {
  Building building = buildings.firstWhere((b) => b.type == buildingType);
  if(!hasEnoughRecources(recources: building.price)) return;
  
  spendRecources(recources: building.price);
  building.level++;
 }

 int buildingLevel({required BuildingType buildingType}) {
  return buildings.firstWhere((b) => b.type == buildingType).level;
}

}