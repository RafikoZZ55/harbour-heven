
import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:harbour_heven/data/model/barghter/offer.dart';
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class TradingPort extends Building {
  double reputation;
  List<Offer> currentOffers;
  int nextRefreshAt;



  TradingPort({int? level, required double reputation, List<Offer>? currentOffers, int? nextRefreshAt}):
  reputation = reputation.clamp(0, 1),
  currentOffers = currentOffers ?? [],
  nextRefreshAt = nextRefreshAt ?? 0,
  super(
    level: level ?? 1,
    type: BuildingType.tradingPort,
    description: "Place where you trade items for gold",
    price: <RecourceType,int>{}
  );
  
  @override
  Map<RecourceType, int> upgradeCost() {
    Map<RecourceType,int> cost = {
      RecourceType.stone: (200 + 2.5 * pow(2, level)).toInt(),
      RecourceType.wood: (200 + 2.5 * pow(2, level)).toInt(),
      RecourceType.fish: (200 + 2.5 * pow(2, level)).toInt(),
      RecourceType.gold: (15 * level + 5 * pow(level,2)).toInt()
    };
    return cost;
  }
  
}