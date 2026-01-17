
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/voyage/voyage.dart';

class VoyagePort extends Building {
  List<Voyage> currentVoyages;
  Map<VoyageShipType, int> voyageShips;
  int voyageQueeSize;

  VoyagePort({int? level, Map<VoyageShipType, int>? voyageShips, List<Voyage>? currentVoyages}):
  voyageQueeSize = 2 + (1* (level ?? 1 / 3).floor()),
  voyageShips = {
    VoyageShipType.barteringShip: voyageShips?[VoyageShipType.barteringShip] ?? 0,
    VoyageShipType.heavyShip: voyageShips?[VoyageShipType.heavyShip] ?? 0,
    VoyageShipType.lightShip: voyageShips?[VoyageShipType.lightShip] ?? 0
  },
  currentVoyages = currentVoyages ?? [],
  super(
    level: level ?? 1,
    type: BuildingType.voyagePort,
    description: "a port for voyage",
    price: <RecourceType,int>{}
  );
  
  @override
  Map<RecourceType, int> upgradeCost() {
    // TODO: implement upgradeCost
    throw UnimplementedError();
  }
  
}