import 'dart:math';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/difficulty.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/model/player/player_recources_operator.dart';
import 'package:harbour_heven/data/model/voyage/bartering_ship.dart';
import 'package:harbour_heven/data/model/voyage/heavy_ship.dart';
import 'package:harbour_heven/data/model/voyage/light_ship.dart';
import 'package:harbour_heven/data/model/voyage/voyage.dart';

extension PlayerVoyageOperator on Player {

  VoyagePort _getVoyagePort() {
    return buildings.singleWhere((b) => b.type == BuildingType.voyagePort) as VoyagePort;
  }

  int _calculateVoyageQueeSize(){
    return 2 + (1 * (_getVoyagePort().level / 3).floor());
  }

  int _calculateFleetBasePoints(){
    int totalBasePoints = 0;
    for(int basePoints in _getVoyagePort().voyageShips.values) {totalBasePoints += basePoints;}
    return totalBasePoints;
  }

  Map<Recourcetype, int> _getVoyageShipPrice({required VoyageShipType type}){
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

  Voyage generateVoyage(){
    //TODO: - make it work
    return Voyage(
      difficulty: Difficulty.easy, 
      recources: {Recourcetype.fish: 1200}, 
      successThreshold: 750 + (buildingLevel(buildingType: BuildingType.tawern) * 250 )
    );
  }

  void generateVoyages(){
    List<Voyage> voyages = List.generate(_calculateVoyageQueeSize(), (_) => generateVoyage());
    _getVoyagePort().currentVoyages = voyages;
  }

  void reRollVoyages(){
    Map<Recourcetype,int> cost = {Recourcetype.gold: 5};
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






