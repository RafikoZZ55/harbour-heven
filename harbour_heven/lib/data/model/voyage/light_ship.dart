import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/voyage/voyage_ship.dart';

class LightShip extends VoyageShip {
  LightShip(): 
  super(
    type: VoyageShipType.barteringShip, 
    description: "light, fast and cheap but has low chance of surviving a voyage",
    returnRate: 0.75,
    basePoints: 100,
    price: <Recourcetype, int>{Recourcetype.wood: 75, Recourcetype.fish: 25}
  );
}