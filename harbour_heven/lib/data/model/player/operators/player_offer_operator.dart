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
    return (250 + 100 * (buildingLevel(buildingType: BuildingType.tradingPort)));
  }

  int _claculeteOfferQueeSize(){
    return 2 + (1* (_getTradingPort().level / 3).floor());
  }

  Map<RecourceType,int> _calculateOfferRewards({required OfferType offerType}) {
    final int size = (_calculateRewardSize() * _calculateOfferMultiplier()).toInt();
    final tawernLevel = buildingLevel(buildingType: BuildingType.tawern);
    int recourceAmount;
    Map<RecourceType,int> rewards = {};
    int remainig = max(0,size - rewards.values.reduce((int a, int b) => a + b));

    while(remainig > 0){
      for (final RecourceType type in offerType.rewardType) {
        switch(type){
          case RecourceType.gold: recourceAmount = 50 + 5 * _random.nextInt(tawernLevel);
          default: recourceAmount = 100 + 10 * _random.nextInt(tawernLevel);
        }

        rewards[type] = (rewards[type] ?? 0) + min(recourceAmount, remainig);
        recourceAmount = 0;
      }
    }
    return rewards;
  }

  Map<RecourceType,int> _claculateOfferPrice({required OfferType offerType}) {
    final int price;
    final RecourceType  recourceType = RecourceType.values[_random.nextInt(RecourceType.values.length)];
    switch(recourceType){
      case RecourceType.gold: price = (_calculateRewardSize() * 0.85 / 4).toInt();
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
    );
  }

  void generateOffers() {
    final port = _getTradingPort();
    List<Offer> offers = List.generate(_claculeteOfferQueeSize(), (_) => _generateOffer());
    port.currentOffers = offers;
  }

  void trade({required int index}) {
    Offer offer = _getTradingPort().currentOffers[index];
    if (!hasEnoughRecources(recources: offer.price)) return;
    spendRecources(recources: offer.price);
    addRecources(recources: offer.reward);
    offer.isCompleted = true;
  }

  void haggle({required int index, required int amount}){
    TradingPort tradingPort = _getTradingPort();
    Offer offer = tradingPort.currentOffers[index];
    if(!offer.canHaggle) return;

    if(amount <= offer.maxHaggleGain) {
      offer.price = {offer.price.keys.first: offer.price.values.first - amount};
      offer.canHaggle = false;
      return;
    }

    offer.patience += (amount - offer.maxHaggleGain) / offer.maxHaggleGain * 0.9;
    if (offer.patience >= 1){
      offer.canHaggle = false;
      offer.isCompleted = true;
      return;
    }
  }


  void rerollOffers(){
    
  }
}
