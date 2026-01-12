
import 'package:harbour_heven/data/model/recource_type.dart';

abstract class Building {
int level;
final String name;
final Map<Recourcetype, int> price;
final String description;

Building({
  required this.level,
  required this.name,
  required this.description,
  required this.price,
});

Map<Recourcetype, int> upgradeCost();

}