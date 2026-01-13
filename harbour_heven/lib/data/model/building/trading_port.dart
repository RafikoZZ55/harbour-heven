
import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class TradingPort extends Building {
  TradingPort({int? level}):
  super(
    level: level ?? 1,
    type: BuildingType.tradingPort,
    description: "Place where you trade items for gold",
    price: <Recourcetype,int>{}
  );
  
  @override
  Map<Recourcetype, int> upgradeCost() {
    // TODO: implement upgradeCost
    throw UnimplementedError();
  }
  
}