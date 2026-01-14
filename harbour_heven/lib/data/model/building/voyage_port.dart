
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/voyage/voyage.dart';

class VoyagePort extends Building {
  late List<Voyage> currentVoyages;
  late Map<VoyageShipType, int> voyageShips;
  int voyageQueeSize;

  VoyagePort({int? level}):
  voyageQueeSize = 2 + (1* (level ?? 1 / 3).floor()),
  super(
    level: level ?? 1,
    type: BuildingType.voyagePort,
    description: "a port for voyage",
    price: <Recourcetype,int>{}
  );
  
  @override
  Map<Recourcetype, int> upgradeCost() {
    // TODO: implement upgradeCost
    throw UnimplementedError();
  }
  
}