
enum BuildingType {
  tawern,
  tradingPort,
  sawmill,
  quarry,
  fishingDock,
  voyagePort;


  static bool checkIfExists({required String buildingType}){
    return BuildingType.values.any((e) => e.name == buildingType);
  }

  static BuildingType get({required String buildingType}){
    return BuildingType.values.singleWhere((e) => e.name == buildingType);
  }
}

