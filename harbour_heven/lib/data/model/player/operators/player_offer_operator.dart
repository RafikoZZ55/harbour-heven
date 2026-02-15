part of '../player.dart';

extension PlayerOfferOperator on Player {

  TradingPort _getTradingPort() {
    return buildings.firstWhere((b) => b.type == BuildingType.tradingPort) as TradingPort;
  }

  double _calculateOfferMultiplier() {
    TradingPort tradingPort = _getTradingPort();
    return 1.0 + (tradingPort.level * 0.05) + (tradingPort.reputation * 1);
  }

  int _calculateRewardSize(){
    int baseReward = 100 + 100 * (buildingLevel(buildingType: BuildingType.tradingPort));
    int bonus = Random().nextInt((baseReward/4).toInt()); 
    return ((baseReward + bonus) * _getTradingPort().reputation).toInt();
  }

  int _claculeteOfferQueeSize(){
    return 2 + (2* (_getTradingPort().level / 3).floor());
  }

  Map<ResourceType,int> _calculateOfferRewards({required OfferType offerType}) {
    final int size = (_calculateRewardSize() * _calculateOfferMultiplier()).toInt();
    final tawernLevel = buildingLevel(buildingType: BuildingType.tawern);
    int recourceAmount;
    Map<ResourceType,int> rewards = {};
    for(ResourceType recourceType in offerType.rewardType){ rewards[recourceType] = 0;}
    int remainig = size;

    while(remainig > 0){
      for (final ResourceType type in offerType.rewardType) {
        switch(type){
          case ResourceType.gold: recourceAmount = 50 + 5 * _random.nextInt(tawernLevel);
          default: recourceAmount = 100 + 10 * _random.nextInt(tawernLevel);
        }

        rewards[type] = (rewards[type] ?? 0) + min(recourceAmount, remainig);
        remainig -= recourceAmount;
        recourceAmount = 0;
      }
    }
    return rewards;
  }

  Map<ResourceType,int> _claculateOfferPrice({required OfferType offerType}) {
    final int price;
    final ResourceType recourceType = ResourceType.values[_random.nextInt(ResourceType.values.length)];
    switch(recourceType){
      case ResourceType.gold: price = (_calculateRewardSize() * 0.85 / 4).toInt();
      default: price = (_calculateRewardSize() * 0.85 / 4).toInt();
    }
    return {recourceType: price};
  }

  Offer _generateOffer() {
    final OfferType offerType = OfferType.getRandom();
    final int maxHaggleGain = (_calculateRewardSize() * 0.125 * _getTradingPort().reputation).toInt();

    return Offer(
      type: offerType,
      reward: _calculateOfferRewards(offerType: offerType),
      price: _claculateOfferPrice(offerType: offerType),
      isCompleted: false,
      maxHaggleGain: maxHaggleGain,
      canHaggle: true,
      patience: 0,
      isFailed: false,
    );
  }

  void generateOffers() {
    final port = _getTradingPort();
    List<Offer> offers = List.generate(_claculeteOfferQueeSize(), (_) => _generateOffer());
    int portIndex = buildings.indexOf(port);
    TradingPort newPort = port.copyWith(currentOffers: offers);
    List<Building> newBuildings = List.from(buildings);
    newBuildings[portIndex] = newPort;
    buildings = newBuildings;
  }

  void reRollOffers(){
    Map<ResourceType,int> cost = {ResourceType.gold: 5};
    if(hasEnoughRecources(recources: cost)){
      spendRecources(recources: cost);
      generateOffers();
    }
  }

  void _trade({required int index}) {
    TradingPort port = _getTradingPort();
    if (index >= port.currentOffers.length || index < 0) return;
    
    Offer offer = port.currentOffers[index];
    if (!hasEnoughRecources(recources: offer.price)) return;
    if(offer.isCompleted) return;
    
    spendRecources(recources: offer.price);
    addRecources(recources: offer.reward);
    
    Offer completedOffer = offer.copyWith(isCompleted: true);
    List<Offer> updatedOffers = List.from(port.currentOffers);
    updatedOffers[index] = completedOffer;

    TradingPort newPort = port.copyWith(currentOffers: updatedOffers);
    int portIndex = buildings.indexOf(port);
    List<Building> newBuildings = List.from(buildings);
    newBuildings[portIndex] = newPort;
    buildings = newBuildings;
  }


  void haggle({required int index, required int hagglePrice}) {
  TradingPort port = _getTradingPort();
  if (index < 0 || index >= port.currentOffers.length) return;

  Offer offer = port.currentOffers[index];
  if (!offer.canHaggle || offer.isCompleted || offer.isFailed) return;

  int currentPrice = offer.price.values.first;
  int discount = currentPrice - hagglePrice;
  int maxHaggle = offer.maxHaggleGain;

  if (discount <= maxHaggle) {
    Offer updatedOffer = offer.copyWith(
      price: {offer.price.keys.first: hagglePrice},
      canHaggle: false,
      isFailed: false,
    );

    _updateOffer(index, updatedOffer);

    _trade(index: index);
    return;
  }

  double newPatience = offer.patience +
      ((discount - maxHaggle) / currentPrice * 2).clamp(0.0, 1.0);

  Offer updatedOffer;

  if (newPatience >= 1) {
    updatedOffer = offer.copyWith(
      patience: 1,
      canHaggle: false,
      isCompleted: false,
      isFailed: true
    );
  } else {
    updatedOffer = offer.copyWith(
      patience: newPatience,
    );
  }

  _updateOffer(index, updatedOffer);
}

void _updateOffer(int index, Offer updatedOffer) {
  TradingPort port = _getTradingPort();

  List<Offer> updatedOffers = List.from(port.currentOffers);
  updatedOffers[index] = updatedOffer;

  TradingPort newPort = port.copyWith(currentOffers: updatedOffers);

  int portIndex = buildings.indexOf(port);
  List<Building> newBuildings = List.from(buildings);
  newBuildings[portIndex] = newPort;

  buildings = newBuildings;
}


}
