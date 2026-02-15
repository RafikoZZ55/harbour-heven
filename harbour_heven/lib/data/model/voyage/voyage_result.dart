import 'package:harbour_heven/data/model/enum/resource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';

class VoyageResult {
  bool isSucces;
  Map<VoyageShipType,int> lostShips;
  Map<ResourceType,int> resourcesGained;

  VoyageResult({
    required this.isSucces,
    required this.resourcesGained,
    required this.lostShips,
  });
}