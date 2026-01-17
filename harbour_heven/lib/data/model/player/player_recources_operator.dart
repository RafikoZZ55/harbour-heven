import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/model/recource/recource_operators.dart';

extension PlayerRecourcesOperator on Player {
  int calculateCapacity({required RecourceType resourceType}) {
    final townLevel = buildingLevel(buildingType: BuildingType.tawern);
    if (townLevel < 1) return 0;
    switch (resourceType) {
      case RecourceType.fish || RecourceType.wood || RecourceType.stone:
        return 200 + 50 * (townLevel) + 10 * pow(2, townLevel - 1).toInt();
      case RecourceType.gold:
        return 50 + 25 * (townLevel) + 5 * pow(2, townLevel - 1).toInt();
    }
  }

  bool hasEnoughRecources({required Map<RecourceType,int> recources}){
    for(RecourceType key in recources.keys){
      if(!(this.recources[key]!.hasEnough(amount: recources[key] ?? 0)) ) return false;
    }
    return true;
  }


  void addRecources({required Map<RecourceType,int>recources}) {
    for(RecourceType key in recources.keys) {
      this.recources[key]?.add(amount: recources[key] ?? 0, capacity: calculateCapacity(resourceType: key));
    }
  }

  void spendRecources({required Map<RecourceType,int>recources}){
    if(!hasEnoughRecources(recources: recources)) return;
    for(RecourceType key in recources.keys) {
      this.recources[key]?.spend(amount: recources[key] ?? 0);
    }
  }
}