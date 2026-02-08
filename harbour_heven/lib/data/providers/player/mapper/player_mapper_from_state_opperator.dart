part of 'player_mapper.dart';

extension PlayerMapperFromStateOpperator on PlayerMapper  {


  Map<VoyageShipType,int> _convertVoyageShipsState({required Map<String,int> voyageShipsState}){
    Map<VoyageShipType,int> ships = {};

    for(String voyageShipState in voyageShipsState.keys){
        if(!VoyageShipType.checkIfExists(voyageShipType: voyageShipState)) continue;
        VoyageShipType voyageShipType = VoyageShipType.get(voyageShipType: voyageShipState);
        ships[voyageShipType] = (ships[voyageShipType] ?? 0) + (voyageShipsState[voyageShipState] ?? 0);
    }

    return ships;
  }

  Offer? _convertOfferState({required OfferState offerState}){
    if(!OfferType.checkIfExists(offerType: offerState.type)) return null;
    OfferType offerType = OfferType.get(offerType: offerState.type);
    
    return Offer(
      type: offerType, 
      reward: _convertRecourcesState(recourcesState: offerState.reward), 
      price: _convertRecourcesState(recourcesState: offerState.price), 
      isCompleted: offerState.isCompleted, 
      maxHaggleGain: offerState.maxHaggleGain, 
      canHaggle: offerState.canHaggle, 
      patience: offerState.patience,
    );
  }

  Voyage? _convertVoyagState({required VoyageState voyageState}){
    if(!VoyageType.checkIfExists(voyageType: voyageState.type)) return null;
    if(!DifficultyType.checkIfExists(difficultyType: voyageState.difficulty)) return null;

    VoyageType voyageType = VoyageType.get(voyageType: voyageState.type);
    DifficultyType difficultyType = DifficultyType.get(difficultyType: voyageState.difficulty);

    return Voyage(
      type: voyageType, 
      difficulty: difficultyType, 
      recources: _convertRecourcesState(recourcesState: voyageState.resources), 
      successThreshold: voyageState.successThreshold,
    );
  }


  Map<ResourceType,int> _convertRecourcesState({required Map<String,int> recourcesState}){
    Map<ResourceType,int> recources = {};

    for(String recourceState in recourcesState.keys){
      if(!ResourceType.checkIfExists(recourceType: recourceState)) continue;
      ResourceType recourceType = ResourceType.get(recourceType: recourceState);
      recources[recourceType] = recourcesState[recourceState] ?? 0;
    }
  
    return recources;
  }

  Building? _convertBuildingState({required BuildingState buildingState}){ 
    if(!BuildingType.checkIfExists(buildingType: buildingState.type)) return null;
    BuildingType buildingType = BuildingType.get(buildingType: buildingState.type);
    Building building;

    switch(buildingType){
      case BuildingType.fishingDock: building = FishingDock(level: buildingState.level); break;
      case BuildingType.quarry: building = Quarry(level: buildingState.level); break;
      case BuildingType.sawmill: building = Sawmill(level: buildingState.level); break;
      case BuildingType.tawern: building = Tawern(level: buildingState.level); break;
      case BuildingType.tradingPort: building = TradingPort(
        level: buildingState.level, 
        reputation: buildingState.reputation ?? 0.5, 
        nextRefreshAt: buildingState.nextRefreshAt,
        currentOffers: buildingState.currentOffers!.map((offerState) => _convertOfferState(offerState: offerState)).whereType<Offer>().toList(),
      );
      break;
      case BuildingType.voyagePort: building = VoyagePort(
        level: buildingState.level,
        voyageShips: _convertVoyageShipsState(voyageShipsState: buildingState.voyageShips ?? {}),
        nextRefreshAt: buildingState.nextRefreshAt,
        currentVoyages: buildingState.currentVoyages!.map((voyageState) => _convertVoyagState(voyageState: voyageState)).whereType<Voyage>().toList(),
      );
      break;
    }

    return building;
  }

}