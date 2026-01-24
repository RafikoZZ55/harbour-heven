
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

  static List<BuildingType> generators(){
    return [
      BuildingType.quarry,
      BuildingType.sawmill,
      BuildingType.fishingDock,
    ];
  }

  static List<BuildingType> special(){
    return [
      BuildingType.tawern
    ];
  }

  static List<BuildingType> buildings(){
    return [
      BuildingType.tradingPort,
      BuildingType.voyagePort,
    ];
  }
}

