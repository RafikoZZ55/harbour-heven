import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/recource/recource.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class Player {
List<Building> buildings;
Map<Recourcetype, Recource> recources;

Player({
  required this.buildings,
  required this.recources
});

}