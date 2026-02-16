import 'package:harbour_heven/data/model/enum/resource_type.dart';

enum VoyageShipType {
  lightShip(
    description: "light, fast and cheap but has low chance of surviving a voyage",
    returnRate: 0.85,
    basePoints: 100,
    buyPrice: <ResourceType, int>{ResourceType.wood: 75, ResourceType.fish: 25},
    sellPrice: <ResourceType, int>{ResourceType.wood: 25, ResourceType.fish: 15},
  ),
  heavyShip(
    description: "unsinkable and powerfull but pricy. Great for long runs",
    returnRate: 1,
    basePoints: 125,
    buyPrice: <ResourceType,int>{ResourceType.wood: 200, ResourceType.fish: 50, ResourceType.gold: 20},
    sellPrice: <ResourceType,int>{ResourceType.wood: 100, ResourceType.fish: 25, ResourceType.gold: 5},
  ),
  barteringShip(
    description: "doest fight, just transports cargo but be carfull to not add them to much cuz they can make you a bigger target",
    returnRate: 0.9,
    basePoints: -50,
    buyPrice: <ResourceType, int>{ResourceType.wood: 75, ResourceType.fish: 15, ResourceType.gold: 35},
    sellPrice: <ResourceType, int>{ResourceType.wood: 25, ResourceType.fish: 5, ResourceType.gold: 20},
  );


  final String description;
  final double returnRate;
  final int basePoints;
  final Map<ResourceType,int> buyPrice;
  final Map<ResourceType,int> sellPrice;

  const VoyageShipType({required this.description, required this.returnRate ,required this.basePoints ,required this.buyPrice, required this.sellPrice });

  static bool checkIfExists({required String voyageShipType}){
    return VoyageShipType.values.any((e) => e.name == voyageShipType);
  }

  static VoyageShipType get({required String voyageShipType}){
    return VoyageShipType.values.singleWhere((e) => e.name == voyageShipType);
  }  
}