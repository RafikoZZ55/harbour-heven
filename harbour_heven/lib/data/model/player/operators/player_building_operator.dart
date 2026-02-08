part of '../player.dart';

extension PlayerBuildingOperator on Player {
 void upgradeBuilding({required int buildingIndex}) {
  Building building = buildings[buildingIndex];
  if(!hasEnoughRecources(recources: building.upgradeCost())) return;
  spendRecources(recources: building.upgradeCost());
  building.level++;
 }

 int buildingLevel({required BuildingType buildingType}) {
  return buildings.firstWhere((b) => b.type == buildingType).level;
}

}