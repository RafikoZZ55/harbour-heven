
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';

abstract class Building {
int level;
final BuildingType type;
final Map<ResourceType, int> price;
final String description;

Building({
  required this.level,
  required this.type,
  required this.description,
  required this.price,
}): assert((level) >=1,"level must be bigger or equal to one");

Map<ResourceType, int> upgradeCost();

}