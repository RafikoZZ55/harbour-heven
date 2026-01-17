import 'dart:math';
import 'package:harbour_heven/data/model/barghter/offer.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/offer_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/model/player/player_recources_operator.dart';

extension PlayerOfferOperator on Player {
  Random get _random => Random();

  TradingPort _getTradingPort() {
    return buildings.firstWhere((building) => building.type == BuildingType.tradingPort) as TradingPort;
  }

  double _calculateOfferMultiplier() {
    int tavernLevel = buildingLevel(buildingType: BuildingType.tawern);
    double reputation = _getTradingPort().reputation;
    return 1.0 + (tavernLevel * 0.5) + (reputation * 1.0);
  }

  Map<RecourceType,int> _calculateOfferRewards({required OfferType offerType}) {
    final scale = _calculateOfferMultiplier();
    Map<RecourceType,int> rewards = {};

    for (final type in offerType.rewardType) {
      int baseReward;
      switch(type) {
        case RecourceType.fish: baseReward = 200; break;
        case RecourceType.wood: baseReward = 150; break;
        case RecourceType.stone: baseReward = 250; break;
        case RecourceType.gold: baseReward = 50; break;
      }

      int reward = ((baseReward * scale) * (0.9 + _random.nextDouble() * 0.2)).ceil();
      rewards[type] = reward;
    }

    return rewards;
  }

  Map<RecourceType,int> _claculateOfferPrice({required OfferType offerType}) {
    final scale = _calculateOfferMultiplier();
    final priceType = offerType.priceType.elementAt(_random.nextInt(offerType.priceType.length));
    int basePrice;
    switch(priceType) {
      case RecourceType.fish: basePrice = 4; break;
      case RecourceType.wood: basePrice = 6; break;
      case RecourceType.stone: basePrice = 8; break;
      case RecourceType.gold: basePrice = 10; break;
    }

    int price = ((basePrice * scale) * (0.9 + _random.nextDouble() * 0.2)).ceil();
    return {priceType: price};
  }

  Offer _generateOffer() {
    OfferType offerType = OfferType.getRandom();

    return Offer(
      type: offerType,
      reward: _calculateOfferRewards(offerType: offerType),
      price: _claculateOfferPrice(offerType: offerType),
      isCompleted: false
    );
  }

  void generateOffers() {
    final port = _getTradingPort();
    List<Offer> offers = List.generate(port.offerQueeSize, (_) => _generateOffer());
    port.currentOffers = offers;
  }

  void trade({required int index}) {
    Offer offer = _getTradingPort().currentOffers[index];
    if (!hasEnoughRecources(recources: offer.price)) return;
    spendRecources(recources: offer.price);
    addRecources(recources: offer.reward);
    offer.isCompleted = true;
  }
}
