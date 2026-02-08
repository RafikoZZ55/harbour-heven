import 'dart:math';

import 'package:harbour_heven/data/model/barghter/offer.dart';
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';

class TradingPort extends Building {
  double reputation;
  List<Offer> currentOffers;
  int nextRefreshAt;



  TradingPort({int? level, required double reputation, List<Offer>? currentOffers, int? nextRefreshAt}):
  reputation = reputation.clamp(0, 1),
  currentOffers = currentOffers ?? [],
  nextRefreshAt = nextRefreshAt ?? DateTime.now().millisecondsSinceEpoch + 1000,
  super(
    level: level ?? 1,
    type: BuildingType.tradingPort,
    description: "Place where you trade items for gold",
    price: <ResourceType,int>{}
  );
  
  @override
  Map<ResourceType, int> upgradeCost() {
    Map<ResourceType,int> cost = {
      ResourceType.stone: (200 + 2.5 * pow(2, level)).toInt(),
      ResourceType.wood: (200 + 2.5 * pow(2, level)).toInt(),
      ResourceType.fish: (200 + 2.5 * pow(2, level)).toInt(),
      ResourceType.gold: (15 * level + 5 * pow(level,2)).toInt()
    };
    return cost;
  }
  
}