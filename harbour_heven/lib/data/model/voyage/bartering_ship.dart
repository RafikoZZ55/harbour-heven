
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/voyage/voyage_ship.dart';

class BarteringShip extends VoyageShip {
  final double recourceMultiplyer = 0.1;

  BarteringShip():
  super(
    type: VoyageShipType.barteringShip,
    description: "doest fight, just transports cargo but be carfull to not add them to much cuz they can make you a bigger target",
    returnRate: 0.9,
    basePoints: -75,
    price: <Recourcetype, int>{Recourcetype.wood: 75, Recourcetype.fish: 15, Recourcetype.gold: 35}
  );
}