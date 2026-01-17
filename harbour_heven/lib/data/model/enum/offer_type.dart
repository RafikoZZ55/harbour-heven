import 'dart:math';
import 'recource_type.dart';

enum OfferType {
  buildingPackage(
    rewardType: {RecourceType.stone, RecourceType.wood},
    priceType: {RecourceType.gold},
  ),

  buildersRush(
    rewardType: {RecourceType.stone},
    priceType: {RecourceType.wood, RecourceType.gold},
  ),

  lumberDeal(
    rewardType: {RecourceType.wood},
    priceType: {RecourceType.fish, RecourceType.gold},
  ),

  quarryContract(
    rewardType: {RecourceType.stone},
    priceType: {RecourceType.fish, RecourceType.gold},
  ),

  fishingSupply(
    rewardType: {RecourceType.fish},
    priceType: {RecourceType.wood, RecourceType.stone},
  ),

  noMoreFishing(
    rewardType: {RecourceType.fish},
    priceType: {RecourceType.gold},
  ),

  goodOldBarter(
    rewardType: {RecourceType.gold},
    priceType: {
      RecourceType.fish,
      RecourceType.stone,
      RecourceType.wood,
    },
  ),

  merchantFavor(
    rewardType: {RecourceType.gold},
    priceType: {RecourceType.stone, RecourceType.wood},
  ),

  tradeBundle(
    rewardType: {
      RecourceType.gold,
      RecourceType.wood,
    },
    priceType: {RecourceType.fish},
  ),

  supplyExchange(
    rewardType: {
      RecourceType.fish,
      RecourceType.wood,
    },
    priceType: {RecourceType.stone},
  ),

  allForOne(
    rewardType: {
      RecourceType.fish,
      RecourceType.stone,
      RecourceType.wood,
    },
    priceType: {RecourceType.gold},
  ),

  luxuryShipment(
    rewardType: {
      RecourceType.fish,
      RecourceType.stone,
      RecourceType.wood,
    },
    priceType: {RecourceType.gold},
  );

  final Set<RecourceType> rewardType;
  final Set<RecourceType> priceType;

  const OfferType({
    required this.rewardType,
    required this.priceType,
  });

  static OfferType getRandom() {
    final values = OfferType.values;
    return values[Random().nextInt(values.length)];
  }
}
