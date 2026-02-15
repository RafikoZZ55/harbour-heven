part of '../player.dart';

extension PlayerBuildingOperator on Player {
 void upgradeBuilding({required int buildingIndex}) {
  Building building = buildings[buildingIndex];
  if(!hasEnoughRecources(recources: building.upgradeCost())) return;
  spendRecources(recources: building.upgradeCost());
  
  // Increment level on the building
  building.level++;
  
  // Create a new buildings list to trigger Riverpod change detection
  List<Building> newBuildings = List.from(buildings);
  buildings = newBuildings;
 }

 int buildingLevel({required BuildingType buildingType}) {
  return buildings.firstWhere((b) => b.type == buildingType).level;
}

}