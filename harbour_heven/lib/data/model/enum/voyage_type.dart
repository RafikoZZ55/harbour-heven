import 'dart:math';

import 'package:harbour_heven/data/model/enum/resource_type.dart';

enum VoyageType {
  woodTrip({ResourceType.wood}),
  fishingTrip({ResourceType.fish}),
  stoneTrip({ResourceType.stone}),
  goldTrip({ResourceType.gold}),
  buildSupplyTrip({ResourceType.stone, ResourceType.wood}),
  foodSupplyTrip({ResourceType.fish,ResourceType.wood}),
  richFishingTrip({ResourceType.gold, ResourceType.fish}),
  tradeConvoy({ResourceType.gold,ResourceType.stone}),
  bigTradeTrip({ResourceType.fish,ResourceType.gold,ResourceType.stone,ResourceType.wood});

  final Set<ResourceType> recources;
  const VoyageType(this.recources);

  static VoyageType getRandom() {
    final values = VoyageType.values;
    return values[Random().nextInt(values.length)];
  }

  bool gives(ResourceType recource) => recources.contains(recource);

  static bool checkIfExists({required String voyageType}){
    return VoyageType.values.any((e) => e.name == voyageType);
  }

  static VoyageType get({required String voyageType}){
    return VoyageType.values.singleWhere((e) => e.name == voyageType);
  }  
}
