part of '../player.dart';

extension PlayerRecourcesOperator on Player {

    void _add({required ResourceType recourceType,required int amount}) {
    final newResources = Map<ResourceType, int>.from(resources);
    newResources[recourceType] = (newResources[recourceType] ?? 0) + amount.clamp(0, calculateCapacity(resourceType: recourceType) - (newResources[recourceType] ?? 0)).toInt();
    resources = newResources;
  }

  void _spend({required ResourceType recourceType,required int amount}) {
    if(!_hasEnough(recourceType: recourceType,amount: amount)) return;
    final newResources = Map<ResourceType, int>.from(resources);
    newResources[recourceType] = (newResources[recourceType] ?? 0) - amount;
    resources = newResources;
  }

  bool _hasEnough({required ResourceType recourceType,required int amount}) {
    return amount <= (resources[recourceType] ?? 0);
  }

  int calculateCapacity({required ResourceType resourceType}) {
    final townLevel = buildingLevel(buildingType: BuildingType.tawern);
    if (townLevel < 1) return 0;
    switch (resourceType) {
      case ResourceType.fish:
      case ResourceType.wood:
      case ResourceType.stone:
        return 200 + 50 * (townLevel) + 10 * pow(2, townLevel - 1).toInt();
      case ResourceType.gold:
        return 50 + 25 * (townLevel) + 5 * pow(2, townLevel - 1).toInt();
    }
  }

  bool hasEnoughRecources({required Map<ResourceType,int> recources}){
    for(ResourceType key in recources.keys){
      if(!_hasEnough(recourceType: key, amount: recources[key] ?? 0)) return false;
    }
    return true;
  }


  void addRecources({required Map<ResourceType,int>recources}) {
    for(ResourceType key in recources.keys) {
      _add(recourceType: key,amount: recources[key] ?? 0);
    }
  }

  void spendRecources({required Map<ResourceType,int>recources}){
    if(!hasEnoughRecources(recources: recources)) return;
    for(ResourceType key in recources.keys) {
      _spend(recourceType: key,amount: recources[key] ?? 0);
    }
  }


  void performCycle({int? cycles}){
    List<Generator> generators = buildings.whereType<Generator>().toList();
    for(Generator generator in generators ) {
      Map<ResourceType,int> generatedRecources = generator.calculateRecourcesPerCycle();
      generatedRecources.updateAll((key, value) => value * (cycles ?? 1));
      addRecources(recources: generatedRecources);
    }

  }
}