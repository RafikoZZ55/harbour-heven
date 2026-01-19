import 'dart:math';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/difficulty_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_type.dart';
import 'package:harbour_heven/data/model/player/operators/player_building_operator.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/model/player/operators/player_recources_operator.dart';
import 'package:harbour_heven/data/model/voyage/bartering_ship.dart';
import 'package:harbour_heven/data/model/voyage/heavy_ship.dart';
import 'package:harbour_heven/data/model/voyage/light_ship.dart';
import 'package:harbour_heven/data/model/voyage/voyage.dart';

extension PlayerVoyageOperator on Player {

  VoyagePort _getVoyagePort() {
    return buildings[BuildingType.voyagePort] as VoyagePort;
  }

  int _calculateVoyageQueeSize(){
    return 2 + (1 * (_getVoyagePort().level / 3).floor());
  }

  int _calculateFleetBasePoints(){
    int totalBasePoints = 0;
    for(int basePoints in _getVoyagePort().voyageShips.values) {totalBasePoints += basePoints;}
    return totalBasePoints;
  }

  Map<RecourceType, int> _getVoyageShipPrice({required VoyageShipType type}){
    switch (type){
      case VoyageShipType.barteringShip: return BarteringShip().price;
      case VoyageShipType.lightShip: return LightShip().price;
      case VoyageShipType.heavyShip: return HeavyShip().price;
    }
  }

  double _getVoyageShipReturnRate({required VoyageShipType type}){
    switch (type){
      case VoyageShipType.barteringShip: return BarteringShip().returnRate;
      case VoyageShipType.lightShip: return LightShip().returnRate;
      case VoyageShipType.heavyShip: return HeavyShip().returnRate;
    }
  }

  DifficultyType _calculateVoyageDifficulty(){
    int tavernLevel = buildingLevel(buildingType: BuildingType.tawern);
    double roll = Random().nextDouble();
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

  Map<RecourceType, int> _calculateVoyageRecources({required VoyageType voyageType, required DifficultyType difficulty}) {
    int voyagePortLevel = _getVoyagePort().level;
    int baseRecources = 100 + 200 * voyagePortLevel + 250 * (difficulty.index + 1) + Random().nextInt((12.5 * pow(2, (difficulty.index + 1)) * voyagePortLevel).toInt());
    int fixedBonus = 100 * (difficulty.index + 1) + 75 * voyagePortLevel;
    Map<RecourceType,int> recources = {
      RecourceType.wood: 0,
      RecourceType.fish: 0,
      RecourceType.stone: 0,
      RecourceType.gold: 0,
    };

    for(RecourceType recource in voyageType.recources){
      recources[recource] = fixedBonus;
    }

    final List<RecourceType> activeRecuorces = voyageType.recources.toList();
    while(baseRecources - recources.values.reduce((value, element) => value + element) > 0){
      RecourceType selectedRecource = activeRecuorces[Random().nextInt(activeRecuorces.length)];

      recources[selectedRecource] = min(
        baseRecources - recources.values.reduce((value, element) => value + element), 
        (recources[selectedRecource] ?? 0) + Random().nextInt(((baseRecources - recources.values.reduce((value, element) => value + element) / 1.5).toInt()) + 10)
      );
    }

    return recources;
  }

  int _calculateVoyageSuccesThreshold({required DifficultyType difficulty}){
      int tawernLevel = buildingLevel(buildingType: BuildingType.tawern);
      return 250 + 225 * tawernLevel + 100 * pow(2, difficulty.index + 1).toInt();
      
  }

  Voyage generateVoyage(){
    VoyageType voyageType = VoyageType.getRandom();
    DifficultyType difficulty = _calculateVoyageDifficulty();

    return Voyage(
      type: voyageType,
      difficulty: difficulty, 
      recources: _calculateVoyageRecources(voyageType: voyageType, difficulty: difficulty), 
      successThreshold: _calculateVoyageSuccesThreshold(difficulty: difficulty)
    );
  }

  void generateVoyages(){
    List<Voyage> voyages = List.generate(_calculateVoyageQueeSize(), (_) => generateVoyage());
    _getVoyagePort().currentVoyages = voyages;
  }

  void reRollVoyages(){
    Map<RecourceType,int> cost = {RecourceType.gold: 5};
    if(hasEnoughRecources(recources: cost)){
      spendRecources(recources: cost);
      generateVoyages();
    }
  }

  void buyVoyageShip({required VoyageShipType type}){
    if(hasEnoughRecources(recources: _getVoyageShipPrice(type: type))){
      spendRecources(recources: _getVoyageShipPrice(type: type));
      VoyagePort port = _getVoyagePort();
      port.voyageShips[type] = (port.voyageShips[type] ?? 0) + 1 ;
    }
  }

  void performVoyage({required int index}){
    VoyagePort port = _getVoyagePort();
    if(index >= port.currentVoyages.length || index < 0) return;
    Voyage voyage = port.currentVoyages[index];
    bool isSucces = Random().nextInt(voyage.successThreshold) <= _calculateFleetBasePoints();

    for(VoyageShipType type in port.voyageShips.keys){
      int returningShips = 0;
      for (var i = 0; i < (port.voyageShips[type] ?? 0); i++) {
        if( Random().nextDouble() <= (_getVoyageShipReturnRate(type: type) / (isSucces ? 1 : 2))) returningShips++;
      }
      port.voyageShips[type] = returningShips;
    }

    if(isSucces) addRecources(recources: port.currentVoyages[index].recources);
    reRollVoyages();
  }

}