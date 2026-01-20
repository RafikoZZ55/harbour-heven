import 'package:harbour_heven/data/model/building/building.dart';
import 'package:harbour_heven/data/model/enum/recource_type.dart';
import 'package:harbour_heven/data/model/building/voyage_port.dart';
import 'package:harbour_heven/data/model/enum/building_type.dart';
import 'package:harbour_heven/data/model/enum/difficulty_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_ship_type.dart';
import 'package:harbour_heven/data/model/enum/voyage_type.dart';
import 'package:harbour_heven/data/model/player/player.dart';
import 'package:harbour_heven/data/model/voyage/voyage.dart';
import 'package:harbour_heven/data/model/barghter/offer.dart';
import 'package:harbour_heven/data/model/building/trading_port.dart';
import 'package:harbour_heven/data/model/enum/offer_type.dart';
import 'dart:math';

part 'operators/player_building_operator.dart';
part 'operators/player_offer_operator.dart';
part 'operators/player_recources_operator.dart';
part 'operators/player_voyage_operator.dart';

class Player {
  List<Building> buildings;
  Map<RecourceType, int> recources;

  Player({required this.buildings, required this.recources});

  Player copyWith({
    List<Building>? buildings,
    Map<RecourceType, int>? recources,
  }) {
    return Player(
      buildings: buildings ?? this.buildings, 
      recources: recources ?? this.recources,
    );
  }

  Random get _random => Random();

}