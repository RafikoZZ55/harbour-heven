import 'dart:math';

import 'package:harbour_heven/data/model/enum/recource_type.dart';

enum VoyageType {
  woodTrip({RecourceType.wood}),
  fishingTrip({RecourceType.fish}),
  stoneTrip({RecourceType.stone}),
  goldTrip({RecourceType.gold}),
  buildSupplyTrip({RecourceType.stone, RecourceType.wood}),
  foodSupplyTrip({RecourceType.fish,RecourceType.wood}),
  richFishingTrip({RecourceType.gold, RecourceType.fish}),
  tradeConvoy({RecourceType.gold,RecourceType.stone}),
  bigTradeTrip({RecourceType.fish,RecourceType.gold,RecourceType.stone,RecourceType.wood});

  final Set<RecourceType> recources;
  const VoyageType(this.recources);

  static VoyageType getRandom() {
    final values = VoyageType.values;
    return values[Random().nextInt(values.length)];
  }

  bool gives(RecourceType recource) => recources.contains(recource);

  static bool checkIfExists({required String voyageType}){
    return VoyageType.values.any((e) => e.name == voyageType);
  }

  VoyageType get({required String voyageType}){
    return VoyageType.values.singleWhere((e) => e.name == voyageType);
  }  
}
