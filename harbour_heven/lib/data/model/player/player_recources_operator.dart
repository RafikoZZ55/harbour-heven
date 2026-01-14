import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/model/recource/recource_operators.dart';

extension PlayerRecourcesOperator on Player {
  int calculateCapacity({required Recourcetype resourceType}) {
    final townLevel = buildingLevel(buildingType: BuildingType.tawern);

    switch (resourceType) {
      case Recourcetype.fish:
        if (townLevel < 1) return 0;
        return 50 * (townLevel + 4);

      case Recourcetype.wood:
        if (townLevel < 2) return 0;
        return 250 + 50 * (townLevel - 2);

      case Recourcetype.stone:
        if (townLevel < 3) return 0;
        return 250 + 50 * (townLevel - 3);

      case Recourcetype.gold:
        if (townLevel < 3) return 0;
        return 50 + 25 * (townLevel - 3);
    }
  }

  bool hasEnoughRecources({required Map<Recourcetype,int> recources}){
    for(Recourcetype key in recources.keys){
      if(!(this.recources[key]!.hasEnough(amount: recources[key] ?? 0)) ) return false;
    }
    return true;
  }


  void addRecources({required Map<Recourcetype,int>recources}) {
    for(Recourcetype key in recources.keys) {
      this.recources[key]?.add(amount: recources[key] ?? 0, capacity: calculateCapacity(resourceType: key));
    }
  }

  void spendRecources({required Map<Recourcetype,int>recources}){
    if(!hasEnoughRecources(recources: recources)) return;
    for(Recourcetype key in recources.keys) {
      this.recources[key]?.spend(amount: recources[key] ?? 0);
    }
  }
}