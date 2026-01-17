
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
    price: <RecourceType,int>{RecourceType.wood: 200, RecourceType.fish: 50, RecourceType.gold: 20}
  );
}