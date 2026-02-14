part of '../player.dart';

extension PlayerVoyageOperator on Player {

  VoyagePort _getVoyagePort() {
    return buildings.firstWhere((b) => b.type == BuildingType.voyagePort) as VoyagePort;
  }

  int _calculateVoyageQueeSize(){
    return 2 + (2 * (_getVoyagePort().level / 3).floor());
  }

  int _calculateFleetBasePoints(){
    VoyagePort voyagePort = _getVoyagePort();
    int totalBasePoints = 0;
    for(VoyageShipType voyageShipType in voyagePort.voyageShips.keys) {
      totalBasePoints += (voyagePort.voyageShips[voyageShipType] ?? 0) * voyageShipType.basePoints;
    }
    return totalBasePoints;
  }

  DifficultyType _calculateVoyageDifficulty(){
    int tavernLevel = buildingLevel(buildingType: BuildingType.tawern);
    double roll = _random.nextDouble();
    double easyChance;
    double mediumChance;
    double hardChance;

    if(tavernLevel <= 3) {
      easyChance = 1;
      mediumChance = 0;
      hardChance = 0;
    }
    else if (tavernLevel <= 6){
      easyChance = 0.3;
      mediumChance = 0.6;
      hardChance = 0.1;
    }
    else if (tavernLevel <= 9){
      easyChance = 0.1;
      mediumChance = 0.3;
      hardChance = 0.5;
    }
    else {
      easyChance = 0;
      mediumChance = 0.2;
      hardChance = 0.3;
    }

    if(roll <= easyChance) {return DifficultyType.easy;}
    else if (roll <= mediumChance + easyChance) {return DifficultyType.medium;}
    else if (roll <= hardChance + mediumChance + hardChance) {return DifficultyType.hard;}
    else {return DifficultyType.extreme;}
  }

Map<ResourceType, int> _calculateVoyageResources({
  required VoyageType voyageType,
  required DifficultyType difficulty,
}) {
  int voyagePortLevel = _getVoyagePort().level;

  int baseResources = 100 +
      200 * voyagePortLevel +
      250 * (difficulty.index + 1) +
      _random.nextInt(
          (12.5 * pow(2, (difficulty.index + 1)) * voyagePortLevel).toInt());

  int fixedBonus = 100 * (difficulty.index + 1) + 75 * voyagePortLevel;

  Map<ResourceType, int> resources = {};
  int numResources = voyageType.resources.length;

  for (ResourceType r in voyageType.resources) {
    resources[r] = fixedBonus;
  }

  int remaining = baseResources - (fixedBonus * numResources);
  if (remaining <= 0) return resources;


  while (remaining > 0) {
    for (var r in voyageType.resources) {
      if (remaining <= 0) break;

      int maxReward = (remaining / voyageType.resources.length).ceil();
      int reward = _random.nextInt(maxReward) + 1;

      resources[r] = (resources[r] ?? 0) + reward;
      remaining -= reward;
    }
  }

  return resources;
}


  int _calculateVoyageSuccesThreshold({required DifficultyType difficulty}){
      int tawernLevel = buildingLevel(buildingType: BuildingType.tawern);
      return 250 + 225 * tawernLevel + 100 * pow(2, difficulty.index + 1).toInt();
      
  }

  Voyage _generateVoyage(){
    VoyageType voyageType = VoyageType.getRandom();
    DifficultyType difficulty = _calculateVoyageDifficulty();

    return Voyage(
      type: voyageType,
      difficulty: difficulty, 
      recources: _calculateVoyageResources(voyageType: voyageType, difficulty: difficulty), 
      successThreshold: _calculateVoyageSuccesThreshold(difficulty: difficulty)
    );
  }

  void generateVoyages(){
    List<Voyage> voyages = List.generate(_calculateVoyageQueeSize(), (_) => _generateVoyage());
    _getVoyagePort().currentVoyages = voyages;
  }

  void reRollVoyages(){
    Map<ResourceType,int> cost = {ResourceType.gold: 5};
    if(hasEnoughRecources(recources: cost)){
      spendRecources(recources: cost);
      generateVoyages();
    }
  }

  void buyVoyageShip({required VoyageShipType type}){
    if(hasEnoughRecources(recources: type.buyPrice)){
      spendRecources(recources: type.buyPrice);
      VoyagePort port = _getVoyagePort();
      port.voyageShips[type] = (port.voyageShips[type] ?? 0) + 1 ;
    }
  }

  void sellVoyageShip({required VoyageShipType type}){
    if(_getVoyagePort().voyageShips[type]! > 0){
      addRecources(recources: type.sellPrice);
      _getVoyagePort().voyageShips[type] = (_getVoyagePort().voyageShips[type] ?? 1) - 1;
    }
  }

  void performVoyage({required int index}){
    VoyagePort port = _getVoyagePort();
    if(index >= port.currentVoyages.length || index < 0) return;
    Voyage voyage = port.currentVoyages[index];
    bool isSucces = _random.nextInt(voyage.successThreshold) <= _calculateFleetBasePoints();

    for(VoyageShipType type in port.voyageShips.keys){
      int returningShips = 0;
      for (var i = 0; i < (port.voyageShips[type] ?? 0); i++) {
        if( _random.nextDouble() <= (type.returnRate / (isSucces ? 1 : 2))) returningShips++;
      }
      port.voyageShips[type] = returningShips;
    }

    if(isSucces) addRecources(recources: port.currentVoyages[index].recources);
    reRollVoyages();
  }

}