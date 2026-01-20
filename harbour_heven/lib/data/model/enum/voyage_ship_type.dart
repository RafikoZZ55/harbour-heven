import 'package:harbour_heven/data/model/enum/recource_type.dart';

enum VoyageShipType {
  lightShip(
    description: "light, fast and cheap but has low chance of surviving a voyage",
    returnRate: 0.75,
    basePoints: 100,
    price: <RecourceType, int>{RecourceType.wood: 75, RecourceType.fish: 25}
  ),
  heavyShip(
    description: "unsinkable and powerfull but pricy. Great for long runs",
    returnRate: 1,
    basePoints: 125,
    price: <RecourceType,int>{RecourceType.wood: 200, RecourceType.fish: 50, RecourceType.gold: 20}
  ),
  barteringShip(
    description: "doest fight, just transports cargo but be carfull to not add them to much cuz they can make you a bigger target",
    returnRate: 0.9,
    basePoints: -50,
    price: <RecourceType, int>{RecourceType.wood: 75, RecourceType.fish: 15, RecourceType.gold: 35}
  );


  final String description;
  final double returnRate;
  final int basePoints;
  final Map<RecourceType,int> price;

  const VoyageShipType({required this.description, required this.returnRate ,required this.basePoints ,required this.price });

  static bool checkIfExists({required String voyageShipType}){
    return VoyageShipType.values.any((e) => e.name == voyageShipType);
  }

  static VoyageShipType get({required String voyageShipType}){
    return VoyageShipType.values.singleWhere((e) => e.name == voyageShipType);
  }  
}