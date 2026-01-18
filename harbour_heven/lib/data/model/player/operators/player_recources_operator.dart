import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';

extension PlayerRecourcesOperator on Player {

    void add({required RecourceType recourceType,required int amount}) {
    recources[recourceType] = (recources[recourceType] ?? 0) + amount.clamp(0, calculateCapacity(resourceType: recourceType) - (recources[recourceType] ?? 0));
  }

  void spend({required RecourceType recourceType,required int amount}) {
    if(!hasEnough(recourceType: recourceType,amount: amount)) return;
    recources[recourceType] = (recources[recourceType] ?? 0) - amount;
  }

  bool hasEnough({required RecourceType recourceType,required int amount}) {
    return amount <= (recources[recourceType] ?? 0);
  }

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
      if(hasEnough(recourceType: key, amount: recources[key] ?? 0)) return false;
    }
    return true;
  }


  void addRecources({required Map<RecourceType,int>recources}) {
    for(RecourceType key in recources.keys) {
      add(recourceType: key,amount: recources[key] ?? 0);
    }
  }

  void spendRecources({required Map<RecourceType,int>recources}){
    if(!hasEnoughRecources(recources: recources)) return;
    for(RecourceType key in recources.keys) {
      spend(recourceType: key,amount: recources[key] ?? 0);
    }
  }
}