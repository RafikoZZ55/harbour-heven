import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';

class Player {
Map<BuildingType,Building> buildings;
Map<RecourceType, int> recources;

Player({required this.buildings, required this.recources});

}