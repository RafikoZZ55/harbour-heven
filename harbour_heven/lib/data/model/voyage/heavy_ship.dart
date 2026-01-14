
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/voyage/voyage_ship.dart';

class HeavyShip extends VoyageShip {
  HeavyShip():
  super(
    type: VoyageShipType.heavyShip,
    description: "unsinkable and powerfull but pricy. Great for long runs",
    returnRate: 1,
    basePoints: 125,
    price: <Recourcetype,int>{Recourcetype.wood: 200, Recourcetype.fish: 50, Recourcetype.gold: 20}
  );
}