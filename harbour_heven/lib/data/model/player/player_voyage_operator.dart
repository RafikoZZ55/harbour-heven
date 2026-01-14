import 'package:harbour_heven/data/model/building/building.dart';
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

int _calculateVoyageQueeSize(){
  Building port = buildings.firstWhere((b) => b.type == BuildingType.voyagePort);
  return 2 + (1* (port.level / 3).floor());
}

Map<Recourcetype, int> _getVoyageShipPrice({required VoyageShipType type}){
  switch (type){
    case VoyageShipType.barteringShip: return BarteringShip().price;
    case VoyageShipType.lightShip: return LightShip().price;
    case VoyageShipType.heavyShip: return HeavyShip().price;
  }
}

void generateVoyages(){
  List<Voyage> voyages = List.generate(
    _calculateVoyageQueeSize(),
    (_) => Voyage(
      difficulty: Difficulty.hard,
      successThreshold: 1000,
      recources: <Recourcetype, int>{
        Recourcetype.fish: 500
      }
    )
  );

  VoyagePort port = buildings.singleWhere((b) => b.type == BuildingType.voyagePort) as VoyagePort;
  port.currentVoyages = voyages;
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
      VoyagePort port = buildings.singleWhere((b) => b.type == BuildingType.voyagePort) as VoyagePort;
      port.voyageShips.addAll({});
    }
  }




}






