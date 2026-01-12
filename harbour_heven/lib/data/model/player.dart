import 'package:harbour_heven/data/model/building.dart';
import 'package:harbour_heven/data/model/recource.dart';
import 'package:harbour_heven/data/model/recource_type.dart';

class Player {
List<Building> buildings;
Map<Recourcetype, Recource> recources;

Player({
  required this.buildings,
  required this.recources
});

}