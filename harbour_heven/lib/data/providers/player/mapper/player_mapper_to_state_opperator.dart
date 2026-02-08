part of 'player_mapper.dart';

extension PlayerMapperToStateOpperator on PlayerMapper{

  Map<String,int> _convertVoyageShips({required Map<VoyageShipType,int> voyageShips}){
    Map<String,int> voyageShipsState = {};
    for(VoyageShipType voyageShipType in voyageShips.keys) {voyageShipsState[voyageShipType.name] = (voyageShips[voyageShipType] ?? 0);}
    return voyageShipsState;
  }

  Map<String, int> _convertRecources({required Map<ResourceType, int> recources}) {
    Map<String,int> recourcesState = {};
    for(ResourceType recourceType in recources.keys) {recourcesState[recourceType.name] =  (recources[recourceType] ?? 0);}
    return recourcesState;
  }

  VoyageState _convertVoyage({required Voyage voyage}){
    return VoyageState(
      type: voyage.type.name, 
      difficulty: voyage.difficulty.name, 
      resources: _convertRecources(recources: voyage.recources), 
      successThreshold: voyage.successThreshold
    );
  }

  OfferState _convertOffer({required Offer offer}){
    return OfferState(
      type: offer.type.name, 
      reward: _convertRecources(recources: offer.reward), 
      price: _convertRecources(recources: offer.price), 
      isCompleted: offer.isCompleted, 
      maxHaggleGain: offer.maxHaggleGain, 
      canHaggle: offer.canHaggle, 
      patience: offer.patience
    );
  }

  BuildingState _convertBuilding({required Building building}){
    BuildingState buildingState;

    switch(building.type){

      case BuildingType.voyagePort:
      VoyagePort voyagePort = building as VoyagePort;
      buildingState = BuildingState(
        level: voyagePort.level, 
        type: voyagePort.type.name,
        currentVoyages: voyagePort.currentVoyages.map((voyage) => _convertVoyage(voyage: voyage)).toList(),
        nextRefreshAt: voyagePort.nextRefreshAt,
        voyageShips: _convertVoyageShips(voyageShips: voyagePort.voyageShips),
      );
      break;

      case BuildingType.tradingPort:
      TradingPort tradingPort = building as TradingPort;
      buildingState = BuildingState(
        level: tradingPort.level, 
        type: tradingPort.type.name,
        reputation: tradingPort.reputation,
        nextRefreshAt: tradingPort.nextRefreshAt,
        currentOffers: tradingPort.currentOffers.map((offer) => _convertOffer(offer: offer)).toList(),
      );
      break;

      default:
      buildingState = BuildingState(
        level: building.level, 
        type: building.type.name,
      );
      break;

    }

    return buildingState;
  }
}