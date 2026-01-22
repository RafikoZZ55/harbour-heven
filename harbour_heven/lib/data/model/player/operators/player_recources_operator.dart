part of '../player.dart';

extension PlayerRecourcesOperator on Player {

    void _add({required RecourceType recourceType,required int amount}) {
    recources[recourceType] = (recources[recourceType] ?? 0) + amount.clamp(0, calculateCapacity(resourceType: recourceType) - (recources[recourceType] ?? 0));
  }

  void _spend({required RecourceType recourceType,required int amount}) {
    if(!_hasEnough(recourceType: recourceType,amount: amount)) return;
    recources[recourceType] = (recources[recourceType] ?? 0) - amount;
  }

  bool _hasEnough({required RecourceType recourceType,required int amount}) {
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
      if(_hasEnough(recourceType: key, amount: recources[key] ?? 0)) return false;
    }
    return true;
  }


  void addRecources({required Map<RecourceType,int>recources}) {
    for(RecourceType key in recources.keys) {
      _add(recourceType: key,amount: recources[key] ?? 0);
    }
  }

  void spendRecources({required Map<RecourceType,int>recources}){
    if(!hasEnoughRecources(recources: recources)) return;
    for(RecourceType key in recources.keys) {
      _spend(recourceType: key,amount: recources[key] ?? 0);
    }
  }


  void performCycle({int? cycles}){
    List<Generator> generators = buildings.whereType<Generator>().toList();
    for(Generator generator in generators ) {
      Map<RecourceType,int> generatedRecources = generator.calculateRecourcesPerCycle();
      generatedRecources.updateAll((key, value) => value * (cycles ?? 1));
      addRecources(recources: generatedRecources);
    }

  }
}