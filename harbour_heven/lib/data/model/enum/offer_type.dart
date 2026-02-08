import 'dart:math';
import 'resource_type.dart';

enum OfferType {
  buildingPackage(
    rewardType: {ResourceType.stone, ResourceType.wood},
    priceType: {ResourceType.gold},
  ),

  buildersRush(
    rewardType: {ResourceType.stone},
    priceType: {ResourceType.wood, ResourceType.gold},
  ),

  lumberDeal(
    rewardType: {ResourceType.wood},
    priceType: {ResourceType.fish, ResourceType.gold},
  ),

  quarryContract(
    rewardType: {ResourceType.stone},
    priceType: {ResourceType.fish, ResourceType.gold},
  ),

  fishingSupply(
    rewardType: {ResourceType.fish},
    priceType: {ResourceType.wood, ResourceType.stone},
  ),

  noMoreFishing(
    rewardType: {ResourceType.fish},
    priceType: {ResourceType.gold},
  ),

  goodOldBarter(
    rewardType: {ResourceType.gold},
    priceType: {
      ResourceType.fish,
      ResourceType.stone,
      ResourceType.wood,
    },
  ),

  merchantFavor(
    rewardType: {ResourceType.gold},
    priceType: {ResourceType.stone, ResourceType.wood},
  ),

  tradeBundle(
    rewardType: {
      ResourceType.gold,
      ResourceType.wood,
    },
    priceType: {ResourceType.fish},
  ),

  supplyExchange(
    rewardType: {
      ResourceType.fish,
      ResourceType.wood,
    },
    priceType: {ResourceType.stone},
  ),

  allForOne(
    rewardType: {
      ResourceType.fish,
      ResourceType.stone,
      ResourceType.wood,
    },
    priceType: {ResourceType.gold},
  ),

  luxuryShipment(
    rewardType: {
      ResourceType.fish,
      ResourceType.stone,
      ResourceType.wood,
    },
    priceType: {ResourceType.gold},
  );

  final Set<ResourceType> rewardType;
  final Set<ResourceType> priceType;

  const OfferType({
    required this.rewardType,
    required this.priceType,
  });

  static OfferType getRandom() {
    final values = OfferType.values;
    return values[Random().nextInt(values.length)];
  }

  static bool checkIfExists({required String offerType}){
    return OfferType.values.any((e) => e.name == offerType);
  }

  static OfferType get({required String offerType}){
    return OfferType.values.singleWhere((e) => e.name == offerType);
  }  
}
