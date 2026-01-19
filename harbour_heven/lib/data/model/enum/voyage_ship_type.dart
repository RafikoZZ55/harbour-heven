enum VoyageShipType {
  lightShip,
  heavyShip,
  barteringShip;

  static bool checkIfExists({required String voyageShipType}){
    return VoyageShipType.values.any((e) => e.name == voyageShipType);
  }

  VoyageShipType get({required String voyageShipType}){
    return VoyageShipType.values.singleWhere((e) => e.name == voyageShipType);
  }  
}