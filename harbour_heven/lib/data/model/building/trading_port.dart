
import 'package:harbour_heven/data/model/barghter/offer.dart';
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class TradingPort extends Building {
  double reputation;
  List<Offer> currentOffers;
  int offerQueeSize;

  TradingPort({int? level, required double reputation, List<Offer>? currentOffers}):
  reputation = reputation.clamp(0, 1),
  currentOffers = currentOffers ?? [],
  offerQueeSize = 2 + (1* (level ?? 1 / 3).floor()),
  super(
    level: level ?? 1,
    type: BuildingType.tradingPort,
    description: "Place where you trade items for gold",
    price: <RecourceType,int>{}
  );
  
  @override
  Map<RecourceType, int> upgradeCost() {
    // TODO: implement upgradeCost
    throw UnimplementedError();
  }
  
}