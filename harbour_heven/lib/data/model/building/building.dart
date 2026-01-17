
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

abstract class Building {
int level;
final BuildingType type;
final Map<RecourceType, int> price;
final String description;

Building({
  required this.level,
  required this.type,
  required this.description,
  required this.price,
});

Map<RecourceType, int> upgradeCost();

}